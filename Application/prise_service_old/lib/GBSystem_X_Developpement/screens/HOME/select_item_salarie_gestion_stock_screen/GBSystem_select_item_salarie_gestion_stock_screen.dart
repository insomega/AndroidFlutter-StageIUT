import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_salarie_gestion_stock_screen/GBSystem_select_item_salarie_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_CardView_Widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystem_SelectItemSalarieGestionStockScreen extends StatelessWidget {
  const GBSystem_SelectItemSalarieGestionStockScreen(
      {super.key, required this.updateUI});

  final Function updateUI;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemSalarieGestionStockController m = Get.put(
        GBSystemSelectItemSalarieGestionStockController(context: context));

    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                elevation: 4.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                toolbarHeight: 70,
                backgroundColor: GbsSystemServerStrings.str_primary_color,
                title: const Text(
                  GbsSystemStrings.str_app_bar_select_item,
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
                        m.filterDataSalarie(query);
                      },
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    m.text != null && m.text != ''
                        ? (m.filtredsalaries.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.filtredsalaries.length,
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
                                          m.salarieGestionStockController
                                                  .setCurrentSalarieSalarie =
                                              m.filtredsalaries[index];

                                          m.salarieGestionStockController
                                                  .setSelectedSalarieToList =
                                              m.filtredsalaries[index];

                                          updateUI();
                                          Get.back();
                                        },
                                        optStr1:
                                            m.filtredsalaries[index].SVR_CODE,
                                        title: m.filtredsalaries[index].SVR_LIB,
                                        optStr2: null,
                                        optStr3: null,
                                        // salarie: m.filtredsalaries[index],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data,
                              ))
                        : (m.salaries.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.salaries.length,
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
                                          m.salarieGestionStockController
                                                  .setCurrentSalarieSalarie =
                                              m.salaries[index];
                                          m.salarieGestionStockController
                                                  .setSelectedSalarieToList =
                                              m.salaries[index];

                                          updateUI();

                                          Get.back();
                                        },
                                        optStr1: m.salaries[index].SVR_CODE,
                                        title: m.salaries[index].SVR_LIB,
                                        optStr2: null,
                                        optStr3: null,

                                        // salarie: m.salaries[index],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data,
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
