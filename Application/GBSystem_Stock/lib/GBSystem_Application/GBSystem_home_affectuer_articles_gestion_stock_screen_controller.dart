import 'package:flutter/cupertino.dart';
import 'package:gbsystem_root/GBSystem_LogEvent.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_site_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/articles_and_dataset_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/articles_controller.dart';
import 'package:get/get.dart';

class GBSystemHomeAffectuerArticlesGestionStockScreenController extends GetxController {
  RxBool isloading = RxBool(false);
  BuildContext context;
  RxBool infoSecondPageVisibility = RxBool(false);
  PageController pageController = PageController(initialPage: 1, keepPage: true);
  RxInt currentPageIndex = 0.obs;
  RxInt selectedIndex = RxInt(0);
  RxDouble currentIndex = RxDouble(0);

  GBSystemHomeAffectuerArticlesGestionStockScreenController(this.context);
  final GBSystemSiteGestionStockController siteGestionStockController = Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController = Get.put(GBSystemSalarieGestionStockController());
  final ArticlesAndDatasetController articlesAndDatasetController = Get.put(ArticlesAndDatasetController());
  final ArticlesController articlesController = Get.put(ArticlesController());

  //final GBSystemAgenceQuickAccessController agencesController = Get.put(GBSystemAgenceQuickAccessController());
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
    // final GBSystemAgenceQuickAccessController agencesController = Get.put(GBSystemAgenceQuickAccessController());
    // agencesController.setLoginAgence = null;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.setString(GBSystem_Application_Strings.kToken, "");
    // await preferences.setString(GBSystem_Application_Strings.kCookies, "");
    // isloading.value = false;
    // Get.offAll(GBSystemLoginScreen());
  }

  Future getArticles() async {
    try {
      isloading.value = true;
      // await GBSystem_AuthService(context).getAllArticlesGestionStock();
      // await GBSystem_AuthService(context)
      //     .getAllArticlesSalarieGestionStock(
      //       salarie: salarieGestionStockController.getCurrentSalarie!, //
      //       site: siteGestionStockController.getCurrentSite!,
      //     )
      //     .then((value) {
      //       isloading.value = false;

      //       articlesAndDatasetController.setCurrentArticlesAndDataSet = value;
      //       Get.to(InformationsProductsSalarieScreen());
      //     });
    } catch (e) {
      isloading.value = false;
      GBSystem_Add_LogEvent(message: e.toString(), method: "getArticles", page: "GBSystem_home_gestion_stock_screen_controller");
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
    //     showErrorDialog(context, GBSystem_Application_Strings.str_remplie_cases);
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

  Future getListSalarieDependSite({required String DOS_IDF}) async {
    isloading.value = true;

    // await GBSystem_AuthService(context).getAllSalarieGestionStockWith_DOS_IDF(DOS_IDF: DOS_IDF).then((Salarie) async {
    //   salarieGestionStockController.setAllSalarie = Salarie;
    //   // if (Salarie != null && Salarie.isNotEmpty) {
    //   //   salarieGestionStockController.setCurrentSalarieSalarie = Salarie.first;
    //   // }
    //   isloading.value = false;
    // });
  }
}
