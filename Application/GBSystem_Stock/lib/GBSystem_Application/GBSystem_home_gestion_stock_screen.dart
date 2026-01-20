import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_lookup/GBSystem_Dossier_Lookup.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_root/custom_button.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_Root_Card_Home_Widget.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_home_gestion_stock_screen_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_with_image_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_select_item_salarie_gestion_stock_screen.dart';

import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemHomeGestionStockScreen extends GetView<GBSystemHomeGestionStockController> {
  const GBSystemHomeGestionStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(appBar: _buildAppBar(), body: _buildBody(context)),
          if (controller.isLoading.value) Waiting(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: InkWell(
        onTap: controller.navigateBack,
        child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
      ),
      elevation: 4.0,
      centerTitle: true,
      shadowColor: Colors.grey.withOpacity(0.5),
      toolbarHeight: 70,
      backgroundColor: GBSystem_Application_Strings.str_primary_color,
      title: Obx(() => Text(controller.infoSecondPageVisibility.value && controller.siteGestionStockController.getCurrentSite != null ? controller.siteGestionStockController.getCurrentSite!.DOS_LIB : GBSystem_Application_Strings.str_article_affectuer, style: const TextStyle(color: Colors.white))),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        //
        horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
        vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
      ),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(), //
        controller: controller.pageController,
        children: [
          _buildFirstPage(context), //
          _buildSecondPage(context),
        ],
      ),
    );
  }

  Widget _buildFirstPage(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),

        GBSystem_Dossier_Lookup_TextField(controllerLookup: controller.dossierLookupController),

        // GBSystem_Root_CardViewHome_Widget_Generique(
        //   title: GBSystem_Application_Strings.str_agence, //
        //   onSearchTap: () => Get.to(() => GBSystem_SelectItemSiteGestionStockScreen()),
        //   opt1: controller.siteGestionStockController.getCurrentSite?.DOS_LIB,
        //   opt2: controller.siteGestionStockController.getCurrentSite?.DOS_CODE,
        //   opt3: '',
        //   opt4: '',
        // ),
        SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonWithTrailling(
              horPadding: 10,
              verPadding: 5,
              text: GBSystem_Application_Strings.str_suivant,
              trailling: const Icon(CupertinoIcons.arrow_right, color: Colors.white),
              onTap: () {
                if (controller.canNavigateToNextPage) {
                  controller.navigateToNextPage();
                } else {
                  showErrorDialog(GBSystem_Application_Strings.str_choisi_une_agence);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondPage(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        controller.hasSelectedSalarie
            ? SalarieGestionStockWidget(
                showDeleteOrSearch: true,
                isSearch: true,
                onTap: () => Get.to(() => GBSystem_SelectItemSalarieGestionStockScreen()),
                salarieGestionStockModel: GbsystemSalarieGestionStockWithImageModel(salarieModel: controller.salarieGestionStockController.getCurrentSalarie!, imageSalarie: null),
              )
            : CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Get.to(() => GBSystem_SelectItemSalarieGestionStockScreen()),
                child: Stack(
                  children: [
                    Container(
                      height: 130,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1)],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_aucune_salarie_selectionner, textColor: Colors.black),
                      ),
                    ),
                    const Positioned(top: 8, right: 8, child: Icon(CupertinoIcons.search)),
                  ],
                ),
              ),
        SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015)),
        CustomButton(width: GBSystem_ScreenHelper.screenWidth(context), text: GBSystem_Application_Strings.str_ok, onTap: controller.getArticles),
      ],
    );
  }
}

// class GBSystemHomeGestionStockScreen extends StatefulWidget {
//   const GBSystemHomeGestionStockScreen({super.key});

//   @override
//   State<GBSystemHomeGestionStockScreen> createState() => _GBSystemHomeGestionStockScreenState();
// }

//class _GBSystemHomeGestionStockScreenState extends State<GBSystemHomeGestionStockScreen> with SingleTickerProviderStateMixin {

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
// import 'package:gbsystem_root/GBSystem_snack_bar.dart';
// import 'package:gbsystem_root/GBSystem_text_helper.dart';
// import 'package:gbsystem_root/GBSystem_waiting.dart';
// import 'package:gbsystem_root/custom_button.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_Root_Card_Home_Widget.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_home_gestion_stock_screencontroller.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_with_image_model.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_select_item_salarie_gestion_stock_screen.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_select_item_site_gestion_stock_screen.dart';
// import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
// import 'package:get/get.dart';

// class GBSystemHomeGestionStockScreen extends StatefulWidget {
//   const GBSystemHomeGestionStockScreen({super.key});

//   @override
//   State<GBSystemHomeGestionStockScreen> createState() => _GBSystemHomeGestionStockScreenState();
// }

