import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_formulaire_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
// import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_photo_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/signature_salarie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/GBSystem_signature_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/text_field_reviews.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class SignatureCauserieWidget extends StatefulWidget {
  const SignatureCauserieWidget(
      {super.key,
      required this.salarie,
      required this.causerieModel,
      this.isViewMode = false,
      required this.previousSignature,
      required this.updateLoading});

  final GBSystemSalarieWithPhotoCauserieModel salarie;
  final CauserieModel? causerieModel;
  final bool isViewMode;
  final SignatureSalarieModel? previousSignature;
  final void Function(bool) updateLoading;

  @override
  State<SignatureCauserieWidget> createState() =>
      _SignatureCauserieWidgetState();
}

class _SignatureCauserieWidgetState extends State<SignatureCauserieWidget> {
  @override
  void initState() {
    controllerComment.text = widget.previousSignature?.comment ?? "";
    super.initState();
  }

  void updateUI() {
    setState(() {});
  }

  TextEditingController controllerComment = TextEditingController();

  bool signatureVisibility = false, isLoading = false;

  final FormulaireController formulaireController =
      Get.put(FormulaireController());
  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes = widget.salarie.imageSalarie != null
        ? base64Decode(widget.salarie.imageSalarie!.split(',').last)
        : null;

    Uint8List? bytesSignature = widget.previousSignature?.signatureData != null
        ? base64Decode(widget.previousSignature!.signatureData!.split(',')[1])
        : null;
    print(
        "signature base 64 sign : ${widget.previousSignature?.signatureData}");
    print(
        "signature base 64 sign split : ${widget.previousSignature?.signatureData?.split(',')[1]}");
    print("signature base 64 sign bytes : ${bytesSignature}");
    print(widget.isViewMode && bytesSignature != null);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
          color: GbsSystemServerStrings.str_primary_color,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                children: [
                  ClipOval(
                    child: bytes != null
                        ? Image.memory(
                            bytes,
                            fit: BoxFit.fill,
                            width: 45,
                            height: 45,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: Colors.white),
                              child: Center(
                                  child: GBSystem_TextHelper().largeText(
                                      text:
                                          "${widget.salarie.salarieCauserieModel.SVR_LIB.substring(0, 1).toUpperCase()}${widget.salarie.salarieCauserieModel.SVR_LIB.substring(0, 1).toUpperCase()}",
                                      textColor: GbsSystemServerStrings
                                          .str_primary_color)),
                            ),
                          )
                        : Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: Colors.white),
                            child: Center(
                                child: GBSystem_TextHelper().largeText(
                                    text:
                                        "${widget.salarie.salarieCauserieModel.SVR_LIB.substring(0, 1).toUpperCase()}${widget.salarie.salarieCauserieModel.SVR_LIB.substring(0, 1).toUpperCase()}",
                                    textColor: GbsSystemServerStrings
                                        .str_primary_color)),
                          ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  GBSystem_TextHelper().smallText(
                      text: widget.salarie.salarieCauserieModel.SVR_LIB,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white)
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    signatureVisibility
                        ? signatureVisibility = false
                        : signatureVisibility = true;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  child: signatureVisibility
                      ? Icon(
                          CupertinoIcons.minus,
                          color: Colors.white,
                        )
                      : Icon(
                          CupertinoIcons.plus,
                          color: Colors.white,
                        ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          AnimatedCrossFade(
              firstCurve: Curves.linear,
              firstChild: Container(
                width: GBSystem_ScreenHelper.screenWidth(context),
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: -30,
                      blurRadius: 18,
                      offset:
                          const Offset(10, 40), // changes the shadow position
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Visibility(
                  visible: signatureVisibility,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical:
                              GBSystem_ScreenHelper.screenHeightPercentage(
                                  context, 0.02),
                        ),
                        child: TextFieldReviews(
                          enabled: widget.isViewMode,
                          controller: controllerComment,
                          hint: GbsSystemStrings.str_comment,
                        ),
                      ),
                      bytesSignature != null
                          ? SvgPicture.memory(
                              bytesSignature,
                              // Optionally, you can adjust properties of SVG rendering here
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                // decoration:
                                //     BoxDecoration(color: Colors.white),
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator(),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              secondChild: Container(
                child: Visibility(
                  visible: signatureVisibility,
                  child: new SignatureWidget(
                    isSalarie: true,
                    causerieModel: widget.causerieModel,
                    showBackBtn: false,
                    paddingContent: true,
                    updateUI: updateUI,
                    onBackTap: () {
                      updateUI();
                      // Get.back();
                    },
                    controllerCommentaires: controllerComment,
                    uploadSignature: (p0) async {
                      try {
                        if (p0 != null) {
                          // setState(() {
                          //   isLoading = true;
                          // });
                          widget.updateLoading(true);

                          print("widget.isViewMode${widget.isViewMode}");
                          print(
                              "widget.causerieModel.LIENSD ${widget.causerieModel?.LIEINSPSVR_IDF}");
                          print("widget.causerieModel ${widget.causerieModel}");

                          String? my_LIEINSPSVR_IDF = widget.isViewMode
                              ? (widget.causerieModel?.LIEINSPSVR_IDF)
                              : formulaireController.get_LIEINSPSVR_IDF;

                          String base64Image = base64Encode(utf8.encode(p0));
                          await GBSystem_AuthService(context)
                              .sendReponseSignatureCauserie(
                                  questionType: formulaireController
                                      .getAllQuestionTypeWithHisQuestionsModel!
                                      .first
                                      .questionType,
                                  LIEINSPSVR_IDF: my_LIEINSPSVR_IDF,
                                  imageBytes: base64Image,
                                  salarie: widget.salarie.salarieCauserieModel,
                                  commentaire: controllerComment.text)
                              .then(
                            (value) {
                              // setState(() {
                              //   isLoading = false;
                              // });
                              widget.updateLoading(false);
                              if (value != null) {
                                // controllerComment.text = '';
                                showSuccesDialog(context,
                                    GbsSystemStrings.str_operation_effectuee);
                              }

                              print("return signature $value");
                            },
                          );
                        } else {
                          showErrorDialog(
                              context, GbsSystemStrings.str_empty_signature);
                        }
                      } catch (e) {
                        isLoading = false;

                        GBSystem_ManageCatchErrors().catchErrors(
                          context,
                          message: e.toString(),
                          method: "sendReponseSignatureCauserie",
                          page: "signature_causerie_widget",
                        );
                      }
                    },
                  ),
                ),
              ),
              crossFadeState: widget.isViewMode && bytesSignature != null
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 500)),

          // AnimatedContainer(
          //   duration: const Duration(seconds: 2),
          //   child: widget.isViewMode && bytesSignature != null
          //       ? Container(
          //           width: GBSystem_ScreenHelper.screenWidth(context),
          //           clipBehavior: Clip.hardEdge,
          //           padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Colors.grey.withOpacity(0.6),
          //                 spreadRadius: -30,
          //                 blurRadius: 18,
          //                 offset: const Offset(
          //                     10, 40), // changes the shadow position
          //               ),
          //             ],
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //           child: Visibility(
          //             visible: signatureVisibility,
          //             child: Column(
          //               children: [
          //                 SvgPicture.memory(
          //                   bytesSignature,
          //                   // Optionally, you can adjust properties of SVG rendering here
          //                   placeholderBuilder: (BuildContext context) =>
          //                       Container(
          //                     // decoration:
          //                     //     BoxDecoration(color: Colors.white),
          //                     padding: const EdgeInsets.all(30.0),
          //                     child: const CircularProgressIndicator(),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: EdgeInsets.symmetric(
          //                     horizontal: 10,
          //                     vertical:
          //                         GBSystem_ScreenHelper.screenHeightPercentage(
          //                             context, 0.02),
          //                   ),
          //                   child: TextFieldReviews(
          //                     enabled: widget.isViewMode,
          //                     controller: controllerComment,
          //                     hint: GbsSystemStrings.str_comment,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         )
          //       : Container(
          //           child: Visibility(
          //             visible: signatureVisibility,
          //             child: new SignatureWidget(
          //               isSalarie: true,
          //               causerieModel: widget.causerieModel,
          //               showBackBtn: false,
          //               paddingContent: true,
          //               updateUI: updateUI,
          //               onBackTap: () {
          //                 updateUI();
          //                 // Get.back();
          //               },
          //               controllerCommentaires: controllerComment,
          //               uploadSignature: (p0) async {
          //                 try {
          //                   if (p0 != null) {
          //                     // setState(() {
          //                     //   isLoading = true;
          //                     // });
          //                     widget.updateLoading(true);

          //                     print("widget.isViewMode${widget.isViewMode}");
          //                     print(
          //                         "widget.causerieModel.LIENSD ${widget.causerieModel?.LIEINSPSVR_IDF}");
          //                     print(
          //                         "widget.causerieModel ${widget.causerieModel}");

          //                     String? my_LIEINSPSVR_IDF = widget.isViewMode
          //                         ? (widget.causerieModel?.LIEINSPSVR_IDF)
          //                         : formulaireController.get_LIEINSPSVR_IDF;

          //                     String base64Image =
          //                         base64Encode(utf8.encode(p0));
          //                     await GBSystem_AuthService(context)
          //                         .sendReponseSignatureCauserie(
          //                             questionType: formulaireController
          //                                 .getAllQuestionTypeWithHisQuestionsModel!
          //                                 .first
          //                                 .questionType,
          //                             LIEINSPSVR_IDF: my_LIEINSPSVR_IDF,
          //                             imageBytes: base64Image,
          //                             salarie:
          //                                 widget.salarie.salarieCauserieModel,
          //                             commentaire: controllerComment.text)
          //                         .then(
          //                       (value) {
          //                         // setState(() {
          //                         //   isLoading = false;
          //                         // });
          //                         widget.updateLoading(false);
          //                         if (value != null) {
          //                           // controllerComment.text = '';
          //                           showSuccesDialog(
          //                               context,
          //                               GbsSystemStrings
          //                                   .str_operation_effectuee);
          //                         }

          //                         print("return signature $value");
          //                       },
          //                     );
          //                   } else {
          //                     showErrorDialog(context,
          //                         GbsSystemStrings.str_empty_signature);
          //                   }
          //                 } catch (e) {
          //                   isLoading = false;

          //                   GBSystem_ManageCatchErrors().catchErrors(
          //                     context,
          //                     message: e.toString(),
          //                     method: "sendReponseSignatureCauserie",
          //                     page: "signature_causerie_widget",
          //                   );
          //                 }
          //               },
          //             ),
          //           ),
          //         ),
          // )
        ],
      ),
    );
  }
}
