import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PDF_PAGE/GBSystem_pdf_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/pdf_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/url_launcher_service.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GBSystemPDFScreen extends StatefulWidget {
  const GBSystemPDFScreen({
    super.key,
    required this.pdfBytes,
    this.isCommingFromOut = false,
    required this.fileName,
    this.addExtensionWhenDownload = false,
    this.pageName,
  });

  final Uint8List pdfBytes;
  final String fileName;

  final bool isCommingFromOut, addExtensionWhenDownload;
  final String? pageName;

  @override
  State<GBSystemPDFScreen> createState() => _GBSystemPDFScreenState();
}

class _GBSystemPDFScreenState extends State<GBSystemPDFScreen> {
  bool isLoading = false;
  final m = Get.put<GBSystemPDFScreenController>(GBSystemPDFScreenController());

  @override
  Widget build(BuildContext context) {
    print(widget.fileName);

    //boubaker 10/02/2025
    String? _fileName = (!widget.fileName.contains("."))
        ? '${widget.fileName}.pdf'
        : widget.fileName;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 4.0,
        shadowColor: GbsSystemStrings.str_primary_color,
        toolbarHeight: 80,
        backgroundColor: GbsSystemStrings.str_primary_color,
        title: Text(
          widget.pageName ?? GbsSystemStrings.str_pdf,
          style: TextStyle(color: Colors.white),
        ),
        leading: widget.isCommingFromOut != true
            ? InkWell(
                onTap: () async {
                  Get.back();
                },
                child: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                ),
              )
            : Container(),
      ),
      body: Stack(
        children: [
          widget.pdfBytes.isEmpty
              ? Center(
                  child: GBSystem_TextHelper()
                      .smallText(text: GbsSystemStrings.str_empty_data.tr))
              //boubaker 10/02/2025
              //: widget.fileName.contains(".pdf")
              : _fileName.contains(".pdf")
                  ? SfPdfViewer.memory(
                      widget.pdfBytes,
                    )
                  : Image.memory(
                      widget.pdfBytes,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                          child: Text(GbsSystemStrings.str_dialog_erreur.tr)),
                    ),
          Positioned(
            top: 5,
            right: 5,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                await PDFService()
                    .downloadAndSavePDF(
                        addExtension: widget.addExtensionWhenDownload,
                        //boubaker 10/02/2025
                        //widget.fileName,
                        _fileName,
                        widget.pdfBytes,
                        context)
                    .then((value) {
                  print("value $value");
                  setState(() {
                    isLoading = false;
                  });
                });
              },
              child: CircleAvatar(
                backgroundColor: GbsSystemStrings.str_primary_color,
                radius: 30,
                child: Icon(
                  CupertinoIcons.share,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          isLoading ? Waiting() : Container()
        ],
      ),
    );
  }
}
