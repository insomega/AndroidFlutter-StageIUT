import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_map_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/SCAN_BARCODE_SCREEN/GBSytem_scan_barcode_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_title.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/PRISE_SERVICE_MAP/GBSystem_user_entrer_sortie_map_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/button_entrer_sortie.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/nfc_bottom_sheet.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'dart:io' show sleep;

import 'package:qr_code_scanner/qr_code_scanner.dart';

class UserEnterSortieMap extends StatefulWidget {
  UserEnterSortieMap(
      {super.key,
      this.isPlanning = false,
      this.afficherPrecSuiv = true,
      this.availability,
      this.afficherOpertaionsBar = true,
      this.updateUI});

  final bool afficherPrecSuiv, afficherOpertaionsBar;
  final bool isPlanning;
  final Function? updateUI;
  final NFCAvailability? availability;

  @override
  State<UserEnterSortieMap> createState() => _UserEnterSortieMapState();
}

class _UserEnterSortieMapState extends State<UserEnterSortieMap>
    with SingleTickerProviderStateMixin {
  Barcode? qrCode;

  void updateQrCode(Barcode? scanedQrCode) {
    setState(() {
      qrCode = scanedQrCode;
    });
  }

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
    print(qrCode?.code);
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

  bool continueScanning = true; // Flag to control NFC scanning loop
  @override
  Widget build(BuildContext context) {
    final m =
        Get.put<UserEntrerSortieMapController>(UserEntrerSortieMapController(
      context: context,
    ));
    final vacationController =
        Get.put<GBSystemVacationMapController>(GBSystemVacationMapController());
    return Obx(() => Stack(
          children: [
            ImageFiltered(
              imageFilter: m.isLoading.value == true
                  ? ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0)
                  : ImageFilter.blur(sigmaX: 00.0, sigmaY: 0.0),
              child: Container(
                height: 350,
                padding: EdgeInsets.symmetric(
                  vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.01),
                  horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                      context, 0.04),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                      width: 0.4, color: Colors.grey, style: BorderStyle.solid),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // CustomButton(
                        //   text: "print qr",
                        //   onTap: () {
                        //     print(qrCode?.code);
                        //   },
                        // ),
                        Visibility(
                          visible:
                              vacationController.getCurrentVacation != null,
                          child: VacationTitle(
                              title: vacationController
                                          .getCurrentVacation?.VAC_START_HOUR !=
                                      null
                                  ? ConvertDateService().formatDateTimeVacation(
                                      vacationController
                                          .getCurrentVacation!.VAC_START_HOUR!)
                                  : ""

                              // title: vacationController
                              //         .getCurrentVacation?.TITLE ??
                              //     vacationController
                              //         .getCurrentVacation?.TITLE ??
                              //     ""
                              ),
                        ),
                        vacationController.getCurrentVacation != null
                            ? const SizedBox(
                                height: 10,
                              )
                            : const SizedBox(),
                        vacationController.getCurrentVacation != null
                            ? SizedBox(
                                height: 200,
                                width:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.8),
                                child: PageView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: m.pageController,
                                  children: m.vacationPages,
                                ),
                              )
                            : SizedBox(
                                height: 200,
                                width:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.8),
                                child: Center(
                                  child: GBSystem_TextHelper().smallText(
                                      text: GbsSystemStrings
                                          .str_aucune_vacation.tr,
                                      textColor: Colors.black),
                                ),
                              ),
                        SizedBox(
                          height: GBSystem_ScreenHelper.screenHeightPercentage(
                              context, 0.03),
                        ),
                        Visibility(
                          visible:
                              vacationController.getCurrentVacation != null &&
                                  widget.afficherOpertaionsBar,
                          child: SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.85),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Visibility(
                                  visible: widget.afficherPrecSuiv,
                                  child: ButtonEntrerSortieWithIcon(
                                    onTap: () async {
                                      try {
                                        await m
                                            .precedentFunction(context)
                                            .then((value) {
                                          if (widget.updateUI != null) {
                                            widget.updateUI!();
                                          }
                                        });
                                      } catch (e) {
                                        m.isLoading.value = false;

                                        GBSystem_ManageCatchErrors()
                                            .catchErrors(context,
                                                message: e.toString(),
                                                method: "precedentFunction",
                                                page: "UserEnterSortieMap");
                                      }
                                    },
                                    color: GbsSystemStrings.str_primary_color,
                                    verPadd: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.02),
                                    horPadd: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.01),
                                    icon: const Icon(
                                      CupertinoIcons.arrow_left,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      vacationController.getCurrentVacation !=
                                              null &&
                                          // new

                                          vacationController.getCurrentVacation!
                                                  .TPH_PSA ==
                                              "1",
                                  child: ButtonEntrerSortieWithIconAndText(
                                    disabled: m.salarieController.getSalarie
                                                ?.salarieModel.CLIENT_ID ==
                                            "1"
                                        ? true
                                        : false,
                                    onTap: () async {
                                      try {
                                        if (vacationController
                                                .getCurrentVacation
                                                ?.LIE_PS_TYPE ==
                                            "1") {
                                          setState(() {
                                            _tag == null;
                                          });
                                          print(_tag?.id);

                                          continueScanning = true;

                                          await readNFCTag(isEnter: true)
                                              .then((value) async {
                                            //Changed to GET.BACK()
                                            // if (Get.isSnackbarOpen) {
                                            //   Get.closeAllSnackbars();
                                            // }
                                            Get.back();

                                            if (continueScanning) {
                                              print(
                                                  "the function is finished  : ${_tag?.id}");
                                              await m.entrerFunction(context,
                                                  nfc: _tag?.id,
                                                  // new NFC
                                                  isNFCErrror: _tag == null,
                                                  isNFCNotSupported:
                                                      _availability ==
                                                          NFCAvailability
                                                              .not_supported,
                                                  isPermissionNFCDenied:
                                                      _availability ==
                                                          NFCAvailability
                                                              .disabled,
                                                  isUserIgnoreNFC:
                                                      _availability !=
                                                              NFCAvailability
                                                                  .disabled &&
                                                          _availability !=
                                                              NFCAvailability
                                                                  .not_supported,
                                                  messageErrNFC: '',

                                                  //

                                                  nfcErr: _tag == null
                                                      ? _availability ==
                                                              NFCAvailability
                                                                  .disabled
                                                          ? "Vous n'avez pas autorise NFC pour l'application"
                                                          : _availability ==
                                                                  NFCAvailability
                                                                      .not_supported
                                                              ? "le téléphone ne support pas le service NFC"
                                                              : "L'utilisateur ignore le scan TAG NFC"
                                                      : null,
                                                  qrCode: null,
                                                  qrCodeErr: null);
                                            }
                                          });

                                          // await readNFCTag().then((value) async {
                                          //   if (Get.isSnackbarOpen) {
                                          //     Get.closeAllSnackbars();
                                          //   }
                                          //   print("after scaning code");

                                          //   await m.entrerFunction(context,
                                          //       nfc: _tag?.id,
                                          //       nfcErr: _tag == null
                                          //           ? _availability ==
                                          //                   NFCAvailability.disabled
                                          //               ? "Vous n'avez pas autorise NFC pour l'application"
                                          //               : _availability ==
                                          //                       NFCAvailability
                                          //                           .not_supported
                                          //                   ? "le téléphone ne support pas le service NFC"
                                          //                   : "L'utilisateur ignore le scan TAG NFC"
                                          //           : null,
                                          //       qrCode: null,
                                          //       qrCodeErr: null);
                                          // });
                                        } else if (vacationController
                                                .getCurrentVacation
                                                ?.LIE_PS_TYPE ==
                                            "2") {
                                          Get.to(ScanBarcodePage(
                                              isMap: true,
                                              // destination:
                                              //     DetailsEventsAgendaScreen(),
                                              updateQR: updateQrCode));
                                        } else {
                                          await m.entrerFunction(context);
                                        }
                                      } catch (e) {
                                        m.isLoading.value = false;

                                        GBSystem_ManageCatchErrors()
                                            .catchErrors(context,
                                                message: e.toString(),
                                                method: "entrerFunction",
                                                page: "UserEnterSortieMap");
                                      }
                                    },
                                    number: vacationController
                                                    .getCurrentVacation
                                                    ?.PNTGS_IN_NBR !=
                                                null &&
                                            vacationController
                                                .getCurrentVacation!
                                                .PNTGS_IN_NBR!
                                                .isNotEmpty
                                        ? int.parse(vacationController
                                            .getCurrentVacation!.PNTGS_IN_NBR!)
                                        : null,
                                    icon: const Icon(
                                      CupertinoIcons.hand_draw_fill,
                                      color: Colors.white,
                                    ),
                                    verPadd: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.02),
                                    horPadd: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.01),
                                    text: GbsSystemStrings.str_entrer.tr,
                                    color: Colors.green,
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      vacationController.getCurrentVacation !=
                                              null &&
                                          // new

                                          vacationController.getCurrentVacation!
                                                  .TPH_PSA ==
                                              "1",
                                  child: ButtonEntrerSortieWithIconAndText(
                                    disabled: m.salarieController.getSalarie
                                                ?.salarieModel.CLIENT_ID ==
                                            "1"
                                        ? true
                                        : false,
                                    number: vacationController
                                                    .getCurrentVacation
                                                    ?.PNTGS_OUT_NBR !=
                                                null &&
                                            vacationController
                                                .getCurrentVacation!
                                                .PNTGS_OUT_NBR!
                                                .isNotEmpty
                                        ? int.parse(vacationController
                                            .getCurrentVacation!.PNTGS_OUT_NBR!)
                                        : null,
                                    onTap: () async {
                                      try {
                                        if (vacationController
                                                .getCurrentVacation
                                                ?.LIE_PS_TYPE ==
                                            "1") {
                                          setState(() {
                                            _tag == null;
                                          });
                                          print(_tag?.id);

                                          continueScanning = true;

                                          await readNFCTag(isEnter: false)
                                              .then((value) async {
                                            //Changed to GET.BACK()
                                            // if (Get.isSnackbarOpen) {
                                            //   Get.closeAllSnackbars();
                                            // }
                                            Get.back();

                                            if (continueScanning) {
                                              print(
                                                  "the function is finished  : ${_tag?.id}");
                                              await m.sortieFunction(context,
                                                  nfc: _tag?.id,
                                                  // new NFC
                                                  isNFCErrror: _tag == null,
                                                  isNFCNotSupported:
                                                      _availability ==
                                                          NFCAvailability
                                                              .not_supported,
                                                  isPermissionNFCDenied:
                                                      _availability ==
                                                          NFCAvailability
                                                              .disabled,
                                                  isUserIgnoreNFC:
                                                      _availability !=
                                                              NFCAvailability
                                                                  .disabled &&
                                                          _availability !=
                                                              NFCAvailability
                                                                  .not_supported,
                                                  messageErrNFC: '',

                                                  //

                                                  nfcErr: _tag == null
                                                      ? _availability ==
                                                              NFCAvailability
                                                                  .disabled
                                                          ? "Vous n'avez pas autorise NFC pour l'application"
                                                          : _availability ==
                                                                  NFCAvailability
                                                                      .not_supported
                                                              ? "le téléphone ne support pas le service NFC"
                                                              : "L'utilisateur ignore le scan TAG NFC"
                                                      : null,
                                                  qrCode: null,
                                                  qrCodeErr: null);
                                            }
                                          });

                                          // await readNFCTag().then((value) async {
                                          //   if (Get.isSnackbarOpen) {
                                          //     Get.closeAllSnackbars();
                                          //   }

                                          //   await m.sortieFunction(context,
                                          //       nfc: _tag?.id,
                                          //       nfcErr: _tag == null
                                          //           ? _availability ==
                                          //                   NFCAvailability.disabled
                                          //               ? "Vous n'avez pas autorise NFC pour l'application"
                                          //               : _availability ==
                                          //                       NFCAvailability
                                          //                           .not_supported
                                          //                   ? "le téléphone ne support pas le service NFC"
                                          //                   : "L'utilisateur ignore le scan TAG NFC"
                                          //           : null,
                                          //       qrCode: null,
                                          //       qrCodeErr: null);
                                          // });
                                        } else if (vacationController
                                                .getCurrentVacation
                                                ?.LIE_PS_TYPE ==
                                            "2") {
                                          Get.to(ScanBarcodePage(
                                              isMap: true,
                                              // destination:
                                              //     DetailsEventsAgendaScreen(),
                                              isSortiePointage: true,
                                              updateQR: updateQrCode));
                                        } else {
                                          await m.sortieFunction(context);
                                        }
                                      } catch (e) {
                                        m.isLoading.value = false;

                                        GBSystem_ManageCatchErrors()
                                            .catchErrors(context,
                                                message: e.toString(),
                                                method: "sortieFunction",
                                                page: "UserEnterSortieMap");
                                      }
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.hand_draw_fill,
                                      color: Colors.white,
                                    ),
                                    verPadd: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.02),
                                    horPadd: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.01),
                                    text: GbsSystemStrings.str_sortie.tr,
                                    color: Colors.red,
                                  ),
                                ),
                                Visibility(
                                  visible: widget.afficherPrecSuiv,
                                  child: ButtonEntrerSortieWithIcon(
                                    onTap: () async {
                                      try {
                                        await m
                                            .suivantFunction(context)
                                            .then((value) {
                                          if (widget.updateUI != null) {
                                            widget.updateUI!();
                                          }
                                        });
                                      } catch (e) {
                                        m.isLoading.value = false;

                                        GBSystem_ManageCatchErrors()
                                            .catchErrors(context,
                                                message: e.toString(),
                                                method: "suivantFunction",
                                                page: "UserEnterSortieMap");
                                      }
                                    },
                                    color: GbsSystemStrings.str_primary_color,
                                    verPadd: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.02),
                                    horPadd: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.01),
                                    icon: const Icon(
                                      CupertinoIcons.arrow_right,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            m.isLoading.value
                ? Waiting(
                    colorBackground: Colors.transparent,
                    text: GbsSystemStrings.str_operation_en_cours,
                    loadingLottieSize: 30,
                    borderRaduis: 10,
                    height: 350,
                    textColor: Colors.black,
                    loadingLottieColor: Colors.black,
                  )
                : Container()
          ],
        ));
  }

  void updateMessageNFC(NFCAvailability availability) {
    if (availability == NFCAvailability.not_supported) {
      messageErrNFC = "l'appareil ne prend pas en charge le NFC";
    } else if (availability == NFCAvailability.disabled) {
      messageErrNFC = "L'autorisation de balise NFC est désactivée";
    }
  }

  Future<void> readNFCTag({required bool isEnter}) async {
    // make the tag null to ensure there is no previous tag used
    _tag = null;

    ///
    Completer<void> completer = Completer<void>();

    await initPlatformState().then((value) {
      print(_availability);
    });

    _availability == NFCAvailability.available
        ? NFCBottomSheet.openSnackBar(
            onPressed: () async {
              await FlutterNfcKit.finish().then((value) async {
                //Changed to GET.BACK()
                // if (Get.isSnackbarOpen) {
                //   Get.closeAllSnackbars();
                // }
                Get.back();

                continueScanning = false;

                // Complete the completer to interrupt NFC polling
                completer.complete();
                print("the function is finished  : ${_tag?.id}");
                final m = Get.put<UserEntrerSortieMapController>(
                    UserEntrerSortieMapController(
                  context: context,
                ));
                if (isEnter) {
                  await m.entrerFunction(context,
                      // new NFC
                      isNFCErrror: _tag == null,
                      isNFCNotSupported:
                          _availability == NFCAvailability.not_supported,
                      isPermissionNFCDenied:
                          _availability == NFCAvailability.disabled,
                      isUserIgnoreNFC:
                          _availability != NFCAvailability.disabled &&
                              _availability != NFCAvailability.not_supported,
                      messageErrNFC: "",

                      //

                      nfc: _tag?.id,
                      nfcErr: _tag == null
                          ? _availability == NFCAvailability.disabled
                              ? "Vous n'avez pas autorise NFC pour l'application"
                              : _availability == NFCAvailability.not_supported
                                  ? "le téléphone ne support pas le service NFC"
                                  : "L'utilisateur ignore le scan TAG NFC"
                          : null,
                      qrCode: null,
                      qrCodeErr: null);
                } else {
                  await m.sortieFunction(context,
                      // new NFC
                      isNFCErrror: _tag == null,
                      isNFCNotSupported:
                          _availability == NFCAvailability.not_supported,
                      isPermissionNFCDenied:
                          _availability == NFCAvailability.disabled,
                      isUserIgnoreNFC:
                          _availability != NFCAvailability.disabled &&
                              _availability != NFCAvailability.not_supported,
                      messageErrNFC: "",

                      //

                      nfc: _tag?.id,
                      nfcErr: _tag == null
                          ? _availability == NFCAvailability.disabled
                              ? "Vous n'avez pas autorise NFC pour l'application"
                              : _availability == NFCAvailability.not_supported
                                  ? "le téléphone ne support pas le service NFC"
                                  : "L'utilisateur ignore le scan TAG NFC"
                          : null,
                      qrCode: null,
                      qrCodeErr: null);
                }
              });
            },
          )
        : _availability == NFCAvailability.not_supported
            ? await doPointage(isEnter)
            // showWarningDialog(
            //     context, GbsSystemStrings.str_your_device_dont_support_nfc.tr)
            : _availability == NFCAvailability.disabled
                ? await doPointage(isEnter)

                // showWarningDialog(
                //     context, GbsSystemStrings.str_nfc_disabled.tr)
                : await doPointage(isEnter);

    // showWarningDialog(context,
    //     GbsSystemStrings.str_please_turn_on_nfc_service.tr);

    // Start NFC scanning process
    await _performNFCScan(continueScanning, completer);
    // if (_tag?.id != null) {
    //   print("------------------");
    //   print("id : ${_tag?.id}");
    //   print("------------------");
    // }
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

  Future<void> doPointage(bool isEnter) async {
    final m =
        Get.put<UserEntrerSortieMapController>(UserEntrerSortieMapController(
      context: context,
    ));
    if (isEnter) {
      await m.entrerFunction(context,
          // new NFC
          isNFCErrror: _tag == null,
          isNFCNotSupported: _availability == NFCAvailability.not_supported,
          isPermissionNFCDenied: _availability == NFCAvailability.disabled,
          isUserIgnoreNFC: _availability != NFCAvailability.disabled &&
              _availability != NFCAvailability.not_supported,
          messageErrNFC: "",

          //

          nfc: _tag?.id,
          nfcErr: _tag == null
              ? _availability == NFCAvailability.disabled
                  ? "Vous n'avez pas autorise NFC pour l'application"
                  : _availability == NFCAvailability.not_supported
                      ? "le téléphone ne support pas le service NFC"
                      : "L'utilisateur ignore le scan TAG NFC"
              : null,
          qrCode: null,
          qrCodeErr: null);
    } else {
      await m.sortieFunction(context,
          // new NFC
          isNFCErrror: _tag == null,
          isNFCNotSupported: _availability == NFCAvailability.not_supported,
          isPermissionNFCDenied: _availability == NFCAvailability.disabled,
          isUserIgnoreNFC: _availability != NFCAvailability.disabled &&
              _availability != NFCAvailability.not_supported,
          messageErrNFC: "",

          //

          nfc: _tag?.id,
          nfcErr: _tag == null
              ? _availability == NFCAvailability.disabled
                  ? "Vous n'avez pas autorise NFC pour l'application"
                  : _availability == NFCAvailability.not_supported
                      ? "le téléphone ne support pas le service NFC"
                      : "L'utilisateur ignore le scan TAG NFC"
              : null,
          qrCode: null,
          qrCodeErr: null);
    }
  }
}
