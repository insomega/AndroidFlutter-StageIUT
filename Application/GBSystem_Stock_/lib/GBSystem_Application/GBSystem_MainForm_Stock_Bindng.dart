import 'package:get/get.dart';

class GBSystem_MainForm_Stock_Binding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => GBSystem_Vacation_Informations_Controller());
    //Get.lazyPut(() => GBSystemSalarieController());

    //Get.lazyPut<GBSystem_MainForm_PS1_Controller>(() => GBSystem_MainForm_PS1_Controller(Get.context!, vacationController: Get.find(), salarieController: Get.find()));
    // Get.lazyPut<GBSystem_MainForm_PS2_Controller>(() => GBSystem_MainForm_PS2_Controller());
  }
}

// class GBSystem_HomeScreen_PS1Binding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<GBSystem_HomeScreen_PS1_Controller>(() => GBSystem_HomeScreen_PS1_Controller(Get.context!));
//   }
// }
