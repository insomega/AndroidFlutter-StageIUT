import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_enterpot/select_item_enterpot_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_CardView_Widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_Card_Home_Widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystem_SelectItemEnterpotScreen extends StatelessWidget {
  const GBSystem_SelectItemEnterpotScreen(
      {super.key, required this.controllerTxtField});

  final TextEditingController controllerTxtField;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemEnterpotScreenController m =
        Get.put(GBSystemSelectItemEnterpotScreenController(context: context));

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
                        ? m.filtredEnterpot.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.filtredEnterpot.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child:
                                          GBSystem_Root_CardViewWidgetGenerique(
                                        tileColor: index % 2 == 0
                                            ? Colors.grey.withOpacity(0.2)
                                            : Colors.white,
                                        onTap: () {
                                          m.selectItemSiteFunction(
                                              selectedEntr:
                                                  m.filtredEnterpot[index]);

                                          controllerTxtField.text =
                                              m.filtredEnterpot[index].ENTR_LIB;
                                        },
                                        title:
                                            m.filtredEnterpot[index].ENTR_LIB,
                                        optStr1:
                                            m.filtredEnterpot[index].ENTR_CODE,
                                        optStr2:
                                            m.filtredEnterpot[index].ENTR_TELPH,
                                        optStr3:
                                            m.filtredEnterpot[index].VIL_LIB,

                                        // enterpot: m.filtredEnterpot[index],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data.tr,
                              ))
                        : (m.enterpot.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.enterpot.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child:
                                          GBSystem_Root_CardViewWidgetGenerique(
                                        tileColor: index % 2 == 0
                                            ? Colors.grey.withOpacity(0.2)
                                            : Colors.white,
                                        onTap: () {
                                          m.selectItemSiteFunction(
                                              selectedEntr: m.enterpot[index]);
                                          controllerTxtField.text =
                                              m.enterpot[index].ENTR_LIB;

                                          // m.sitePlanningController
                                          //     .setCurrentSite = m.habiliter[index];
                                          // Get.back();
                                        },
                                        title: m.enterpot[index].ENTR_LIB,
                                        optStr1: m.enterpot[index].ENTR_EMAIL,
                                        optStr2: m.enterpot[index].ENTR_TELPH,
                                        optStr3: m.enterpot[index].VIL_LIB,

                                        // enterpot: m.enterpot[index],
                                      ),
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
