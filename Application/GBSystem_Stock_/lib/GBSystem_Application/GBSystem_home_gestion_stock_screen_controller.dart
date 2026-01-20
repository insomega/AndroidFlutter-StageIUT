// controllers/gbsystem_home_gestion_stock_controller.dart
import 'package:flutter/cupertino.dart';
import 'package:gbsystem_root/GBSystem_LogEvent.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_site_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/articles_and_dataset_controller.dart';
import 'package:get/get.dart';

class GBSystemHomeGestionStockController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool infoSecondPageVisibility = false.obs;
  final PageController pageController = PageController(initialPage: 0);
  final RxDouble currentIndex = 0.0.obs;

  final GBSystemSiteGestionStockController siteGestionStockController = Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController = Get.put(GBSystemSalarieGestionStockController());
  final ArticlesAndDatasetController articlesAndDatasetController = Get.put(ArticlesAndDatasetController());

  final BuildContext context;

  GBSystemHomeGestionStockController(this.context);

  @override
  void onInit() {
    pageController.addListener(() {
      currentIndex.value = pageController.page ?? 0.0;
    });
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void navigateToFirstPage() {
    pageController.animateToPage(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInCubic);
    infoSecondPageVisibility.value = false;
    salarieGestionStockController.setCurrentSalarieSalarie = null;
  }

  void navigateToSecondPage() {
    if (siteGestionStockController.getCurrentSite != null) {
      pageController.animateToPage(1, duration: const Duration(milliseconds: 800), curve: Curves.easeInCubic);
      infoSecondPageVisibility.value = true;
    } else {
      // Show error - should be handled in view
    }
  }

  Future<void> getArticles() async {
    try {
      isLoading.value = true;

      final currentSite = siteGestionStockController.getCurrentSite;
      final currentSalarie = salarieGestionStockController.getCurrentSalarie;

      if (currentSite == null || currentSalarie == null) {
        // Show error - should be handled in view
        isLoading.value = false;
        return;
      }

      print("Current site used: ${currentSite.DOS_IDF}");
      print("Current salarie used: ${currentSalarie.SVR_IDF}");

      // Uncomment and implement your service call
      /*
      final articles = await GBSystem_AuthService(context).getAllArticlesSalarieGestionStock(
        salarie: currentSalarie,
        site: currentSite,
      );
      
      articlesAndDatasetController.setCurrentArticlesAndDataSet = articles;
      Get.to(InformationsProductsSalarieScreen());
      */

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      GBSystem_Add_LogEvent(message: e.toString(), method: "getArticles", page: "GBSystemHomeGestionStockController");
    }
  }
}
