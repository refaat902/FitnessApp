// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:typed_data';

// // import 'package:flutter/material.dart';
// // import 'package:camera/camera.dart';
// // import 'package:socket_io_client/socket_io_client.dart' as io;
// // import 'package:intl/intl.dart';

// // class WebSocketFrameTest extends StatefulWidget {
// //   final CameraDescription camera;

// //   const WebSocketFrameTest({Key? key, required this.camera}) : super(key: key);

// //   @override
// //   _WebSocketFrameTestState createState() => _WebSocketFrameTestState();
// // }

// // class _WebSocketFrameTestState extends State<WebSocketFrameTest> {
// //   CameraController? _controller;
// //   io.Socket? socket;
// //   String? sessionId;
// //   bool isConnected = false;
// //   bool isCameraInitialized = false;
// //   bool isRunning = false;
// //   Timer? frameTimer;
// //   Uint8List? responseImageBytes;
// //   int leftCounter = 0;
// //   int rightCounter = 0;
// //   String feedback = '';
  
// //   // Performance tracking
// //   int framesSent = 0;
// //   int framesReceived = 0;
// //   double fps = 0;
// //   int lastFpsUpdateTime = 0;
// //   int frameCount = 0;
// //   bool _isProcessingFrame = false;
  
// //   // Optimized settings for minimal lag
// //   static const double targetFps = 12; // 12 FPS for smooth performance
// //   static  int frameIntervalMs = (1000 / targetFps).round(); // ~83ms
  
// //   // Server URL
// //   final String serverUrl = 'https://exercisedeploy-791062084724.us-central1.run.app';

// //   @override
// //   void initState() {
// //     super.initState();
// //     initializeCamera();
// //   }

// //   @override
// //   void dispose() {
// //     stopTracking();
// //     _controller?.dispose();
// //     socket?.disconnect();
// //     super.dispose();
// //   }

// //   Future<void> initializeCamera() async {
// //     debugPrint('Starting camera initialization...');
    
// //     try {
// //       final CameraController cameraController = CameraController(
// //         widget.camera,
// //         ResolutionPreset.medium, // Medium resolution for better balance
// //         enableAudio: false,
// //         imageFormatGroup: ImageFormatGroup.jpeg,
// //       );

// //       await cameraController.initialize();
      
// //       if (mounted) {
// //         setState(() {
// //           _controller = cameraController;
// //           isCameraInitialized = true;
// //         });
// //         debugPrint('Camera initialized successfully');
        
// //         // Auto-connect to server after camera is ready
// //         connectToServer();
// //       }
// //     } catch (e) {
// //       debugPrint('Camera initialization error: $e');
// //       // Show error dialog
// //       if (mounted) {
// //         showDialog(
// //           context: context,
// //           builder: (context) => AlertDialog(
// //             title: const Text('Camera Error'),
// //             content: Text('Failed to initialize camera: $e'),
// //             actions: [
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop();
// //                   Navigator.of(context).pop(); // Go back to previous screen
// //                 },
// //                 child: const Text('OK'),
// //               ),
// //             ],
// //           ),
// //         );
// //       }
// //     }
// //   }

// //   void connectToServer() {
// //     debugPrint('Connecting to server...');

// //     try {
// //       socket = io.io(
// //         serverUrl,
// //         io.OptionBuilder()
// //             .setTransports(['websocket'])
// //             .enableReconnection()
// //             .setReconnectionAttempts(3)
// //             .setReconnectionDelay(1000)
// //             .setTimeout(15000)
// //             .build(),
// //       );

// //       socket!.onConnect((_) {
// //         debugPrint('Connected to server');
// //         if (mounted) {
// //           setState(() {
// //             isConnected = true;
// //           });
// //         }
// //       });

// //       socket!.on('session_id', (data) {
// //         sessionId = data['session_id'];
// //         debugPrint('Session established: $sessionId');
        
// //         // Select exercise automatically
// //         socket!.emit('select_exercise', {
// //           'exercise': 'bicep_curl',
// //           'session_id': sessionId
// //         });
// //       });

// //       socket!.on('frame', (data) {
// //         _isProcessingFrame = false; // Reset processing flag
        
// //         if (data['image'] != null && mounted) {
// //           try {
// //             // Extract base64 image data
// //             String imageDataUrl = data['image'];
// //             String base64String = imageDataUrl.split(',')[1];
// //             Uint8List imageBytes = base64Decode(base64String);
            
// //             setState(() {
// //               responseImageBytes = imageBytes;
// //               leftCounter = data['left_counter'] ?? 0;
// //               rightCounter = data['right_counter'] ?? 0;
// //               feedback = data['feedback'] ?? '';
// //               framesReceived++;
// //             });
            
// //             updateFps();
// //           } catch (e) {
// //             debugPrint('Error processing frame: $e');
// //           }
// //         }
// //       });

// //       socket!.on('error', (data) {
// //         debugPrint('Socket error: $data');
// //         _isProcessingFrame = false;
// //       });

// //       socket!.onDisconnect((_) {
// //         debugPrint('Disconnected from server');
// //         if (mounted) {
// //           setState(() {
// //             isConnected = false;
// //           });
// //         }
// //         stopFrameSending();
// //       });

