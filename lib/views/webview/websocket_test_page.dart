import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'websocket_frame_test.dart';
import 'camera_service.dart';

class WebSocketTestPage extends StatefulWidget {
  const WebSocketTestPage({Key? key}) : super(key: key);

  @override
  State<WebSocketTestPage> createState() => _WebSocketTestPageState();
}

class _WebSocketTestPageState extends State<WebSocketTestPage> {
  bool _isLoading = true;
  CameraDescription? _camera;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final camera = await CameraService.getDefaultCamera();
      setState(() {
        _camera = camera;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Could not initialize camera: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                      _errorMessage = null;
                    });
                    _initCamera();
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Camera is initialized, show the WebSocket test page
    return WebSocketFrameTest(camera: _camera!);
  }
}