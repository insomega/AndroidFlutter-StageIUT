import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/SCAN_BARCODE_SCREEN/GBSytem_scan_barcode_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_date_picker.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_title.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/GBSystem_info_vacation_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/GBSystem_user_entrer_sortie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/button_entrer_sortie.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/nfc_bottom_sheet.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'dart:io' show sleep;

import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class MapTest extends StatefulWidget {
  const MapTest({super.key});

  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> with SingleTickerProviderStateMixin {
  NFCAvailability _availability = NFCAvailability.not_supported;
  NFCTag? _tag;
  late TabController _tabController;
  String? messageErrNFC;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (!GbsSystemServerStrings.kIsWeb) {
    } else {}
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPlatformState();
    });

    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> initPlatformState() async {
    NFCAvailability availability;
    try {
      availability = await FlutterNfcKit.nfcAvailability;
    } on PlatformException {
      availability = NFCAvailability.not_supported;
    }

    if (!mounted) return;

    setState(() {
      _availability = availability;
    });
  }

  Completer<NFCTag>? _completer;

  Future<void> _finishNFC() async {
    await FlutterNfcKit.finish();
    // If NFC polling is still ongoing, cancel it
    _completer?.complete();
    if (_completer != null && !_completer!.isCompleted) {
      _completer!.completeError('NFC polling was canceled');
    }
  }

