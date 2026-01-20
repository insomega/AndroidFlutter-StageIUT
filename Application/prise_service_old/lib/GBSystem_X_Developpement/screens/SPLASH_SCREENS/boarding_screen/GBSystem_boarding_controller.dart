import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystem_Boarding_Controller extends GetxController {
  PageController pageController = PageController();
  RxDouble currentIndex = 0.0.obs;
  SharedPreferences? prefs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentIndex.value = pageController.page ?? 0.0;
    });
  }

  Future updateFirstTime() async {
    prefs = await SharedPreferences.getInstance();
    await prefs!
        .setBool(GbsSystemServerStrings.kIsFirstTime, false)
        .then((value) {
      Get.offAll(GBSystemLoginScreen());
    });
  }
}