// class _GBSystemHomeGestionStockScreenState extends State<GBSystemHomeGestionStockScreen> with SingleTickerProviderStateMixin {
//   void updateUI() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final GBSystemHomeGestionStockScreenController m = Get.put(GBSystemHomeGestionStockScreenController(context));
//     return Obx(
//       () => Stack(
//         children: [
//           Scaffold(
//             appBar: AppBar(
//               leading: InkWell(
//                 onTap: () {
//                   if (m.infoSecondPageVisibility.value) {
//                     m.pageController.animateToPage(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInCubic);
//                     m.infoSecondPageVisibility.value = false;
//                     m.salarieGestionStockController.setCurrentSalarieSalarie = null;
//                   } else {
//                     Get.back();
//                   }
//                 },
//                 child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
//               ),
//               elevation: 4.0,
//               centerTitle: true,
//               shadowColor: Colors.grey.withOpacity(0.5),
//               toolbarHeight: 70,
//               backgroundColor: GBSystem_Application_Strings.str_primary_color,
//               title: Obx(() => Text(m.infoSecondPageVisibility.value && m.siteGestionStockController.getCurrentSite != null ? m.siteGestionStockController.getCurrentSite!.DOS_LIB : GBSystem_Application_Strings.str_article_affectuer, style: TextStyle(color: Colors.white))),
//             ),
//             body: Padding(
//               padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
//               child: PageView(
//                 physics: const NeverScrollableScrollPhysics(),
//                 controller: m.pageController,
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   Column(
//                     children: [
//                       SizedBox(height: 10),
//                       GBSystem_Root_CardViewHome_Widget_Generique(
//                         title: GBSystem_Application_Strings.str_agence,
//                         onSearchTap: () {
//                           Get.to(GBSystem_SelectItemSiteGestionStockScreen(updateUI: updateUI));
//                         },
//                         opt1: m.siteGestionStockController.getCurrentSite?.DOS_LIB,
//                         opt2: m.siteGestionStockController.getCurrentSite?.DOS_CODE,
//                         opt3: null,
//                         opt4: null,

//                         // site: sitePlanningController.getCurrentSite
//                       ),
//                       // GBSystem_Root_CardViewHome_Widget_Site_Gestion_Stock(
//                       //     title: GBSystem_Application_Strings.str_agence,
//                       //     onSearchTap: () {
//                       //       Get.to(GBSystem_SelectItemSiteGestionStockScreen(
//                       //         updateUI: updateUI,
//                       //       ));
//                       //     },
//                       //     site: m.siteGestionStockController.getCurrentSite),
//                       SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015)),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           CustomButtonWithTrailling(
//                             horPadding: 10,
//                             verPadding: 5,
//                             text: GBSystem_Application_Strings.str_suivant,
//                             trailling: Icon(CupertinoIcons.arrow_right, color: Colors.white),
//                             onTap: () async {
//                               if (m.siteGestionStockController.getCurrentSite != null) {
//                                 m.pageController.animateToPage(1, duration: const Duration(milliseconds: 800), curve: Curves.easeInCubic);
//                                 m.infoSecondPageVisibility.value = true;
//                               } else {
//                                 showErrorDialog(GBSystem_Application_Strings.str_choisi_une_agence);
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(height: 10),
//                       m.salarieGestionStockController.getCurrentSalarie != null
//                           ? SalarieGestionStockWidget(
//                               showDeleteOrSearch: true,
//                               isSearch: true,
//                               onTap: () {
//                                 Get.to(GBSystem_SelectItemSalarieGestionStockScreen(updateUI: updateUI));
//                               },
//                               salarieGestionStockModel: GbsystemSalarieGestionStockWithImageModel(salarieModel: m.salarieGestionStockController.getCurrentSalarie!, imageSalarie: null),
//                             )
//                           : CupertinoButton(
//                               padding: EdgeInsets.zero,
//                               onPressed: () {
//                                 Get.to(GBSystem_SelectItemSalarieGestionStockScreen(updateUI: updateUI));
//                               },
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                     height: 130,
//                                     width: double.maxFinite,
//                                     padding: EdgeInsets.symmetric(horizontal: 10),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade100,
//                                       boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1)],
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Center(
//                                       child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_aucune_salarie_selectionner, textColor: Colors.black),
//                                     ),
//                                   ),
//                                   Positioned(top: 8, right: 8, child: Icon(CupertinoIcons.search)),
//                                 ],
//                               ),
//                             ),

//                       Visibility(
//                         visible: false,
//                         child: GBSystem_Root_CardViewHome_Widget_Generique(
//                           title: GBSystem_Application_Strings.str_salarie,
//                           onSearchTap: () {
//                             Get.to(GBSystem_SelectItemSalarieGestionStockScreen(updateUI: updateUI));
//                           },
//                           opt1: m.salarieGestionStockController.getCurrentSalarie?.SVR_LIB,
//                           opt2: m.salarieGestionStockController.getCurrentSalarie?.SVR_CODE,
//                           opt3: null,
//                           opt4: null,
//                         ),
//                       ),
//                       // GBSystem_Root_CardViewHome_Widget_Salarie_Gestion_Stock(
//                       //     title: GBSystem_Application_Strings.str_salarie,
//                       //     onSearchTap: () {
//                       //       Get.to(GBSystem_SelectItemSalarieGestionStockScreen(
//                       //         updateUI: updateUI,
//                       //       ));
//                       //     },
//                       //     salarie: m
//                       //         .salarieGestionStockController.getCurrentSalarie),
//                       SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015)),
//                       CustomButton(
//                         width: GBSystem_ScreenHelper.screenWidth(context),
//                         text: GBSystem_Application_Strings.str_ok,
//                         onTap: () async {
//                           await m.getArticles();
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           m.isloading.value ? Waiting() : Container(),
//         ],
//       ),
//     );
//   }
// }
