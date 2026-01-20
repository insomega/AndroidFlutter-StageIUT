import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_root/custom_button.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_Root_Card_Home_Widget.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_home_affectuer_articles_gestion_stock_screen_controller.dart';

import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_with_image_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_select_item_site_gestion_stock_screen.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

import 'package:get/get.dart';

class GBSystemHomeAffectuerArticlesGestionStockScreen extends StatefulWidget {
  const GBSystemHomeAffectuerArticlesGestionStockScreen({super.key});

  @override
  State<GBSystemHomeAffectuerArticlesGestionStockScreen> createState() => _GBSystemHomeAffectuerArticlesGestionStockScreenState();
}

class _GBSystemHomeAffectuerArticlesGestionStockScreenState extends State<GBSystemHomeAffectuerArticlesGestionStockScreen> with SingleTickerProviderStateMixin {
  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GBSystemHomeAffectuerArticlesGestionStockScreenController m = Get.put(GBSystemHomeAffectuerArticlesGestionStockScreenController(context));
    print(m.salarieGestionStockController.getAllSelectedSalaries?.length);
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            floatingActionButton: m.salarieGestionStockController.getAllSelectedSalaries != null && m.salarieGestionStockController.getAllSelectedSalaries!.isNotEmpty
                ? FloatingActionButton(
                    backgroundColor: GBSystem_Application_Strings.str_primary_color,
                    child: Icon(Icons.done, color: Colors.white),
                    onPressed: () {},
                    // () async {
                    //   await GBSystem_AuthService(context).getAllArticlesNonAffectuer().then((value) {
                    //     m.articlesController.setAllArticles = value;
                    //     Get.to(ArticlesNonAffectuerScreen());
                    //   });
                    //   // ArticleWidget
                    //   // await m.getArticles();
                    // },
                  )
                : null,
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
              ),
              elevation: 4.0,
              centerTitle: true,
              shadowColor: Colors.grey.withOpacity(0.5),
              toolbarHeight: 70,
              backgroundColor: GBSystem_Application_Strings.str_primary_color,
              title: Obx(() => Text(m.infoSecondPageVisibility.value && m.siteGestionStockController.getCurrentSite != null ? m.siteGestionStockController.getCurrentSite!.DOS_LIB : GBSystem_Application_Strings.str_affecter_article, style: TextStyle(color: Colors.white))),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: m.pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 10),
                      GBSystem_Root_CardViewHome_Widget_Generique(
                        title: GBSystem_Application_Strings.str_agence,
                        onSearchTap: () {
                          Get.to(GBSystem_SelectItemSiteGestionStockScreen());
                        },
                        opt1: m.siteGestionStockController.getCurrentSite?.DOS_LIB,
                        opt2: m.siteGestionStockController.getCurrentSite?.DOS_CODE,
                        opt3: null,
                        opt4: null,

                        // site: sitePlanningController.getCurrentSite
                      ),
                      // GBSystem_Root_CardViewHome_Widget_Site_Gestion_Stock(
                      //     title: GBSystem_Application_Strings.str_agence,
                      //     onSearchTap: () {
                      //       Get.to(GBSystem_SelectItemSiteGestionStockScreen(
                      //         updateUI: updateUI,
                      //       ));
                      //     },
                      //     site: m.siteGestionStockController.getCurrentSite),
                      SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButtonWithTrailling(
                            horPadding: 10,
                            verPadding: 5,
                            text: GBSystem_Application_Strings.str_suivant,
                            trailling: Icon(CupertinoIcons.arrow_right, color: Colors.white),
                            onTap: () async {
                              if (m.siteGestionStockController.getCurrentSite != null) {
                                m.pageController.animateToPage(1, duration: const Duration(milliseconds: 800), curve: Curves.easeInCubic);
                                m.infoSecondPageVisibility.value = true;
                              } else {
                                showErrorDialog(GBSystem_Application_Strings.str_choisi_une_agence);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 10),

                      GBSystem_Root_CardViewHome_Widget_Generique(
                        title: GBSystem_Application_Strings.str_salarie,
                        onSearchTap: () {},
                        // () async {
                        //   final prefs = await SharedPreferences.getInstance();
                        //   final curent_DOS_IDF = prefs.getString(GBSystem_Application_Strings.kDOS_IDF);
                        //   print(curent_DOS_IDF);
                        //   if (curent_DOS_IDF != null) {
                        //     await m.getListSalarieDependSite(DOS_IDF: curent_DOS_IDF);
                        //     Get.to(GBSystem_SelectItemSalarieGestionStockScreen(updateUI: updateUI));
                        //   } else {
                        //     showErrorDialog(context, GBSystem_Application_Strings.str_stp_deconnecter);
                        //   }
                        // },
                        opt1: m.salarieGestionStockController.getCurrentSalarie?.SVR_LIB,
                        opt2: m.salarieGestionStockController.getCurrentSalarie?.SVR_CODE,
                        opt3: null,
                        opt4: null,
                      ),

                      // Visibility(
                      //   visible: m.salarieGestionStockController
                      //               .getAllSelectedSalaries !=
                      //           null &&
                      //       m.salarieGestionStockController
                      //           .getAllSelectedSalaries!.isNotEmpty,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top: 10, bottom: 2),
                      //     child: Row(
                      //       children: [
                      //         GBSystem_TextHelper().smallText(
                      //             text:
                      //                 GBSystem_Application_Strings.str_salarie_selectionner,
                      //             fontWeight: FontWeight.bold,
                      //             textColor: Colors.black),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: (m.salarieGestionStockController.getAllSelectedSalaries != null && m.salarieGestionStockController.getAllSelectedSalaries!.isNotEmpty)
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: (m.salarieGestionStockController.getAllSelectedSalaries?.length ?? 0),
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: SalarieGestionStockWidget(
                                    showDeleteOrSearch: true,
                                    isSearch: false,
                                    onDeleteTap: () {
                                      m.salarieGestionStockController.deleteSelectedSalarie(m.salarieGestionStockController.getAllSelectedSalaries![index]);
                                      setState(() {});
                                    },
                                    salarieGestionStockModel: GbsystemSalarieGestionStockWithImageModel(salarieModel: m.salarieGestionStockController.getAllSelectedSalaries![index], imageSalarie: null),
                                  ),
                                  // SelectedSalarieWidgetGestionStock(
                                  //   onDeleteTap: () {
                                  //     m.salarieGestionStockController
                                  //         .deleteSelectedSalarie(m
                                  //             .salarieGestionStockController
                                  //             .getAllSelectedSalaries![index]);
                                  //     setState(() {});
                                  //   },
                                  //   salarie: m.salarieGestionStockController
                                  //       .getAllSelectedSalaries![index],
                                  // ),
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_aucune_salarie_selectionner, fontWeight: FontWeight.normal, textColor: Colors.black),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          m.isloading.value ? Waiting() : Container(),
        ],
      ),
    );
  }
}
