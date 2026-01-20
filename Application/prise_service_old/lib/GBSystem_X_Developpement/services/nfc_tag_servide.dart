// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
// import 'package:get/get.dart';

// class NFCTagService {
  

//   Future<void> readNFCTag({required bool isEnter}) async {
//     // make the tag null to ensure there is no previous tag used
//     _tag = null;

//     ///
//     Completer<void> completer = Completer<void>();

//     await initPlatformState().then((value) {
//       print(_availability);
//     });

//     _availability == NFCAvailability.available
//         ? NFCBottomSheet.openSnackBar(
//             onPressed: () async {
//               await FlutterNfcKit.finish().then((value) async {
//                 if (Get.isSnackbarOpen) {
//                   Get.closeAllSnackbars();
//                 }
//                 // Get.closeAllSnackbars();
//                 continueScanning = false;

//                 // Complete the completer to interrupt NFC polling
//                 completer.complete();
//                 print("the function is finished  : ${_tag?.id}");
//                 final m = Get.put<UserEntrerSortieController>(
//                     UserEntrerSortieController(
//                   context: context,
//                 ));
//                 if (isEnter) {
//                   await m.entrerFunction(context,
//                       nfc: _tag?.id,
//                       nfcErr: _tag == null
//                           ? _availability == NFCAvailability.disabled
//                               ? "Vous n'avez pas autorise NFC pour l'application"
//                               : _availability == NFCAvailability.not_supported
//                                   ? "le téléphone ne support pas le service NFC"
//                                   : "L'utilisateur ignore le scan TAG NFC"
//                           : null,
//                       qrCode: null,
//                       qrCodeErr: null);
//                 } else {
//                   await m.sortieFunction(context,
//                       nfc: _tag?.id,
//                       nfcErr: _tag == null
//                           ? _availability == NFCAvailability.disabled
//                               ? "Vous n'avez pas autorise NFC pour l'application"
//                               : _availability == NFCAvailability.not_supported
//                                   ? "le téléphone ne support pas le service NFC"
//                                   : "L'utilisateur ignore le scan TAG NFC"
//                           : null,
//                       qrCode: null,
//                       qrCodeErr: null);
//                 }
//               });
//             },
//           )
//         : _availability == NFCAvailability.not_supported
//             ? showWarningDialog(
//                 context, GbsSystemStrings.str_your_device_dont_support_nfc.tr)
//             : _availability == NFCAvailability.disabled
//                 ? showWarningDialog(
//                     context, GbsSystemStrings.str_nfc_disabled.tr)
//                 : showWarningDialog(context,
//                     GbsSystemStrings.str_please_turn_on_nfc_service.tr);

//     // Start NFC scanning process
//     await _performNFCScan(continueScanning, completer);
//     // if (_tag?.id != null) {
//     //   print("------------------");
//     //   print("id : ${_tag?.id}");
//     //   print("------------------");
//     // }
//     print("------------- func finished ---------------");
//   }

//   Future<void> _performNFCScan(
//       bool continueScanning, Completer<void> completer) async {
//     try {
//       while (continueScanning) {
//         NFCTag tag = await FlutterNfcKit.poll();
//         setState(() {
//           _tag = tag;
//         });
//         // Process the NFC tag data
//         print('NFC Tag ID: ${tag.id}');
//         // Add code here to continue with other operations after NFC polling completes
//         if (tag.standard == "ISO 14443-4 (Type B)") {
//           String result1 = await FlutterNfcKit.transceive("00B0950000");
//           String result2 =
//               await FlutterNfcKit.transceive("00A4040009A00000000386980701");
//         } else if (tag.type == NFCTagType.iso18092) {
//           String result1 = await FlutterNfcKit.transceive("060080080100");
//         } else if (tag.type == NFCTagType.mifare_ultralight ||
//             tag.type == NFCTagType.mifare_classic ||
//             tag.type == NFCTagType.iso15693) {
//           var ndefRecords = await FlutterNfcKit.readNDEFRecords();
//           var ndefString = '';
//           for (int i = 0; i < ndefRecords.length; i++) {
//             ndefString += '${i + 1}: ${ndefRecords[i]}\n';
//           }
//         } else if (tag.type == NFCTagType.webusb) {
//           var r = await FlutterNfcKit.transceive("00A4040006D27600012401");
//         }

//         // If a tag is successfully scanned, stop scanning immediately
//         continueScanning = false;
//       }
//     } catch (e) {
//       // Handle any errors that occur during NFC polling
//       print('Error during NFC polling: $e');
//     }

//     // Pretend that we are working
//     if (!GbsSystemServerStrings.kIsWeb) sleep(const Duration(seconds: 1));
//     await FlutterNfcKit.finish(iosAlertMessage: "Finished!");

//     // Complete the completer if it's not completed already
//     if (!completer.isCompleted) {
//       completer.complete();
//     }
//   }
// }
