import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/custom_button.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_ref_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/permission_handler_service.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key, required this.articleRefModel});

  final GbsystemArticleRefModel articleRefModel;

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  String data = 'This is a simple QR code';
  TextEditingController controllerFournisseur = TextEditingController();
  final GlobalKey _qrkey = GlobalKey();
  final GlobalKey _barkey = GlobalKey();

  bool dirExists = false;
  String _shareFilePath = ''; // Variable to hold the file path for sharing and printing
  @override
  void initState() {
    data = 'ARTREF-' + widget.articleRefModel.ARTREF_IDF;
    super.initState();
  }

  RxBool isQrCode = RxBool(false);
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        shadowColor: Colors.grey.withOpacity(0.5),
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: GBSystem_Application_Strings.str_primary_color,
        title: Text("${GBSystem_Application_Strings.str_qr_code} / ${GBSystem_Application_Strings.str_bar_code}", style: TextStyle(color: Colors.white)),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                                child: GBSystem_TextHelper().largeText(text: widget.articleRefModel.ARTREF_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                                child: GBSystem_TextHelper().normalText(text: widget.articleRefModel.ARTCAT_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                      SizedBox(height: 3),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                        child: GBSystem_TextHelper().smallText(text: widget.articleRefModel.ARTREF_LIB, textColor: Colors.black38, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Obx(
                        () => AnimatedCrossFade(
                          firstChild: RepaintBoundary(
                            key: _qrkey,
                            child: QrImageView(
                              data: data,
                              version: QrVersions.auto,
                              size: 120,
                              gapless: false,
                              errorStateBuilder: (context, error) => Center(child: Text(GBSystem_Application_Strings.str_error_generate_qrcode)),
                            ),
                          ),
                          secondChild: RepaintBoundary(
                            key: _barkey,
                            child: BarcodeWidget(
                              height: 120,
                              // width: 250,
                              drawText: false,
                              barcode: Barcode.code128(),
                              data: data,
                            ),
                          ),
                          crossFadeState: isQrCode.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          duration: Duration(milliseconds: 600),
                        ),
                      ),
                      // Obx(
                      //   () => isQrCode.value
                      //       ? RepaintBoundary(
                      //           key: _qrkey,
                      //           child: QrImageView(
                      //             data: data,
                      //             version: QrVersions.auto,
                      //             size: 120,
                      //             gapless: false,
                      //             errorStateBuilder: (context, error) =>
                      //                 Center(
                      //               child: Text(GBSystem_Application_Strings
                      //                   .str_error_generate_qrcode),
                      //             ),
                      //           ),
                      //         )
                      //       : RepaintBoundary(
                      //           key: _qrkey,
                      //           child: BarcodeWidget(
                      //             height: 120,
                      //             // width: 250,
                      //             drawText: false,
                      //             barcode: Barcode.code128(),
                      //             data: data,
                      //           ),
                      //         ),
                      // )
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: AnimatedToggleSwitch<int>.rolling(
                    height: 40,
                    indicatorSize: Size.fromWidth(36),
                    current: value,
                    values: [0, 1],
                    onChanged: (i) {
                      setState(() => value = i);
                      isQrCode.value = value == 1 ? true : false;
                    },
                    iconBuilder: (value, foreground) {
                      if (value == 0) {
                        return Icon(CupertinoIcons.barcode, color: Colors.white);
                      } else {
                        return Icon(CupertinoIcons.qrcode, color: Colors.white);
                      }
                    },
                    style: ToggleStyle(backgroundColor: Colors.grey.shade500, indicatorColor: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButtonWithTrailling(
                    onTap: _shareFilePath.isNotEmpty
                        ? () async {
                            await _captureAndSavePng(showSnackBar: false).then((value) async {
                              await shareQRCode(_shareFilePath);
                            });
                            // await shareQRCode(_shareFilePath);
                          }
                        : () {
                            showErrorDialog(GBSystem_Application_Strings.str_vous_devez_sauvgarder_premiermenet.tr);
                          },
                    horPadding: 15,
                    verPadding: 10,
                    // addBorder: true,
                    color: Colors.white,
                    text: GBSystem_Application_Strings.str_share.tr,
                    textColor: Colors.black,
                    trailling: Icon(CupertinoIcons.share, color: GBSystem_Application_Strings.str_primary_color),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: CustomButtonWithTrailling(
                    onTap: _shareFilePath.isNotEmpty
                        ? () async {
                            await _captureAndSavePng(showSnackBar: false).then((value) async {
                              await printQRCode2(_shareFilePath, isQrCode.value);
                            });
                            // await printQRCode2(
                            //     _shareFilePath, isQrCode.value);
                          }
                        : () {
                            showErrorDialog(GBSystem_Application_Strings.str_vous_devez_sauvgarder_premiermenet.tr);
                          },
                    horPadding: 15,
                    verPadding: 10,
                    // addBorder: true,
                    color: Colors.white,
                    text: GBSystem_Application_Strings.str_print.tr,
                    textColor: Colors.black,
                    trailling: Icon(CupertinoIcons.printer, color: GBSystem_Application_Strings.str_primary_color),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomButtonWithTrailling(
              onTap: () async {
                await _captureAndSavePng();
              },
              horPadding: 15,
              verPadding: 10,
              // addBorder: true,
              color: Colors.white,
              text: GBSystem_Application_Strings.str_save,
              textColor: Colors.black,
              trailling: Icon(Icons.save, color: GBSystem_Application_Strings.str_primary_color),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _captureAndSavePng({bool showSnackBar = true}) async {
    try {
      final String externalDir = await getDownloadDirectory();

      RenderRepaintBoundary boundary = isQrCode.value ? _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary : _barkey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      var image = await boundary.toImage(pixelRatio: 3.0);

      // Drawing White Background because QR Code is Black
      final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
      canvas.drawRect(Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()), whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Check for duplicate file name to avoid Override
      // String fileName = data;
      String fileName = 'qr_code_${data}_${DateTime.now().millisecondsSinceEpoch}.png';

      // Ensure the directory exists
      // final dir = Directory(externalDir);
      // if (!await dir.exists()) {
      //   await dir.create(recursive: true);
      // }

      // Check if Directory Path exists or not
      dirExists = await File(externalDir).exists();
      // If not, then create the path
      if (!dirExists) {
        await Directory(externalDir).create(recursive: true);
        dirExists = true;
      }

      final file = await File('$externalDir/$fileName.png').create();
      await file.writeAsBytes(pngBytes);

      if (!mounted) return;

      if (showSnackBar) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isQrCode.value ? 'code QR bien enregistrer sur galerie' : 'code barre bien enregistrer sur galerie')));
      }

      // Update the file path for sharing and printing
      setState(() {
        _shareFilePath = file.path;
      });
    } catch (e) {
      if (!mounted) return;
      if (showSnackBar) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('quelque chose mal tourné !!!')));
      }
    }
  }

  Future<void> shareQRCode(String filePath) async {
    // await _captureAndSavePng(showSnackBar: false).then(
    //   (value) => Share.shareFiles([filePath], text: data),
    // );
    //  Share.shareFiles([filePath], text: data);
    //Share.shareXFiles([XFile(filePath)], text: data);

    // Create an XFile object for the file you want to share
    XFile file = XFile(filePath);

    // Create ShareParams with the file(s) and optional text/subject
    ShareParams params = ShareParams(files: [file], text: data, subject: 'Shared from my app');

    // Share the content using SharePlus.instance.share()
    SharePlus.instance.share(params);
  }

  Future<void> printQRCode2(String filePath, bool isQrCode) async {
    try {
      await _captureAndSavePng(showSnackBar: false);
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Row(
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Image(pw.MemoryImage(bytes), height: isQrCode ? 300 : 250, width: isQrCode ? 300 : 500, fit: pw.BoxFit.fill),
                    pw.SizedBox(height: 20), // Add spacing between the image and the text
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('${data}', style: pw.TextStyle(fontSize: 12)),
                        // pw.Text('Article : ${widget.articleRefModel.ARTREF_LIB}',
                        //     style: pw.TextStyle(fontSize: 12)),
                        // pw.Text(
                        //     'Catégorie : ${widget.articleRefModel.ARTCAT_LIB}',
                        //     style: pw.TextStyle(fontSize: 12)),
                        // pw.Text(
                        //     'Article Dureé de vie type : ${widget.articleRefModel.ARTREF_DUREE_VIE_TYPE}',
                        //     style: pw.TextStyle(fontSize: 12)),
                        // pw.Text(
                        //     'Article Dureé de vie unit : ${widget.articleRefModel.ARTREF_DUREE_VIE_UNIT}',
                        //     style: pw.TextStyle(fontSize: 12)),
                        // pw.Text(
                        //     widget.articleRefModel.ARTREF_START_DATE != null
                        //         ? 'date de début : ${ConvertDateService().parseDate(date: widget.articleRefModel.ARTREF_START_DATE!)}'
                        //         : "",
                        //     style: pw.TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
    } catch (e) {
      print('Error printing QR code: $e');
    }
  }

  Future<String> getDownloadDirectory() async {
    Directory? externalDir = Directory('/storage/emulated/0/Download');
    // Directory? externalDir = Directory('/storage/');
    bool exist = await externalDir.exists();
    if (exist) {
      await PermissionHandlerService().requestStoragePermission();
    } else {
      externalDir = await getExternalStorageDirectory();
    }

    return '${externalDir!.path}';
  }
}
