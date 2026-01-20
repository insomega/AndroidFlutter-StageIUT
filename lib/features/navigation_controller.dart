// lib/features/navigation_controller.dart

import 'package:get/get.dart';

class NavigationController extends GetxController {
  // Variable réactive pour suivre l'ID de la page actuelle
  var currentViewId = 'home_link'.obs;

  // Change la vue en fonction du pageId extrait
  void navigateTo(String pageId) {
    currentViewId.value = pageId;
  }
}