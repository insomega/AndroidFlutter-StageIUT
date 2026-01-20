import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
//import 'package:get_storage/get_storage.dart';
//import 'package:gbsystem_root/GBSystem_Root_Params.dart';
//import 'package:gbsystem_root/GBSystem_System_Strings.dart';
//import '../../../Application_Model_NG/lib/GBSystem_Application/Routes/GBSystem_Application_Routes.dart';

class GBSystem_Onboarding_Controller extends GBSystem_Root_Controller {
  static const routeName = '/onboarding';

  final PageController pageController = PageController();
  final RxDouble currentIndex = 0.0.obs;
  //final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentIndex.value = pageController.page ?? 0.0;
    });
  }

  void completeOnboarding() {
    GBSystem_Storage_Service().saveIsFirstTime(); // marquer comme vu
    //box.write(GBSystem_System_Strings.kIsFirstTime, false);

    //Get.offAll(() => LoginView());
    //  Get.offAllNamed(GBSystem_Application_Params_Manager.instance.login);
    Get.back(); // ✅ Cela "réveille" le await dans execute(), donc _runSteps continue
  }
}
