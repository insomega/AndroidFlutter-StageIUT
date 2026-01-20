import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_salarie_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_sites_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_planning_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_planning_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemSelectItemController extends GetxController {
  GBSystemSelectItemController({required this.type, required this.context});
  BuildContext context;
  String type;

  RxBool isLoading = RxBool(false);
  RxList<SitePlanningModel> sites = RxList<SitePlanningModel>([]);
  RxList<SitePlanningModel> filtredSites = RxList<SitePlanningModel>([]);

  RxList<SalariePlanningModel> salaries = RxList<SalariePlanningModel>([]);
  RxList<SalariePlanningModel> filtredSalaries =
      RxList<SalariePlanningModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final GBSystemSitesPlanningController sitePlanningController =
      Get.put(GBSystemSitesPlanningController());

  final GBSystemSalariePlanningController salariePlanningController =
      Get.put(GBSystemSalariePlanningController());

  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());

  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    if (type == GbsSystemStrings.str_type_site) {
      sites.value = sitePlanningController.getAllSites!;
    } else if (type == GbsSystemStrings.str_type_salarie) {
      salaries.value = salariePlanningController.getAllSalaries!;
    }
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredSites.value = sites.where((agence) {
      return agence.LIE_LIB
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          agence.LIE_CODE
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  void filterDataSalarie(String query) {
    text?.value = query;
    filtredSalaries.value = salaries.where((agence) {
      return agence.SVR_LIB
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          agence.SVR_CODE
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  Future selectItemSiteFunction(
      {required SitePlanningModel selectedSite}) async {
    isLoading.value = true;

    await GBSystem_AuthService(context)
        .getVacationPlanning(sitePlanningModel: selectedSite)
        .then((vacations) {
      vacationController.setAllVacation = vacations;
      if (vacations != null && vacations.isNotEmpty) {
        vacationController.setCurrentVacationVacation = vacations.first;
      } else {
        vacationController.setCurrentVacationVacation = null;
      }
      sitePlanningController.setCurrentSite = selectedSite;
      addFilterSitesDependCurrentVacations();
      isLoading.value = false;

      Get.back();
    });
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
