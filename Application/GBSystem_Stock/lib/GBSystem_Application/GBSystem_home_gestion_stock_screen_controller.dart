import 'package:flutter/material.dart';
import 'package:gbsystem_lookup/GBSystem_Dossier_Lookup.dart';
import 'package:get/get.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_site_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/articles_and_dataset_controller.dart';

import 'package:gbsystem_root/GBSystem_LogEvent.dart';

class GBSystemHomeGestionStockModel {
  final RxBool isLoading = false.obs;
  final RxBool infoSecondPageVisibility = false.obs;

  final PageController pageController = PageController(initialPage: 0);

  final GBSystemSiteGestionStockController siteGestionStockController = Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController = Get.put(GBSystemSalarieGestionStockController());
  final ArticlesAndDatasetController articlesAndDatasetController = Get.put(ArticlesAndDatasetController());

  void dispose() {
    pageController.dispose();
  }

  bool get canNavigateToNextPage => siteGestionStockController.getCurrentSite != null;
  bool get hasSelectedSalarie => salarieGestionStockController.getCurrentSalarie != null;
}

class GBSystemHomeGestionStockController extends GetxController {
  final GBSystemHomeGestionStockModel model = GBSystemHomeGestionStockModel();

  late final GBSystem_Dossier_Lookup_Controller dossierLookupController;

  // Expose model fields
  RxBool get isLoading => model.isLoading;
  RxBool get infoSecondPageVisibility => model.infoSecondPageVisibility;
  PageController get pageController => model.pageController;

  get siteGestionStockController => model.siteGestionStockController;
  get salarieGestionStockController => model.salarieGestionStockController;

  //bool get canNavigateToNextPage => model.canNavigateToNextPage;
  bool get canNavigateToNextPage => dossierLookupController.searchController.selectedItem != null;
  bool get hasSelectedSalarie => model.hasSelectedSalarie;

  @override
  void onInit() {
    super.onInit();
    dossierLookupController = Get.put(GBSystem_Dossier_InApp_Lookup_Controller());
  }

  void navigateBack() {
    if (infoSecondPageVisibility.value) {
      pageController.animateToPage(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInCubic);
      infoSecondPageVisibility.value = false;
      salarieGestionStockController.setCurrentSalarieSalarie = null;
    } else {
      Get.back();
    }
  }

  void navigateToNextPage() {
    if (canNavigateToNextPage) {
      pageController.animateToPage(1, duration: const Duration(milliseconds: 800), curve: Curves.easeInCubic);
      infoSecondPageVisibility.value = true;
    }
  }

  Future<void> getArticles() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      GBSystem_Add_LogEvent(message: e.toString(), method: "getArticles", page: "GBSystem_home_gestion_stock_controller");
    }
  }

  @override
  void onClose() {
    model.dispose();
    super.onClose();
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:gbsystem_root/GBSystem_LogEvent.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_controller.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_site_gestion_stock_controller.dart';
// import 'package:gbsystem_stock/GBSystem_Application/articles_and_dataset_controller.dart';
// import 'package:get/get.dart';

// class GBSystemHomeGestionStockScreenController extends GetxController {
//   RxBool isloading = RxBool(false);
//   BuildContext context;
//   RxBool infoSecondPageVisibility = RxBool(false);
//   PageController pageController = PageController(initialPage: 0);
//   RxInt currentPageIndex = 0.obs;
//   RxInt selectedIndex = RxInt(0);
//   RxDouble currentIndex = RxDouble(0);

//   GBSystemHomeGestionStockScreenController(this.context);
//   final GBSystemSiteGestionStockController siteGestionStockController = Get.put(GBSystemSiteGestionStockController());
//   final GBSystemSalarieGestionStockController salarieGestionStockController = Get.put(GBSystemSalarieGestionStockController());
//   final ArticlesAndDatasetController articlesAndDatasetController = Get.put(ArticlesAndDatasetController());

//   @override
//   void onInit() {
//     pageController.addListener(() {
//       currentIndex = RxDouble(pageController.page!.toDouble());
//     });

//     super.onInit();
//   }

//   @override
//   void onClose() {
//     pageController.dispose();

//     super.onClose();
//   }

//   Future deconnexion() async {
//     // isloading.value = true;
//     // final GBSystemAgenceQuickAccessController agencesController = Get.put(GBSystemAgenceQuickAccessController());
//     // agencesController.setLoginAgence = null;
//     // SharedPreferences preferences = await SharedPreferences.getInstance();
//     // await preferences.setString(GBSystem_Application_Strings.kToken, "");
//     // await preferences.setString(GBSystem_Application_Strings.kCookies, "");
//     // isloading.value = false;
//     // Get.offAll(GBSystemLoginScreen());
//   }

//   Future getArticles() async {
//     try {
//       isloading.value = true;
//       // await GBSystem_AuthService(context).getAllArticlesGestionStock();
//       print("current site useeeed : ${siteGestionStockController.getCurrentSite?.DOS_IDF}");
//       print("current salarie useeeed : ${salarieGestionStockController.getCurrentSalarie?.SVR_IDF}");

//       // await GBSystem_AuthService(context).getAllArticlesSalarieGestionStock(salarie: salarieGestionStockController.getCurrentSalarie!, site: siteGestionStockController.getCurrentSite!).then((value) {
//       //   isloading.value = false;

//       //   articlesAndDatasetController.setCurrentArticlesAndDataSet = value;
//       //   Get.to(InformationsProductsSalarieScreen());
//       // });
//     } catch (e) {
//       isloading.value = false;
//       GBSystem_Add_LogEvent(message: e.toString(), method: "getArticles", page: "GBSystem_home_gestion_stock_screen_controller");
//     }

//     // try {
//     //   if (salarieGestionStockController.getCurrentSalarie != null &&
//     //       siteGestionStockController.getCurrentSite != null) {
//     //     isloading.value = true;
//     //     await GBSystem_AuthService(context)
//     //         .getAllArticlesSalarieGestionStock(
//     //             salarie: salarieGestionStockController.getCurrentSalarie!,
//     //             site: siteGestionStockController.getCurrentSite!)
//     //         .then(
//     //       (value) {
//     //         isloading.value = false;
//     //       },
//     //     );
//     //   } else {
//     //     showErrorDialog(context, GBSystem_Application_Strings.str_remplie_cases);
//     //   }
//     // } catch (e) {
//     //   isloading.value = false;
//     //   GBSystem_ManageCatchErrors().catchErrors(
//     //     context,
//     //     message: e.toString(),
//     //     method: "getArticles",
//     //     page: "GBSystem_home_gestion_stock_screen_controller",
//     //   );
//     // }
//   }
// }
