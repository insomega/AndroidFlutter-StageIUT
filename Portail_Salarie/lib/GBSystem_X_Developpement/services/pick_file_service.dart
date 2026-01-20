import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickFileService {
  Future<PlatformFile?> pickFile() async {
    await allowManageStoragePermission(); // Ensure storage permission is granted

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        "pdf",
        // "png", "jpg", "jpeg"
      ],
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.single; // This will return the selected file
    } else {
      print("No file picked or canceled.");
      return null;
    }
  }

  // Future<PlatformFile?> pickFile() async {
  //   await allowManageStoragePermission();

  //   PlatformFile? filePath = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowMultiple: false,
  //       allowedExtensions: [
  //         "pdf",
  //         // "png", "jpg"
  //       ]).then((result) {
  //     if (result != null) {
  //       return result.files.single;
  //     } else {
  //       return null;
  //     }
  //   });
  //   return filePath;
  // }

  Future<String> encodeFileToBase64(PlatformFile file,
      {required String? extension}) async {
    try {
      File file1 = File(file.path!);
      List<int>? fileBytes = await file1.readAsBytes();
      String? base64File = base64Encode(fileBytes);
      String? dataUri;
      // Construct the data URI
      // String dataUri = 'data:application/pdf;base64,$base64File';
      if (extension?.replaceAll(" ", "") == "pdf") {
        dataUri = 'data:application/${extension ?? "pdf"};base64,$base64File';
      } else {
        dataUri = 'data:image/${extension ?? "png"};base64,$base64File';
      }

      return dataUri;
    } catch (e) {
      // print('Error encoding file: $e');
      return '';
    }
  }

  Future<String> encodeFileToBase64WithoutIntro(PlatformFile file,
      {required String? extension}) async {
    try {
      File file1 = File(file.path!);
      List<int>? fileBytes = await file1.readAsBytes();
      String? base64File = base64Encode(fileBytes);
      String? dataUri;
      if (extension?.replaceAll(" ", "") == "pdf") {
        dataUri = '$base64File';
      } else {
        dataUri = '$base64File';
      }

      return dataUri;
    } catch (e) {
      // print('Error encoding file: $e');
      return '';
    }
  }

  Future<void> allowManageStoragePermission() async {
    // boubaker 06/02/2025 google play: Mise à jour refusée, Politique d'autorisation d'accès à tous les fichiers : Pas une fonctionnalité principale
    // if (await Permission.manageExternalStorage.isDenied) {
    //   Permission.manageExternalStorage.request();
    // }
  }
}
