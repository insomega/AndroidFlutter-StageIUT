import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_events_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_planning_vacation_controller.dart';

class PlanningInformationsWidgetController extends GetxController {
  PageController pageController = PageController();
  RxDouble currentIndex = 0.0.obs;
 
  RxBool isLoading = RxBool(false);
  final vacationController = Get.put<GBSystemPlanningVacationController>(
      GBSystemPlanningVacationController());
  final eventController =
      Get.put<GBSystemEventsController>(GBSystemEventsController());

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentIndex.value = pageController.page ?? 0.0;
    });
   
  }
}
