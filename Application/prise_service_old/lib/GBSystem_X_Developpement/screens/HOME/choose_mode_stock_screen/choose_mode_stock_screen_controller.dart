import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GESTION_STOCK_CONTROLLERS/articles_add_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_site_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseModeStockScreenController extends GetxController {
  BuildContext context;
  RxBool isLoading = RxBool(false);
  ChooseModeStockScreenController({required this.context});

  final ArticlesAddController articlesController =
      Get.put(ArticlesAddController());
  final GBSystemSiteGestionStockController siteGestionStockController =
      Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController =
      Get.put(GBSystemSalarieGestionStockController());
  Future deconnexion() async {
    isLoading.value = true;
    final GBSystemAgenceQuickAccessController agencesController =
        Get.put(GBSystemAgenceQuickAccessController());
    agencesController.setLoginAgence = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(GbsSystemServerStrings.kToken, "");
    await preferences.setString(GbsSystemServerStrings.kCookies, "");
    isLoading.value = false;
    Get.offAll(GBSystemLoginScreen());
  }

  void viderPreviousData() {
    articlesController.setAllArticles = null;
    articlesController.setSelectedArticle = null;
  }

  void viderDataAgenceSalarie() {
    siteGestionStockController.setCurrentSiteSite = null;
    salarieGestionStockController.setCurrentSalarieSalarie = null;
    salarieGestionStockController.setAllSelectedSalarie = [];
  }
}
