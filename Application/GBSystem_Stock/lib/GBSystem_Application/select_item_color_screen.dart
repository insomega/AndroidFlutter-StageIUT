import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_Root_CardView_Widget.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_stock/GBSystem_Application/select_item_color_screen_controller.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GBSystem_SelectItemColorScreen extends StatelessWidget {
  GBSystem_SelectItemColorScreen({super.key, required this.controllerTxtField, required this.colorField, required this.updateUI});

  final TextEditingController controllerTxtField;
  final Function updateUI;
  Color? colorField;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemColorScreenController m = Get.put(GBSystemSelectItemColorScreenController(context: context));

    return Obx(
      () => Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              elevation: 4.0,
              shadowColor: Colors.grey.withOpacity(0.5),
              toolbarHeight: 70,
              backgroundColor: GBSystem_Application_Strings.str_primary_color,
              title: Text(GBSystem_Application_Strings.str_app_bar_select_item.tr, style: TextStyle(color: Colors.white)),
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
              child: Column(
                children: [
                  SearchBar(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    hintText: GBSystem_Application_Strings.str_rechercher,
                    controller: m.controllerSearch,
                    leading: const Icon(CupertinoIcons.search),
                    trailing: [
                      GestureDetector(
                        onTap: () {
                          m.controllerSearch.text = "";
                          m.text?.value = "";
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                    onChanged: (String query) {
                      m.filterDataSite(query);
                    },
                  ),
                  SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
                  m.text != null && m.text != ''
                      ? m.filtredColors.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.filtredColors.length,
                                  itemBuilder: (context, index) {
                                    late Color color;
                                    final hexColor = m.filtredColors[index].CLR_CODE_colorweb.replaceAll(r"#", "").replaceAll(r"$", "").replaceAll(r"#", "");
                                    if (int.tryParse('0xFF$hexColor') != null) {
                                      color = Color(int.parse('0xFF$hexColor'));
                                    } else {
                                      color = Colors.white;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: GBSystem_Root_CardViewWidgetGenerique(
                                        tileColor: color,

                                        // index % 2 == 0
                                        //     ? Colors.grey.withOpacity(0.2)
                                        //     : Colors.white,
                                        onTap: () {
                                          m.selectItemSiteFunction(selectedColor: m.filtredColors[index]);

                                          controllerTxtField.text = m.filtredColors[index].CLR_LIB;

                                          colorField = Color(int.parse('0xFF${m.filtredColors[index].CLR_CODE_colorweb.replaceAll(r"#", "").replaceAll(r"$", "")}'));
                                          updateUI();
                                        },
                                        title: m.filtredColors[index].CLR_LIB,
                                        optStr1: m.filtredColors[index].CLRCAT_LIB,
                                        optStr2: m.filtredColors[index].DGRP_LIB,
                                        optStr3: m.filtredColors[index].CLR_CAT,
                                        // color: m.filtredColors[index],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_no_item.tr))
                      : (m.colors.isNotEmpty)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: m.colors.length,
                            itemBuilder: (context, index) {
                              late Color color;
                              final hexColor = m.colors[index].CLR_CODE_colorweb.replaceAll(r"#", "").replaceAll(r"$", "").replaceAll(r"#", "");
                              if (int.tryParse('0xFF$hexColor') != null) {
                                color = Color(int.parse('0xFF$hexColor'));
                              } else {
                                color = Colors.white;
                              }

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: GBSystem_Root_CardViewWidgetGenerique(
                                  circleColor: color,
                                  showCircleBorder: m.colors[index].CLR_LIB.toLowerCase().contains("blanc") ? true : false,
                                  textCircleColor: m.colors[index].CLR_LIB.toLowerCase().contains("blanc") ? Colors.black : null,
                                  tileColor: index % 2 == 0 ? Colors.grey.withOpacity(0.2) : Colors.white,
                                  onTap: () {
                                    m.selectItemSiteFunction(selectedColor: m.colors[index]);
                                    controllerTxtField.text = m.colors[index].CLR_LIB;
                                    colorField = Color(int.parse('0xFF${m.colors[index].CLR_CODE_colorweb.replaceAll(r"#", "").replaceAll(r"$", "")}'));
                                    updateUI();

                                    // m.sitePlanningController
                                    //     .setCurrentSite = m.habiliter[index];
                                    // Get.back();
                                  },
                                  title: m.colors[index].CLR_LIB,
                                  optStr1: m.colors[index].CLRCAT_LIB,
                                  optStr2: m.colors[index].DGRP_LIB,
                                  optStr3: m.colors[index].CLR_CAT,

                                  // color: m.colors[index],
                                ),
                              );
                            },
                          ),
                        )
                      : Center(child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_no_item.tr)),
                  // SizedBox(
                  //   height: GBSystem_ScreenHelper.screenHeightPercentage(
                  //       context, 0.02),
                  // ),
                ],
              ),
            ),
          ),
          m.isLoading.value ? Waiting() : Container(),
        ],
      ),
    );
  }
}
