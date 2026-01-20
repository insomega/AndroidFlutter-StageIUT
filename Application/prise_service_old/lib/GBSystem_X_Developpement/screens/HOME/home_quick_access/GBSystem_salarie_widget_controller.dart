import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GBSystemSalarieWidgetController extends GetxController {
  PageController pageController = PageController();
  RxDouble currentIndex = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentIndex.value = pageController.page ?? 0.0;
    });
  }
}
