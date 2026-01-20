import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  // Method to request storage permission
  Future<PermissionStatus> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      print("Storage permission granted.");
    } else if (status.isDenied) {
      print("Storage permission denied.");
    } else if (status.isPermanentlyDenied) {
      print("Storage permission permanently denied. Opening settings...");
      await openAppSettings();
    }
    return status;
  }

  // Method to check storage permission status
  Future<PermissionStatus> checkStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    print("Storage permission status: $status");
    return status;
  }

  // Method to request camera permission
  Future<PermissionStatus> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      print("Camera permission granted.");
    } else if (status.isDenied) {
      print("Camera permission denied.");
    } else if (status.isPermanentlyDenied) {
      print("Camera permission permanently denied. Opening settings...");
      await openAppSettings();
    }
    return status;
  }

  // Method to check camera permission status
  Future<PermissionStatus> checkCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    print("Camera permission status: $status");
    return status;
  }

  // Method to request location permission
  Future<PermissionStatus> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      print("Location permission granted.");
    } else if (status.isDenied) {
      print("Location permission denied.");
    } else if (status.isPermanentlyDenied) {
      print("Location permission permanently denied. Opening settings...");
      await openAppSettings();
    }
    return status;
  }

  // Method to check location permission status
  Future<PermissionStatus> checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    print("Location permission status: $status");
    return status;
  }

  // Method to request microphone permission
  Future<PermissionStatus> requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status.isGranted) {
      print("Microphone permission granted.");
    } else if (status.isDenied) {
      print("Microphone permission denied.");
    } else if (status.isPermanentlyDenied) {
      print("Microphone permission permanently denied. Opening settings...");
      await openAppSettings();
    }
    return status;
  }

  // Method to check microphone permission status
  Future<PermissionStatus> checkMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    print("Microphone permission status: $status");
    return status;
  }

  // Method to request all permissions at once
  Future<Map<Permission, PermissionStatus>> requestAllPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.location,
      Permission.microphone,
    ].request();
    print("All permission statuses: $statuses");
    return statuses;
  }

  // Method to check if permissions are permanently denied
  bool arePermissionsPermanentlyDenied(PermissionStatus status) {
    return status.isPermanentlyDenied;
  }
}
