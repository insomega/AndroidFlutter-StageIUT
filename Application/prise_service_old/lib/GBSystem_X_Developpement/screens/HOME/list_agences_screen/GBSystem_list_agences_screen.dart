import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/list_agences_screen/GBSystem_list_agences_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/GBSystem_agence_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GBSystemListAgencesScreen extends StatelessWidget {
  GBSystemListAgencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GBSystemListAgencesScreenController m =
        Get.put(GBSystemListAgencesScreenController(context: context));

    return Obx(() => Stack(
          children: [
            Scaffold(
                appBar: AppBar(
                  elevation: 4.0,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  toolbarHeight: 80,
                  backgroundColor: GbsSystemServerStrings.str_primary_color,
                  title: const Text(
                    GbsSystemStrings.str_selectioner_salarie,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
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
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: SearchBar(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        hintText: GbsSystemStrings.str_rechercher,
                        controller: m.controllerSearch,
                        leading: const Icon(CupertinoIcons.search),
                        trailing: [
                          GestureDetector(
                              onTap: () {
                                m.controllerSearch.text = "";
                                m.text?.value = "";
                              },
                              child: const Icon(Icons.close))
                        ],
                        onChanged: (String query) {
                          m.text?.value = query;
                        },
                      ),
                    ),
                    Expanded(
                      child: m.usedListAgences().isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.02),
                              ),
                              child: ListView.builder(
                                itemCount: m.usedListAgences().length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: AgenceQuickAccessWidget(
                                      onTap: () async {
                                        try {
                                          m.salarieQuickAccessWithImageController
                                                  .setSelectedAgence =
                                              m.usedListAgences()[index];
                                          await m
                                              .chargerDataQuestionnaireFromUtilisateur();
                                        } catch (e) {
                                          m.isLoading.value = false;

                                          GBSystem_ManageCatchErrors()
                                              .catchErrors(
                                            context,
                                            message: e.toString(),
                                            method:
                                                "chargerDataQuestionnaireFromUtilisateur",
                                            page:
                                                "GBSystem_list_agences_screen",
                                          );
                                        }
                                      },
                                      salarieQuickAccessModel:
                                          m.usedListAgences()[index],
                                    ),
                                  );
                                },
                              ),
                            )
                          : SingleChildScrollView(
                              child: EmptyDataWidget(
                                heightLottie:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.8),
                              ),
                            ),
                    )
                  ],
                )),
            m.isLoading.value ? Waiting() : Container(),
          ],
        ));
  }
}
