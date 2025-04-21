// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;
// import 'package:intl/intl.dart';

// class WebSocketFrameTest extends StatefulWidget {
//   final CameraDescription camera;

//   const WebSocketFrameTest({Key? key, required this.camera}) : super(key: key);

//   @override
//   _WebSocketFrameTestState createState() => _WebSocketFrameTestState();
// }

// class _WebSocketFrameTestState extends State<WebSocketFrameTest> {
//   CameraController? _controller;
//   io.Socket? socket;
//   String? sessionId;
//   bool isConnected = false;
//   bool isCameraInitialized = false;
//   bool isRunning = false;
//   Timer? frameTimer;
//   Uint8List? responseImageBytes;
//   int leftCounter = 0;
//   int rightCounter = 0;
//   String feedback = '';
//   List<String> logs = [];
//   ScrollController logsScrollController = ScrollController();
//   bool showLogs = false;

//   // Server URL - update this with your Cloud Run URL
//   final String serverUrl = 'https://exercisedeploy-791062084724.us-central1.run.app';

//   @override
//   void initState() {
//     super.initState();
//     // Auto-initialize camera on startup
//     initializeCamera();
//   }

//   @override
//   void dispose() {
//     stopTracking();
//     _controller?.dispose();
//     socket?.disconnect();
//     super.dispose();
//   }

//   void addLog(String message) {
//     final now = DateFormat('HH:mm:ss').format(DateTime.now());
//     setState(() {
//       logs.add('[$now] $message');
//     });

