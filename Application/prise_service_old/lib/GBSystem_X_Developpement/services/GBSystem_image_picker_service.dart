import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';

class ImagePickerService {
  ImagePickerService(this.context);
  BuildContext context;
  Future<XFile?> pickImageFromGallerie() async {
    XFile? image;
    final ImagePicker picker = ImagePicker();
    if (await storagePermissionGranted()) {
      image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    } else {
      showErrorDialog(context, "storage permission not granted");
    }
    return image;
  }

  Future<XFile?> pickImageFromCamera() async {
    XFile? image;
    final ImagePicker picker = ImagePicker();

    if (await cameraPermissionGranted()) {
      image =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    } else {
      showErrorDialog(context, "camera permission not granted");
    }

    return image;
  }

  Future<bool> cameraPermissionGranted() async {
    final status = await Permission.camera.status;

    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> storagePermissionGranted() async {
    final DeviceInfoPlugin info =
        DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
    debugPrint('releaseVersion : ${androidInfo.version.release}');
    final double androidVersion = double.parse(androidInfo.version.release);
    bool havePermission = false;

    // Here you can use android api level
    // like android api level 33 = android 13
    // This way you can also find out how to request storage permission

    if (androidVersion >= 13) {
      final request = await [
        Permission.videos,
        Permission.photos,
        //..... as needed
      ].request(); //import 'package:permission_handler/permission_handler.dart';

      havePermission =
          request.values.every((status) => status == PermissionStatus.granted);
    } else {
      final status = await Permission.storage.request();
      havePermission = status.isGranted;
    }

    if (!havePermission) {
      // if no permission then open app-setting
      await openAppSettings();
    }

    return havePermission;
  }

  // Future<bool> storagePermissionGranted() async {
  //   final status = await Permission.storage.status;

  //   if (status == PermissionStatus.granted) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  String getFileType(XFile file) {
    // Get the file path from XFile
    String filePath = file.path;

    // Extract the file extension
    String fileExtension = filePath.split('.').last.toLowerCase();

    return fileExtension;
  }

  Future<String> createFolder(String download) async {
    final dir = Directory((Platform.isAndroid
                ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )!
            .path +
        '/$download');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await dir.exists())) {
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }

  Future<void> saveImage(
      String fileName, Uint8List bytes, BuildContext context) async {
    var tempPath = await createFolder("download");
    var tempFile = File('$tempPath/$fileName.jpg');
    tempFile.writeAsBytesSync(bytes);

    try {
      // Get the directory where the PDF file will be saved
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/$fileName.jpg';

      // Write the PDF bytes to a file
      File file = File(filePath);
      await file.writeAsBytes(bytes, flush: true).then((value) {
        showSuccesDialog(context, GbsSystemStrings.str_operation_effectuer);
      });
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  Future<XFile> generateXFileFromBase64(
      String base64String, String fileExtension) async {
    // Remove the header if it exists
    final RegExp regex = RegExp(r'data:image/[^;]+;base64,');
    base64String = base64String.replaceFirst(regex, '');

    // Decode base64 string to bytes
    Uint8List bytes = base64Decode(base64String);

    // Get temporary directory
    Directory tempDir = await getTemporaryDirectory();
    String filePath =
        '${tempDir.path}/image${DateTime.now().day - DateTime.now().month - DateTime.now().year - DateTime.now().hour - DateTime.now().minute - DateTime.now().second - DateTime.now().millisecond}.$fileExtension';

    // Write the file
    File file = File(filePath);
    await file.writeAsBytes(bytes);

    // Return as XFile
    return XFile(file.path);
  }
}