// --------------------------------------------

  bool isFunctionRunning = false;

  Future<void> startFunction() async {
    bool functionCompleted = false;
    print('Function started');
    await Future.delayed(Duration(seconds: 5));
    if (isFunctionRunning) {
      functionCompleted = true;
      print('Function completed successfully');
    } else {
      print('Function stopped manually');
    }
    // Print message only if the function completed successfully
    if (functionCompleted) {
      print("after running code !!!");
    }
  }

  void stopFunction() {
    print('Function stopped manually');
    setState(() {
      isFunctionRunning = false;
    });
  }

  bool continueScanning = true; // Flag to control NFC scanning loop
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            setState(() {
              isFunctionRunning = true;
            });
            try {
              await startFunction();
            } catch (error) {
              print('Error occurred: $error');
            }
          },
          child: Text('Start Function'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            stopFunction();
          },
          child: Text('Stop Function'),
        ),
        CustomButton(
          text: "open nfc",
          onTap: () async {
            // fetchDataFromServer().then((data) {
            //   print('Data received: $data');
            // });
            continueScanning = true;

            await readNFCTag().then((value) {
              // Get.closeAllSnackbars();
              Get.back();
              if (continueScanning) {
                print("the function is finished  : ${_tag?.id}");
              }
            });
          },
        ),
        // CustomButton(
        //   text: "open nfc",
        //   onTap: () async {
        //     await _finishNFC();
        //   },
        // ),
      ],
    ));
  }

  Future<String> fetchDataFromServer() {
    Completer<String> completer = Completer<String>();

    // Simulate fetching data from server after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      completer.complete('Data from server');
    });

    return completer.future;
  }

  Future<void> readNFCTag() async {
    Completer<void> completer = Completer<void>();

    await initPlatformState().then((value) {
      print(_availability);
    });

    _availability == NFCAvailability.available
        ? NFCBottomSheet.openSnackBar(
            onPressed: () async {
              await FlutterNfcKit.finish().then((value) {
                Get.back();
                // Get.closeAllSnackbars();
                continueScanning = false;

                // Complete the completer to interrupt NFC polling
                completer.complete();
                print("the function is finished  : ${_tag?.id}");
              });
            },
          )
        : _availability == NFCAvailability.not_supported
            ? showWarningDialog(
                context, GbsSystemStrings.str_your_device_dont_support_nfc.tr)
            : _availability == NFCAvailability.disabled
                ? showWarningDialog(
                    context, GbsSystemStrings.str_nfc_disabled.tr)
                : showWarningDialog(context,
                    GbsSystemStrings.str_please_turn_on_nfc_service.tr);

    // Start NFC scanning process
    await _performNFCScan(continueScanning, completer);
    if (_tag?.id != null) {
      print("------------------");
      print("id : ${_tag?.id}");
      print("------------------");
    }
    print("------------- func finished ---------------");
  }

  Future<void> _performNFCScan(
      bool continueScanning, Completer<void> completer) async {
    try {
      while (continueScanning) {
        NFCTag tag = await FlutterNfcKit.poll();
        setState(() {
          _tag = tag;
        });
        // Process the NFC tag data
        print('NFC Tag ID: ${tag.id}');
        // Add code here to continue with other operations after NFC polling completes
        if (tag.standard == "ISO 14443-4 (Type B)") {
          String result1 = await FlutterNfcKit.transceive("00B0950000");
          String result2 =
              await FlutterNfcKit.transceive("00A4040009A00000000386980701");
        } else if (tag.type == NFCTagType.iso18092) {
          String result1 = await FlutterNfcKit.transceive("060080080100");
        } else if (tag.type == NFCTagType.mifare_ultralight ||
            tag.type == NFCTagType.mifare_classic ||
            tag.type == NFCTagType.iso15693) {
          var ndefRecords = await FlutterNfcKit.readNDEFRecords();
          var ndefString = '';
          for (int i = 0; i < ndefRecords.length; i++) {
            ndefString += '${i + 1}: ${ndefRecords[i]}\n';
          }
        } else if (tag.type == NFCTagType.webusb) {
          var r = await FlutterNfcKit.transceive("00A4040006D27600012401");
        }

        // If a tag is successfully scanned, stop scanning immediately
        continueScanning = false;
      }
    } catch (e) {
      // Handle any errors that occur during NFC polling
      print('Error during NFC polling: $e');
    }

    // Pretend that we are working
    if (!GbsSystemServerStrings.kIsWeb) sleep(const Duration(seconds: 1));
    await FlutterNfcKit.finish(iosAlertMessage: "Finished!");

    // Complete the completer if it's not completed already
    if (!completer.isCompleted) {
      completer.complete();
    }
  }

  // Future<void> _performNFCScan(
  //     bool continueScanning, Completer<void> completer) async {
  //   try {
  //     while (continueScanning) {
  //       NFCTag tag = await FlutterNfcKit.poll(
  //           // timeout: Duration(seconds: 5),
  //           );

  //       // Process the NFC tag data
  //       print('NFC Tag ID: ${tag.id}');
  //       // Add code here to continue with other operations after NFC polling completes
  //       if (tag.standard == "ISO 14443-4 (Type B)") {
  //         String result1 = await FlutterNfcKit.transceive("00B0950000");
  //         String result2 =
  //             await FlutterNfcKit.transceive("00A4040009A00000000386980701");
  //       } else if (tag.type == NFCTagType.iso18092) {
  //         String result1 = await FlutterNfcKit.transceive("060080080100");
  //       } else if (tag.type == NFCTagType.mifare_ultralight ||
  //           tag.type == NFCTagType.mifare_classic ||
  //           tag.type == NFCTagType.iso15693) {
  //         var ndefRecords = await FlutterNfcKit.readNDEFRecords();
  //         var ndefString = '';
  //         for (int i = 0; i < ndefRecords.length; i++) {
  //           ndefString += '${i + 1}: ${ndefRecords[i]}\n';
  //         }
  //       } else if (tag.type == NFCTagType.webusb) {
  //         var r = await FlutterNfcKit.transceive("00A4040006D27600012401");
  //       }
  //     }
  //   } catch (e) {
  //     // Handle any errors that occur during NFC polling
  //     print('Error during NFC polling: $e');
  //   }

  //   // Pretend that we are working
  //   if (!GbsSystemServerStrings.kIsWeb) sleep(const Duration(seconds: 1));
  //   await FlutterNfcKit.finish(iosAlertMessage: "Finished!");

  //   // Complete the completer if it's not completed already
  //   if (!completer.isCompleted) {
  //     completer.complete();
  //   }
  // }

  // Future<void> readNFCTag() async {
  //   Completer<void> completer = Completer<void>();

  //   await initPlatformState().then((value) {
  //     // updateMessageNFC(_availability);
  //     print(_availability);
  //   });
  //   bool continueScanning = true; // Flag to control NFC scanning loop

  //   _availability == NFCAvailability.available
  //       ? NFCBottomSheet.openSnackBar(
  //           onPressed: () async {
  //             await FlutterNfcKit.finish().then((value) {
  //               Get.back();
  //               continueScanning = false;

  //               // Complete the completer to interrupt NFC polling
  //               completer.complete();
  //             });
  //           },
  //         )
  //       : _availability == NFCAvailability.not_supported
  //           ? showWarningDialog(
  //               context, GbsSystemStrings.str_your_device_dont_support_nfc.tr)
  //           : _availability == NFCAvailability.disabled
  //               ? showWarningDialog(
  //                   context, GbsSystemStrings.str_nfc_disabled.tr)
  //               : showWarningDialog(context,
  //                   GbsSystemStrings.str_please_turn_on_nfc_service.tr);

  //   if (_availability == NFCAvailability.available) {
  //     try {
  //       while (continueScanning) {
  //         await Future.delayed(Duration(seconds: 5), () async {
  //           NFCTag tag = await FlutterNfcKit.poll(
  //             timeout: Duration(seconds: 5),
  //           );

  //           // Process the NFC tag data
  //           print('NFC Tag ID: ${tag.id}');
  //           // Add code here to continue with other operations after NFC polling completes
  //           if (tag.standard == "ISO 14443-4 (Type B)") {
  //             String result1 = await FlutterNfcKit.transceive("00B0950000");
  //             String result2 = await FlutterNfcKit.transceive(
  //                 "00A4040009A00000000386980701");
  //           } else if (tag.type == NFCTagType.iso18092) {
  //             String result1 = await FlutterNfcKit.transceive("060080080100");
  //           } else if (tag.type == NFCTagType.mifare_ultralight ||
  //               tag.type == NFCTagType.mifare_classic ||
  //               tag.type == NFCTagType.iso15693) {
  //             var ndefRecords = await FlutterNfcKit.readNDEFRecords();
  //             var ndefString = '';
  //             for (int i = 0; i < ndefRecords.length; i++) {
  //               ndefString += '${i + 1}: ${ndefRecords[i]}\n';
  //             }
  //           } else if (tag.type == NFCTagType.webusb) {
  //             var r = await FlutterNfcKit.transceive("00A4040006D27600012401");
  //           }
  //         });
  //       }
  //     } catch (e) {
  //       // Handle any errors that occur during NFC polling
  //       print('Error during NFC polling: $e');
  //     }

  //     // Pretend that we are working
  //     if (!GbsSystemServerStrings.kIsWeb) sleep(const Duration(seconds: 1));
  //     await FlutterNfcKit.finish(iosAlertMessage: "Finished!");
  //   }

  //   print("------------- func finished ---------------");
  // }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
