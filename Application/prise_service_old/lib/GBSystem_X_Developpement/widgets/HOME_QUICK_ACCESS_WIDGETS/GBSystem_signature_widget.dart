import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_signature_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/signature_page/GBSystem_signature_widget_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/text_field_reviews.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

// ignore: must_be_immutable
class SignatureWidget extends StatefulWidget {
  SignatureWidget({
    Key? key,
    this.onBackTap,
    this.onDoneTap,
    this.imageSignature,
    required this.uploadSignature,
    this.controllerCommentaires,
    required this.updateUI,
    this.paddingContent = false,
    this.visibility = true,
    this.showBackBtn = true,
    this.viewMode = false,
    required this.causerieModel,
    this.isSalarie = false,
  }) : super(key: key);

  final CauserieModel? causerieModel;
  final Function updateUI;
  final VoidCallback? onBackTap, onDoneTap;
  Uint8List? imageSignature;
  final Function(String?) uploadSignature;
  final TextEditingController? controllerCommentaires;
  final bool paddingContent, visibility, showBackBtn, viewMode, isSalarie;

  @override
  State<SignatureWidget> createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  late GBSystemSignatureWidgetController m;
  @override
  void initState() {
    print(widget.causerieModel?.LIEINSPSVR_MEMO);
    if (widget.causerieModel != null && widget.isSalarie == false) {
      widget.controllerCommentaires?.text =
          widget.causerieModel?.LIEINSPSVR_MEMO ?? "";
    } else if (widget.isSalarie) {
      signatureController.getAllSignatureSalaries.forEach(
        (element) {
          if (element.SVR_IDF == widget.causerieModel?.SVR_IDF) {
            widget.controllerCommentaires?.text = element.comment ?? "";
          }
        },
      );
    }
    super.initState();
    m = GBSystemSignatureWidgetController(); // Initialize controller here
  }

  final signatureController =
      Get.put<GBSystemSignatureController>(GBSystemSignatureController());
  Uint8List? bytes;
  bool stopSignature = true;

  @override
  Widget build(BuildContext context) {
    // print(signatureController.getSignatureBase64!.split(','));
    if (widget.isSalarie == false) {
      if (widget.viewMode) {
        bytes = signatureController.getSignatureBase64 != null
            ? base64Decode(
                signatureController.getSignatureBase64!.split(',')[1])
            : null;
      } else {
        bytes = signatureController.getSignatureBase64 != null
            ? base64Decode(
                signatureController.getSignatureBase64!.split(',')[0])
            : null;
      }
    } else {
      signatureController.getAllSignatureSalaries.forEach(
        (element) {
          if (element.SVR_IDF == widget.causerieModel?.SVR_IDF &&
              element.signatureData != null) {
            bytes = base64Decode(element.signatureData!.split(',')[1]);
          }
        },
      );
    }

    //  Uint8List bytes = base64Decode(imageData.split(',')[1]);

    return Visibility(
      visible: widget.visibility,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: GBSystem_ScreenHelper.screenWidth(context),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: -30,
              blurRadius: 18,
              offset: const Offset(10, 40), // changes the shadow position
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: widget.paddingContent ? 10 : 0,
                right: widget.paddingContent ? 10 : 0,
                top:
                    GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
                bottom:
                    GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
              ),
              child: TextFieldReviews(
                enabled: widget.viewMode,
                controller: widget.controllerCommentaires,
                hint: GbsSystemStrings.str_comment,
              ),
            ),
            widget.isSalarie && bytes != null
                ? SvgPicture.memory(
                    bytes!,
                    // Optionally, you can adjust properties of SVG rendering here
                    placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : widget.viewMode
                    ? bytes != null
                        ? SvgPicture.memory(
                            bytes!,
                            // Optionally, you can adjust properties of SVG rendering here
                            placeholderBuilder: (BuildContext context) =>
                                Container(
                              padding: const EdgeInsets.all(30.0),
                              child: const CircularProgressIndicator(),
                            ),
                          )
                        // Image.memory(bytes,
                        //     fit: BoxFit.fill,
                        //     width: 45,
                        //     height: 45, errorBuilder: (context, error, stackTrace) {
                        //     print(error);
                        //     print(stackTrace);

                        //     return Container(
                        //       width: 45,
                        //       height: 45,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(200),
                        //           color: Colors.white),
                        //       child: Center(
                        //           child: GBSystem_TextHelper().largeText(
                        //               text: "ds",
                        //               textColor:
                        //                   GbsSystemStrings.str_primary_color)),
                        //     );
                        //   })
                        : Container(
                            width: GBSystem_ScreenHelper.screenWidth(context),
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: Colors.grey.shade200),
                          )
                    : AbsorbPointer(
                        absorbing: stopSignature,
                        child: Signature(
                          // dynamicPressureSupported: true,
                          backgroundColor: Colors.grey.shade300,
                          width: GBSystem_ScreenHelper.screenWidth(context),
                          height: GBSystem_ScreenHelper.screenHeightPercentage(
                              context, 0.4),
                          controller: m.signatureController,
                        ),
                      ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.paddingContent ? 10 : 0,
                vertical:
                    GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
              ),
              child: Visibility(
                visible: !widget.viewMode,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: widget.showBackBtn,
                      child: CustomIconButton(
                        onTap: widget.onBackTap,
                        icon: const Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // btn stop start signature
                    CustomIconButton(
                      onTap: () async {
                        setState(() {
                          stopSignature = !stopSignature;
                        });
                      },
                      icon: Icon(
                        stopSignature ? Icons.lock_open : Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.03),
                      ),
                      child: CustomIconButton(
                        onTap: () {
                          m.signatureController.clear();
                        },
                        icon: const Icon(
                          CupertinoIcons.repeat,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CustomIconButton(
                      onTap: () async {
                        String? img2 = await m.signatureController.toRawSVG();
                        img2 = img2?.replaceFirst(
                            RegExp(r'<svg'), '<svg width="583" height="96"');
                        // img2 = img2?.replaceFirst(
                        //     RegExp(r'height="[^"]*"'), 'height=96');

                        print("signature sended $img2");

                        widget.uploadSignature(img2);
                        m.signatureController.redo();
                        // m.signatureController.clear();
                        // widget.updateUI();
                      },
                      icon: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
