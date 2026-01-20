import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_signature_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_photo_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GBSystemAppBarQuickAccess2 extends StatelessWidget
    implements PreferredSizeWidget {
  GBSystemAppBarQuickAccess2({
    super.key,
    required this.listSalarie,
    this.onSignatureTap,
    this.onChargerTap,
    this.showBackBtn = true,
    this.causerieModel,
    this.isViewMode = false,
  });

  final bool isViewMode;
  final List<GBSystemSalarieWithPhotoCauserieModel> listSalarie;
  final void Function()? onSignatureTap, onChargerTap;
  final CauserieModel? causerieModel;
  final bool showBackBtn;
  final evaluationController =
      Get.put<EvaluationController>(EvaluationController());
  final signatureController =
      Get.put<GBSystemSignatureController>(GBSystemSignatureController());
  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());
  bool isClotureDone = false;
  @override
  Widget build(BuildContext context) {
    bool isSignatureDone = signatureController.getSignatureBase64 != null;
    if (!isViewMode) {
      isClotureDone = signatureController.getIsCloture;
    }

    print(listSalarie.length);
    return Container(
        height: 165,
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
              visible: showBackBtn,
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
                    const SizedBox(
                      width: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   width: GBSystem_ScreenHelper.screenWidthPercentage(
                        //       context, 0.4),
                        //   child: GBSystem_TextHelper().smallText(
                        //     text: listSalarie
                        //         .map(
                        //           (e) => e.salarieCauserieModel.SVR_LIB,
                        //         )
                        //         .join(", "),
                        //     maxLines: 2,
                        //     textColor: Colors.white,
                        //   ),
                        // ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.location_solid,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.4),
                              child: GBSystem_TextHelper().smallText(
                                text: causerieModel?.LIE_LIB ??
                                    evaluationSurSiteController
                                        .getSelectedSite?.LIE_LIB ??
                                    "",
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              CupertinoIcons.calendar,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.4),
                              child: GBSystem_TextHelper().smallText(
                                  text: isViewMode &&
                                          causerieModel != null &&
                                          causerieModel!
                                                  .LIEINSPSVR_START_DATE !=
                                              null &&
                                          causerieModel!.LIEINSPSVR_END_DATE !=
                                              null
                                      ? "${ConvertDateService().parseDateAndTime(date: causerieModel!.LIEINSPSVR_START_DATE!)}\n${ConvertDateService().parseDateAndTime(date: causerieModel!.LIEINSPSVR_END_DATE!)}"
                                      : evaluationSurSiteController
                                                      .getDateFinCloture !=
                                                  null &&
                                              evaluationSurSiteController
                                                      .getDateDebutCloture !=
                                                  null
                                          ? "${ConvertDateService().parseDateAndTime(date: evaluationSurSiteController.getDateDebutCloture!)}\n${ConvertDateService().parseDateAndTime(date: evaluationSurSiteController.getDateFinCloture!)}"
                                          : evaluationSurSiteController
                                                      .getDateDebutCloture !=
                                                  null
                                              ? "${ConvertDateService().parseDateAndTime(date: evaluationSurSiteController.getDateDebutCloture!)}"
                                              : "${ConvertDateService().parseDateAndTime(date: DateTime.now())}",
                                  textColor: Colors.white,
                                  maxLines: 2),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: onSignatureTap,
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
                            width: 85,
                            child: GBSystem_TextHelper().smallText(
                                text:
                                    "${GbsSystemStrings.str_signatur}\n${GbsSystemStrings.str_responsable}",
                                maxLines: 2,
                                textAlign: TextAlign.center,
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
                  onTap: onChargerTap,
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
                                text: "${GbsSystemStrings.str_cloturer}\n",
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
                text: evaluationController.getCurrentEvaluation != null
                    ? "${evaluationController.getCurrentEvaluation?.EVAL_MOYENNE}% ${evaluationController.getCurrentEvaluation?.EVAL_STAT}"
                    : "00,00% 0,0",
                textColor: Colors.white)),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(165);
}
