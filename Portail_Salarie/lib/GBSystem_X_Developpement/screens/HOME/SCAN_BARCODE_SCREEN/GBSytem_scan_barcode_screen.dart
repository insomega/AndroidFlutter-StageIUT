import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/VALIDER_DOCUMENTS_SCREEN/GBSystem_valider_documents_screen__controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/APP_BAR/custom_app_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/GBSystem_user_entrer_sortie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/PRISE_SERVICE_MAP/GBSystem_user_entrer_sortie_map_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/PRISE_SERVICE_VALIDER_DOCS/GBSystem_prise_service_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanBarcodePage extends StatefulWidget {
  const ScanBarcodePage({
    super.key,
    required this.updateQR,
    this.isSortiePointage = false,
    this.isValideDocument = false,
    this.isMap = false,
    this.UpdateUI,
  });

  final void Function(Barcode?) updateQR;
  final bool isSortiePointage, isValideDocument, isMap;
  final Function? UpdateUI;

  @override
  State<ScanBarcodePage> createState() => _ScanBarcodePageState();
}

class _ScanBarcodePageState extends State<ScanBarcodePage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? data;
  bool flashStatus = false;
  bool cameraPause = false;
  bool isBackToMainPage = false;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
            onLeadingTap: () async {
              widget.updateQR(result);

              if (widget.isSortiePointage == false &&
                  widget.isValideDocument == false &&
                  widget.isMap == false) {
                final m = Get.put<UserEntrerSortieController>(
                    UserEntrerSortieController(
                  context: context,
                ));
                m.entrerFunction(
                  context,
                  // new
                  isQRErrror: result == null,
                  isUserIgnoreQR: result == null,
                  messageErrQR: "",
                  //
                  nfc: null,
                  nfcErr: null,
                  qrCode: result?.code,
                  qrCodeErr: result == null
                      ? "L'utilisateur ignore la lecture QrCode"
                      : null,
                );
              } else if (widget.isSortiePointage == true &&
                  widget.isValideDocument == false &&
                  widget.isMap == false) {
                final m = Get.put<UserEntrerSortieController>(
                    UserEntrerSortieController(
                  context: context,
                ));
                m.sortieFunction(
                  context,
                  // new
                  isQRErrror: result == null,
                  isUserIgnoreQR: result == null,
                  messageErrQR: "",
                  //
                  nfc: null,
                  nfcErr: null,
                  qrCode: result?.code,
                  qrCodeErr: result == null
                      ? "L'utilisateur ignore la lecture QrCode"
                      : null,
                );
              } else if (widget.isSortiePointage == false &&
                  widget.isValideDocument == true &&
                  widget.isMap == false) {
                final m =
                    Get.put<PriseServiceController>(PriseServiceController(
                  context: context,
                ));
                final m2 = Get.put<GBSystemValiderDocumentsScreenController>(
                    GBSystemValiderDocumentsScreenController(
                  context: context,
                ));

                m
                    .entrerFunction(
                  context,
                  // new
                  isQRErrror: result == null,
                  isUserIgnoreQR: result == null,
                  messageErrQR: "",
                  //
                  nfc: null,
                  nfcErr: null,
                  qrCode: result?.code,
                  qrCodeErr: result == null
                      ? "L'utilisateur ignore la lecture QrCode"
                      : null,
                )
                    .then((value) async {
                  await m2.onPointageTap(context);
                });

                widget.UpdateUI!();
              } else if (widget.isSortiePointage == true &&
                  widget.isValideDocument == true &&
                  widget.isMap == false) {
                final m =
                    Get.put<PriseServiceController>(PriseServiceController(
                  context: context,
                ));
                final m2 = Get.put<GBSystemValiderDocumentsScreenController>(
                    GBSystemValiderDocumentsScreenController(
                  context: context,
                ));
                m
                    .sortieFunction(
                  context,
                  // new
                  isQRErrror: result == null,
                  isUserIgnoreQR: result == null,
                  messageErrQR: "",
                  //
                  nfc: null,
                  nfcErr: null,
                  qrCode: result?.code,
                  qrCodeErr: result == null
                      ? "L'utilisateur ignore la lecture QrCode"
                      : null,
                )
                    .then((value) async {
                  await m2.onPointageTap(context);
                });
                widget.UpdateUI!();
              } else if (widget.isSortiePointage == false &&
                  widget.isValideDocument == false &&
                  widget.isMap == true) {
                final m = Get.put<UserEntrerSortieMapController>(
                    UserEntrerSortieMapController(
                  context: context,
                ));

                m.entrerFunction(
                  context,
                  // new
                  isQRErrror: result == null,
                  isUserIgnoreQR: result == null,
                  messageErrQR: "",
                  //
                  nfc: null,
                  nfcErr: null,
                  qrCode: result?.code,
                  qrCodeErr: result == null
                      ? "L'utilisateur ignore la lecture QrCode"
                      : null,
                );
              } else if (widget.isSortiePointage == true &&
                  widget.isValideDocument == false &&
                  widget.isMap == true) {
                final m = Get.put<UserEntrerSortieMapController>(
                    UserEntrerSortieMapController(
                  context: context,
                ));
                print("sortie map -----");

                m.sortieFunction(
                  context,
                  // new
                  isQRErrror: result == null,
                  isUserIgnoreQR: result == null,
                  messageErrQR: "",
                  //
                  nfc: null,
                  nfcErr: null,
                  qrCode: result?.code,
                  qrCodeErr: result == null
                      ? "L'utilisateur ignore la lecture QrCode"
                      : null,
                );
              }

              if (isBackToMainPage == false) {
                setState(() {
                  isBackToMainPage = true;
                });
                Get.back();
              }
            },
            leadingIcon: const Icon(CupertinoIcons.arrow_left)),
        body: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Barcode Type: ${describeEnum(result!.format)}

                          Text('Result : ${result!.code}'),

                          // ElevatedButton(
                          //   onPressed: () async {},
                          //   child: const Text('Save'),
                          // ),
                        ],
                      )
                    else
                      const Text('Scan a code'),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                              await controller?.getFlashStatus().then((value) {
                                setState(() {
                                  flashStatus = value!;
                                });
                              });
                            },
                            child: Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: GbsSystemStrings.str_primary_color),
                                child: flashStatus
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Icon(
                                            Icons.flash_off,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Icon(
                                            Icons.flash_on,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                          ),
                          InkWell(
                            onTap: () async {
                              await controller?.flipCamera();
                              setState(() {});
                              await controller?.getCameraInfo().then((value) {
                                debugPrint(value.name);
                              });
                            },
                            child: Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: GbsSystemStrings.str_primary_color),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Icon(
                                      Icons.flip_camera_ios_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ),
                          InkWell(
                            onTap: () async {
                              if (cameraPause == false) {
                                await controller?.pauseCamera().then((value) {
                                  setState(() {
                                    cameraPause = true;
                                  });
                                });
                              } else {
                                await controller?.resumeCamera().then((value) {
                                  setState(() {
                                    cameraPause = false;
                                  });
                                });
                              }

                              await controller?.getFlashStatus().then((value) {
                                setState(() {
                                  flashStatus = value!;
                                });
                              });
                            },
                            child: Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: GbsSystemStrings.str_primary_color),
                                child: cameraPause == false
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Icon(
                                            Icons.pause,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    bool isDone = false;
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      widget.updateQR(result);
      print("result changed : $result");

      if (isDone == false) {
        if (widget.isSortiePointage == false &&
            widget.isValideDocument == false &&
            widget.isMap == false) {
          final m =
              Get.put<UserEntrerSortieController>(UserEntrerSortieController(
            context: context,
          ));
          m.entrerFunction(
            context,
            // new
            isQRErrror: result == null,
            isUserIgnoreQR: result == null,
            messageErrQR: "",
            //
            nfc: null,
            nfcErr: null,
            qrCode: result?.code,
            qrCodeErr: result == null
                ? "L'utilisateur ignore la lecture QrCode"
                : null,
          );
        } else if (widget.isSortiePointage == true &&
            widget.isValideDocument == false &&
            widget.isMap == false) {
          final m =
              Get.put<UserEntrerSortieController>(UserEntrerSortieController(
            context: context,
          ));
          m.sortieFunction(
            context,
            // new
            isQRErrror: result == null,
            isUserIgnoreQR: result == null,
            messageErrQR: "",
            //
            nfc: null,
            nfcErr: null,
            qrCode: result?.code,
            qrCodeErr: result == null
                ? "L'utilisateur ignore la lecture QrCode"
                : null,
          );
        } else if (widget.isSortiePointage == false &&
            widget.isValideDocument == true &&
            widget.isMap == false) {
          final m = Get.put<PriseServiceController>(PriseServiceController(
            context: context,
          ));
          final m2 = Get.put<GBSystemValiderDocumentsScreenController>(
              GBSystemValiderDocumentsScreenController(
            context: context,
          ));
          m
              .entrerFunction(
            context,
            // new
            isQRErrror: result == null,
            isUserIgnoreQR: result == null,
            messageErrQR: "",
            //
            nfc: null,
            nfcErr: null,
            qrCode: result?.code,
            qrCodeErr: result == null
                ? "L'utilisateur ignore la lecture QrCode"
                : null,
          )
              .then((value) async {
            await m2.onPointageTap(context);
            print("done all !!!!!");
            widget.UpdateUI!();
          });
        } else if (widget.isSortiePointage == true &&
            widget.isValideDocument == true &&
            widget.isMap == false) {
          final m = Get.put<PriseServiceController>(PriseServiceController(
            context: context,
          ));
          final m2 = Get.put<GBSystemValiderDocumentsScreenController>(
              GBSystemValiderDocumentsScreenController(
            context: context,
          ));
          m
              .sortieFunction(
            context,
            // new
            isQRErrror: result == null,
            isUserIgnoreQR: result == null,
            messageErrQR: "",
            //
            nfc: null,
            nfcErr: null,
            qrCode: result?.code,
            qrCodeErr: result == null
                ? "L'utilisateur ignore la lecture QrCode"
                : null,
          )
              .then((value) async {
            await m2.onPointageTap(context);
          });
          widget.UpdateUI!();
        } else if (widget.isSortiePointage == false &&
            widget.isValideDocument == false &&
            widget.isMap == true) {
          final m = Get.put<UserEntrerSortieMapController>(
              UserEntrerSortieMapController(
            context: context,
          ));

          m.entrerFunction(
            context,
            // new
            isQRErrror: result == null,
            isUserIgnoreQR: result == null,
            messageErrQR: "",
            //
            nfc: null,
            nfcErr: null,
            qrCode: result?.code,
            qrCodeErr: result == null
                ? "L'utilisateur ignore la lecture QrCode"
                : null,
          );
        } else if (widget.isSortiePointage == true &&
            widget.isValideDocument == false &&
            widget.isMap == true) {
          final m = Get.put<UserEntrerSortieMapController>(
              UserEntrerSortieMapController(
            context: context,
          ));
          print("sortie map -----");

          m.sortieFunction(
            context,
            // new
            isQRErrror: result == null,
            isUserIgnoreQR: result == null,
            messageErrQR: "",
            //
            nfc: null,
            nfcErr: null,
            qrCode: result?.code,
            qrCodeErr: result == null
                ? "L'utilisateur ignore la lecture QrCode"
                : null,
          );
        }
        setState(() {
          isDone = true;
        });
      }

      // Get.back();
      // if (widget.destination != null) {
      //   Get.off(widget.destination);
      // } else {
      //   Get.back();
      // }
      if (isBackToMainPage == false) {
        setState(() {
          isBackToMainPage = true;
        });
        Get.back();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
