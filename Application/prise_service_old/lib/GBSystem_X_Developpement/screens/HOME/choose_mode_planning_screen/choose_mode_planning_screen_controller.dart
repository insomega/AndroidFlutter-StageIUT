import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_sites_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_planning_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseModePlanningScreenController extends GetxController {
  BuildContext context;
  RxBool isLoading = RxBool(false);
  ChooseModePlanningScreenController({required this.context});

  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());

  final GBSystemSitesPlanningController sitePlanningController =
      Get.put(GBSystemSitesPlanningController());
  Future deconnexion() async {
    isLoading.value = true;
    final GBSystemAgenceQuickAccessController agencesController =
        Get.put(GBSystemAgenceQuickAccessController());
    agencesController.setLoginAgence = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(GbsSystemServerStrings.kToken, "");
    await preferences.setString(GbsSystemServerStrings.kCookies, "");
    isLoading.value = false;
    Get.offAll(GBSystemLoginScreen());
  }

  void viderPreviousData() {
    vacationController.setAllVacation = null;
    vacationController.setCurrentVacationVacation = null;
  }

  void addFilterSitesDependCurrentVacations() {
    // lieu
    List<String> list_LIE_IDF = (vacationController.getAllVacations ?? []).map(
      (e) {
        print(
            "aavacation ${e.VAC_IDF} his lieu is : ${e.LIE_LIB} | ${e.LIE_IDF}");

        return e.LIE_LIB;
      },
    ).toList();

    list_LIE_IDF = list_LIE_IDF.toSet().toList();
    print(list_LIE_IDF);

    List<SitePlanningModel> allLieu = (sitePlanningController.getAllSites ?? [])
        .where((element) {
          print("compare ${element.LIE_LIB}");
          return list_LIE_IDF.contains(element.LIE_LIB);
        })
        .toSet()
        .toList();

    vacationController.setAllLieu = allLieu;
    //  end added
  }
}
