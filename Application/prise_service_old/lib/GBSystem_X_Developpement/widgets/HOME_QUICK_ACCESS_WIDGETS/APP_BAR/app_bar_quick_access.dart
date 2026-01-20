import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_en_cours_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_signature_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_evaluation_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystemAppBarQuickAccess extends StatefulWidget
    implements PreferredSizeWidget {
  GBSystemAppBarQuickAccess({
    super.key,
    required this.salarie_idf,
    this.onSignatureTap,
    this.onChargerTap,
    this.onImageTap,
    this.showBackBtn = true,
    required this.salarie_lib,
    this.dateDebut,
    this.isViewMode = false,
  });

  final String salarie_idf, salarie_lib;
  final void Function()? onSignatureTap, onChargerTap, onImageTap;
  final bool showBackBtn;
  final DateTime? dateDebut;
  final bool isViewMode;

  @override
  State<GBSystemAppBarQuickAccess> createState() =>
      _GBSystemAppBarQuickAccessState();

  @override
  Size get preferredSize => const Size.fromHeight(150);
}

class _GBSystemAppBarQuickAccessState extends State<GBSystemAppBarQuickAccess> {
  @override
  void initState() {
    // init eval STATE and EVAL MOY
    // if (evaluationEnCoursController.getSelectedEval.value != null) {
    //   evaluationController.setCuurentEvaluationView = EvaluationModel(
    //       EVAL_MOYENNE:
    //           evaluationEnCoursController.getSelectedEval.value!.EVAL_MOYENNE,
    //       EVAL_STAT:
    //           evaluationEnCoursController.getSelectedEval.value!.EVAL_STAT);
    // }
    super.initState();
  }

  final evaluationController =
      Get.put<EvaluationController>(EvaluationController());

  final signatureController =
      Get.put<GBSystemSignatureController>(GBSystemSignatureController());

  final GbsystemEvaluationEnCoursController evaluationEnCoursController =
      Get.put(GbsystemEvaluationEnCoursController());

  @override
  Widget build(BuildContext context) {
    bool isSignatureDone = signatureController.getSignatureBase64 != null;
    bool isClotureDone = signatureController.getIsCloture;
    return Container(
        height: 150,
        padding: EdgeInsets.symmetric(
            horizontal:
                GBSystem_ScreenHelper.screenWidthPercentage(context, 0.015),
            vertical:
                GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
        decoration: const BoxDecoration(
          color: GbsSystemServerStrings.str_primary_color,
        ),
        child: Column(
          children: [
            Visibility(
              visible: widget.showBackBtn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: widget.onImageTap,
                      child: FutureBuilder<String?>(
                          future: GBSystem_AuthService(context)
                              .getPhotoSalarieQuickAccess(
                                  SVR_IDF: widget.salarie_idf),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // salarie.imageSalarie = snapshot.data;
                            }
                            return ClipOval(
                              child: snapshot.data != null
                                  ? Image.memory(
                                      base64Decode(
                                          snapshot.data!.split(',').last),
                                      fit: BoxFit.fill,
                                      width: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.13),
                                      height: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.13),
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        width: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.12),
                                        height: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.12),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(300),
                                            color: Colors.white),
                                        child: Center(
                                          child: GBSystem_TextHelper().normalText(
                                              text:
                                                  "${widget.salarie_lib.substring(0, 1).toUpperCase()}${widget.salarie_lib.substring(1, 2).toUpperCase()}",
                                              textColor: GbsSystemServerStrings
                                                  .str_primary_color),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.12),
                                      height: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.12),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          color: Colors.white),
                                      child: Center(
                                        child: GBSystem_TextHelper().normalText(
                                            text:
                                                "${widget.salarie_lib.substring(0, 1).toUpperCase()}${widget.salarie_lib.substring(1, 2).toUpperCase()}",
                                            textColor: GbsSystemServerStrings
                                                .str_primary_color),
                                      ),
                                    ),
                            );
                          }),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(
                              context, 0.4),
                          child: GBSystem_TextHelper().smallText(
                            text: widget.salarie_lib,
                            textColor: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.location_solid,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.4),
                              child: GBSystem_TextHelper().smallText(
                                text: widget.salarie_lib,
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.4),
                              child: GBSystem_TextHelper().smallText(
                                text: widget.dateDebut != null
                                    ? "${ConvertDateService().parseDateAndTimeWithoutSec(date: widget.dateDebut!)} ~"
                                    : "${ConvertDateService().parseDateAndTimeWithoutSec(date: DateTime.now())} ~",
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: widget.onSignatureTap,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              "assets/images/signature.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_signatur,
                                maxLines: 2,
                                textColor: Colors.white),
                          )
                        ],
                      ),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: Visibility(
                            visible: isSignatureDone,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: widget.onChargerTap,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.edit_document,
                              size: 40,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_cloturer,
                                maxLines: 2,
                                textColor: Colors.white),
                          )
                        ],
                      ),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: Visibility(
                            visible: isClotureDone,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            Obx(() => GBSystem_TextHelper().smallText(
                text: widget.isViewMode
                    ? evaluationController.getCurrentEvaluationView != null
                        ? "${evaluationController.getCurrentEvaluationView?.EVAL_MOYENNE}% ${evaluationController.getCurrentEvaluationView?.EVAL_STAT}"
                        : "00,00% 0,0"
                    : evaluationController.getCurrentEvaluation != null
                        ? "${evaluationController.getCurrentEvaluation?.EVAL_MOYENNE}% ${evaluationController.getCurrentEvaluation?.EVAL_STAT}"
                        : "00,00% 0,0",
                textColor: Colors.white)),
          ],
        ));
  }
}