//     // Scroll to bottom after rendering
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (logsScrollController.hasClients) {
//         logsScrollController.animateTo(
//           logsScrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 200),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   Future<void> initializeCamera() async {
//     addLog('Initializing camera...');
    
//     final CameraController cameraController = CameraController(
//       widget.camera,
//       ResolutionPreset.low, // Lower resolution for better performance
//       enableAudio: false,
//       imageFormatGroup: ImageFormatGroup.jpeg,
//     );

//     try {
//       await cameraController.initialize();
//       setState(() {
//         _controller = cameraController;
//         isCameraInitialized = true;
//       });
//       addLog('Camera initialized');
//     } catch (e) {
//       addLog('Error initializing camera: $e');
//     }
//   }

//   Future<void> startTracking() async {
//     if (!isCameraInitialized) {
//       addLog('Camera not initialized, initializing...');
//       await initializeCamera();
//       if (!isCameraInitialized) {
//         addLog('Failed to initialize camera');
//         return;
//       }
//     }
    
//     setState(() {
//       isRunning = true;
//     });
    
//     // Connect to server if not already connected
//     if (!isConnected) {
//       connectToServer();
//     } else {
//       startFrameSending();
//     }
//   }

//   void stopTracking() {
//     stopFrameSending();
    
//     setState(() {
//       isRunning = false;
//     });
    
//     addLog('Tracking stopped');
//   }

//   void connectToServer() {
//     addLog('Connecting to server...');

//     try {
//       socket = io.io(
//         serverUrl,
//         io.OptionBuilder()
//             .setTransports(['websocket'])
//             .enableReconnection()
//             .enableForceNew()
//             .build(),
//       );

//       socket!.onConnect((_) {
//         setState(() {
//           isConnected = true;
//         });
//         addLog('Connected to server');
        
//         // Start sending frames once connected
//         if (isRunning) {
//           startFrameSending();
//         }
//       });

//       socket!.on('session_id', (data) {
//         sessionId = data['session_id'];
//         addLog('Session established');
//       });

//       socket!.on('frame', (data) {
//         if (data['image'] != null) {
//           // Extract base64 image from the data URL format
//           final String base64String = data['image'].split(',')[1];
//           setState(() {
//             responseImageBytes = base64Decode(base64String);
//             leftCounter = data['left_counter'] ?? 0;
//             rightCounter = data['right_counter'] ?? 0;
//             feedback = data['feedback'] ?? '';
//           });
//         }
//       });

//       socket!.on('error', (data) {
//         addLog('Error: ${data['message']}');
//       });

//       socket!.onDisconnect((_) {
//         setState(() {
//           isConnected = false;
//         });
//         addLog('Disconnected from server');
//         stopFrameSending();
//       });

//       // Connect to the server
//       socket!.connect();
//     } catch (e) {
//       addLog('Connection error: $e');
//     }
//   }

//   Future<void> sendFrame() async {
//     if (!isConnected || sessionId == null || !isCameraInitialized) {
//       return;
//     }

//     try {
//       final start = DateTime.now();
      
//       // Capture image from camera with lower quality for better performance
//       final XFile image = await _controller!.takePicture();
//       final bytes = await image.readAsBytes();

//       // Convert to base64
//       final base64Image = base64Encode(bytes);

//       // Send to server
//       socket!.emit('frame', {
//         'session_id': sessionId,
//         'image': 'data:image/jpeg;base64,$base64Image',
//       });
      
//       final duration = DateTime.now().difference(start).inMilliseconds;
//       if (duration > 100) {
//         addLog('Frame processing time: ${duration}ms');
//       }
//     } catch (e) {
//       addLog('Error sending frame: $e');
//     }
//   }

//   void startFrameSending() {
//     if (!isConnected || sessionId == null || !isCameraInitialized) {
//       addLog('Cannot start: Not ready');
//       return;
//     }

//     stopFrameSending(); // Clear any existing timer

//     addLog('Starting frame sending');
//     frameTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
//       await sendFrame();
//     });
//   }

//   void stopFrameSending() {
//     if (frameTimer != null) {
//       frameTimer!.cancel();
//       frameTimer = null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
//     // Responsive sizes
//     final feedWidth = size.width > 600 ? 600.0 : size.width * 0.9;
//     final feedHeight = size.width > 600 ? 450.0 : size.width * 0.675;
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fitness Tracker'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(showLogs ? Icons.visibility_off : Icons.visibility),
//             onPressed: () {
//               setState(() {
//                 showLogs = !showLogs;
//               });
//             },
//             tooltip: showLogs ? 'Hide logs' : 'Show logs',
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
                
//                 // Exercise feedback
//                 if (feedback.isNotEmpty)
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: isDarkMode ? Colors.blueGrey.shade800 : Colors.blue.shade50,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 4,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.tips_and_updates, 
//                           color: isDarkMode ? Colors.amber : Colors.blue,
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             feedback,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: isDarkMode ? Colors.white : Colors.blue.shade800,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
                
//                 // Counter cards
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     children: [
//                       // Left counter
//                       Expanded(
//                         child: _buildCounterCard(
//                           'Left Arm',
//                           leftCounter,
//                           isDarkMode ? Colors.indigo.shade700 : Colors.indigo.shade100,
//                           isDarkMode ? Colors.white : Colors.indigo.shade900,
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                       // Right counter
//                       Expanded(
//                         child: _buildCounterCard(
//                           'Right Arm',
//                           rightCounter,
//                           isDarkMode ? Colors.teal.shade700 : Colors.teal.shade100,
//                           isDarkMode ? Colors.white : Colors.teal.shade900,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
                
//                 const SizedBox(height: 20),
                
//                 // Video feeds
//                 Container(
//                   width: feedWidth,
//                   height: feedHeight,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 8,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: responseImageBytes != null
//                       ? Image.memory(
//                           responseImageBytes!,
//                           fit: BoxFit.cover,
//                         )
//                       : isCameraInitialized
//                           ? CameraPreview(_controller!)
//                           : Container(
//                               color: isDarkMode ? Colors.black : Colors.grey.shade200,
//                               child: const Center(
//                                 child: CircularProgressIndicator(),
//                               ),
//                             ),
//                 ),
                
//                 const SizedBox(height: 25),
                
//                 // Start/Stop button
//                 SizedBox(
//                   width: 200,
//                   height: 60,
//                   child: ElevatedButton(
//                     onPressed: isRunning ? stopTracking : startTracking,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isRunning ? Colors.red : Colors.green,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       elevation: 5,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(isRunning ? Icons.stop : Icons.play_arrow),
//                         const SizedBox(width: 8),
//                         Text(
//                           isRunning ? 'STOP' : 'START',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
                
//                 const SizedBox(height: 20),
                
//                 // Connection status
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: isConnected
//                         ? (isDarkMode ? Colors.green.shade900 : Colors.green.shade100)
//                         : (isDarkMode ? Colors.red.shade900 : Colors.red.shade100),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     isConnected ? 'Connected' : 'Disconnected',
//                     style: TextStyle(
//                       color: isConnected 
//                           ? (isDarkMode ? Colors.green.shade100 : Colors.green.shade800)
//                           : (isDarkMode ? Colors.red.shade100 : Colors.red.shade800),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
                
//                 // Logs section (collapsible)
//                 if (showLogs) ...[
//                   const SizedBox(height: 20),
//                   Container(
//                     width: feedWidth,
//                     height: 200,
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Scrollbar(
//                       controller: logsScrollController,
//                       child: ListView.builder(
//                         controller: logsScrollController,
//                         itemCount: logs.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 10.0,
//                               vertical: 3.0,
//                             ),
//                             child: Text(
//                               logs[index],
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 fontFamily: 'monospace',
//                                 color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
                
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
  
//   // Helper method to build counter cards
//   Widget _buildCounterCard(String title, int count, Color backgroundColor, Color textColor) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: textColor,
//             ),
//           ),
//           const SizedBox(height: 5),
//           Text(
//             count.toString(),
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: textColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:intl/intl.dart';

class WebSocketFrameTest extends StatefulWidget {
  final CameraDescription camera;

  const WebSocketFrameTest({Key? key, required this.camera}) : super(key: key);

  @override
  _WebSocketFrameTestState createState() => _WebSocketFrameTestState();
}

class _WebSocketFrameTestState extends State<WebSocketFrameTest> {
  CameraController? _controller;
  io.Socket? socket;
  String? sessionId;
  bool isConnected = false;
  bool isCameraInitialized = false;
  bool isRunning = false;
  Timer? frameTimer;
  Uint8List? responseImageBytes;
  int leftCounter = 0;
  int rightCounter = 0;
  String feedback = '';
  List<String> logs = [];
  ScrollController logsScrollController = ScrollController();

  // Server URL - update this with your Cloud Run URL
  final String serverUrl = 'https://exercisedeploy-791062084724.us-central1.run.app';

  @override
  void initState() {
    super.initState();
    // Auto-initialize camera on startup
    initializeCamera();
    // Auto-connect to server on startup
    connectToServer();
  }

  @override
  void dispose() {
    stopTracking();
    _controller?.dispose();
    socket?.disconnect();
    super.dispose();
  }

  void addLog(String message) {
    final now = DateFormat('HH:mm:ss').format(DateTime.now());
    logs.add('[$now] $message');
    
    // Only keep the last 100 logs to avoid memory issues
    if (logs.length > 100) {
      logs.removeAt(0);
    }
  }

  Future<void> initializeCamera() async {
    addLog('Initializing camera...');
    
    final CameraController cameraController = CameraController(
      widget.camera,
      ResolutionPreset.medium, // Medium resolution for better performance
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await cameraController.initialize();
      setState(() {
        _controller = cameraController;
        isCameraInitialized = true;
      });
      addLog('Camera initialized');
    } catch (e) {
      addLog('Error initializing camera: $e');
    }
  }

  Future<void> startTracking() async {
    if (!isCameraInitialized) {
      addLog('Camera not initialized, initializing...');
      await initializeCamera();
      if (!isCameraInitialized) {
        addLog('Failed to initialize camera');
        return;
      }
    }
    
    setState(() {
      isRunning = true;
    });
    
    // Connect to server if not already connected
    if (!isConnected) {
      connectToServer();
    } else {
      startFrameSending();
    }
  }

  void stopTracking() {
    stopFrameSending();
    
    setState(() {
      isRunning = false;
    });
    
    addLog('Tracking stopped');
  }

  void connectToServer() {
    addLog('Connecting to server...');

    try {
      socket = io.io(
        serverUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableReconnection()
            .enableForceNew()
            .build(),
      );

      socket!.onConnect((_) {
        setState(() {
          isConnected = true;
        });
        addLog('Connected to server');
        
        // Start sending frames once connected if we're supposed to be running
        if (isRunning) {
          startFrameSending();
        }
      });

      socket!.on('session_id', (data) {
        sessionId = data['session_id'];
        addLog('Session established');
      });

      socket!.on('frame', (data) {
        if (data['image'] != null) {
          // Extract base64 image from the data URL format
          final String base64String = data['image'].split(',')[1];
          setState(() {
            responseImageBytes = base64Decode(base64String);
            leftCounter = data['left_counter'] ?? 0;
            rightCounter = data['right_counter'] ?? 0;
            feedback = data['feedback'] ?? '';
          });
        }
      });

      socket!.onDisconnect((_) {
        setState(() {
          isConnected = false;
        });
        addLog('Disconnected from server');
        stopFrameSending();
      });

      // Connect to the server
      socket!.connect();
    } catch (e) {
      addLog('Connection error: $e');
    }
  }

  Future<void> sendFrame() async {
    if (!isConnected || sessionId == null || !isCameraInitialized) {
      return;
    }

    try {
      // Capture image from camera with lower quality for better performance
      final XFile image = await _controller!.takePicture();
      final bytes = await image.readAsBytes();

      // Convert to base64
      final base64Image = base64Encode(bytes);

      // Send to server
      socket!.emit('frame', {
        'session_id': sessionId,
        'image': 'data:image/jpeg;base64,$base64Image',
      });
    } catch (e) {
      addLog('Error sending frame: $e');
    }
  }

  void startFrameSending() {
    if (!isConnected || sessionId == null || !isCameraInitialized) {
      addLog('Cannot start: Not ready');
      return;
    }

    stopFrameSending(); // Clear any existing timer

    addLog('Starting frame sending');
    // Reduced from 100ms to 50ms for more stream-like experience
    frameTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) async {
      await sendFrame();
    });
  }

  void stopFrameSending() {
    if (frameTimer != null) {
      frameTimer!.cancel();
      frameTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Responsive sizes based on screen dimensions
    final isTablet = size.width > 600;
    final isLandscape = size.width > size.height;
    
    // Dynamic sizes for different screen sizes
    final buttonSize = isTablet ? 100.0 : (size.width * 0.18);
    final buttonIconSize = isTablet ? 60.0 : (size.width * 0.09);
    final statusIndicatorSize = isTablet ? 16.0 : 12.0;
    final counterIconSize = isTablet ? 22.0 : 16.0;
    final counterFontSize = isTablet ? 22.0 : 16.0;
    final feedbackFontSize = isTablet ? 16.0 : 14.0;
    final paddingScale = isTablet ? 1.5 : 1.0;
    
    // Adjusted positions for landscape mode
    final buttonBottomPosition = isLandscape ? 20.0 : 30.0;
    final feedbackBottomPosition = isLandscape ? 
        (isTablet ? 140.0 : 100.0) : 
        (isTablet ? 180.0 : 130.0);
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Full screen camera preview
            isCameraInitialized && _controller != null
                ? Positioned.fill(
                    child: isLandscape 
                      ? CameraPreview(_controller!)
                      : AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: responseImageBytes != null
                              ? Image.memory(
                                  responseImageBytes!,
                                  fit: BoxFit.cover,
                                )
                              : CameraPreview(_controller!),
                        ),
                  )
                : Container(
                    color: Colors.black,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
            // Buttons and controls overlay
            Positioned(
              left: 0,
              right: 0,
              bottom: buttonBottomPosition,
              child: Center(
                child: Container(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isRunning ? Colors.red.withOpacity(0.7) : Colors.green.withOpacity(0.7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: isRunning ? stopTracking : startTracking,
                      child: Icon(
                        isRunning ? Icons.stop_rounded : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: buttonIconSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Connection status indicator
            Positioned(
              top: 20 * paddingScale,
              right: 20 * paddingScale,
              child: Container(
                width: statusIndicatorSize,
                height: statusIndicatorSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isConnected ? Colors.green : Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: (isConnected ? Colors.green : Colors.red).withOpacity(0.5),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            
            // Counters (minimalist, top left)
            if (leftCounter > 0 || rightCounter > 0)
              Positioned(
                top: 20 * paddingScale,
                left: isLandscape && !isTablet ? 70 * paddingScale : 20 * paddingScale,
                child: Container(
                  padding: EdgeInsets.all(12 * paddingScale),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12 * paddingScale),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_circle_left_outlined, 
                                color: Colors.blue, 
                                size: counterIconSize
                              ),
                              SizedBox(width: 5 * paddingScale),
                              Text(
                                '$leftCounter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: counterFontSize,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4 * paddingScale),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_circle_right_outlined, 
                                color: Colors.green, 
                                size: counterIconSize
                              ),
                              SizedBox(width: 5 * paddingScale),
                              Text(
                                '$rightCounter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: counterFontSize,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
            // Feedback overlay (only shows when there's feedback)
            if (feedback.isNotEmpty)
              Positioned(
                bottom: feedbackBottomPosition,
                left: 20 * paddingScale,
                right: 20 * paddingScale,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * paddingScale, 
                    vertical: 12 * paddingScale
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20 * paddingScale),
                    border: Border.all(
                      color: Colors.white24,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Colors.amber.shade300,
                        size: 20 * paddingScale,
                      ),
                      SizedBox(width: 10 * paddingScale),
                      Expanded(
                        child: Text(
                          feedback,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: feedbackFontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
            // Back button
            Positioned(
              top: 20 * paddingScale,
              left: 20 * paddingScale,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 24 * paddingScale,
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}