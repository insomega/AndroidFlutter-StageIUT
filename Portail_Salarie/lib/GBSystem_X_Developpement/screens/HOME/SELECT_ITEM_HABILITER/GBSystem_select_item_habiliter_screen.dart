import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/SELECT_ITEM_HABILITER/GBSystem_select_item_habiliter_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/SELECT_ITEM_WIDGET/GBSystem_Root_Card_Habiliter_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystem_SelectItemHabiliterScreen extends StatelessWidget {
  const GBSystem_SelectItemHabiliterScreen(
      {super.key, required this.controllerTxtField});

  final TextEditingController controllerTxtField;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemHabiliterController m =
        Get.put(GBSystemSelectItemHabiliterController(context: context));

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
                        ? m.filtredHabiliter.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.filtredHabiliter.length,
                                  itemBuilder: (context, index) {
                                    return GBSystem_Root_CardView_Habiliter_Widget(
                                      tileColor: index % 2 == 0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      onTap: () {
                                        m.selectItemSiteFunction(
                                            selectedSite:
                                                m.filtredHabiliter[index]);

                                        controllerTxtField.text =
                                            m.filtredHabiliter[index].FOR_LIB;
                                      },
                                      habiliter: m.filtredHabiliter[index],
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data.tr,
                              ))
                        : (m.habiliter.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.habiliter.length,
                                  itemBuilder: (context, index) {
                                    return GBSystem_Root_CardView_Habiliter_Widget(
                                      tileColor: index % 2 == 0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      onTap: () {
                                        m.selectItemSiteFunction(
                                            selectedSite: m.habiliter[index]);
                                        controllerTxtField.text =
                                            m.habiliter[index].FOR_LIB;

                                        // m.sitePlanningController
                                        //     .setCurrentSite = m.habiliter[index];
                                        // Get.back();
                                      },
                                      habiliter: m.habiliter[index],
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
