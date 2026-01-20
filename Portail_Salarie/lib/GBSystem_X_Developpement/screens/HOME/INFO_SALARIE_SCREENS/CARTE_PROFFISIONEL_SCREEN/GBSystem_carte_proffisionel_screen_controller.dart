import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';

class GBSystemCarteProffisionelScreenController extends GetxController {
   GBSystemCarteProffisionelScreenController(this.context);

BuildContext context;

final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());

// PageController pageController = PageController(initialPage: 0);
  // RxInt currentPageIndex = 0.obs;
@override
  void onClose() {
  // pageController.dispose();
   super.onClose();
  }

@override
  void onInit() {
   super.onInit();
  }


}