import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/SELECT_ITEM_AGENCE/GBSystem_Root_Card_Diplome_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/SELECT_ITEM_AGENCE/GBSystem_select_item_agence_controller.dart';

import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystem_SelectItemAgenceScreen extends StatelessWidget {
  const GBSystem_SelectItemAgenceScreen(
      {super.key, required this.controllerTxtField});

  final TextEditingController controllerTxtField;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemAgenceController m =
        Get.put(GBSystemSelectItemAgenceController(context: context));

    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                elevation: 4.0,
                shadowColor: GbsSystemServerStrings.str_primary_color,
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
                        ? m.filtredAgences.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.filtredAgences.length,
                                  itemBuilder: (context, index) {
                                    return GBSystem_Root_CardView_Agence_Widget(
                                      tileColor: index % 2 == 0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      onTap: () {
                                        m.selectItemSiteFunction(
                                            selectedAgence:
                                                m.filtredAgences[index]);

                                        controllerTxtField.text =
                                            '${m.filtredAgences[index].DOS_CODE} | ${m.filtredAgences[index].DOS_LIB}';
                                      },
                                      agence: m.filtredAgences[index],
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data.tr,
                              ))
                        : (m.agences.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.agences.length,
                                  itemBuilder: (context, index) {
                                    return GBSystem_Root_CardView_Agence_Widget(
                                      tileColor: index % 2 == 0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      onTap: () {
                                        m.selectItemSiteFunction(
                                            selectedAgence: m.agences[index]);
                                        // controllerTxtField.text =
                                        //     m.agences[index].DOS_LIB;
                                        controllerTxtField.text =
                                            '${m.agences[index].DOS_CODE} | ${m.agences[index].DOS_LIB}';
                                      },
                                      agence: m.agences[index],
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data.tr,
                              )),
                  ],
                ),
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
