import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GBSystem_internet_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_salarie_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_sites_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_site_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystemSplashController extends GetxController {
  RxBool? isFirstTime;
  RxBool? isSignedIn;
  RxString? token;
  RxString? cookies, previousSiteWeb;
  RxBool isConnected = false.obs, toValidPIN = false.obs;
  GBSystemSplashController({required this.context});
  BuildContext context;
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
  final GBSystemInternatController internatController =
      Get.put(GBSystemInternatController());
// ------------------
  final GBSystemSalariePlanningController salariePlanningController =
      Get.put(GBSystemSalariePlanningController());
  final GBSystemSitesPlanningController sitePlanningController =
      Get.put(GBSystemSitesPlanningController());
// ----------------------
  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());
// -------------------
  final GBSystemSiteGestionStockController siteGestionStockController =
      Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController =
      Get.put(GBSystemSalarieGestionStockController());

  loadData() async {
    await internatController.initConnectivity().then((value) {
      isConnected = RxBool(internatController.isConnected);
    });

    await SharedPreferences.getInstance().then((value) {
      value.getBool(GbsSystemServerStrings.kIsFirstTime) != null
          ? isFirstTime =
              RxBool(value.getBool(GbsSystemServerStrings.kIsFirstTime)!)
          : null;

      value.getString(GbsSystemServerStrings.kToken) != null
          ? token = RxString(value.getString(GbsSystemServerStrings.kToken)!)
          : null;

      value.getString(GbsSystemServerStrings.kCookies) != null
          ? cookies =
              RxString(value.getString(GbsSystemServerStrings.kCookies)!)
          : null;

      isSignedIn = ((token?.value != null &&
              token!.value.isNotEmpty &&
              cookies?.value != null &&
              cookies!.value.isNotEmpty)
          ? RxBool(true)
          : RxBool(false));

      value.getString(GbsSystemServerStrings.kSiteWeb) != null
          ? previousSiteWeb =
              RxString(value.getString(GbsSystemServerStrings.kSiteWeb)!)
          : null;
      value.getString(GbsSystemServerStrings.kPINCode) != null
          ? toValidPIN = RxBool(true)
          : RxBool(false);
    });

    // // set new value of url (after getting previousSiteWeb with previous value)
    // await changePerfermencesURL(
    //     newSite: GbsSystemServerStrings.kMyBaseUrlStandard);
    // //vider previous data (wid cookies) if change app url
    // if (previousSiteWeb != GbsSystemServerStrings.kMyBaseUrlStandard) {
    //   await viderSharedPerfermences();
    //   isFirstTime = RxBool(true);
    //   isSignedIn = RxBool(false);
    // }

    if (isSignedIn?.value == true && isConnected.value == true) {
      // load other data next time
      await GBSystem_AuthService(context)
          .getInfoVacation()
          .then((listVacations) async {
        print("list vacs splsh : ${listVacations}");
        if (listVacations != null && listVacations.isNotEmpty) {
          vacationController.setAllVacation = listVacations;
          vacationController.setCurrentVacationVacation = listVacations[0];
        } else if (listVacations != null && listVacations.isEmpty) {
        } else {
          print("isSignedIn turn off  getInfoVacation : ${isSignedIn?.value}");
          isSignedIn = RxBool(false);
        }
      });

      await GBSystem_AuthService(context)
          .getInfoSalarie()
          .then((infoSalarie) async {
        if (infoSalarie != null) {
          salarieController.setSalarie = infoSalarie.salarieModel;
          if (infoSalarie.imageSalarie != null) {
            salarieController.setImage = infoSalarie.imageSalarie!;
          }
        } else {
          print("isSignedIn turn off  getInfoSalarie : ${isSignedIn?.value}");

          isSignedIn = RxBool(false);
        }
      });
    }
  }

  loadDataPlanning() async {
    await internatController.initConnectivity().then((value) {
      isConnected = RxBool(internatController.isConnected);
    });

    await SharedPreferences.getInstance().then((value) {
      value.getBool(GbsSystemServerStrings.kIsFirstTime) != null
          ? isFirstTime =
              RxBool(value.getBool(GbsSystemServerStrings.kIsFirstTime)!)
          : null;

      value.getString(GbsSystemServerStrings.kToken) != null &&
              value.getString(GbsSystemServerStrings.kToken)!.isNotEmpty
          ? token = RxString(value.getString(GbsSystemServerStrings.kToken)!)
          : null;

      value.getString(GbsSystemServerStrings.kCookies) != null &&
              value.getString(GbsSystemServerStrings.kCookies)!.isNotEmpty
          ? cookies =
              RxString(value.getString(GbsSystemServerStrings.kCookies)!)
          : null;

      isSignedIn = ((token?.value != null &&
              token!.value.isNotEmpty &&
              cookies?.value != null &&
              cookies!.value.isNotEmpty)
          ? RxBool(true)
          : RxBool(false));
      value.getString(GbsSystemServerStrings.kSiteWeb) != null
          ? previousSiteWeb =
              RxString(value.getString(GbsSystemServerStrings.kSiteWeb)!)
          : null;

      value.getString(GbsSystemServerStrings.kPINCode) != null
          ? toValidPIN = RxBool(true)
          : RxBool(false);
    });

    // //set new value of url (after getting previousSiteWeb with previous value)
    // await changePerfermencesURL(
    //     newSite: GbsSystemServerStrings.kMyBaseUrlStandard);
    // //vider previous data (wid cookies) if change app url
    // if (previousSiteWeb != GbsSystemServerStrings.kMyBaseUrlStandard) {
    //   await viderSharedPerfermences();
    //   isFirstTime = RxBool(true);
    //   isSignedIn = RxBool(false);
    // }

    if (isSignedIn?.value == true && isConnected.value == true) {
      // load other data next time
      await GBSystem_AuthService(context)
          .getAllEmployer()
          .then((listEmployee) async {
        if (listEmployee != null && listEmployee.isNotEmpty) {
          salariePlanningController.setAllSalaries = listEmployee;
          salariePlanningController.setCurrentSalarie = listEmployee[0];
        } else if (listEmployee != null && listEmployee.isEmpty) {
        } else {
          isSignedIn = RxBool(false);
        }
      });

      await GBSystem_AuthService(context).getAllSites().then((listSites) async {
        if (listSites != null && listSites.isNotEmpty) {
          sitePlanningController.setCurrentSite = listSites[0];
          sitePlanningController.setAllSite = listSites;
          await GBSystem_AuthService(context)
              .getVacationPlanning(sitePlanningModel: listSites[0])
              .then((vacations) {
            if (vacations != null && vacations.isNotEmpty) {
              vacationController.setAllVacation = vacations;
              vacationController.setCurrentVacationVacation = vacations[0];
            } else if (vacations != null && vacations.isEmpty) {
            } else {
              isSignedIn = RxBool(false);
            }
          });
        } else if (listSites != null && listSites.isEmpty) {
        } else {
          isSignedIn = RxBool(false);
        }
      });
    }
  }

  loadDataQuickAcces() async {
    await internatController.initConnectivity().then((value) {
      isConnected = RxBool(internatController.isConnected);
    });

    await SharedPreferences.getInstance().then((value) {
      value.getBool(GbsSystemServerStrings.kIsFirstTime) != null
          ? isFirstTime =
              RxBool(value.getBool(GbsSystemServerStrings.kIsFirstTime)!)
          : null;
      value.getString(GbsSystemServerStrings.kToken) != null
          ? token = RxString(value.getString(GbsSystemServerStrings.kToken)!)
          : null;
      value.getString(GbsSystemServerStrings.kCookies) != null
          ? cookies =
              RxString(value.getString(GbsSystemServerStrings.kCookies)!)
          : null;
      isSignedIn = ((token?.value != null &&
              token!.value.isNotEmpty &&
              cookies?.value != null &&
              cookies!.value.isNotEmpty)
          ? RxBool(true)
          : RxBool(false));

      value.getString(GbsSystemServerStrings.kPINCode) != null
          ? toValidPIN = RxBool(true)
          : RxBool(false);
    });
    if (isSignedIn?.value == true && isConnected.value == true) {
      // load other data next time
      await GBSystem_AuthService(context)
          .getTypeQuestionnaireQuickAccess()
          .then((typeQuestionnaire) async {
        if (typeQuestionnaire != null && typeQuestionnaire.isNotEmpty) {
          evaluationSurSiteController.setAllTypeQuestionnaire =
              typeQuestionnaire;
          // evaluationSurSiteController.setSelectedTypeQuestionnaire =
          //     typeQuestionnaire.first;
        } else if (typeQuestionnaire != null && typeQuestionnaire.isEmpty) {
        } else {
          isSignedIn = RxBool(false);
        }
      });

      await GBSystem_AuthService(context)
          .getQuestionnaireQuickAccess()
          .then((questionnaire) async {
        if (questionnaire != null && questionnaire.isNotEmpty) {
          evaluationSurSiteController.setAllQuestionnaire = questionnaire;
        } else if (questionnaire != null && questionnaire.isEmpty) {
        } else {
          isSignedIn = RxBool(false);
        }
      });
      await GBSystem_AuthService(context)
          .getSiteQuickAccess()
          .then((sites) async {
        if (sites != null && sites.isNotEmpty) {
          evaluationSurSiteController.setAllSites = sites;
        } else if (sites != null && sites.isEmpty) {
        } else {
          isSignedIn = RxBool(false);
        }
      });
    }
  }

  loadDataGestionDeStock() async {
    await internatController.initConnectivity().then((value) {
      isConnected = RxBool(internatController.isConnected);
    });

    await SharedPreferences.getInstance().then((value) {
      value.getBool(GbsSystemServerStrings.kIsFirstTime) != null
          ? isFirstTime =
              RxBool(value.getBool(GbsSystemServerStrings.kIsFirstTime)!)
          : null;
      value.getString(GbsSystemServerStrings.kToken) != null
          ? token = RxString(value.getString(GbsSystemServerStrings.kToken)!)
          : null;
      value.getString(GbsSystemServerStrings.kCookies) != null
          ? cookies =
              RxString(value.getString(GbsSystemServerStrings.kCookies)!)
          : null;
      isSignedIn = ((token?.value != null &&
              token!.value.isNotEmpty &&
              cookies?.value != null &&
              cookies!.value.isNotEmpty)
          ? RxBool(true)
          : RxBool(false));

      value.getString(GbsSystemServerStrings.kPINCode) != null
          ? toValidPIN = RxBool(true)
          : RxBool(false);
    });
    if (isSignedIn?.value == true && isConnected.value == true) {
      // load other data next time
      await GBSystem_AuthService(context)
          .getAllSiteGestionStock()
          .then((siteGestionStock) async {
        siteGestionStockController.setAllSite = siteGestionStock;

        if (siteGestionStock != null && siteGestionStock.isNotEmpty) {
          // siteGestionStockController.setCurrentSiteSite =
          //     siteGestionStock.first;

          // await GBSystem_AuthService(context)
          //     .getAllSalarieGestionStock(site: siteGestionStock.first)
          //     .then((Salarie) async {
          //   if (Salarie != null) {
          //     salarieGestionStockController.setAllSalarie = Salarie;
          //   } else {
          //     isSignedIn = RxBool(false);
          //   }
          // });
        } else if (siteGestionStock != null && siteGestionStock.isEmpty) {
        } else {
          isSignedIn = RxBool(false);
        }
      });

      // await GBSystem_AuthService(context)
      //     .getSiteQuickAccess()
      //     .then((sites) async {
      //   if (sites != null) {
      //     evaluationSurSiteController.setAllSites = sites;
      //   } else {
      //     isSignedIn = RxBool(false);
      //   }
      // });
    }
  }

  viderSharedPerfermences() async {
    await SharedPreferences.getInstance().then((value) {
      value.setBool(GbsSystemServerStrings.kIsFirstTime, true);
      value.setString(GbsSystemServerStrings.kToken, "");
      value.setString(GbsSystemServerStrings.kCookies, "");
    });
  }

  changePerfermencesURL({required String newSite}) async {
    await SharedPreferences.getInstance().then((value) {
      value.setString(GbsSystemServerStrings.kSiteWeb, newSite);
    });
  }
}
