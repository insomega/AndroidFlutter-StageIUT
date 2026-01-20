import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_salarie_causerie_with_image_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/formulaire_couserie_screen.dart/formulaire_couserie_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/list_salarie_causerie_screen/GBSystem_list_salaries_causerie_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/GBSystem_salarie_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystemListSalariesCauserieScreen extends StatefulWidget {
  GBSystemListSalariesCauserieScreen({super.key});

  @override
  State<GBSystemListSalariesCauserieScreen> createState() =>
      _GBSystemListSalariesCauserieScreenState();
}

class _GBSystemListSalariesCauserieScreenState
    extends State<GBSystemListSalariesCauserieScreen> {
  final GBSystemSalarieCauserieWithImageController
      salarieCauserieWithImageController =
      Get.put(GBSystemSalarieCauserieWithImageController());

  @override
  Widget build(BuildContext context) {
    final GBSystemListSalariesCauserieController m =
        Get.put(GBSystemListSalariesCauserieController(context: context));
    return Obx(() => Stack(
          children: [
            Scaffold(
                appBar: AppBar(
                  elevation: 4.0,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  toolbarHeight: 80,
                  backgroundColor: GbsSystemServerStrings.str_primary_color,
                  title: const Text(
                    GbsSystemStrings.str_selectioner_des_salarie,
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
                floatingActionButton: FloatingActionButton(
                    backgroundColor: GbsSystemServerStrings.str_primary_color,
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      try {
                        if (m.listSalarieSelected.isNotEmpty) {
                          m.isLoading.value = true;
                          salarieCauserieWithImageController
                              .setAllSelectedSalaries = m.listSalarieSelected;

                          await m.getCauserieData().then(
                            (value) {
                              m.isLoading.value = false;
                              print("vallll $value");
                              if (value != null && value.isNotEmpty) {
                                m.evaluationSurSiteController
                                    .setDateDebutCloture = DateTime.now();
                                Get.to(FormulaireCouserieScreen(
                                  causerieModel: null,
                                ));
                              }
                            },
                          );
                        } else {
                          showErrorDialog(
                              context, GbsSystemStrings.str_no_salarie);
                        }
                      } catch (e) {
                        m.isLoading.value = false;

                        GBSystem_ManageCatchErrors().catchErrors(
                          context,
                          message: e.toString(),
                          method: "getCauserieData",
                          page: "GBSystem_list_salaries_causerie_screen",
                        );
                      }
                    }),
                body: salarieCauserieWithImageController.getAllSalaries !=
                            null &&
                        salarieCauserieWithImageController
                            .getAllSalaries!.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GBSystem_ScreenHelper.screenWidthPercentage(
                                    context, 0.02),
                            vertical:
                                GBSystem_ScreenHelper.screenHeightPercentage(
                                    context, 0.02)),
                        child: GridView.builder(
                          itemCount: salarieCauserieWithImageController
                              .getAllSalaries?.length,
                          clipBehavior: Clip.none,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  //nmr element f l3Ordh
                                  crossAxisCount: 2,
                                  // taille t3 l element
                                  childAspectRatio: 0.62,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return SalarieCauserieWidget(
                              isSelected: m.testExistance(
                                  listSalarieSelected: m.listSalarieSelected,
                                  salarie: salarieCauserieWithImageController
                                      .getAllSalaries![index]),
                              onTap: () async {
                                try {
                                  bool check = m.testExistance(
                                      listSalarieSelected:
                                          m.listSalarieSelected,
                                      salarie:
                                          salarieCauserieWithImageController
                                              .getAllSalaries![index]);
                                  if (check) {
                                    m.listSalarieSelected.remove(
                                        salarieCauserieWithImageController
                                            .getAllSalaries![index]);
                                  } else {
                                    m.listSalarieSelected.add(
                                        salarieCauserieWithImageController
                                            .getAllSalaries![index]);
                                  }
                                  setState(() {});

                                  // m
                                  //             .evaluationSurSiteController
                                  //             .getSelectedTypeQuestionnaire
                                  //             ?.LIEINSQUESTYP_LIB ==
                                  //         GbsSystemStrings
                                  //             .str_selected_type_questionnaire_controle
                                  //     ? m.getFormulaireData(
                                  //         salarie:
                                  //             salarieCauserieWithImageController
                                  //                 .getAllSalaries![index])
                                  //     : m.getQCMData(
                                  //         salarie:
                                  //             salarieCauserieWithImageController
                                  //                 .getAllSalaries![index]);
                                } catch (e) {
                                  m.isLoading.value = false;

                                  GBSystem_ManageCatchErrors().catchErrors(
                                    context,
                                    message: e.toString(),
                                    method: "addRemoveSalarie",
                                    page:
                                        "GBSystem_list_salaries_causerie_screen",
                                  );
                                }
                              },
                              salarieCauserieModel:
                                  salarieCauserieWithImageController
                                      .getAllSalaries![index],
                            );
                          },
                        ),
                      )
                    : EmptyDataWidget(
                        heightLottie:
                            GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.8),
                      )),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
