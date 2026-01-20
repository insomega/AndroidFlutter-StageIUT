import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_fournisseur/select_item_fournisseur_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_CardView_Widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_Card_Home_Widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystem_SelectItemFournisseurScreen extends StatelessWidget {
  const GBSystem_SelectItemFournisseurScreen(
      {super.key, required this.controllerTxtField});

  final TextEditingController controllerTxtField;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemFournisseurScreenController m = Get.put(
        GBSystemSelectItemFournisseurScreenController(context: context));

    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                elevation: 4.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                toolbarHeight: 70,
                backgroundColor: GbsSystemServerStrings.str_primary_color,
                title: Text(
                  GbsSystemStrings.str_app_bar_select_item.tr,
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
                        context, 0.02),
                    vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                        context, 0.02)),
                child: Column(
                  children: [
                    SearchBar(
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
                        m.filterDataSite(query);
                      },
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    m.text != null && m.text != ''
                        ? m.filtredFournisseur.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.filtredFournisseur.length,
                                  itemBuilder: (context, index) {
                                    return GBSystem_Root_CardViewWidgetGenerique(
                                      tileColor: index % 2 == 0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      onTap: () {
                                        m.selectItemSiteFunction(
                                            selectedFourni:
                                                m.filtredFournisseur[index]);

                                        controllerTxtField.text =
                                            m.filtredFournisseur[index].FOU_LIB;
                                      },
                                      title:
                                          m.filtredFournisseur[index].FOU_LIB,
                                      optStr1:
                                          m.filtredFournisseur[index].FOU_TEL,
                                      optStr2:
                                          m.filtredFournisseur[index].FOU_ADR1,
                                      optStr3: m
                                          .filtredFournisseur[index].FOU_TELPOR,

                                      // fournisseur: m.filtredFournisseur[index],
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data.tr,
                              ))
                        : (m.fournisseur.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.fournisseur.length,
                                  itemBuilder: (context, index) {
                                    return GBSystem_Root_CardViewWidgetGenerique(
                                      tileColor: index % 2 == 0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      onTap: () {
                                        m.selectItemSiteFunction(
                                            selectedFourni:
                                                m.fournisseur[index]);
                                        controllerTxtField.text =
                                            m.fournisseur[index].FOU_LIB;

                                        // m.sitePlanningController
                                        //     .setCurrentSite = m.habiliter[index];
                                        // Get.back();
                                      },
                                      title: m.fournisseur[index].FOU_LIB,
                                      optStr1: m.fournisseur[index].FOU_CODE,
                                      optStr2: m.fournisseur[index].FOU_ADR1,
                                      optStr3: m.fournisseur[index].FOU_TELPOR,

                                      // fournisseur: m.fournisseur[index],
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data.tr,
                              )),
                    // SizedBox(
                    //   height: GBSystem_ScreenHelper.screenHeightPercentage(
                    //       context, 0.02),
                    // ),
                  ],
                ),
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
