import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_screen/GBSystem_select_item_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_CardView_Widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystem_SelectItemScreen extends StatelessWidget {
  const GBSystem_SelectItemScreen({super.key, required this.type});

  final String type;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemController m =
        Get.put(GBSystemSelectItemController(type: type, context: context));

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
                        type == GbsSystemStrings.str_type_site
                            ? m.filterDataSite(query)
                            : m.filterDataSalarie(query);
                      },
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    m.text != null && m.text != ''
                        ? (type == GbsSystemStrings.str_type_site
                                ? m.filtredSites.isNotEmpty
                                : m.filtredSalaries.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      type == GbsSystemStrings.str_type_site
                                          ? m.filtredSites.length
                                          : m.filtredSalaries.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: type ==
                                              GbsSystemStrings.str_type_site
                                          ? GBSystem_Root_CardViewWidgetGenerique(
                                              tileColor: index % 2 == 0
                                                  ? Colors.grey.withOpacity(0.2)
                                                  : Colors.white,
                                              onTap: () async {
                                                await m.selectItemSiteFunction(
                                                    selectedSite:
                                                        m.filtredSites[index]);
                                              },
                                              title:
                                                  m.filtredSites[index].LIE_LIB,
                                              optStr1: m
                                                  .filtredSites[index].LIE_ADR1,
                                              optStr2: m
                                                  .filtredSites[index].LIE_ADR2,
                                              optStr3:
                                                  m.filtredSites[index].VIL_LIB,
                                            )
                                          : GBSystem_Root_CardViewWidgetGenerique(
                                              tileColor: index % 2 == 0
                                                  ? Colors.grey.withOpacity(0.2)
                                                  : Colors.white,
                                              onTap: () {
                                                m.salariePlanningController
                                                        .setCurrentSalarie =
                                                    m.filtredSalaries[index];
                                                Get.back();
                                              },
                                              title:
                                                  "${m.filtredSalaries[index].SVR_NOM} ${m.filtredSalaries[index].SVR_PRNOM}",
                                              optStr1: m.filtredSalaries[index]
                                                  .SVR_TELPOR,
                                              optStr2: m.filtredSalaries[index]
                                                  .VIL_CODE,
                                              optStr3: m.filtredSalaries[index]
                                                  .VIL_LIB,
                                            ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data,
                              ))
                        : (type == GbsSystemStrings.str_type_site
                                ? m.sites.isNotEmpty
                                : m.salaries.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      type == GbsSystemStrings.str_type_site
                                          ? m.sites.length
                                          : m.salaries.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: type ==
                                              GbsSystemStrings.str_type_site
                                          ? GBSystem_Root_CardViewWidgetGenerique(
                                              tileColor: index % 2 == 0
                                                  ? Colors.grey.withOpacity(0.2)
                                                  : Colors.white,
                                              onTap: () async {
                                                await m.selectItemSiteFunction(
                                                    selectedSite:
                                                        m.sites[index]);

                                                // m.sitePlanningController
                                                //     .setCurrentSite = m.sites[index];
                                                // Get.back();
                                              },
                                              title: m.sites[index].LIE_LIB,
                                              optStr1: m.sites[index].LIE_ADR1,
                                              optStr2: m.sites[index].LIE_ADR2,
                                              optStr3: m.sites[index].VIL_LIB,
                                            )
                                          : GBSystem_Root_CardViewWidgetGenerique(
                                              tileColor: index % 2 == 0
                                                  ? Colors.grey.withOpacity(0.2)
                                                  : Colors.white,
                                              onTap: () {
                                                m.salariePlanningController
                                                        .setCurrentSalarie =
                                                    m.salaries[index];
                                                Get.back();
                                              },
                                              title:
                                                  "${m.salaries[index].SVR_NOM} ${m.salaries[index].SVR_PRNOM}",
                                              optStr1:
                                                  m.salaries[index].SVR_TELPOR,
                                              optStr2:
                                                  m.salaries[index].VIL_CODE,
                                              optStr3:
                                                  m.salaries[index].VIL_LIB,
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
