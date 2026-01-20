import 'package:gbsystem_stock/GBSystem_Application/GBSystem_home_gestion_stock_screen_controller.dart';
import 'package:get/get.dart';

class GBSystemHomeGestionStockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GBSystemHomeGestionStockController>(() => GBSystemHomeGestionStockController());
  }
}
