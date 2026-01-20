import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_internet_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_location_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/GBSystem_vacation_informations.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class VacationStateDisplayDataControllerController extends GetxController {
  BuildContext context;
  VacationStateDisplayDataControllerController({required this.context});
  final String pageName = "vacation_state_demander_display_data_controller";

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
      isMapVacation: false,
    ));
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future precedentFunction(BuildContext context) async {
    isLoading.value = true;
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
          GbsSystemStrings.str_aucune_vacation_prec.tr,
        );
      }
    });
  }

  Future entrerFunction(BuildContext context) async {
    isLoading.value = true;

    Position? currentPosition = await LocationService().determinePosition();
    if (currentPosition != null) {
      await GBSystem_AuthService(context)
          .pointageEntrerSorie(
              Sens: GbsSystemServerStrings.str_pointage_entrer_sens,
              vacation: currentVacation!)
          .then((infoEntrer) async {
        if (infoEntrer != null) {
          VacationModel myVacation = infoEntrer;
          vacationController.setVacationEntrer =
              myVacation.PNTGS_START_HOUR_IN!;
          vacationController.setCurrentVacationVacation = myVacation;
          isLoading.value = false;
          showSuccesDialog(
              context, GbsSystemStrings.str_pointage_entrer_succes.tr);
        } else {
          isLoading.value = false;
          showErrorDialog(context, GbsSystemStrings.str_mal_tourner.tr);
        }
      }).catchError((e) async {
        isLoading.value = false;
        GBSystem_ManageCatchErrors().catchErrors(context,
            message: e.toString(), method: "entrerFunction", page: pageName);
      });
    } else {
      isLoading.value = false;
      showErrorDialog(context, GbsSystemStrings.str_location_denied.tr);
    }
  }

  Future sortieFunction(BuildContext context) async {
    isLoading.value = true;

    Position? currentPosition = await LocationService().determinePosition();

    if (currentPosition != null) {
      await GBSystem_AuthService(context)
          .pointageEntrerSorie(
              Sens: GbsSystemServerStrings.str_pointage_sortie_sens,
              vacation: currentVacation!)
          .then((infoSortie) async {
        if (infoSortie != null) {
          VacationModel myVacation = infoSortie;
          vacationController.setVacationSortie =
              myVacation.PNTGS_START_HOUR_OUT!;
          vacationController.setCurrentVacationVacation = myVacation;
          isLoading.value = false;
          showSuccesDialog(
              context, GbsSystemStrings.str_pointage_sortie_succes.tr);
        } else {
          isLoading.value = false;
          showErrorDialog(context, GbsSystemStrings.str_mal_tourner.tr);
        }
      }).catchError((e) async {
        isLoading.value = false;
        GBSystem_ManageCatchErrors().catchErrors(context,
            message: e.toString(),
            method: "pointageEntrerSorie",
            page: pageName);
      });
    } else {
      isLoading.value = false;
      showErrorDialog(context, GbsSystemStrings.str_location_denied.tr);
    }
  }

  Future suivantFunction(BuildContext context) async {
    isLoading.value = true;
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
          GbsSystemStrings.str_aucune_vacation_suiv.tr,
        );
      }
    });
  }
}
