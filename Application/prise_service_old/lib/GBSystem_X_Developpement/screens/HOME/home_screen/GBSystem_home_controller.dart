import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_connection_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_vacation_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_local_database_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystem_Home_Controller extends GetxController {
  BuildContext context;
  GBSystem_Home_Controller(this.context);
  SalarieModel? salarie;
  String? imageSalarie;
  RxBool loading = RxBool(false);
  VacationModel? vacation, vacationPrec, vacationSuiv;
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
  var subscription;

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    // ///Connectivity
    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   // GBSystemConnectionSnackBar().afficherSnackBarConnection(result);
    //   GBSystemConnectionSnackBar().afficherSnackBarConnection(
    //       connectivityResult: result,
    //       whenConnextionReturn: () async {
    //         bool isActionOfflineExists =
    //             (await LocalDatabaseService().getAllStoredRequests() as List)
    //                 .isNotEmpty;
    //         if (isActionOfflineExists) {
    //           Get.defaultDialog(
    //             title: "Actions Offline",
    //             middleText:
    //                 "Vous avez quelque action en stockage local , vous veuillez les lancer maintenant ?",
    //             textCancel: "Non",
    //             textConfirm: "Oui",
    //             onConfirm: () async {
    //               print("conf");
    //             },
    //             onCancel: () async {
    //               print("cancel");
    //             },
    //           );
    //         }
    //       });
    // });
////
    salarie = salarieController.getSalarie;
    imageSalarie = salarieController.getImage;
    vacation = vacationController.getAllVacations?[0];
    super.onInit();
  }

  Future deconnexion() async {
    loading.value = true;
    final GBSystemAgenceQuickAccessController agencesController =
        Get.put(GBSystemAgenceQuickAccessController());
    agencesController.setLoginAgence = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(GbsSystemServerStrings.kToken, "");
    await preferences.setString(GbsSystemServerStrings.kCookies, "");
    loading.value = false;
    Get.offAll(GBSystemLoginScreen());
  }
}
