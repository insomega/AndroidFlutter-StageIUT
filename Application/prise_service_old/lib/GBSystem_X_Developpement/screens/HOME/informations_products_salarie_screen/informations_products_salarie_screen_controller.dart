import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GESTION_STOCK_CONTROLLERS/articles_and_dataset_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GESTION_STOCK_CONTROLLERS/articles_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GESTION_STOCK_CONTROLLERS/articles_salarie_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_site_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_article_salarie_gestion_stock_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:get/get.dart';

class InformationsProductsSalarieScreenController extends GetxController {
  InformationsProductsSalarieScreenController(this.context);
  BuildContext context;
  final ArticlesAndDatasetController articlesAndDatasetController =
      Get.put(ArticlesAndDatasetController());
  final GBSystemSiteGestionStockController siteGestionStockController =
      Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController =
      Get.put(GBSystemSalarieGestionStockController());
  final ArticlesController articlesController = Get.put(ArticlesController());
  final ArticlesSalarieController articlesSalarieController =
      Get.put(ArticlesSalarieController());

  RxBool isLoading = RxBool(false);

  Future retourArticleSalarie(
      ArticleSalarieGestionStockModel articleSalarie) async {
    try {
      isLoading.value = true;
      await GBSystem_AuthService(context)
          .retourArticle(
              salarie: salarieGestionStockController.getCurrentSalarie!,
              site: siteGestionStockController.getCurrentSite!,
              article: articleSalarie)
          .then(
        (value) {
          isLoading.value = false;
          if (value != null) {
            articlesAndDatasetController.setAllArticles = value;
          } else {
            // showErrorDialog(context, GbsSystemStrings.str_error_send_data);
          }
        },
      );
    } catch (e) {
      isLoading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "retourArticleSalarie",
        page: "informations_products_salarie_screen_controller",
      );
    }
  }
}
