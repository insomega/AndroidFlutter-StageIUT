import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/SELECT_ITEM_DIPLOME/GBSystem_select_item_diplome_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/SELECT_ITEM_WIDGET/GBSystem_Root_Card_Diplome_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystem_SelectItemDiplomeScreen extends StatelessWidget {
  const GBSystem_SelectItemDiplomeScreen(
      {super.key, required this.controllerTxtField});

  final TextEditingController controllerTxtField;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemDiplomeController m =
        Get.put(GBSystemSelectItemDiplomeController(context: context));

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
                        ? m.filtredDiplome.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.filtredDiplome.length,
                                  itemBuilder: (context, index) {
                                    return GBSystem_Root_CardView_Diplome_Widget(
                                      tileColor: index % 2 == 0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      onTap: () {
                                        m.selectItemSiteFunction(
                                            selectedSite:
                                                m.filtredDiplome[index]);

                                        controllerTxtField.text =
                                            m.filtredDiplome[index].DIP_LIB;
                                      },
                                      diplome: m.filtredDiplome[index],
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data.tr,
                              ))
                        : (m.diplome.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.diplome.length,
                                  itemBuilder: (context, index) {
                                    return GBSystem_Root_CardView_Diplome_Widget(
                                      tileColor: index % 2 == 0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      onTap: () {
                                        m.selectItemSiteFunction(
                                            selectedSite: m.diplome[index]);
                                        controllerTxtField.text =
                                            m.diplome[index].DIP_LIB;

                                        // m.sitePlanningController
                                        //     .setCurrentSite = m.diplome[index];
                                        // Get.back();
                                      },
                                      diplome: m.diplome[index],
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
