// lib/core/services/permission_service.dart
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionService {
  static const String _cameraPermissionKey = 'camera_permission_granted';
  static const String _dataCollectionKey = 'data_collection_granted';
  
  // Check if all required permissions are granted
  static Future<bool> areAllPermissionsGranted() async {
    final prefs = await SharedPreferences.getInstance();
    final isCameraGranted = prefs.getBool(_cameraPermissionKey) ?? false;
    final isDataCollectionGranted = prefs.getBool(_dataCollectionKey) ?? false;
    
    return isCameraGranted && isDataCollectionGranted;
  }
  
  // Request camera permission
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    final isGranted = status.isGranted;
    
    // Save the permission status
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_cameraPermissionKey, isGranted);
    
    return isGranted;
  }
  
  // Request data collection permission
  static Future<bool> requestDataCollectionPermission(bool granted) async {
    // Save the user's choice
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dataCollectionKey, granted);
    
    return granted;
  }
  
  // Check camera permission status
  static Future<bool> checkCameraPermission() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }
  
  // Check if data collection permission was granted
  static Future<bool> checkDataCollectionPermission() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_dataCollectionKey) ?? false;
  }
  
  // Reset all permissions (for testing purposes)
  static Future<void> resetPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cameraPermissionKey);
    await prefs.remove(_dataCollectionKey);
  }
}