import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_internet_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_planning_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_map_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/GBSystem_vacation_informations.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class UserEntrerSortieMapController extends GetxController {
  BuildContext context;
  UserEntrerSortieMapController({required this.context});
  final String pageName = "GBSystem_user_entrer_sortie_controller";

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
  final GBSystemVacationMapController vacationController =
      Get.put(GBSystemVacationMapController());
  final planningVacationController =
      Get.put<GBSystemPlanningVacationController>(
          GBSystemPlanningVacationController());

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
      isMapVacation: true,
    ));
  }

  Future precedentFunction(BuildContext context) async {
    isLoading.value = true;
    await GBSystem_AuthService(context)
        .getInfoVacationPrecedent(VAC_IDF: currentVacation!.VAC_IDF)
        .then((value) {
      if (value != null) {
        vacationController.setVacationToLeft = value;
        currentVacation = value;

        /// addedd
        vacationController.setCurrentVacationList = value;

        ///

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

  Future entrerFunction(
    BuildContext context, {
    String? nfc,
    String? nfcErr,
    String? qrCode,
    String? qrCodeErr,
    // new NFC
    bool? isNFCErrror,
    bool? isNFCNotSupported,
    bool? isPermissionNFCDenied,
    bool? isUserIgnoreNFC,
    String? messageErrNFC,
    // new QR
    bool? isQRErrror,
    bool? isUserIgnoreQR,
    String? messageErrQR,
  }) async {
    isLoading.value = true;
    await GBSystem_AuthService(context)
        .pointageEntrerSorie(
            // new
            isNFCErrror: isNFCErrror,
            isNFCNotSupported: isNFCNotSupported,
            isPermissionNFCDenied: isPermissionNFCDenied,
            isUserIgnoreNFC: isUserIgnoreNFC,
            messageErrNFC: messageErrNFC,
            //
            isQRErrror: isQRErrror,
            isUserIgnoreQR: isUserIgnoreQR,
            messageErrQR: messageErrQR,
            //

            ERR_NFC: nfcErr,
            ERR_QRCODE: qrCodeErr,
            QRCODE: qrCode,
            NFC: nfc,
            Sens: GbsSystemServerStrings.str_pointage_entrer_sens,
            vacation: currentVacation!)
        .then((infoEntrer) async {
      isLoading.value = false;
      if (infoEntrer != null) {
        VacationModel myVacation = infoEntrer;
        vacationController.setVacationEntrer = myVacation.PNTGS_START_HOUR_IN!;
        vacationController.setCurrentVacationVacation = myVacation;

        //Refresh vacation planning
        planningVacationController.setAllVacation = null;
        planningVacationController.setPrecBool = true;

        showSuccesDialog(
            context, GbsSystemStrings.str_pointage_entrer_succes.tr);
      }
      // else {
      //   isLoading.value = false;
      //   showErrorDialog(context, GbsSystemStrings.str_mal_tourner.tr);
      // }
    }).catchError((e) async {
      isLoading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(context,
          message: e.toString(), method: "entrerFunction", page: pageName);
    });
  }

  Future sortieFunction(
    BuildContext context, {
    String? nfc,
    String? nfcErr,
    String? qrCode,
    String? qrCodeErr,
    // new NFC
    bool? isNFCErrror,
    bool? isNFCNotSupported,
    bool? isPermissionNFCDenied,
    bool? isUserIgnoreNFC,
    String? messageErrNFC,
    // new QR
    bool? isQRErrror,
    bool? isUserIgnoreQR,
    String? messageErrQR,
  }) async {
    isLoading.value = true;
    await GBSystem_AuthService(context)
        .pointageEntrerSorie(
            // new
            isNFCErrror: isNFCErrror,
            isNFCNotSupported: isNFCNotSupported,
            isPermissionNFCDenied: isPermissionNFCDenied,
            isUserIgnoreNFC: isUserIgnoreNFC,
            messageErrNFC: messageErrNFC,
            //
            isQRErrror: isQRErrror,
            isUserIgnoreQR: isUserIgnoreQR,
            messageErrQR: messageErrQR,
            //

            ERR_NFC: nfcErr,
            ERR_QRCODE: qrCodeErr,
            QRCODE: qrCode,
            NFC: nfc,
            Sens: GbsSystemServerStrings.str_pointage_sortie_sens,
            vacation: currentVacation!)
        .then((infoSortie) async {
      isLoading.value = false;

      if (infoSortie != null) {
        VacationModel myVacation = infoSortie;
        vacationController.setVacationSortie = myVacation.PNTGS_START_HOUR_OUT!;
        vacationController.setCurrentVacationVacation = myVacation;
        //Refresh vacation planning
        planningVacationController.setAllVacation = null;
        planningVacationController.setPrecBool = true;

        showSuccesDialog(
            context, GbsSystemStrings.str_pointage_sortie_succes.tr);
      }
      // else {
      //   isLoading.value = false;
      //   showErrorDialog(context, GbsSystemStrings.str_mal_tourner.tr);
      // }
    }).catchError((e) async {
      isLoading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(context,
          message: e.toString(), method: "sortieFunction", page: pageName);
    });
  }

  Future suivantFunction(BuildContext context) async {
    isLoading.value = true;
    await GBSystem_AuthService(context)
        .getInfoVacationSuivant(VAC_IDF: currentVacation?.VAC_IDF)
        .then((value) {
      if (value != null) {
        vacationController.setVacationToRight = value;
        currentVacation = value;

        /// addedd
        vacationController.setCurrentVacationList = value;

        ///
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
