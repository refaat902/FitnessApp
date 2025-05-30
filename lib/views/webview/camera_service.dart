

import 'package:camera/camera.dart';

class CameraService {
  static Future<List<CameraDescription>> getAvailableCameras() async {
    // Returns a list of available cameras on the device
    return await availableCameras();
  }

  static Future<CameraDescription> getDefaultCamera() async {
    final cameras = await getAvailableCameras();
    
    // Look for a front-facing camera
    for (var camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        return camera; // Return the front camera when found
      }
    }
    
    // If no front camera is found, return the first available camera
    return cameras.first;
  }
}