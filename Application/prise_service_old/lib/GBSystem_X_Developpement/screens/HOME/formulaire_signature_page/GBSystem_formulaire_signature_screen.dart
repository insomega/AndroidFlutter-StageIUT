import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/evaluation_status_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/formulaire_signature_page/GBSystem_formulaire_signature_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/signature_page/GBSystem_signature_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/APP_BAR/app_bar_quick_access.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/focused_image_salarie_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/qcm_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/tab_bar.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemFormulaireSignatureScreen extends StatefulWidget {
  const GBSystemFormulaireSignatureScreen(
      {super.key,
      required this.salarie_idf,
      required this.salarie_lib,
      this.isQCM = false,
      this.dateDebut,
      this.isViewMode = false,
      required this.evaluationEnCoursModel_LIEINSPSVR_IDF,
      required this.evaluationStatus});
  //
  final String evaluationEnCoursModel_LIEINSPSVR_IDF;
  final EvaluationStatus? evaluationStatus;
  //
  final String salarie_idf;
  final String salarie_lib;
  final DateTime? dateDebut;
  final bool isQCM;
  final bool isViewMode;

  @override
  State<GBSystemFormulaireSignatureScreen> createState() =>
      _GBSystemFormulaireSignatureScreenState();
}

class _GBSystemFormulaireSignatureScreenState
    extends State<GBSystemFormulaireSignatureScreen> {
  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GBSystemFormulaireSignatureController m = Get.put(
        GBSystemFormulaireSignatureController(
            evaluationStatus: widget.evaluationStatus,
            context,
            widget.isQCM,
            widget.isViewMode,
            GBSystem_ScreenHelper.screenWidth(context),
            widget.evaluationEnCoursModel_LIEINSPSVR_IDF));
    return Obx(() => GestureDetector(
          onTap: m.isImageFocused.value
              ? () {
                  try {
                    m.updateImageBool(false);
                  } catch (e) {
                    m.isLoading.value = false;

                    GBSystem_ManageCatchErrors().catchErrors(
                      context,
                      message: e.toString(),
                      method: "updateImageBool",
                      page: "GBSystem_formulaire_signature_screen",
                    );
                  }
                }
              : null,
          child: Stack(
            children: [
              AbsorbPointer(
                absorbing: m.isImageFocused.value,
                child: Scaffold(
                  appBar: GBSystemAppBarQuickAccess(
                    isViewMode: widget.isViewMode,
                    dateDebut: widget.dateDebut,
                    onSignatureTap: () {
                      Get.to(GBSystemSignatureScreen(
                          evaluationEnCoursModel_LIEINSPSVR_IDF:
                              widget.evaluationEnCoursModel_LIEINSPSVR_IDF,
                          causerieModel: null,
                          updateUI: updateUI));
                    },
                    onImageTap: () {
                      try {
                        m.updateImageBool(true);
                      } catch (e) {
                        m.isLoading.value = false;

                        GBSystem_ManageCatchErrors().catchErrors(
                          context,
                          message: e.toString(),
                          method: "updateImageBool 2",
                          page: "GBSystem_formulaire_signature_screen",
                        );
                      }
                    },
                    onChargerTap: () async {
                      try {
                        await m.chargerData();
                      } catch (e) {
                        m.isLoading.value = false;

                        GBSystem_ManageCatchErrors().catchErrors(
                          context,
                          message: e.toString(),
                          method: "chargerData",
                          page: "GBSystem_formulaire_signature_screen",
                        );
                      }
                    },
                    salarie_idf: widget.salarie_idf,
                    salarie_lib: widget.salarie_lib,
                  ),
                  body: widget.isQCM
                      ? ListView.builder(
                          itemCount: m.listQCM.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: GBSystem_ScreenHelper
                                      .screenWidthPercentage(context, 0.03),
                                  vertical: GBSystem_ScreenHelper
                                      .screenHeightPercentage(context, 0.01)),
                              child: QCMWidget(
                                isViewMode: widget.isViewMode,
                                questionModel: m.listQCM[index],
                              ),
                            );
                          },
                        )
                      : m
                                  .evaluationSurSiteController
                                  .getSelectedTypeQuestionnaire
                                  ?.LIEINSQUESTYP_LIB ==
                              GbsSystemStrings
                                  .str_selected_type_questionnaire_controle
                          ? Column(
                              children: [
                                TabBarWidget(
                                  evaluationEnCoursModel_LIEINSPSVR_IDF: widget
                                      .evaluationEnCoursModel_LIEINSPSVR_IDF,
                                  pageController: m.pageController,
                                  items: m.items,
                                  current: m.current,
                                  scrollController: m.scrollTabBarController,
                                ),
                                Expanded(
                                  child: PageView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      controller: m.pageController,
                                      children: m.listPagesFormulaires),
                                )
                              ],
                            )
                          : ListView.builder(
                              itemCount: m.listQCM.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.03),
                                      vertical: GBSystem_ScreenHelper
                                          .screenHeightPercentage(
                                              context, 0.01)),
                                  child: QCMWidget(
                                    isViewMode: widget.isViewMode,
                                    questionModel: m.listQCM[index],
                                  ),
                                );
                              },
                            ),
                ),
              ),
              m.isImageFocused.value
                  ? FocusedImageSalarieWidget(
                      salarie_idf: widget.salarie_idf,
                      salarie_lib: widget.salarie_lib,
                    )
                  : Container(),
              m.isLoading.value ? Waiting() : Container()
            ],
          ),
        ));
  }
}
