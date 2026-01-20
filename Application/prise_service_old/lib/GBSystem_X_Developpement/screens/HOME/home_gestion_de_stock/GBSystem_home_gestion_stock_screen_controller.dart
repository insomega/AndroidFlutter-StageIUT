import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GESTION_STOCK_CONTROLLERS/articles_and_dataset_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_site_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';

import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/informations_products_salarie_screen/informations_products_salarie_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';

import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystemHomeGestionStockScreenController extends GetxController {
  RxBool isloading = RxBool(false);
  BuildContext context;
  RxBool infoSecondPageVisibility = RxBool(false);
  PageController pageController = PageController(initialPage: 0);
  RxInt currentPageIndex = 0.obs;
  RxInt selectedIndex = RxInt(0);
  RxDouble currentIndex = RxDouble(0);

  GBSystemHomeGestionStockScreenController(this.context);
  final GBSystemSiteGestionStockController siteGestionStockController =
      Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController =
      Get.put(GBSystemSalarieGestionStockController());
  final ArticlesAndDatasetController articlesAndDatasetController =
      Get.put(ArticlesAndDatasetController());

  @override
  void onInit() {
    pageController.addListener(() {
      currentIndex = RxDouble(pageController.page!.toDouble());
    });

    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();

    super.onClose();
  }

  Future deconnexion() async {
    isloading.value = true;
    final GBSystemAgenceQuickAccessController agencesController =
        Get.put(GBSystemAgenceQuickAccessController());
    agencesController.setLoginAgence = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(GbsSystemServerStrings.kToken, "");
    await preferences.setString(GbsSystemServerStrings.kCookies, "");
    isloading.value = false;
    Get.offAll(GBSystemLoginScreen());
  }

  Future getArticles() async {
    try {
      isloading.value = true;
      // await GBSystem_AuthService(context).getAllArticlesGestionStock();
      print(
          "current site useeeed : ${siteGestionStockController.getCurrentSite?.DOS_IDF}");
      print(
          "current salarie useeeed : ${salarieGestionStockController.getCurrentSalarie?.SVR_IDF}");

      await GBSystem_AuthService(context)
          .getAllArticlesSalarieGestionStock(
              salarie: salarieGestionStockController.getCurrentSalarie!,
              site: siteGestionStockController.getCurrentSite!)
          .then(
        (value) {
          isloading.value = false;

          articlesAndDatasetController.setCurrentArticlesAndDataSet = value;
          Get.to(InformationsProductsSalarieScreen());
        },
      );
    } catch (e) {
      isloading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "getArticles",
        page: "GBSystem_home_gestion_stock_screen_controller",
      );
    }

    // try {
    //   if (salarieGestionStockController.getCurrentSalarie != null &&
    //       siteGestionStockController.getCurrentSite != null) {
    //     isloading.value = true;
    //     await GBSystem_AuthService(context)
    //         .getAllArticlesSalarieGestionStock(
    //             salarie: salarieGestionStockController.getCurrentSalarie!,
    //             site: siteGestionStockController.getCurrentSite!)
    //         .then(
    //       (value) {
    //         isloading.value = false;
    //       },
    //     );
    //   } else {
    //     showErrorDialog(context, GbsSystemStrings.str_remplie_cases);
    //   }
    // } catch (e) {
    //   isloading.value = false;
    //   GBSystem_ManageCatchErrors().catchErrors(
    //     context,
    //     message: e.toString(),
    //     method: "getArticles",
    //     page: "GBSystem_home_gestion_stock_screen_controller",
    //   );
    // }
  }
}
