import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_preferences_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_prise_de_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_preferences_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_prise_de_vacation_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemPriseDeVacationScreenController extends GetxController {
  final priseDeVacationController = Get.put<GBSystemPriseDeVacationController>(
      GBSystemPriseDeVacationController());
  final preferencesController =
      Get.put<GBSystemPreferencesController>(GBSystemPreferencesController());

  // Rx<List<PriseDeVacationModel>?>? listPriseDeVacation =
  //     Rx<List<PriseDeVacationModel>?>(null);
  List<PriseDeVacationModel>? listPriseDeVacation;
  List<PreferencesModel>? listPreferences;

  final PageController pageController = PageController(initialPage: 0);
  RxInt selectedIndex = RxInt(0);
  RxDouble currentIndex = RxDouble(0);

  List<String> listType = [
    GbsSystemStrings.str_list_des_vacations.tr,
    GbsSystemStrings.str_preferences.tr
  ];
  RxString selectedType = "".obs;
  @override
  void onInit() {
    listPriseDeVacation = priseDeVacationController.getAllVacations;
    listPreferences = preferencesController.getAllPreferences;
    pageController.addListener(() {
      currentIndex = RxDouble(pageController.page!.toDouble());
    });

    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();

    super.onClose();
  }
}
