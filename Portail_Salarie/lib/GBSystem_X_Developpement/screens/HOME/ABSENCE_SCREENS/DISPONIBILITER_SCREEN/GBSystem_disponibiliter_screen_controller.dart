import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisponibiliterScreenController extends GetxController {
  RxBool isLoading = RxBool(false);
  PageController pageController = PageController(initialPage: 0);
  RxInt currentPageIndex = 0.obs;
  PageController pageControllerDialog = PageController(initialPage: 0);
  RxInt currentPageIndexDialog = 0.obs;

  
  @override
  void onClose() {
    pageController.dispose();
    pageControllerDialog.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

}