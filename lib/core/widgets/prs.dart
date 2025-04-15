// lib/views/permission/permission_request_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/pc.dart';
import 'package:flutter_application_1/views/navigation/navigation_page.dart';
import 'package:flutter_application_1/views/pageview/pageview.dart';


class PermissionRequestScreen extends StatefulWidget {
  final bool isLoggedIn;

  const PermissionRequestScreen({
    Key? key,
    required this.isLoggedIn,
  }) : super(key: key);

  @override
  State<PermissionRequestScreen> createState() => _PermissionRequestScreenState();
}

class _PermissionRequestScreenState extends State<PermissionRequestScreen> {
  bool _cameraPermissionGranted = false;
  bool _dataCollectionGranted = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final cameraStatus = await PermissionService.checkCameraPermission();
    final dataStatus = await PermissionService.checkDataCollectionPermission();
    
    setState(() {
      _cameraPermissionGranted = cameraStatus;
      _dataCollectionGranted = dataStatus;
      _isLoading = false;
    });
    
    // If all permissions are already granted, navigate to the appropriate screen
    if (_cameraPermissionGranted && _dataCollectionGranted) {
      _navigateToNextScreen();
    }
  }

  Future<void> _requestCameraPermission() async {
    final granted = await PermissionService.requestCameraPermission();
    setState(() {
      _cameraPermissionGranted = granted;
    });
  }

  Future<void> _setDataCollectionPermission(bool granted) async {
    final result = await PermissionService.requestDataCollectionPermission(granted);
    setState(() {
      _dataCollectionGranted = result;
    });
  }

  void _navigateToNextScreen() {
    if (_cameraPermissionGranted && _dataCollectionGranted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => widget.isLoggedIn 
              ? const NavigationPage() 
              : const PageViewWithSlider(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Required Permissions',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Camera permission card
              _buildPermissionCard(
                context,
                title: 'Camera Access',
                description: 'We need access to your camera to enable core functionality of the app.',
                isGranted: _cameraPermissionGranted,
                onRequest: _requestCameraPermission,
                icon: Icons.camera_alt_outlined,
              ),
              
              const SizedBox(height: 16),
              
              // Data collection permission card
              _buildPermissionCard(
                context,
                title: 'Data Collection',
                description: 'Allow us to collect and save your data to provide personalized experience.',
                isGranted: _dataCollectionGranted,
                onRequest: () => _setDataCollectionPermission(true),
                icon: Icons.storage_outlined,
              ),
              
              const Spacer(),
              
              // Continue button
              ElevatedButton(
                onPressed: (_cameraPermissionGranted && _dataCollectionGranted)
                    ? _navigateToNextScreen
                    : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: (_cameraPermissionGranted && _dataCollectionGranted)
                      ? Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({})
                      : Colors.grey,
                ),
                child: const Text('CONTINUE'),
              ),
              
              const SizedBox(height: 16),
              
              // Exit app button
              TextButton(
                onPressed: () {
                  // In a real app, you would exit the app here
                  // For now, we'll just show a dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Exit App'),
                      content: const Text('These permissions are required to use the app.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Exit App'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionCard(
    BuildContext context, {
    required String title,
    required String description,
    required bool isGranted,
    required VoidCallback onRequest,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xff289004)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          isGranted
              ? const Icon(Icons.check_circle, color: Color(0xff289004))
              : TextButton(
                  onPressed: onRequest,
                  child: const Text('GRANT'),
                ),
        ],
      ),
    );
  }
}