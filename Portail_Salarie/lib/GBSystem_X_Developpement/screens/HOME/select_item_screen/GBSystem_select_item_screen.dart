import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/select_item_screen/GBSystem_select_item_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/SELECT_ITEM_WIDGET/GBSystem_Root_CardView_Widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystem_SelectItemScreen extends StatelessWidget {
  const GBSystem_SelectItemScreen(
      {super.key,
      required this.selectedTypeAbsence,
      required this.controllerTxtField,
      required this.enabledDates});

  final TypeAbsenceModel selectedTypeAbsence;
  final TextEditingController controllerTxtField;
  final Rx<bool> enabledDates;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemController m = Get.put(GBSystemSelectItemController(
        selectedTypeAbsence: selectedTypeAbsence, context: context));

    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                elevation: 4.0,
                shadowColor: GbsSystemStrings.str_primary_color,
                toolbarHeight: 70,
                backgroundColor: GbsSystemStrings.str_primary_color,
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
                        ? m.filtredSites.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.filtredSites.length,
                                  itemBuilder: (context, index) {
                                    return GBSystem_Root_CardViewWidget(
                                      tileColor: index % 2 == 0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      onTap: () {
                                        m.selectItemSiteFunction(
                                            selectedSite:
                                                m.filtredSites[index]);

                                        controllerTxtField.text =
                                            m.filtredSites[index].TPH_CODE;
                                        enabledDates.value = false;
                                      },
                                      site: m.filtredSites[index],
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data.tr,
                              ))
                        : (m.sites.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.sites.length,
                                  itemBuilder: (context, index) {
                                    return GBSystem_Root_CardViewWidget(
                                      tileColor: index % 2 == 0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      onTap: () {
                                        m.selectItemSiteFunction(
                                            selectedSite: m.sites[index]);
                                        controllerTxtField.text =
                                            m.sites[index].TPH_CODE;

                                        enabledDates.value = false;

                                        // m.sitePlanningController
                                        //     .setCurrentSite = m.sites[index];
                                        // Get.back();
                                      },
                                      site: m.sites[index],
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
