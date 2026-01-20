import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_events_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_planning_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_planning_vacation_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemPlanningScreenController extends GetxController {
  final planningVacationController =
      Get.put<GBSystemPlanningVacationController>(
          GBSystemPlanningVacationController());
  final eventsController =
      Get.put<GBSystemEventsController>(GBSystemEventsController());

  List<EventModel>? listEvents = [];
  final PageController pageController = PageController(initialPage: 0);
  RxInt selectedIndex = RxInt(0);
  RxDouble currentIndex = RxDouble(0);

  PlanningVacationModel? currentPlanningVacation;
  List<String> listType = [
    GbsSystemStrings.str_vacation.tr,
    GbsSystemStrings.str_planning.tr,
    GbsSystemStrings.str_agenda.tr
  ];
  RxString selectedType = "".obs;
  @override
  void onInit() {
    listEvents = eventsController.getAllEvents;
    currentPlanningVacation = planningVacationController.getCurrentVacation;
    pageController.addListener(() {
      currentIndex = RxDouble(pageController.page!.toDouble());
    });

    super.onInit();
  }
}
