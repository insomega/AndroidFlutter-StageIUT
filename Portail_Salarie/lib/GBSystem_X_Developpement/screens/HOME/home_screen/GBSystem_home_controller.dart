import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_error_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_historique_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_map_token_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_nombre_notifications_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_historique_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/HISTORIQUE_SCREEN/GBSystem_historique_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/VALIDER_DOCUMENTS_SCREEN/GBSysetm_valider_documents_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/firebase_serivce.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystem_Home_Controller extends GetxController {
  GBSystemSalarieWithPhotoModel? salarie;
  RxBool isloading = RxBool(false);
  RxBool markerLocationVisibility = RxBool(false);
  RxBool markerUserVisibility = RxBool(false);

  // LatLng? myPosition;
  Rx<LatLng?> myPosition = Rx<LatLng?>(null);
  Rx<int?> nombreVacation = Rx<int?>(null);
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());

  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
  final GBSystemHistoriqueController historiqueController =
      Get.put(GBSystemHistoriqueController());

  final GBSystemMapTokenController tokenController =
      Get.put(GBSystemMapTokenController());
  final notificationController =
      Get.put<GBSystemNotificationController>(GBSystemNotificationController());
  final errorController =
      Get.put<GBSystemErrorController>(GBSystemErrorController());

  @override
  void onInit() {
    nombreVacation = vacationController.getNumberVacationProposer;
    salarie = salarieController.getSalarie;
    myPosition.value = initPositionMap();
    super.onInit();
  }

  Future<void> fetchDataHome(BuildContext context) async {
    try {
      await GBSystem_AuthService(context)
          .getInfoSalarie()
          .then((infoSalarie) async {
        if (infoSalarie != null) {
          salarieController.setSalarie = infoSalarie;

          //boubaker 14/04/2025
          await FirebaseSerivce(context).subscribeTopicsAndDisubscribeOld();
          await GBSystem_AuthService(context)
              .getVacationsHome()
              .then((vacationsHome) async {
            print("vacation : $vacationsHome");
            if (vacationsHome != null && vacationsHome.isNotEmpty) {
              vacationController.setAllVacation = vacationsHome;
              vacationController.setCurrentVacationVacation =
                  vacationsHome.first;
            }
          });
          await GBSystem_AuthService(context)
              .getNombreNotiChat()
              .then((nbrNoti) async {
            if (nbrNoti != null) {
              notificationController.setNbrNoti = nbrNoti;
            }
          });
          await GBSystem_AuthService(context)
              .getNombreVacationProposer()
              .then((nbrVac) async {
            if (nbrVac != null) {
              vacationController.setNumberVacationsProposer = nbrVac;
            }
          });
        } else {
          if (errorController.getCurrentError?.code == "0605") {
            Get.off(GBSystemValiderDocumentsScreen());
          }
        }
      });
    } catch (e) {
      GBSystem_ManageCatchErrors().catchErrors(context,
          message: e.toString(),
          method: "fetchDataHome",
          page: "GBSystem_home_controller");
    }
  }

  void dialogMapDetails({
    required String? mapToken,
  }) {
    Get.dialog(AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.info,
            color: GbsSystemStrings.str_primary_color,
          ),
          const SizedBox(
            width: 10,
          ),
          GBSystem_TextHelper().normalText(
              text: GbsSystemStrings.str_server_informations,
              textColor: GbsSystemStrings.str_primary_color),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GBSystem_TextHelper().smallText(
                text: "map token : ",
                fontWeight: FontWeight.bold,
              ),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: mapToken ?? "",
                    // GbsSystemServerStrings.kMyBaseUrlStandard,
                    maxLines: 5),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              GbsSystemStrings.str_fermer.tr,
              style: TextStyle(color: GbsSystemStrings.str_primary_color),
            ))
      ],
    ));
  }

  Future deconnexion() async {
    isloading.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(GbsSystemServerStrings.kToken, "");
    await preferences.setString(GbsSystemServerStrings.kCookies, "");
    isloading.value = false;
    Get.off(GBSystemLoginScreen());
  }

  Future getHistorique(BuildContext context) async {
    isloading.value = true;
    await GBSystem_AuthService(context).getListHistorique().then((value) async {
      isloading.value = false;
      // if (value != null && value.isNotEmpty) {
      // print("val $value");
      historiqueController.setAllHistorique = value;
      // print("controller : ${historiqueController.getAllHistoriques}");
      Get.to(GBSystemHistoriqueScreen());
      // await showDialogCompteurInfoSimple(
      //     context: context, historiqueModel: value.first);
      // }
      // else {
      //   showErrorDialog(context, GbsSystemStrings.str_empty_data.tr);
      // }
    });
  }

  LatLng? initPositionMap() {
    if ((vacationController.getCurrentVacation?.LIE_LATITUDE != null &&
            vacationController.getCurrentVacation!.LIE_LATITUDE.isNotEmpty) &&
        (vacationController.getCurrentVacation?.LIE_LONGITUDE != null &&
            vacationController.getCurrentVacation!.LIE_LONGITUDE.isNotEmpty)) {
      final myPosition = LatLng(
          double.parse(vacationController.getCurrentVacation!.LIE_LATITUDE
              .replaceAll(",", ".")),
          double.parse(vacationController.getCurrentVacation!.LIE_LONGITUDE
              .replaceAll(",", ".")));
      return myPosition;
    } else if ((salarieController.getSalarie?.salarieModel.SVR_LATITUDE !=
                null &&
            salarieController
                .getSalarie!.salarieModel.SVR_LATITUDE.isNotEmpty) &&
        (salarieController.getSalarie?.salarieModel.SVR_LONGITUDE != null &&
            salarieController
                .getSalarie!.salarieModel.SVR_LONGITUDE.isNotEmpty)) {
      final myPosition = LatLng(
          double.parse(salarieController.getSalarie!.salarieModel.SVR_LATITUDE
              .replaceAll(",", ".")),
          double.parse(salarieController.getSalarie!.salarieModel.SVR_LONGITUDE
              .replaceAll(",", ".")));
      return myPosition;
    } else {
      return null;
    }
  }

  void dialogSeasirEntrprise() {
    Get.dialog(AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.info,
            color: GbsSystemStrings.str_primary_color,
          ),
          const SizedBox(
            width: 10,
          ),
          GBSystem_TextHelper().normalText(
              text: GbsSystemStrings.str_saisie_code_client.tr,
              textColor: Colors.black),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [CustomTextField(text: GbsSystemStrings.str_code_client.tr)],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              GbsSystemStrings.str_fermer.tr,
              style: TextStyle(color: Colors.black54),
            )),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              GbsSystemStrings.str_ok.tr,
              style: TextStyle(color: GbsSystemStrings.str_primary_color),
            ))
      ],
    ));
  }

  void dialogToken() {
    Get.dialog(AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.info,
            color: GbsSystemStrings.str_primary_color,
          ),
          const SizedBox(
            width: 10,
          ),
          GBSystem_TextHelper().normalText(
              text: "Map Informations",
              textColor: GbsSystemStrings.str_primary_color),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GBSystem_TextHelper().smallText(
                text: "token map : ",
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Flexible(
            child: GBSystem_TextHelper().smallText(
                text: salarieController.getSalarie!.mapToken!, maxLines: 5),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              GbsSystemStrings.str_fermer.tr,
              style: TextStyle(color: GbsSystemStrings.str_primary_color),
            ))
      ],
    ));
  }

  Future<void> showDialogCompteurInfoSimple(
      {required BuildContext context,
      required HistoriqueModel historiqueModel}) async {
    // Capture the context before it's disposed
    BuildContext dialogContext = context;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: dialogContext,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              backgroundColor:
                  GbsSystemStrings.str_primary_color.withOpacity(0.85),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("DATE_VU :  ${historiqueModel.DATE_VU}"),
                  Text("PLATPH_ETAT :  ${historiqueModel.PLATPH_ETAT}"),
                  Text(
                      "SVRHIST_ACTION_D :  ${historiqueModel.SVRHIST_ACTION_D}"),
                  Text(
                      "SVRHIST_ACTION_F :  ${historiqueModel.SVRHIST_ACTION_F}"),
                  Text("SVRHIST_DATE :  ${historiqueModel.SVRHIST_DATE}"),
                  Text("TPH_TYPE :  ${historiqueModel.TPH_TYPE}"),
                ],
              ),
              actions: [],
            ),
          );
        },
      );
    });
  }
}
