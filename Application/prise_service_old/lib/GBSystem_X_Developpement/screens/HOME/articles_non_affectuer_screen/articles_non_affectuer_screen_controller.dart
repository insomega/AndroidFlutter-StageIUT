import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GESTION_STOCK_CONTROLLERS/articles_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ArticlesNonAffectuerScreenController extends GetxController {
  final ArticlesController articlesController = Get.put(ArticlesController());
  final GBSystemSalarieGestionStockController salarieGestionStockController =
      Get.put(GBSystemSalarieGestionStockController());
}