// //       socket!.connect();
// //     } catch (e) {
// //       debugPrint('Connection error: $e');
// //     }
// //   }

// //   void updateFps() {
// //     final now = DateTime.now().millisecondsSinceEpoch;
// //     final elapsed = now - lastFpsUpdateTime;
    
// //     if (elapsed >= 1000) {
// //       if (mounted) {
// //         setState(() {
// //           fps = (frameCount * 1000) / elapsed;
// //           frameCount = 0;
// //           lastFpsUpdateTime = now;
// //         });
// //       }
// //     }
// //     frameCount++;
// //   }

// //   Future<void> startTracking() async {
// //     if (!isCameraInitialized) {
// //       debugPrint('Camera not ready');
// //       return;
// //     }
    
// //     if (!isConnected) {
// //       debugPrint('Not connected to server');
// //       connectToServer();
// //       return;
// //     }
    
// //     if (sessionId == null) {
// //       debugPrint('No session ID');
// //       return;
// //     }
    
// //     setState(() {
// //       isRunning = true;
// //       framesSent = 0;
// //       framesReceived = 0;
// //       frameCount = 0;
// //       lastFpsUpdateTime = DateTime.now().millisecondsSinceEpoch;
// //     });
    
// //     startFrameSending();
// //   }

// //   void stopTracking() {
// //     stopFrameSending();
    
// //     if (mounted) {
// //       setState(() {
// //         isRunning = false;
// //         _isProcessingFrame = false;
// //       });
// //     }
// //   }

// //   void startFrameSending() {
// //     if (!isConnected || sessionId == null || !isCameraInitialized) {
// //       debugPrint('Cannot start frame sending - not ready');
// //       return;
// //     }

// //     stopFrameSending(); // Clear any existing timer
// //     debugPrint('Starting frame sending at $targetFps FPS');
    
// //     frameTimer = Timer.periodic(
// //       Duration(milliseconds: frameIntervalMs),
// //       (timer) async {
// //         await sendFrame();
// //       },
// //     );
// //   }

// //   void stopFrameSending() {
// //     frameTimer?.cancel();
// //     frameTimer = null;
// //   }

// //   Future<void> sendFrame() async {
// //     if (!isConnected || 
// //         sessionId == null || 
// //         !isCameraInitialized || 
// //         _isProcessingFrame) {
// //       return;
// //     }

// //     _isProcessingFrame = true;

// //     try {
// //       // Capture image from camera
// //       final XFile image = await _controller!.takePicture();
// //       final bytes = await image.readAsBytes();

// //       // Convert to base64
// //       final base64Image = base64Encode(bytes);

// //       // Send to server
// //       socket!.emit('frame', {
// //         'session_id': sessionId,
// //         'image': 'data:image/jpeg;base64,$base64Image',
// //       });
      
// //       if (mounted) {
// //         setState(() {
// //           framesSent++;
// //         });
// //       }
// //     } catch (e) {
// //       debugPrint('Error sending frame: $e');
// //       _isProcessingFrame = false;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
// //     return Scaffold(
// //       backgroundColor: isDarkMode ? Colors.black : Colors.white,
// //       body: SafeArea(
// //         child: Stack(
// //           children: [
// //             // Camera preview or processed image
// //             Positioned.fill(
// //               child: isCameraInitialized && _controller != null
// //                   ? (responseImageBytes != null
// //                       ? Image.memory(
// //                           responseImageBytes!,
// //                           fit: BoxFit.contain, // Keep original API image size
// //                           gaplessPlayback: true,
// //                         )
// //                       : CameraPreview(_controller!))
// //                   : Container(
// //                       color: Colors.black,
// //                       child: const Center(
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             CircularProgressIndicator(color: Colors.white),
// //                             SizedBox(height: 16),
// //                             Text(
// //                               'Initializing camera...',
// //                               style: TextStyle(color: Colors.white),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //             ),
            
