import 'package:get/get.dart';
import 'GBSystem_MainForm_BMEvents_Controller.dart';
//import '../GBSystem_Application/GBSystem_MainForm_BMEvents_View.dart';

//import '../GBSystem_Serveur/GBSystem_salarie_controller.dart';
import 'package:gbsystem_vacation_priseservice/GBSystem_Vacation_Informations_Controller.dart';

class GBSystem_MainForm_BMEvents_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GBSystem_Vacation_Informations_Controller());
    //Get.lazyPut(() => GBSystemSalarieController());

    //Get.lazyPut<GBSystem_MainForm_BMEvents_Controller>(() => GBSystem_MainForm_BMEvents_Controller(Get.context!, vacationController: Get.find(), salarieController: Get.find()));
    Get.lazyPut<GBSystem_MainForm_BMEvents_Controller>(() => GBSystem_MainForm_BMEvents_Controller());
  }
}

// class GBSystem_HomeScreen_BMEventsBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<GBSystem_HomeScreen_BMEvents_Controller>(() => GBSystem_HomeScreen_BMEvents_Controller(Get.context!));
//   }
// }
