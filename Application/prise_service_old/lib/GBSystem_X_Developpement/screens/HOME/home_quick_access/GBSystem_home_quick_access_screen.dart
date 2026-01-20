import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/home_quick_access/GBSystem_home_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_quick_access/GBSystem_select_item_screen_quick_access.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/GBSystem_custom_button.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/select_questionnaire_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:animated_toggle/animated_toggle.dart';

class GBSystemHomeQuickAccessScreen extends StatelessWidget {
  const GBSystemHomeQuickAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GBSystemHomeQuickAccessController m =
        Get.put(GBSystemHomeQuickAccessController(context: context));

    return Obx(() => Stack(
          children: [
            Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 4.0,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  toolbarHeight: 80,
                  backgroundColor: GbsSystemServerStrings.str_primary_color,
                  title: const Text(
                    GbsSystemStrings.str_evaluation_sur_site,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.white,
                      )),
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                        context,
                        0.02,
                      ),
                      vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GBSystem_TextHelper().normalText(
                        text: GbsSystemStrings.str_type,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  GBSystem_ScreenHelper.screenHeightPercentage(
                                      context, 0.02),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: AnimatedHorizontalToggle(
                                taps: m.listType,
                                activeBoxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  ),
                                ],

                                width: MediaQuery.of(context).size.width - 20,
                                height: 48,
                                duration: const Duration(milliseconds: 200),
                                initialIndex: 0,
                                background: Colors.grey.shade200,
                                activeColor:
                                    GbsSystemServerStrings.str_primary_color,
                                // .withOpacity(0.5),
                                activeTextStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                inActiveTextStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: GbsSystemServerStrings
                                        .str_primary_color),
                                horizontalPadding: 4,
                                verticalPadding: 4,
                                activeHorizontalPadding: 2,
                                activeVerticalPadding: 4,
                                radius: 14,
                                activeButtonRadius: 14,
                                onChange: (int currentIndex, int targetIndex) {
                                  try {
                                    // write Your Personal Code Here
                                    m.selectedType.value =
                                        m.listType[targetIndex];

                                    m.evaluationSurSiteController
                                            .setSelectedType =
                                        m.listType[targetIndex];
                                  } catch (e) {
                                    GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "AnimatedHorizontalToggle",
                                      page: "GBSystem_home_quick_access_screen",
                                    );
                                  }
                                },
                                showActiveButtonColor: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: GBSystem_ScreenHelper.screenHeightPercentage(
                            context, 0.02),
                      ),
                      Obx(
                        () => SelectWidgetGenerique(
                          isObligatoire: true,
                          onTap: () {
                            Get.to(GBSystem_SelectItemQuickAccessScreen(
                                selectedQuestionTypeModel:
                                    m.selectedTypeQuestionnaire.value,
                                type: GbsSystemStrings
                                    .str_type_type_questionnaire));
                          },
                          selectedItemStr: m.evaluationSurSiteController
                              .getSelectedTypeQuestionnaire?.LIEINSQUESTYP_CODE,
                          opt1Str: m.evaluationSurSiteController
                              .getSelectedTypeQuestionnaire?.LIEINSQUESTYP_LIB,
                          catStr: GbsSystemStrings.str_type_questionnaire,

                          // typeQuestionnaire: m.evaluationSurSiteController
                          //     .getSelectedTypeQuestionnaire,
                          onDeleteTap: () {
                            m.evaluationSurSiteController
                                .setSelectedTypeQuestionnaire = null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: GBSystem_ScreenHelper.screenHeightPercentage(
                            context, 0.02),
                      ),
                      Obx(
                        () => SelectWidgetGenerique(
                          isObligatoire: true,
                          onTap: () {
                            Get.to(GBSystem_SelectItemQuickAccessScreen(
                                selectedQuestionTypeModel:
                                    m.selectedTypeQuestionnaire.value,
                                type: GbsSystemStrings.str_type_questionnaire));
                          },
                          selectedItemStr: m.evaluationSurSiteController
                              .getSelectedQuestionnaire?.LIEINSPQSNR_CODE,
                          opt1Str: m.evaluationSurSiteController
                              .getSelectedQuestionnaire?.LIEINSPQSNR_LIB,
                          catStr: GbsSystemStrings.str_questionnaire,
                          // questionnaireModel: m.evaluationSurSiteController
                          //     .getSelectedQuestionnaire,
                          onDeleteTap: () {
                            m.evaluationSurSiteController
                                .setSelectedQuestionnaire = null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: GBSystem_ScreenHelper.screenHeightPercentage(
                            context, 0.02),
                      ),
                      Obx(
                        () => SelectWidgetGenerique(
                          onTap: () async {
                            try {
                              m.isLoading.value = true;

                              await GBSystem_AuthService(context)
                                  .getSiteQuickAccessFiltred(
                                      isLibre: m.selectedType == m.listType[0]
                                          ? false
                                          : m.selectedType == m.listType[1]
                                              ? true
                                              : false,
                                      isPeriodique:
                                          m.selectedType == m.listType[0]
                                              ? true
                                              : m.selectedType == m.listType[1]
                                                  ? false
                                                  : false,
                                      isUtilisateur: m.selectedType ==
                                              m.listType[0]
                                          ? false
                                          : m.selectedType == m.listType[1]
                                              ? false
                                              : m.selectedType == m.listType[2]
                                                  ? true
                                                  : false)
                                  .then((value) {
                                m.isLoading.value = false;
                                final GBSystemEvaluationSurSiteController
                                    evaluationSurSiteController = Get.put(
                                        GBSystemEvaluationSurSiteController());
                                evaluationSurSiteController.setAllSites = value;

                                Get.to(GBSystem_SelectItemQuickAccessScreen(
                                  selectedQuestionTypeModel:
                                      m.selectedTypeQuestionnaire.value,
                                  type: GbsSystemStrings.str_type_site,
                                ));
                              });
                            } catch (e) {
                              m.isLoading.value = false;

                              GBSystem_ManageCatchErrors().catchErrors(
                                context,
                                message: e.toString(),
                                method: "getSiteQuickAccessFiltred",
                                page: "GBSystem_home_quick_access_screen",
                              );
                            }
                          },
                          selectedItemStr: m.evaluationSurSiteController
                              .getSelectedSite?.LIE_LIB,
                          opt1Str: m.evaluationSurSiteController.getSelectedSite
                              ?.LIE_CODE,
                          catStr: GbsSystemStrings.str_lieu,

                          // siteModel:
                          //     m.evaluationSurSiteController.getSelectedSite,
                          onDeleteTap: () {
                            m.evaluationSurSiteController.setSelectedSite =
                                null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: GBSystem_ScreenHelper.screenHeightPercentage(
                            context, 0.03),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            onTap: () async {
                              try {
                                if (m.selectedType.value ==
                                    GbsSystemStrings.str_utilisateur) {
                                  await m.chargerDataAgenceQuestionnaire();
                                } else {
                                  await m.chargerDataQuestionnaire();
                                }
                              } catch (e) {
                                m.isLoading.value = false;

                                GBSystem_ManageCatchErrors().catchErrors(
                                  context,
                                  message: e.toString(),
                                  method: "chargerDataQuestionnaire",
                                  page: "GBSystem_home_quick_access_screen",
                                );
                              }
                            },
                            text: GbsSystemStrings.str_charger,
                            horPadding: 20,
                            verPadding: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
