import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GBSystem_internet_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_vacation_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_vacation_informations.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserEntrerSortieController extends GetxController {
  BuildContext context;
  UserEntrerSortieController({
    required this.context,
    required this.isUpdatePause,
    required this.isClosePointageAfterExists,
  });
  final bool isUpdatePause, isClosePointageAfterExists;

  final PageController pageController = PageController(initialPage: 0);
  RxBool isLoading = RxBool(false);
  RxDouble currentIndex = RxDouble(0);
  List<VacationInformations> vacationPages = [];
  VacationModel? currentVacation;
  List<VacationModel>? listVacations = [];

  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
  final GBSystemInternatController internatController =
      Get.put(GBSystemInternatController());
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());

  @override
  void onInit() {
    currentVacation = vacationController.getCurrentVacation;
    initVacationsPages();
    pageController.addListener(() {
      currentIndex = RxDouble(pageController.page!);
    });
    super.onInit();
  }

  void initVacationsPages() {
    vacationPages.add(VacationInformations(
      isUpdatePause: isUpdatePause,
    ));
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future precedentFunction(BuildContext context) async {
    isLoading.value = true;
    currentVacation = vacationController.getCurrentVacation;
    await GBSystem_AuthService(context)
        .getInfoVacationPrecedent(VAC_IDF: currentVacation!.VAC_IDF)
        .then((value) {
      if (value != null) {
        vacationController.setVacationToLeft = value;
        currentVacation = value;
        vacationController.setCurrentVacationVacation = value;
        isLoading.value = false;
        // initVacationsPages();
      } else {
        isLoading.value = false;

        showWarningDialog(
          context,
          GbsSystemStrings.str_aucune_vacation_prec,
        );
      }
    });
  }

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

  Future entrerFunction(
      BuildContext context, bool desconnectAfterSuccess) async {
//  test connexion
    isLoading.value = true;
    currentVacation = vacationController.getCurrentVacation;

    await GBSystem_AuthService(context)
        .pointageEntrerSorie(
            Sens: GbsSystemServerStrings.str_pointage_entrer_sens,
            vacation: currentVacation!)
        .then((infoEntrer) async {
      if (infoEntrer != null) {
        VacationModel myVacation = infoEntrer;
        vacationController.setVacationEntrer = myVacation.PNTGS_START_HOUR_IN!;
        vacationController.setCurrentVacationVacation = myVacation;
        isLoading.value = false;
        showSuccesDialog(context, GbsSystemStrings.str_pointage_entrer_succes);
        if (desconnectAfterSuccess) {
          deconnexion();
        }
      } else {
        await internatController.initConnectivity();
        isLoading.value = false;

        if (internatController.isConnected) {
          showErrorDialog(context, GbsSystemStrings.str_mal_tourner);
        } else {
          // stocked locally
          // showWarningDialog(context,
          //     GbsSystemStrings.str_no_connexion_action_stocked_locally);
        }
      }
    }).catchError((e) async {
      isLoading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "entrerFunction",
        page: "GBSystem_user_entrer_sortie_controller",
      );
    });
  }

  Future sortieFunction(
      BuildContext context, bool desconnectAfterSuccess) async {
    isLoading.value = true;
    currentVacation = vacationController.getCurrentVacation;

    await GBSystem_AuthService(context)
        .pointageEntrerSorie(
            Sens: GbsSystemServerStrings.str_pointage_sortie_sens,
            vacation: currentVacation!)
        .then((infoSortie) async {
      // print('info $infoSortie');
      if (infoSortie != null) {
        VacationModel myVacation = infoSortie;
        vacationController.setVacationSortie = myVacation.PNTGS_START_HOUR_OUT!;
        vacationController.setCurrentVacationVacation = myVacation;
        isLoading.value = false;
        showSuccesDialog(context, GbsSystemStrings.str_pointage_sortie_succes);
        if (desconnectAfterSuccess) {
          deconnexion();
        }
      } else {
        await internatController.initConnectivity();
        isLoading.value = false;
        // showErrorDialog(context, GbsSystemStrings.str_mal_tourner);
        if (internatController.isConnected) {
          showErrorDialog(context, GbsSystemStrings.str_mal_tourner);
        } else {
          // stocked locally
          // showWarningDialog(context,
          //     GbsSystemStrings.str_no_connexion_action_stocked_locally);
        }
      }
    }).catchError((e) async {
      // print('err');
      isLoading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "sortieFunction",
        page: "GBSystem_user_entrer_sortie_controller",
      );
    });
  }

  Future suivantFunction(BuildContext context) async {
    isLoading.value = true;
    currentVacation = vacationController.getCurrentVacation;

    await GBSystem_AuthService(context)
        .getInfoVacationSuivant(VAC_IDF: currentVacation?.VAC_IDF)
        .then((value) {
      if (value != null) {
        vacationController.setVacationToRight = value;
        currentVacation = value;
        vacationController.setCurrentVacationVacation = currentVacation!;
        isLoading.value = false;
        // initVacationsPages();
      } else {
        isLoading.value = false;

        showWarningDialog(
          context,
          GbsSystemStrings.str_aucune_vacation_suiv,
        );
      }
    });
  }
}
