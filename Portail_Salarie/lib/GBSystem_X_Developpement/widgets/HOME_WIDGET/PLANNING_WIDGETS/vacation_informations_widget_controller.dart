import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VacationInformationsWidgetController extends GetxController {
  PageController pageController = PageController();
  RxDouble currentIndex = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentIndex.value = pageController.page ?? 0.0;
    });
  }

  @override
  void onClose() {
    pageController.dispose();

    super.onClose();
  }
}
