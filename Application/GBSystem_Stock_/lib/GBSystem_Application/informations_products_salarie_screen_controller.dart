import 'package:flutter/cupertino.dart';
import 'package:gbsystem_root/GBSystem_LogEvent.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_salarie_gestion_stock_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_site_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/articles_and_dataset_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/articles_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/articles_salarie_controller.dart';
import 'package:get/get.dart';

class InformationsProductsSalarieScreenController extends GetxController {
  InformationsProductsSalarieScreenController(this.context);
  BuildContext context;
  final ArticlesAndDatasetController articlesAndDatasetController = Get.put(ArticlesAndDatasetController());
  final GBSystemSiteGestionStockController siteGestionStockController = Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController = Get.put(GBSystemSalarieGestionStockController());
  final ArticlesController articlesController = Get.put(ArticlesController());
  final ArticlesSalarieController articlesSalarieController = Get.put(ArticlesSalarieController());

  RxBool isLoading = RxBool(false);

  Future retourArticleSalarie(ArticleSalarieGestionStockModel articleSalarie) async {
    try {
      isLoading.value = true;
      // await GBSystem_AuthService(context).retourArticle(salarie: salarieGestionStockController.getCurrentSalarie!, site: siteGestionStockController.getCurrentSite!, article: articleSalarie).then((value) {
      //   isLoading.value = false;
      //   if (value != null) {
      //     articlesAndDatasetController.setAllArticles = value;
      //   } else {
      //     // showErrorDialog(context, GBSystem_Application_Strings.str_error_send_data);
      //   }
      // });
    } catch (e) {
      isLoading.value = false;
      GBSystem_Add_LogEvent(message: e.toString(), method: "retourArticleSalarie", page: "informations_products_salarie_screen_controller");
    }
  }
}
