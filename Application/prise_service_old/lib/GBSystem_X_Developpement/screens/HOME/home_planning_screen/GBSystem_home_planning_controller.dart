import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_salarie_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_sites_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_salarie_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_vacation_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystemHomePlanningController extends GetxController {
  RxInt selectedIndex = RxInt(0);
  RxBool isloading = RxBool(false);
  RxDouble currentIndex = RxDouble(0);
  final PageController pageController = PageController(initialPage: 0);
  final GBSystemSalariePlanningController salariePlanningController =
      Get.put(GBSystemSalariePlanningController());
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());

  final GBSystemSitesPlanningController sitePlanningController =
      Get.put(GBSystemSitesPlanningController());

  List<GBSystemSalariePlanningWidget> salarieWidgets = [];
  List<GBSystemVacationPlanningWidget> vacationWidgets = [];

  @override
  void onInit() {
    initSalarieWidgets();
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

  void initSalarieWidgets() {
    salarieWidgets = [];
    salariePlanningController.getAllSalaries?.forEach((element) {
      salarieWidgets.add(
        GBSystemSalariePlanningWidget(salariePlanning: element),
      );
    });
  }

  void onTapSheetChanged(int index) {
    selectedIndex.value = index;
    currentIndex.value = index.toDouble();
    pageController.animateToPage(selectedIndex.value,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  Future deconnexion() async {
    isloading.value = true;
    final GBSystemAgenceQuickAccessController agencesController =
        Get.put(GBSystemAgenceQuickAccessController());
    agencesController.setLoginAgence = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(GbsSystemServerStrings.kToken, "");
    await preferences.setString(GbsSystemServerStrings.kCookies, "");
    isloading.value = false;
    Get.offAll(GBSystemLoginScreen());
  }

  Future selectItemSiteFunction(
    BuildContext context,
  ) async {
    if (sitePlanningController.getCurrentSite != null) {
      isloading.value = true;
      await GBSystem_AuthService(context)
          .getVacationPlanning(
              sitePlanningModel: sitePlanningController.getCurrentSite!)
          .then((vacations) {
        vacationController.setAllVacation = vacations;
        isloading.value = false;
      });
    }
  }
}
