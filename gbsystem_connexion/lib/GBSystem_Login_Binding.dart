import 'package:get/get.dart';
import './GBSystem_Login_Controller.dart';
//import './GBSystem_Login_Exchange_Server.dart';
import 'GBSystem_Login_MDP_Oublier_Controller.dart';
import 'GBSystem_Login_MDP_Change_Controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GBSystem_Login_Controller());
    // Get.lazyPut(() => GBSystem_Login_Exchange_Server());
    // Get.lazyPut(() => GBSystem_MDP_Oublier_Controller());
  }
}

class GBSystem_Mdp_OublierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GBSystem_MDP_Oublier_Controller());
  }
}

class GBSystem_Mdp_ChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GBSystem_MDP_Change_Controller());
  }
}
