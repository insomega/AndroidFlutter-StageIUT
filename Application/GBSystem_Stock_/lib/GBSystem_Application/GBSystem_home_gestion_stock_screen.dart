// views/gbsystem_home_gestion_stock_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_lookup/GBSystem_Dossier_Lookup.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_root/custom_button.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_Root_Card_Home_Widget.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_home_gestion_stock_screen_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_with_image_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_select_item_salarie_gestion_stock_screen.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_select_item_site_gestion_stock_screen.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemHomeGestionStockScreen extends StatelessWidget {
  const GBSystemHomeGestionStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GBSystemHomeGestionStockController(context));

    return Obx(() => _buildScreen(context, controller));
  }

  Widget _buildScreen(BuildContext context, GBSystemHomeGestionStockController controller) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(controller), //
          body: _buildBody(context, controller),
        ),
        controller.isLoading.value ? Waiting() : Container(),
      ],
    );
  }

  AppBar _buildAppBar(GBSystemHomeGestionStockController controller) {
    return AppBar(
      leading: InkWell(
        onTap: controller.navigateToFirstPage,
        child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
      ),
      elevation: 4.0,
      centerTitle: true,
      // ignore: deprecated_member_use
      shadowColor: Colors.grey.withOpacity(0.5),
      toolbarHeight: 70,
      backgroundColor: GBSystem_Application_Strings.str_primary_color,
      title: Obx(() => Text(controller.infoSecondPageVisibility.value && controller.siteGestionStockController.getCurrentSite != null ? controller.siteGestionStockController.getCurrentSite!.DOS_LIB ?? '' : GBSystem_Application_Strings.str_article_affectuer, style: TextStyle(color: Colors.white))),
    );
  }

  Widget _buildBody(BuildContext context, GBSystemHomeGestionStockController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(), //
        controller: controller.pageController,
        scrollDirection: Axis.horizontal,
        children: [
          _buildFirstPage(context, controller), //
          _buildSecondPage(context, controller),
        ],
      ),
    );
  }

  Widget _buildFirstPage(BuildContext context, GBSystemHomeGestionStockController controller) {
    return Column(
      children: [
        const SizedBox(height: 10),
        GBSystem_Dossier_InAPP_Lookup_TextField(),

        GBSystem_Root_CardViewHome_Widget_Generique(
          title: GBSystem_Application_Strings.str_agence,
          onSearchTap: () {
            Get.to(GBSystem_SelectItemSiteGestionStockScreen(updateUI: () => controller.update()));
          },
          opt1: controller.siteGestionStockController.getCurrentSite?.DOS_LIB,
          opt2: controller.siteGestionStockController.getCurrentSite?.DOS_CODE,
          opt3: null,
          opt4: null,
        ),
        SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonWithTrailling(
              horPadding: 10,
              verPadding: 5,
              text: GBSystem_Application_Strings.str_suivant,
              trailling: const Icon(CupertinoIcons.arrow_right, color: Colors.white),
              onTap: controller.navigateToSecondPage,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondPage(BuildContext context, GBSystemHomeGestionStockController controller) {
    return Column(
      children: [
        const SizedBox(height: 10),
        _buildSalarieSelectionWidget(controller),
        const SizedBox(height: 10),
        CustomButton(width: GBSystem_ScreenHelper.screenWidth(context), text: GBSystem_Application_Strings.str_ok, onTap: controller.getArticles),
      ],
    );
  }

  Widget _buildSalarieSelectionWidget(GBSystemHomeGestionStockController controller) {
    final salarie = controller.salarieGestionStockController.getCurrentSalarie;

    if (salarie != null) {
      return SalarieGestionStockWidget(
        showDeleteOrSearch: true,
        isSearch: true,
        onTap: () {
          Get.to(GBSystem_SelectItemSalarieGestionStockScreen(updateUI: () => controller.update()));
        },
        salarieGestionStockModel: GbsystemSalarieGestionStockWithImageModel(salarieModel: salarie, imageSalarie: null),
      );
    } else {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Get.to(GBSystem_SelectItemSalarieGestionStockScreen(updateUI: () => controller.update()));
        },
        child: Stack(
          children: [
            Container(
              height: 130,
              width: double.maxFinite,
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
      );
    }
  }
}
