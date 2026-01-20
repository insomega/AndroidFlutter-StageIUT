import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_Root_CardView_Widget.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_select_item_site_gestion_stock_controller.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystem_SelectItemSiteGestionStockScreen extends StatelessWidget {
  const GBSystem_SelectItemSiteGestionStockScreen({super.key, required this.updateUI});

  final Function updateUI;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemSiteGestionStockController m = Get.put(GBSystemSelectItemSiteGestionStockController(context: context));
    // m.isLoading.value = false;
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
              title: const Text(GBSystem_Application_Strings.str_app_bar_select_item, style: TextStyle(color: Colors.white)),
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
                      m.filterDataSalarie(query);
                    },
                  ),
                  SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
                  m.text != null && m.text != ''
                      ? (m.filtredsites.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.filtredsites.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      child: GBSystem_Root_CardViewWidgetGenerique(
                                        tileColor: index % 2 == 0 ? Colors.grey.withOpacity(0.2) : Colors.white,
                                        onTap: () async {
                                          m.siteGestionStockController.setCurrentSiteSite = m.filtredsites[index];
                                          updateUI();

                                          await m.getListSalarieDependSite(selectedSite: m.filtredsites[index]).then((value) {
                                            Get.back();
                                          });
                                        },
                                        optStr1: m.filtredsites[index].DOS_CODE,
                                        title: m.filtredsites[index].DOS_LIB,
                                        optStr2: null,
                                        optStr3: null,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_no_item))
                      : (m.sites.isNotEmpty)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: m.sites.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: GBSystem_Root_CardViewWidgetGenerique(
                                  tileColor: index % 2 == 0 ? Colors.grey.withOpacity(0.2) : Colors.white,
                                  onTap: () async {
                                    m.siteGestionStockController.setCurrentSiteSite = m.sites[index];
                                    print('current site selected to get salarie useeeed : ${m.sites[index].DOS_IDF}');
                                    updateUI();
                                    await m.getListSalarieDependSite(selectedSite: m.sites[index]).then((value) {
                                      Get.back();
                                    });
                                  },
                                  optStr1: m.sites[index].DOS_CODE,
                                  title: m.sites[index].DOS_LIB,
                                  optStr2: null,
                                  optStr3: null,
                                  // site: m.sites[index],
                                ),
                              );
                            },
                          ),
                        )
                      : Center(child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_no_item)),
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
