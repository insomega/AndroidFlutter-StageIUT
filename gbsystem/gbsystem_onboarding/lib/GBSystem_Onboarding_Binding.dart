import 'package:get/get.dart';
import 'GBSystem_Onboarding_Controller.dart';

class GBSystem_Onboarding_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GBSystem_Onboarding_Controller());
  }
}
