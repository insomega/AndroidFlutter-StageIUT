import 'package:get/get.dart';
import 'gbsystem_splash_controller.dart';
import 'package:gbsystem_root/GBSystem_Root_SplashStep.dart';
import 'package:gbsystem_root/GBSystem_Root_Params.dart';

class GBSystem_splash_binding extends Bindings {
  final List<GBSystem_Root_SplashStep> steps = GBSystem_Application_Params_Manager.instance.splash_steps;
  final String mainRoute = GBSystem_Application_Params_Manager.instance.mainAppView;

  GBSystem_splash_binding();

  @override
  void dependencies() {
    Get.lazyPut(() => GBSystem_SplashController(steps: steps, fallbackRoute: mainRoute));
  }
}