// import 'package:get/get.dart';
// import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
// import 'package:portail_salarie/GBSystem_X_Developpement/helper/nfc_bottom_sheet.dart';
// import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
// import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
// import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
// import 'dart:io' show sleep;

// class TestNFCTag extends StatefulWidget {
//   const TestNFCTag({super.key});

//   @override
//   State<TestNFCTag> createState() => _TestNFCTagState();
// }

// class _TestNFCTagState extends State<TestNFCTag>
//     with SingleTickerProviderStateMixin {
//   NFCAvailability _availability = NFCAvailability.not_supported;
//   NFCTag? _tag;
//   late TabController _tabController;

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     if (!GbsSystemServerStrings.kIsWeb) {
//     } else {}
//     initPlatformState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   Future<void> initPlatformState() async {
//     NFCAvailability availability;
//     try {
//       availability = await FlutterNfcKit.nfcAvailability;
//     } on PlatformException {
//       availability = NFCAvailability.not_supported;
//     }

//     if (!mounted) return;

//     setState(() {
//       _availability = availability;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           CustomButton(
//             text: "start scan",
//             onTap: () async {
//               _availability == NFCAvailability.available
//                   ? NFCBottomSheet.openBottomSheetAdresse(context)
//                   : _availability == NFCAvailability.not_supported
//                       ? showWarningDialog(context,
//                           GbsSystemStrings.str_your_device_dont_support_nfc.tr)
//                       : _availability == NFCAvailability.disabled
//                           ? showWarningDialog(
//                               context, GbsSystemStrings.str_nfc_disabled.tr)
//                           : showWarningDialog(
//                               context,
//                               GbsSystemStrings
//                                   .str_please_turn_on_nfc_service.tr);

//               if (_availability == NFCAvailability.available) {
//                 try {
//                   NFCTag tag = await FlutterNfcKit.poll();
//                   setState(() {
//                     _tag = tag;
//                   });
//                   await FlutterNfcKit.setIosAlertMessage("Working on it...");
//                   if (tag.standard == "ISO 14443-4 (Type B)") {
//                     String result1 =
//                         await FlutterNfcKit.transceive("00B0950000");
//                     String result2 = await FlutterNfcKit.transceive(
//                         "00A4040009A00000000386980701");
//                     setState(() {});
//                   } else if (tag.type == NFCTagType.iso18092) {
//                     String result1 =
//                         await FlutterNfcKit.transceive("060080080100");
//                     setState(() {});
//                   } else if (tag.type == NFCTagType.mifare_ultralight ||
//                       tag.type == NFCTagType.mifare_classic ||
//                       tag.type == NFCTagType.iso15693) {
//                     var ndefRecords = await FlutterNfcKit.readNDEFRecords();
//                     var ndefString = '';
//                     for (int i = 0; i < ndefRecords.length; i++) {
//                       ndefString += '${i + 1}: ${ndefRecords[i]}\n';
//                     }
//                     setState(() {});
//                   } else if (tag.type == NFCTagType.webusb) {
//                     var r = await FlutterNfcKit.transceive(
//                         "00A4040006D27600012401");
//                   }
//                 } catch (e) {
//                   setState(() {});
//                 }

//                 // Pretend that we are working
//                 if (!GbsSystemServerStrings.kIsWeb)
//                   sleep(const Duration(seconds: 1));
//                 await FlutterNfcKit.finish(iosAlertMessage: "Finished!");
//               }

//               if (_tag?.id != null) {
//                 print("------------------");
//                 print(_tag?.id);
//                 print("------------------");

//                 Get.back();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
