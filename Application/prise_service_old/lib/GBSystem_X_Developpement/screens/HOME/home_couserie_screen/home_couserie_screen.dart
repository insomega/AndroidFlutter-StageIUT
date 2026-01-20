import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_photo_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/causerie_done_screen/causerie_done_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/home_couserie_screen/home_couserie_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/list_salarie_causerie_screen/GBSystem_list_salaries_causerie_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_quick_access/GBSystem_select_item_screen_quick_access.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/GBSystem_custom_button.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/custom_date_picker.dart';

import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/select_questionnaire_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

import '../../../widgets/GENERAL_WIDGETS/custom_date_picker.dart';

class HomeCouserieScreen extends StatelessWidget {
  const HomeCouserieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeCouserieScreenController m =
        Get.put(HomeCouserieScreenController(context: context));
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 4.0,
              shadowColor: Colors.grey.withOpacity(0.5),
              toolbarHeight: 80,
              backgroundColor: GbsSystemServerStrings.str_primary_color,
              title: const Text(
                GbsSystemStrings.str_salaries_evaluation,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: false,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomDatePickerFrench(
                              selectedDate: m.dateDebut.value,
                              labelText: GbsSystemStrings.str_date_debut.tr,
                              initialDate: m.dateDebut.value,
                              onDateSelected: (DateTime selectedDate) {
                                m.dateDebut.value = selectedDate;
                                m.evaluationSurSiteController.setDateDebut =
                                    selectedDate;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: CustomDatePickerFrench(
                              selectedDate: m.dateFin.value,
                              labelText: GbsSystemStrings.str_date_fin.tr,
                              initialDate: m.dateFin.value,
                              onDateSelected: (DateTime selectedDate) {
                                m.dateFin.value = selectedDate;
                                m.evaluationSurSiteController.setDateFin =
                                    selectedDate;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => SelectWidgetGenerique(
                        onTap: () async {
                          try {
                            m.isLoading.value = true;

                            await GBSystem_AuthService(context)
                                .getSiteQuickAccess()
                                .then((value) {
                              m.isLoading.value = false;
                              // final GBSystemEvaluationSurSiteController
                              //     evaluationSurSiteController =
                              //     Get.put(GBSystemEvaluationSurSiteController());
                              m.evaluationSurSiteController.setAllSites = value;

                              Get.to(GBSystem_SelectItemQuickAccessScreen(
                                selectedQuestionTypeModel: null,
                                type: GbsSystemStrings.str_type_site,
                              ));
                            });
                          } catch (e) {
                            m.isLoading.value = false;

                            GBSystem_ManageCatchErrors().catchErrors(
                              context,
                              message: e.toString(),
                              method: "getSiteQuickAccess",
                              page: "home_couserie_screen",
                            );
                          }
                        },
                        selectedItemStr: m.evaluationSurSiteController
                            .getSelectedSite?.LIE_LIB,
                        opt1Str: m.evaluationSurSiteController.getSelectedSite
                            ?.LIE_CODE,
                        catStr: GbsSystemStrings.str_lieu,
                        isObligatoire: true,

                        // siteModel:
                        //     m.evaluationSurSiteController.getSelectedSite,
                        onDeleteTap: () {
                          m.evaluationSurSiteController.setSelectedSite = null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => SelectWidgetGenerique(
                        onTap: () async {
                          if (m.dateDebut.value != null) {
                            try {
                              m.isLoading.value = true;

                              await GBSystem_AuthService(context)
                                  .getQuestionnaireCauserie(
                                      dateDebut: m.dateDebut.value!)
                                  .then((value) {
                                m.isLoading.value = false;
                                // final GBSystemEvaluationSurSiteController
                                //     evaluationSurSiteController =
                                //     Get.put(GBSystemEvaluationSurSiteController());
                                m.evaluationSurSiteController
                                    .setAllQuestionnaire = value ?? [];

                                Get.to(GBSystem_SelectItemQuickAccessScreen(
                                  isCauserie: true,
                                  selectedQuestionTypeModel: null,
                                  type: GbsSystemStrings.str_type_questionnaire,
                                ));
                              });
                            } catch (e) {
                              m.isLoading.value = false;

                              GBSystem_ManageCatchErrors().catchErrors(
                                context,
                                message: e.toString(),
                                method: "getQuestionnaireCauserie",
                                page: "home_couserie_screen",
                              );
                            }
                          } else {
                            showErrorDialog(context,
                                GbsSystemStrings.str_choisi_date_debut);
                          }
                        },
                        selectedItemStr: m.evaluationSurSiteController
                            .getSelectedQuestionnaire?.LIEINSPQSNR_CODE,
                        opt1Str: m.evaluationSurSiteController
                            .getSelectedQuestionnaire?.LIEINSPQSNR_LIB,
                        catStr: GbsSystemStrings.str_questionnaire,
                        isObligatoire: true,

                        // questionnaireModel: m.evaluationSurSiteController
                        //     .getSelectedQuestionnaire,
                        onDeleteTap: () {
                          m.evaluationSurSiteController
                              .setSelectedQuestionnaire = null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      spacing: 4,
                      runSpacing: 5,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              onTap: () async {
                                try {
                                  if (m.evaluationSurSiteController
                                              .getSelectedQuestionnaire !=
                                          null &&
                                      m.evaluationSurSiteController
                                              .getSelectedSite !=
                                          null) {
                                    List<GBSystemSalarieWithPhotoCauserieModel>
                                        listSalarieWithPhoto = [];
                                    m.isLoading.value = true;
                                    await GBSystem_AuthService(context)
                                        .getSalariesQuickAccessCauserie(
                                            site: m.evaluationSurSiteController
                                                .getSelectedSite!,
                                            questionnaire: m
                                                .evaluationSurSiteController
                                                .getSelectedQuestionnaire!)
                                        .then(
                                      (value) async {
                                        for (var i = 0;
                                            i < (value?.length ?? 0);
                                            i++) {
                                          await GBSystem_AuthService(context)
                                              .getPhotoSalarieCauserie(
                                                  salarieCauserieModel_SVR_IDF:
                                                      value![i].SVR_IDF)
                                              .then(
                                            (image) {
                                              listSalarieWithPhoto.add(
                                                  GBSystemSalarieWithPhotoCauserieModel(
                                                      salarieCauserieModel:
                                                          value[i],
                                                      imageSalarie: image));
                                            },
                                          );
                                        }
                                        m.salarieCauserieWithImageController
                                                .setAllSalaries =
                                            listSalarieWithPhoto;
                                        m.isLoading.value = false;
                                        Get.to(
                                            GBSystemListSalariesCauserieScreen());
                                      },
                                    );
                                  } else if (m.evaluationSurSiteController
                                          .getSelectedSite ==
                                      null) {
                                    showErrorDialog(context,
                                        GbsSystemStrings.str_choisi_lieu);
                                  } else {
                                    showErrorDialog(
                                        context,
                                        GbsSystemStrings
                                            .str_choisi_questionnaire);
                                  }
                                } catch (e) {
                                  m.isLoading.value = false;

                                  GBSystem_ManageCatchErrors().catchErrors(
                                    context,
                                    message: e.toString(),
                                    method: "getSalariesQuickAccessCauserie",
                                    page: "home_couserie_screen",
                                  );
                                }
                              },
                              text: GbsSystemStrings.str_charger,
                              horPadding: 20,
                              verPadding: 10,
                            ),
                          ],
                        ),
                        Visibility(
                          visible: false,
                          child: CustomButtonWithTrailling(
                              onTap: () {
                                if (m.evaluationSurSiteController
                                        .getSelectedQuestionnaire !=
                                    null) {
                                  Get.to(CauserieDoneScreen(
                                    dateDebut: m.dateDebut.value,
                                    dateFin: m.dateFin.value,
                                    site: m.evaluationSurSiteController
                                        .getSelectedSite,
                                  ));
                                } else {
                                  showErrorDialog(
                                      context,
                                      GbsSystemStrings
                                          .str_choisi_questionnaire);
                                }
                              },
                              text: GbsSystemStrings.str_terminer,
                              horPadding: 8,
                              verPadding: 10,
                              color: Colors.lightGreen[700],
                              textSize: 12,
                              shadowColor: GbsSystemServerStrings
                                  .str_primary_color
                                  .withOpacity(0.6),
                              trailling: Icon(
                                CupertinoIcons.checkmark_circle,
                                color: Colors.white,
                              )),
                        ),
                        // CustomButtonWithTrailling(
                        //     onTap: () {},
                        //     text: GbsSystemStrings.str_demarer_causerie,
                        //     horPadding: 8,
                        //     verPadding: 5,
                        //     textSize: 12,
                        //     shadowColor: GbsSystemStrings.str_primary_color
                        //         .withOpacity(0.6),
                        //     trailling: Icon(
                        //       CupertinoIcons.play,
                        //       color: Colors.white,
                        //     )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          m.isLoading.value ? Waiting() : Container()
        ],
      ),
    );
  }
}
