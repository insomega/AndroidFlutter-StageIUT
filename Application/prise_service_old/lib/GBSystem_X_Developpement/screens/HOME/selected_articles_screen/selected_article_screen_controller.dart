import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GESTION_STOCK_CONTROLLERS/articles_and_dataset_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GESTION_STOCK_CONTROLLERS/articles_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_site_gestion_stock_controller.dart';
import 'package:get/get.dart';

class SelectedArticleScreenController extends GetxController {
  RxBool isLoading = RxBool(false);
  final ArticlesController articlesController = Get.put(ArticlesController());

  final GBSystemSiteGestionStockController siteGestionStockController =
      Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController =
      Get.put(GBSystemSalarieGestionStockController());
  final ArticlesAndDatasetController articlesAndDatasetController =
      Get.put(ArticlesAndDatasetController());
}