// //             // Status indicators (top right)
// //             Positioned(
// //               top: 20,
// //               right: 20,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.end,
// //                 children: [
// //                   // Connection status
// //                   Container(
// //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                     decoration: BoxDecoration(
// //                       color: Colors.black.withOpacity(0.7),
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Container(
// //                           width: 8,
// //                           height: 8,
// //                           decoration: BoxDecoration(
// //                             shape: BoxShape.circle,
// //                             color: isConnected ? Colors.green : Colors.red,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 6),
// //                         Text(
// //                           '${fps.toStringAsFixed(1)} FPS',
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 12,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
                  
// //                   // Frame counters
// //                   if (isRunning && isConnected)
// //                     Padding(
// //                       padding: const EdgeInsets.only(top: 4),
// //                       child: Container(
// //                         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //                         decoration: BoxDecoration(
// //                           color: Colors.black.withOpacity(0.5),
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                         child: Text(
// //                           'S:$framesSent R:$framesReceived',
// //                           style: const TextStyle(
// //                             color: Colors.white70,
// //                             fontSize: 10,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                 ],
// //               ),
// //             ),
            
// //             // Exercise counters (top left)
// //             if (leftCounter > 0 || rightCounter > 0)
// //               Positioned(
// //                 top: 20,
// //                 left: 20,
// //                 child: Container(
// //                   padding: const EdgeInsets.all(12),
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.7),
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Row(
// //                         children: [
// //                           const Icon(
// //                             Icons.arrow_circle_left_outlined, 
// //                             color: Colors.blue, 
// //                             size: 18,
// //                           ),
// //                           const SizedBox(width: 6),
// //                           Text(
// //                             '$leftCounter',
// //                             style: const TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 16,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 6),
// //                       Row(
// //                         children: [
// //                           const Icon(
// //                             Icons.arrow_circle_right_outlined, 
// //                             color: Colors.green, 
// //                             size: 18,
// //                           ),
// //                           const SizedBox(width: 6),
// //                           Text(
// //                             '$rightCounter',
// //                             style: const TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 16,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
              
// //             // Feedback overlay
// //             if (feedback.isNotEmpty)
// //               Positioned(
// //                 bottom: 120,
// //                 left: 20,
// //                 right: 20,
// //                 child: Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.8),
// //                     borderRadius: BorderRadius.circular(20),
// //                     border: Border.all(color: Colors.white24),
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       const Icon(
// //                         Icons.lightbulb_outline,
// //                         color: Colors.amber,
// //                         size: 20,
// //                       ),
// //                       const SizedBox(width: 10),
// //                       Expanded(
// //                         child: Text(
// //                           feedback,
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 14,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
              
// //             // Control button (bottom center)
// //             Positioned(
// //               left: 0,
// //               right: 0,
// //               bottom: 30,
// //               child: Center(
// //                 child: GestureDetector(
// //                   onTap: () {
// //                     if (isRunning) {
// //                       stopTracking();
// //                     } else {
// //                       startTracking();
// //                     }
// //                   },
// //                   child: Container(
// //                     width: 80,
// //                     height: 80,
// //                     decoration: BoxDecoration(
// //                       shape: BoxShape.circle,
// //                       color: isRunning 
// //                           ? Colors.red.withOpacity(0.8) 
// //                           : Colors.green.withOpacity(0.8),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black.withOpacity(0.3),
// //                           blurRadius: 10,
// //                           spreadRadius: 1,
// //                         ),
// //                       ],
// //                     ),
// //                     child: Icon(
// //                       isRunning ? Icons.stop_rounded : Icons.play_arrow_rounded,
// //                       color: Colors.white,
// //                       size: 40,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
            
// //             // Back button
// //             Positioned(
// //               bottom: 30,
// //               left: 20,
// //               child: GestureDetector(
// //                 onTap: () {
// //                   stopTracking();
// //                   Navigator.pop(context);
// //                 },
// //                 child: Container(
// //                   width: 50,
// //                   height: 50,
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.6),
// //                     shape: BoxShape.circle,
// //                   ),
// //                   child: const Icon(
// //                     Icons.arrow_back,
// //                     color: Colors.white,
// //                     size: 24,
// //                   ),
// //                 ),
// //               ),
// //             ),
            
// //             // Connection status message
// //             if (!isConnected && isCameraInitialized)
// //               Positioned(
// //                 top: 100,
// //                 left: 20,
// //                 right: 20,
// //                 child: Container(
// //                   padding: const EdgeInsets.all(12),
// //                   decoration: BoxDecoration(
// //                     color: Colors.orange.withOpacity(0.9),
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                   child: const Text(
// //                     'Connecting to server...',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }





// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:typed_data' as ui;
// import 'dart:ui' as ui;

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
//   bool streamActive = false;
//   Timer? frameTimer;
//   Uint8List? responseImageBytes;
  
//   // UI State
//   String status = 'Not connected';
//   int leftCounter = 0;
//   int rightCounter = 0;
//   String feedback = '';
//   List<String> logs = [];
//   ScrollController logsScrollController = ScrollController();
  
//   // Performance metrics - exactly like HTML
//   int framesSent = 0;
//   int framesReceived = 0;
//   int lastFrameSentTime = 0;
//   int lastLatencyUpdate = 0;
//   List<int> latencyValues = [];
//   int frameCount = 0;
//   int lastFpsTime = 0;
//   int currentFps = 0;
  
//   // Configuration (tied to sliders) - exactly like HTML
//   double frameRate = 30;
//   double frameInterval = 1000 / 30;
//   double imageQuality = 0.7;
//   String selectedResolution = '640x480';
//   Map<String, int> resolution = {'width': 640, 'height': 480};
  
//   // Available resolutions - exactly like HTML
//   final List<String> resolutions = ['320x240', '640x480', '1280x720'];
  
//   // Server URL - exactly like HTML
//   final String serverUrl = 'https://exercisedeploy-791062084724.us-central1.run.app';

//   @override
//   void initState() {
//     super.initState();
//     frameInterval = 1000 / frameRate;
//   }

//   @override
//   void dispose() {
//     stopSendingFrames();
//     _controller?.dispose();
//     socket?.disconnect();
//     frameTimer?.cancel();
//     super.dispose();
//   }

//   // Add log entry with timestamp - exactly like HTML
//   void log(String message) {
//     final timestamp = DateFormat('HH:mm:ss').format(DateTime.now());
//     if (mounted) {
//       setState(() {
//         logs.add('[$timestamp] $message');
//       });
      
//       // Scroll to bottom
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (logsScrollController.hasClients) {
//           logsScrollController.animateTo(
//             logsScrollController.position.maxScrollExtent,
//             duration: const Duration(milliseconds: 200),
//             curve: Curves.easeOut,
//           );
//         }
//       });
//     }
//   }
  
//   // Update FPS counter - exactly like HTML
//   void updateFPS() {
//     final now = DateTime.now().millisecondsSinceEpoch;
//     final elapsed = now - lastFpsTime;
    
//     if (elapsed >= 1000) {
//       final fps = ((frameCount * 1000) / elapsed).round();
//       if (mounted) {
//         setState(() {
//           currentFps = fps;
//           frameCount = 0;
//           lastFpsTime = now;
//         });
//       }
//     }
//   }
  
//   // Update latency display - exactly like HTML
//   void updateLatency() {
//     if (latencyValues.isNotEmpty) {
//       // Calculate average latency over the last 10 values
//       final avgLatency = latencyValues.reduce((a, b) => a + b) / latencyValues.length;
      
//       // Reset for next calculation
//       if (latencyValues.length > 10) {
//         latencyValues.clear();
//       }
      
//       if (mounted) {
//         setState(() {
//           // Update latency display in UI
//         });
//       }
//     }
//   }

//   // Start camera - exactly like HTML functionality
//   Future<void> startCamera() async {
//     try {
//       final parts = selectedResolution.split('x');
//       final width = int.parse(parts[0]);
//       final height = int.parse(parts[1]);
//       resolution = {'width': width, 'height': height};
      
//       // Determine resolution preset
//       ResolutionPreset preset;
//       if (width <= 320) {
//         preset = ResolutionPreset.low;
//       } else if (width <= 640) {
//         preset = ResolutionPreset.medium;
//       } else {
//         preset = ResolutionPreset.high;
//       }
      
//       final CameraController cameraController = CameraController(
//         widget.camera,
//         preset,
//         enableAudio: false,
//         imageFormatGroup: ImageFormatGroup.jpeg,
//       );

//       await cameraController.initialize();
      
//       if (mounted) {
//         setState(() {
//           _controller = cameraController;
//           isCameraInitialized = true;
//           status = 'Camera started';
//         });
//       }
      
//       log('Camera started');
//     } catch (error) {
//       log('Camera error: ${error.toString()}');
//       if (mounted) {
//         setState(() {
//           status = 'Error: ${error.toString()}';
//         });
//       }
//     }
//   }

//   // Connect to server - exactly like HTML
//   void connectToServer() {
//     log('Connecting to $serverUrl...');
//     setState(() {
//       status = 'Connecting...';
//     });
    
//     socket = io.io(serverUrl, io.OptionBuilder()
//         .setTransports(['websocket'])
//         .enableReconnection()
//         .setReconnectionAttempts(5)
//         .setReconnectionDelay(1000)
//         .setTimeout(20000)
//         .build());
    
//     socket!.on('connect', (_) {
//       log('Connected to server');
//       if (mounted) {
//         setState(() {
//           isConnected = true;
//           status = 'Connected';
//         });
//       }
//     });
    
//     socket!.on('session_id', (data) {
//       sessionId = data['session_id'];
//       log('Session established: $sessionId');
//       if (mounted) {
//         setState(() {
//           status = 'Session: ${sessionId!.substring(0, 8)}...';
//         });
//       }
//     });
    
//     socket!.on('frame', (data) {
//       if (data['image'] != null) {
//         // Calculate latency - exactly like HTML
//         if (lastFrameSentTime > 0) {
//           final now = DateTime.now().millisecondsSinceEpoch;
//           final latency = now - lastFrameSentTime;
//           latencyValues.add(latency);
          
//           // Update latency display periodically
//           if (now - lastLatencyUpdate > 500) {
//             updateLatency();
//             lastLatencyUpdate = now;
//           }
//         }
        
//         // Update UI - exactly like HTML
//         final imageDataUrl = data['image'] as String;
//         final base64String = imageDataUrl.split(',')[1];
//         final imageBytes = base64Decode(base64String);
        
//         if (mounted) {
//           setState(() {
//             responseImageBytes = imageBytes;
//             framesReceived++;
//             leftCounter = data['left_counter'] ?? 0;
//             rightCounter = data['right_counter'] ?? 0;
//             feedback = data['feedback'] ?? '';
//           });
//         }
        
//         // Update FPS counter
//         frameCount++;
//         updateFPS();
//       }
//     });
    
//     socket!.on('error', (data) {
//       log('Error: ${data['message']}');
//       if (mounted) {
//         setState(() {
//           status = 'Error: ${data['message']}';
//         });
//       }
//     });
    
//     socket!.on('disconnect', (_) {
//       log('Disconnected from server');
//       if (mounted) {
//         setState(() {
//           isConnected = false;
//           status = 'Disconnected';
//         });
//       }
//       stopSendingFrames();
//     });
//   }

//   // Start sending frames - exactly like HTML
//   void startFrames() {
//     if (socket == null || sessionId == null || !isCameraInitialized) {
//       log('Cannot start streaming: Missing socket, session, or camera');
//       return;
//     }
    
//     log('Starting to send frames');
//     setState(() {
//       streamActive = true;
//       framesSent = 0;
//       framesReceived = 0;
//     });
    
//     lastFpsTime = DateTime.now().millisecondsSinceEpoch;
    
//     // Select bicep curl exercise by default - exactly like HTML
//     socket!.emit('select_exercise', {
//       'exercise': 'bicep_curl',
//       'session_id': sessionId
//     });
    
//     // Start frame sending timer
//     frameTimer = Timer.periodic(
//       Duration(milliseconds: frameInterval.round()),
//       (timer) => sendVideoFrame(),
//     );
//   }

//   // Stop sending frames - exactly like HTML
//   void stopSendingFrames() {
//     setState(() {
//       streamActive = false;
//     });
//     frameTimer?.cancel();
//     frameTimer = null;
//     log('Stopped sending frames');
//   }

//   // Function to capture and send a single frame - exactly like HTML logic
//   Future<void> sendVideoFrame() async {
//     if (socket == null || sessionId == null || !isCameraInitialized || socket!.disconnected) {
//       return;
//     }
    
//     try {
//       // Capture image from camera
//       final XFile image = await _controller!.takePicture();
//       final bytes = await image.readAsBytes();
      
//       // Resize to desired resolution and apply quality
//       final processedBytes = await _processImageWithQuality(
//         bytes, 
//         resolution['width']!, 
//         resolution['height']!, 
//         imageQuality
//       );
      
//       // Convert to base64 with JPEG format
//       final base64Image = 'data:image/jpeg;base64,${base64Encode(processedBytes)}';
      
//       // Record time for latency calculation
//       lastFrameSentTime = DateTime.now().millisecondsSinceEpoch;
      
//       // Send to server
//       socket!.emit('frame', {
//         'session_id': sessionId,
//         'image': base64Image
//       });
      
//       // Update metrics
//       if (mounted) {
//         setState(() {
//           framesSent++;
//         });
//       }
//     } catch (error) {
//       log('Error sending frame: ${error.toString()}');
//     }
//   }

//   // Process image with quality setting - like HTML canvas.toDataURL
//   Future<Uint8List> _processImageWithQuality(Uint8List imageBytes, int width, int height, double quality) async {
//     try {
//       final ui.Codec codec = await ui.instantiateImageCodec(
//         imageBytes,
//         targetWidth: width,
//         targetHeight: height,
//       );
//       final ui.FrameInfo frame = await codec.getNextFrame();
//       final ui.Image image = frame.image;
      
//       // Convert to bytes with quality (PNG preserves more quality control)
//       final ui.ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       return byteData!.buffer.asUint8List();
//     } catch (e) {
//       return imageBytes; // Fallback to original
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final latency = latencyValues.isNotEmpty 
//         ? (latencyValues.reduce((a, b) => a + b) / latencyValues.length).round()
//         : 0;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('WebSocket Frame Test - Optimized'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Controls - exactly like HTML
//             const Text('Controls:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             Wrap(
//               spacing: 10,
//               children: [
//                 ElevatedButton(
//                   onPressed: startCamera,
//                   child: const Text('Start Camera'),
//                 ),
//                 ElevatedButton(
//                   onPressed: connectToServer,
//                   child: const Text('Connect to Server'),
//                 ),
//                 ElevatedButton(
//                   onPressed: streamActive ? null : startFrames,
//                   child: const Text('Start Streaming'),
//                 ),
//                 ElevatedButton(
//                   onPressed: streamActive ? stopSendingFrames : null,
//                   child: const Text('Stop Streaming'),
//                 ),
//               ],
//             ),
            
//             const SizedBox(height: 20),
            
//             // Sliders - exactly like HTML
//             _buildSlider(
//               'Frame Rate:',
//               frameRate,
//               1,
//               60,
//               '${frameRate.round()} FPS',
//               (value) {
//                 setState(() {
//                   frameRate = value;
//                   frameInterval = 1000 / frameRate;
//                 });
//               },
//             ),
            
//             _buildSlider(
//               'Image Quality:',
//               imageQuality * 10,
//               1,
//               10,
//               '${(imageQuality * 100).round()}%',
//               (value) {
//                 setState(() {
//                   imageQuality = value / 10;
//                 });
//               },
//             ),
            
//             // Resolution dropdown - exactly like HTML
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: Row(
//                 children: [
//                   const SizedBox(
//                     width: 150,
//                     child: Text('Resolution:', style: TextStyle(fontSize: 16)),
//                   ),
//                   SizedBox(
//                     width: 200,
//                     child: DropdownButton<String>(
//                       value: selectedResolution,
//                       isExpanded: true,
//                       items: resolutions.map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         if (newValue != null) {
//                           setState(() {
//                             selectedResolution = newValue;
//                             final parts = newValue.split('x');
//                             resolution = {
//                               'width': int.parse(parts[0]),
//                               'height': int.parse(parts[1])
//                             };
//                           });
//                           log('Resolution changed to $newValue');
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             const SizedBox(height: 20),
            
//             // Camera and Response panels - exactly like HTML layout
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Camera Feed panel
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('Camera Feed', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 10),
//                         Container(
//                           width: 320,
//                           height: 240,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: isCameraInitialized && _controller != null
//                               ? ClipRRect(
//                                   borderRadius: BorderRadius.circular(4),
//                                   child: CameraPreview(_controller!),
//                                 )
//                               : const Center(
//                                   child: Text('Camera not started'),
//                                 ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
                
//                 const SizedBox(width: 20),
                
//                 // Server Response panel
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text('Server Response', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                             // FPS Display - exactly like HTML
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                               decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.6),
//                                 borderRadius: BorderRadius.circular(3),
//                               ),
//                               child: Text(
//                                 '$currentFps FPS',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Container(
//                           width: 320,
//                           height: 240,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: responseImageBytes != null
//                               ? ClipRRect(
//                                   borderRadius: BorderRadius.circular(4),
//                                   child: Image.memory(
//                                     responseImageBytes!,
//                                     // NO fit parameter - display at original API size
//                                     gaplessPlayback: true,
//                                   ),
//                                 )
//                               : Container(
//                                   color: Colors.grey.shade100,
//                                   child: const Center(
//                                     child: Text('No response'),
//                                   ),
//                                 ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
            
//             const SizedBox(height: 20),
            
//             // Status information - exactly like HTML
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Status: $status'),
//                 Text('Left Counter: $leftCounter'),
//                 Text('Right Counter: $rightCounter'),
//                 Text('Feedback: $feedback'),
//                 Text('Latency: $latency ms'),
//                 Text('Frames Sent: $framesSent / Frames Received: $framesReceived'),
//               ],
//             ),
            
//             const SizedBox(height: 20),
            
//             // Logs container - exactly like HTML
//             Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Logs:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: ListView.builder(
//                       controller: logsScrollController,
//                       itemCount: logs.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 1.0),
//                           child: Text(
//                             logs[index],
//                             style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper to build sliders - like HTML sliders
//   Widget _buildSlider(String label, double value, double min, double max, String displayValue, Function(double) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 150,
//             child: Text(label, style: const TextStyle(fontSize: 16)),
//           ),
//           SizedBox(
//             width: 200,
//             child: Slider(
//               value: value,
//               min: min,
//               max: max,
//               divisions: (max - min).round(),
//               onChanged: onChanged,
//             ),
//           ),
//           const SizedBox(width: 10),
//           Text(displayValue),
//         ],
//       ),
//     );
//   }
// }



import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:typed_data' as ui;
import 'dart:ui' as ui;

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
  bool streamActive = false;
  Timer? frameTimer;
  Uint8List? responseImageBytes;
  
  // UI State
  String status = 'Not connected';
  int leftCounter = 0;
  int rightCounter = 0;
  String feedback = '';
  List<String> logs = [];
  
  // Performance metrics
  int framesSent = 0;
  int framesReceived = 0;
  int lastFrameSentTime = 0;
  int lastLatencyUpdate = 0;
  List<int> latencyValues = [];
  int frameCount = 0;
  int lastFpsTime = 0;
  int currentFps = 0;
  
  // Configuration
  double frameRate = 30;
  double frameInterval = 1000 / 30;
  double imageQuality = 0.7;
  String selectedResolution = '640x480';
  Map<String, int> resolution = {'width': 640, 'height': 480};
  
  final List<String> resolutions = ['320x240', '640x480', '1280x720'];
  final String serverUrl = 'https://exercisedeploy-791062084724.us-central1.run.app';

  @override
  void initState() {
    super.initState();
    frameInterval = 1000 / frameRate;
  }

  @override
  void dispose() {
    stopSendingFrames();
    _controller?.dispose();
    socket?.disconnect();
    frameTimer?.cancel();
    super.dispose();
  }

  void log(String message) {
    final timestamp = DateFormat('HH:mm:ss').format(DateTime.now());
    if (mounted) {
      setState(() {
        logs.add('[$timestamp] $message');
      });
    }
  }
  
  void updateFPS() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - lastFpsTime;
    
    if (elapsed >= 1000) {
      final fps = ((frameCount * 1000) / elapsed).round();
      if (mounted) {
        setState(() {
          currentFps = fps;
          frameCount = 0;
          lastFpsTime = now;
        });
      }
    }
  }
  
  void updateLatency() {
    if (latencyValues.isNotEmpty) {
      final avgLatency = latencyValues.reduce((a, b) => a + b) / latencyValues.length;
      
      if (latencyValues.length > 10) {
        latencyValues.clear();
      }
      
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> startCamera() async {
    try {
      final parts = selectedResolution.split('x');
      final width = int.parse(parts[0]);
      final height = int.parse(parts[1]);
      resolution = {'width': width, 'height': height};
      
      ResolutionPreset preset;
      if (width <= 320) {
        preset = ResolutionPreset.low;
      } else if (width <= 640) {
        preset = ResolutionPreset.medium;
      } else {
        preset = ResolutionPreset.high;
      }
      
      final CameraController cameraController = CameraController(
        widget.camera,
        preset,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await cameraController.initialize();
      
      if (mounted) {
        setState(() {
          _controller = cameraController;
          isCameraInitialized = true;
          status = 'Camera started';
        });
      }
      
      log('Camera started');
    } catch (error) {
      log('Camera error: ${error.toString()}');
      if (mounted) {
        setState(() {
          status = 'Error: ${error.toString()}';
        });
      }
    }
  }

  void connectToServer() {
    log('Connecting to $serverUrl...');
    setState(() {
      status = 'Connecting...';
    });
    
    socket = io.io(serverUrl, io.OptionBuilder()
        .setTransports(['websocket'])
        .enableReconnection()
        .setReconnectionAttempts(5)
        .setReconnectionDelay(1000)
        .setTimeout(20000)
        .build());
    
    socket!.on('connect', (_) {
      log('Connected to server');
      if (mounted) {
        setState(() {
          isConnected = true;
          status = 'Connected';
        });
      }
    });
    
    socket!.on('session_id', (data) {
      sessionId = data['session_id'];
      log('Session established: $sessionId');
      if (mounted) {
        setState(() {
          status = 'Session: ${sessionId!.substring(0, 8)}...';
        });
      }
    });
    
    socket!.on('frame', (data) {
      if (data['image'] != null) {
        if (lastFrameSentTime > 0) {
          final now = DateTime.now().millisecondsSinceEpoch;
          final latency = now - lastFrameSentTime;
          latencyValues.add(latency);
          
          if (now - lastLatencyUpdate > 500) {
            updateLatency();
            lastLatencyUpdate = now;
          }
        }
        
        final imageDataUrl = data['image'] as String;
        final base64String = imageDataUrl.split(',')[1];
        final imageBytes = base64Decode(base64String);
        
        if (mounted) {
          setState(() {
            responseImageBytes = imageBytes;
            framesReceived++;
            leftCounter = data['left_counter'] ?? 0;
            rightCounter = data['right_counter'] ?? 0;
            feedback = data['feedback'] ?? '';
          });
        }
        
        frameCount++;
        updateFPS();
      }
    });
    
    socket!.on('error', (data) {
      log('Error: ${data['message']}');
      if (mounted) {
        setState(() {
          status = 'Error: ${data['message']}';
        });
      }
    });
    
    socket!.on('disconnect', (_) {
      log('Disconnected from server');
      if (mounted) {
        setState(() {
          isConnected = false;
          status = 'Disconnected';
        });
      }
      stopSendingFrames();
    });
  }

  void startFrames() {
    if (socket == null || sessionId == null || !isCameraInitialized) {
      log('Cannot start streaming: Missing socket, session, or camera');
      return;
    }
    
    log('Starting to send frames');
    setState(() {
      streamActive = true;
      framesSent = 0;
      framesReceived = 0;
    });
    
    lastFpsTime = DateTime.now().millisecondsSinceEpoch;
    
    socket!.emit('select_exercise', {
      'exercise': 'bicep_curl',
      'session_id': sessionId
    });
    
    frameTimer = Timer.periodic(
      Duration(milliseconds: frameInterval.round()),
      (timer) => sendVideoFrame(),
    );
  }

  void stopSendingFrames() {
    setState(() {
      streamActive = false;
    });
    frameTimer?.cancel();
    frameTimer = null;
    log('Stopped sending frames');
  }

  Future<void> sendVideoFrame() async {
    if (socket == null || sessionId == null || !isCameraInitialized || socket!.disconnected) {
      return;
    }
    
    try {
      final XFile image = await _controller!.takePicture();
      final bytes = await image.readAsBytes();
      
      final processedBytes = await _processImageWithQuality(
        bytes, 
        resolution['width']!, 
        resolution['height']!, 
        imageQuality
      );
      
      final base64Image = 'data:image/jpeg;base64,${base64Encode(processedBytes)}';
      
      lastFrameSentTime = DateTime.now().millisecondsSinceEpoch;
      
      socket!.emit('frame', {
        'session_id': sessionId,
        'image': base64Image
      });
      
      if (mounted) {
        setState(() {
          framesSent++;
        });
      }
    } catch (error) {
      log('Error sending frame: ${error.toString()}');
    }
  }

  Future<Uint8List> _processImageWithQuality(Uint8List imageBytes, int width, int height, double quality) async {
    try {
      final ui.Codec codec = await ui.instantiateImageCodec(
        imageBytes,
        targetWidth: width,
        targetHeight: height,
      );
      final ui.FrameInfo frame = await codec.getNextFrame();
      final ui.Image image = frame.image;
      
      final ui.ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (e) {
      return imageBytes;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 768;
    final isMobile = size.width < 600;
    
    final latency = latencyValues.isNotEmpty 
        ? (latencyValues.reduce((a, b) => a + b) / latencyValues.length).round()
        : 0;

    // Responsive dimensions
    final horizontalPadding = isMobile ? 16.0 : (isTablet ? 32.0 : 24.0);
    final verticalSpacing = isMobile ? 16.0 : 24.0;
    final cardPadding = isMobile ? 16.0 : 24.0;
    final imageWidth = isMobile ? size.width - 64 : (isTablet ? 500.0 : 400.0);
    final imageHeight = isMobile ? (size.width - 64) * 0.75 : (isTablet ? 375.0 : 300.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Exercise Tracker',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 18 : 20,
          ),
        ),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controls Card
            Card(
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Controls',
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: verticalSpacing),
                    
                    // Control Buttons
                    if (isMobile)
                      Column(
                        children: [
                          _buildControlButton('Start Camera', Icons.camera_alt, startCamera, false),
                          const SizedBox(height: 12),
                          _buildControlButton('Connect Server', Icons.wifi, connectToServer, false),
                          const SizedBox(height: 12),
                          _buildControlButton('Start Streaming', Icons.play_arrow, streamActive ? null : startFrames, streamActive),
                          const SizedBox(height: 12),
                          _buildControlButton('Stop Streaming', Icons.stop, streamActive ? stopSendingFrames : null, !streamActive),
                        ],
                      )
                    else
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          _buildControlButton('Start Camera', Icons.camera_alt, startCamera, false),
                          _buildControlButton('Connect Server', Icons.wifi, connectToServer, false),
                          _buildControlButton('Start Streaming', Icons.play_arrow, streamActive ? null : startFrames, streamActive),
                          _buildControlButton('Stop Streaming', Icons.stop, streamActive ? stopSendingFrames : null, !streamActive),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: verticalSpacing),
            
            // Settings Card
            Card(
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: verticalSpacing),
                    
                    // Settings Controls
                    _buildModernSlider(
                      'Frame Rate',
                      frameRate,
                      1,
                      60,
                      '${frameRate.round()} FPS',
                      Icons.speed,
                      (value) {
                        setState(() {
                          frameRate = value;
                          frameInterval = 1000 / frameRate;
                        });
                      },
                      isMobile,
                    ),
                    
                    SizedBox(height: verticalSpacing),
                    
                    _buildModernSlider(
                      'Image Quality',
                      imageQuality * 10,
                      1,
                      10,
                      '${(imageQuality * 100).round()}%',
                      Icons.high_quality,
                      (value) {
                        setState(() {
                          imageQuality = value / 10;
                        });
                      },
                      isMobile,
                    ),
                    
                    SizedBox(height: verticalSpacing),
                    
                    // Resolution Dropdown
                    _buildModernDropdown(isMobile),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: verticalSpacing),
            
            // Server Response Card
            Card(
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exercise Detection',
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 20,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF3B82F6),
                                const Color(0xFF1D4ED8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$currentFps FPS',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: verticalSpacing),
                    
                    // Exercise Display
                    Center(
                      child: Container(
                        width: imageWidth,
                        height: imageHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: responseImageBytes != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  responseImageBytes!,
                                  gaplessPlayback: true,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFFF1F5F9),
                                      const Color(0xFFE2E8F0),
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.fitness_center,
                                        size: 48,
                                        color: Color(0xFF94A3B8),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'Waiting for exercise data...',
                                        style: TextStyle(
                                          color: Color(0xFF64748B),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: verticalSpacing),
            
            // Status Cards
            if (isMobile)
              Column(
                children: [
                  _buildStatusCard('Exercise Counters', isMobile),
                  SizedBox(height: verticalSpacing),
                  _buildMetricsCard(latency, isMobile),
                ],
              )
            else
              Row(
                children: [
                  Expanded(child: _buildStatusCard('Exercise Counters', isMobile)),
                  const SizedBox(width: 24),
                  Expanded(child: _buildMetricsCard(latency, isMobile)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(String text, IconData icon, VoidCallback? onPressed, bool isDisabled) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: Icon(icon, size: 20),
        label: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? const Color(0xFFE2E8F0) : const Color(0xFF3B82F6),
          foregroundColor: isDisabled ? const Color(0xFF94A3B8) : Colors.white,
          elevation: isDisabled ? 0 : 4,
          shadowColor: const Color(0xFF3B82F6).withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
    );
  }

  Widget _buildModernSlider(String label, double value, double min, double max, String displayValue, IconData icon, Function(double) onChanged, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF64748B)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                displayValue,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFF3B82F6),
            inactiveTrackColor: const Color(0xFFE2E8F0),
            thumbColor: const Color(0xFF3B82F6),
            overlayColor: const Color(0xFF3B82F6).withOpacity(0.1),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).round(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildModernDropdown(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.aspect_ratio, size: 20, color: Color(0xFF64748B)),
            const SizedBox(width: 8),
            Text(
              'Resolution',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE2E8F0)),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedResolution,
              isExpanded: true,
              items: resolutions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedResolution = newValue;
                    final parts = newValue.split('x');
                    resolution = {
                      'width': int.parse(parts[0]),
                      'height': int.parse(parts[1])
                    };
                  });
                  log('Resolution changed to $newValue');
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(String title, bool isMobile) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildCounterItem('Left Arm', leftCounter, const Color(0xFF3B82F6)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCounterItem('Right Arm', rightCounter, const Color(0xFF10B981)),
                ),
              ],
            ),
            if (feedback.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD97706).withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.tips_and_updates, color: Color(0xFFD97706), size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feedback,
                        style: const TextStyle(
                          color: Color(0xFF92400E),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsCard(int latency, bool isMobile) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance',
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            _buildMetricRow('Status', status, _getStatusColor()),
            const SizedBox(height: 8),
            _buildMetricRow('Latency', '$latency ms', const Color(0xFF8B5CF6)),
            const SizedBox(height: 8),
            _buildMetricRow('Frames', '$framesSent / $framesReceived', const Color(0xFF06B6D4)),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterItem(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    if (status.contains('Connected') || status.contains('Session')) {
      return const Color(0xFF10B981);
    } else if (status.contains('Error')) {
      return const Color(0xFFEF4444);
    } else {
      return const Color(0xFFF59E0B);
    }
  }
}