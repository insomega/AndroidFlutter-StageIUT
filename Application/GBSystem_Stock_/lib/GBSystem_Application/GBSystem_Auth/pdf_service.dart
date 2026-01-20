import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//import 'GBSystem_Ajoutshare_plus_service.dart';

import 'package:permission_handler/permission_handler.dart';
// boubaker 06/02/2025
// import 'package:file_saver/file_saver.dart';
// import 'package:mime_type/mime_type.dart';

class PDFService {
  Future<String> createFolder(String download) async {
    final dir = Directory(
      (Platform.isAndroid
                  ? await getExternalStorageDirectory() //FOR ANDROID
                  : await getApplicationSupportDirectory() //FOR IOS
                    )!
              .path +
          '/$download',
    );
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

  Future<double> getAndroidVersion() async {
    // String version = Platform.operatingSystemVersion;

    // // Extract first number (Android version)
    // RegExp regExp = RegExp(r'\d+');
    // Match? match = regExp.firstMatch(version);

    // if (match != null) {
    //   return int.parse(match.group(0)!);
    // }
    // return 0; // Default value if parsing fails
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return double.parse(androidInfo.version.release); // Extracts Android version
  }

  Future<String?> downloadAndSavePDF(String fileName, Uint8List pdfBytes, BuildContext context, {bool addExtension = false, bool autoShare = true}) async {
    try {
      // save at app directory to can share it
      Directory downloadsDir = await getApplicationDocumentsDirectory();
      // Ensure the directory exists
      if (!downloadsDir.existsSync()) {
        downloadsDir.createSync(recursive: true);
      }
      late String filePath;

      // boubaker 10/02/2025
      /*
      // Define the file path
      if (!fileName.contains(".")) {
        filePath = '${downloadsDir.path}/$fileName.pdf';
      } else {
        filePath = '${downloadsDir.path}/$fileName';
      }
*/
      // Define the file path
      if (!fileName.contains(".")) {
        fileName = '$fileName.pdf';
      }

      filePath = '${downloadsDir.path}/$fileName';

      // Write the file
      File file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      if (autoShare) {
        if (Platform.isAndroid) {
          double androidVersion = await getAndroidVersion();
          print("version android : $androidVersion");
          if (androidVersion <= 9) {
            print("Auto Download");
            Directory? downloadsDir = Directory('/storage/emulated/0/Download');
            // boubaker 10/02/2025
            //  String filePath = '${downloadsDir.path}/$fileName.pdf';
            String filePath = '${downloadsDir.path}/$fileName';
            if (!await Permission.storage.request().isGranted) {
              print("Storage permission denied.");
              return null;
            }
            // Ensure the Downloads directory exists
            if (!downloadsDir.existsSync()) {
              downloadsDir.createSync(recursive: true);
            }
            // Save the file
            File file = File(filePath);
            await file.writeAsBytes(pdfBytes);
          } else {
            //Amar--  SharePlusService().shareFile(filePath);
          }
        } else {
          //Amar--SharePlusService().shareFile(filePath);
        }
      }

      return filePath; // Return the saved file path
    } catch (e) {
      print("Error saving PDF: $e");
    }
    return null;
  }

  // Future<void> downloadAndSavePDF(
  //     String fileName, Uint8List pdfBytes, BuildContext context,
  //     {bool addExtension = false}) async {
  //   /*
  //   // await FileSaver.instance.saveFile(
  //   //     {name: fileName, mimeType: 'PDF', ext: ".PDF", bytes: pdfBytes});
  //   try {

  //     var filePath = await createFolder("download");
  //     await FileSaver.instance.saveFile(
  //         name: fileName,
  //         bytes: pdfBytes,
  //         ext: 'pdf',
  //         mimeType: MimeType.pdf,
  //         filePath: filePath);
  //     print('File saved to: $fileName');
  //   } catch (e) {
  //     print('Error saving file: $e');
  //   }
  //      */

  //   var tempPath = await createFolder("download");
  //   var tempFile;
  //   if (addExtension) {
  //     tempFile = File('$tempPath/$fileName.pdf');
  //   } else {
  //     tempFile = File('$tempPath/$fileName');
  //   }

  //   tempFile.writeAsBytesSync(pdfBytes);

  //   try {
  //     // Get the directory where the PDF file will be saved
  //     // Directory directory = await getApplicationDocumentsDirectory();
  //     Directory directory = await getApplicationDocumentsDirectory();

  //     String filePath = '${directory.path}/planningPDF.pdf';

  //     // Write the PDF bytes to a file
  //     File file = File(filePath);
  //     await file.writeAsBytes(pdfBytes, flush: true).then((value) {
  //       showSuccesDialog(
  //           context, GBSystem_Application_Strings.str_file_uploaded_with_success.tr);
  //     });
  //   } catch (e) {
  //     showErrorDialog(context, e.toString());
  //   }
  // }

  Uint8List cleanPDFStringAndConvertToUnit8List({required String stringPDF}) {
    String cleanedString = stringPDF;

    /// first cond

    if (stringPDF.startsWith('data:application/octet-stream;base64,')) {
      int entrerLength = 'data:application/octet-stream;base64,'.length;
      // print( stringPDF.substring(entrerLength));
      // print( stringPDF.substring(entrerLength,stringPDF.length));

      cleanedString = stringPDF.substring(entrerLength);
    } else {
      cleanedString = stringPDF;
    }
    //second cond

    if (cleanedString.startsWith('data:application/pdf;base64,')) {
      int entrerLength = 'data:application/pdf;base64,'.length;
      // print( cleanedString.substring(entrerLength));
      // print( cleanedString.substring(entrerLength,cleanedString.length));

      cleanedString = cleanedString.substring(entrerLength);
    } else {
      cleanedString = cleanedString;
    }
    print("cleaned : $cleanedString");
    Uint8List bytes;

    bytes = base64Decode(cleanedString);

    return bytes;
  }
}
