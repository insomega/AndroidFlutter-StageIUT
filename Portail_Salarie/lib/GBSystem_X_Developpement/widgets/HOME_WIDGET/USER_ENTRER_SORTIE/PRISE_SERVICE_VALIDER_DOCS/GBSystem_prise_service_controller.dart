import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_internet_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_planning_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_valider_document_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/PRISE_SERVICE_VALIDER_DOCS/GBSystem_vacation_informations_valide_docs.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class PriseServiceController extends GetxController {
  BuildContext context;
  PriseServiceController({required this.context});
  final String pageName = "GBSystem_prise_service_controller";
  final PageController pageController = PageController(initialPage: 0);
  RxBool isLoading = RxBool(false);
  RxDouble currentIndex = RxDouble(0);
  List<VacationInformationsValideDocs> vacationPages = [];
  VacationModel? currentVacation;
  List<VacationModel>? listVacations = [];

  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
  final GBSystemInternatController internatController =
      Get.put(GBSystemInternatController());
  final GBSystemValiderDocumentController validerDocsController =
      Get.put(GBSystemValiderDocumentController());
  final planningVacationController =
      Get.put<GBSystemPlanningVacationController>(
          GBSystemPlanningVacationController());

  @override
  void onInit() {
    if (validerDocsController.getCurrentVacation != null) {
      currentVacation = validerDocsController.getCurrentVacation;
    }

    initVacationsPages();
    pageController.addListener(() {
      currentIndex = RxDouble(pageController.page!);
    });
    super.onInit();
  }

  void initVacationsPages() {
    vacationPages.add(VacationInformationsValideDocs());
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
        validerDocsController.AddVacationToLeft = value;
        currentVacation = value;
        validerDocsController.setCurrentVacationVacation = value;

        isLoading.value = false;
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
        validerDocsController.setVacationEntrer =
            myVacation.PNTGS_START_HOUR_IN!;
        validerDocsController.setCurrentVacationVacation = myVacation;
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
        validerDocsController.setVacationSortie =
            myVacation.PNTGS_START_HOUR_OUT!;
        validerDocsController.setCurrentVacationVacation = myVacation;
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
    });
  }

  // Future entrerFunction(BuildContext context) async {
  //   isLoading.value = true;

  //   // Position? currentPosition = await LocationService().determinePosition();
  //   // if (currentPosition != null) {
  //   await GBSystem_AuthService(context)
  //           .pointageEntrerSorie(
  //               Sens: GbsSystemServerStrings.str_pointage_entrer_sens,
  //               vacation: currentVacation!)
  //           .then((infoEntrer) async {
  //     if (infoEntrer != null) {
  //       VacationModel myVacation = infoEntrer;
  //       validerDocsController.setVacationEntrer =
  //           myVacation.PNTGS_START_HOUR_IN!;
  //       validerDocsController.setCurrentVacationVacation = myVacation;

  //       isLoading.value = false;

  //       showSuccesDialog(
  //           context, GbsSystemStrings.str_pointage_entrer_succes.tr);
  //       return true;
  //     } else {
  //       isLoading.value = false;
  //       showErrorDialog(context, GbsSystemStrings.str_mal_tourner.tr);
  //     }
  //   })
  //       // .catchError((e) async {
  //       //   isLoading.value = false;
  //       //   GBSystem_ManageCatchErrors().catchErrors(GBSystem_Home_Screen());
  //       // })
  //       ;
  //   // } else {
  //   //   isLoading.value = false;
  //   //   showErrorDialog(context, GbsSystemStrings.str_location_denied.tr);
  //   // }
  // }

  // Future sortieFunction(BuildContext context) async {
  //   isLoading.value = true;

  //   // Position? currentPosition = await LocationService().determinePosition();

  //   // if (currentPosition != null) {
  //   await GBSystem_AuthService(context)
  //       .pointageEntrerSorie(
  //           Sens: GbsSystemServerStrings.str_pointage_sortie_sens,
  //           vacation: currentVacation!)
  //       .then((infoSortie) async {
  //     if (infoSortie != null) {
  //       VacationModel myVacation = infoSortie;
  //       validerDocsController.setVacationSortie =
  //           myVacation.PNTGS_START_HOUR_OUT!;
  //       validerDocsController.setCurrentVacationVacation = myVacation;
  //       isLoading.value = false;
  //       showSuccesDialog(
  //           context, GbsSystemStrings.str_pointage_sortie_succes.tr);
  //       return true;
  //     } else {
  //       isLoading.value = false;
  //       showErrorDialog(context, GbsSystemStrings.str_mal_tourner.tr);
  //     }
  //   }).catchError((e) async {
  //     isLoading.value = false;
  //     GBSystem_ManageCatchErrors().catchErrors(context,
  //         message: e.toString(), method: "sortieFunction", page: pageName);
  //   });
  //   // } else {
  //   //   isLoading.value = false;
  //   //   showErrorDialog(context, GbsSystemStrings.str_location_denied.tr);
  //   // }
  // }

  Future suivantFunction(BuildContext context) async {
    isLoading.value = true;
    await GBSystem_AuthService(context)
        .getInfoVacationSuivant(VAC_IDF: currentVacation?.VAC_IDF)
        .then((value) {
      if (value != null) {
        validerDocsController.AddVacationToRight = value;
        currentVacation = value;
        validerDocsController.setCurrentVacationVacation = currentVacation!;
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
