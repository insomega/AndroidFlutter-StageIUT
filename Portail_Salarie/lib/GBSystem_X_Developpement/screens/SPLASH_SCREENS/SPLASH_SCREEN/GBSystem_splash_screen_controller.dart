import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_error_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_internet_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_map_token_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_nombre_notifications_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_valider_document_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/firebase_serivce.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class GBSystemSplashController extends GetxController {
  RxBool? isFirstTime;
  RxBool? isSignedIn;
  RxString? token, previousSiteWeb;
  RxString? cookies;
  RxBool isConnected = false.obs,
      toValidDocs = false.obs,
      toValidPIN = false.obs,
      isSSO = false.obs;
  GBSystemSplashController({required this.context});
  BuildContext context;
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
  final GBSystemInternatController internatController =
      Get.put(GBSystemInternatController());
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());
  final GBSystemMapTokenController tokenController =
      Get.put(GBSystemMapTokenController());
  final validerDocumentsController = Get.put<GBSystemValiderDocumentController>(
      GBSystemValiderDocumentController());
  final errorController =
      Get.put<GBSystemErrorController>(GBSystemErrorController());
  final notificationController =
      Get.put<GBSystemNotificationController>(GBSystemNotificationController());

  loadData() async {
    // Firebase initialisation
    FirebaseSerivce(context).initNotifications().then(
      (value) {
        print("init noti finished ");
      },
    );

    await internatController.initConnectivity().then((value) {
      isConnected = RxBool(internatController.isConnected);
    });

    await SharedPreferences.getInstance().then((value) {
      value.getBool(GbsSystemServerStrings.kIsFirstTime) != null
          ? isFirstTime =
              RxBool(value.getBool(GbsSystemServerStrings.kIsFirstTime)!)
          : null;

      value.getBool(GbsSystemServerStrings.kSSO) != null
          ? isSSO = RxBool(value.getBool(GbsSystemServerStrings.kSSO)!)
          : null;
      value.getString(GbsSystemServerStrings.kToken) != null &&
              value.getString(GbsSystemServerStrings.kToken)!.isNotEmpty
          ? token = RxString(value.getString(GbsSystemServerStrings.kToken)!)
          : null;
      value.getString(GbsSystemServerStrings.kCookies) != null &&
              value.getString(GbsSystemServerStrings.kToken)!.isNotEmpty
          ? cookies =
              RxString(value.getString(GbsSystemServerStrings.kCookies)!)
          : null;
      isSignedIn = ((token?.value != null && cookies?.value != null)
          ? RxBool(true)
          : RxBool(false));
      value.getString(GbsSystemServerStrings.kSiteWeb) != null
          ? previousSiteWeb =
              RxString(value.getString(GbsSystemServerStrings.kSiteWeb)!)
          : null;
      value.getString(GbsSystemServerStrings.kPINCode) != null &&
              value.getString(GbsSystemServerStrings.kPINCode)!.isNotEmpty
          ? toValidPIN = RxBool(true)
          : RxBool(false);
    });
    print("isFirstTime $isFirstTime");
    print("token $token");
    print("cookies $cookies");
    print("isSignedIn $isSignedIn");
    print("previousSiteWeb $previousSiteWeb");
    print("toValidPIN $toValidPIN");

    //set new value of url (after getting previousSiteWeb with previous value)
    // await changePerfermencesURL(
    //     newSite: GbsSystemServerStrings.kMyBaseUrlStandard);
    //vider previous data (wid cookies) if change app url
    // if (previousSiteWeb != GbsSystemServerStrings.kMyBaseUrlStandard) {
    // await viderSharedPerfermences();
    //   isFirstTime = RxBool(true);
    //   isSignedIn = RxBool(false);
    //   print("issss ${isSignedIn?.value}");
    // }
    // initialise locale
    // await updateSharedPerfermenceLocal();

    if (isSignedIn?.value == true && isConnected.value == true) {
      // load other data next time
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
            print("info salarie  : ${infoSalarie}");

            if (vacationsHome != null) {
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
            print("nbr vac   : ${nbrVac}");

            if (nbrVac != null) {
              vacationController.setNumberVacationsProposer = nbrVac;
            } else {
              isSignedIn = RxBool(false);
            }
          });
        } else {
          if (errorController.getCurrentError?.code == "0605") {
            toValidDocs = RxBool(true);
          } else {
            isSignedIn = RxBool(false);
          }
        }
      });

      // await GBSystem_AuthService(context)
      //     .getValiderDocuments()
      //     .then((validerDocs) async {
      //   print("avlide doc  : ${validerDocs}");
      //   if (validerDocs != null) {
      //     if (validerDocs.listVacations != null &&
      //         validerDocs.listVacations!.isNotEmpty) {
      //       validerDocumentsController.setCurrentVacationVacation =
      //           validerDocs.listVacations!.first;
      //     }
      //     validerDocumentsController.setCurrentValiderDocument = validerDocs;
      //     // if there is docs or publications go to valide docs else go to home
      //     if ((validerDocs.listDocuments != null &&
      //             validerDocs.listDocuments!.isNotEmpty) ||
      //         (validerDocs.listPublications != null &&
      //             validerDocs.listPublications!.isNotEmpty)) {
      //       toValidDocs = RxBool(true);
      //     }
      //   }
      // });
      // if (toValidDocs.value != true) {
      //   await GBSystem_AuthService(context)
      //       .getInfoSalarie()
      //       .then((infoSalarie) async {
      //     if (infoSalarie != null) {
      //       salarieController.setSalarie = infoSalarie;
      //       await GBSystem_AuthService(context)
      //           .getVacationsHome()
      //           .then((vacationsHome) async {
      //         print("info salarie  : ${infoSalarie}");

      //         if (vacationsHome != null) {
      //           vacationController.setAllVacation = vacationsHome;
      //           vacationController.setCurrentVacationVacation =
      //               vacationsHome.first;
      //         }
      //       });

      //       await GBSystem_AuthService(context)
      //           .getNombreVacationProposer()
      //           .then((nbrVac) async {
      //         print("nbr vac   : ${nbrVac}");

      //         if (nbrVac != null) {
      //           vacationController.setNumberVacationsProposer = nbrVac;
      //         } else {
      //           isSignedIn = RxBool(false);
      //         }
      //       });
      //     } else {
      //       isSignedIn = RxBool(false);
      //     }
      //   });
      // } else {
      //   showErrorDialog(
      //       context, GbsSystemStrings.str_att_vos_devez_valider_docs.tr);
      // }
    }
  }

  viderSharedPerfermences() async {
    await SharedPreferences.getInstance().then((value) {
      value.setBool(GbsSystemServerStrings.kIsFirstTime, true);
      value.setString(GbsSystemServerStrings.kToken, "");
      value.setString(GbsSystemServerStrings.kCookies, "");
    });
  }

  Future<Locale?> getSharedPerfermenceLocal() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    String? localeString =
        await prefs2.getString(GbsSystemServerStrings.kLocale);
    if (localeString != null) {
      return Locale(localeString);
    } else {
      return null;
    }
  }

  Future<void> updateSharedPerfermenceLocal() async {
    Locale? usedLocale = await getSharedPerfermenceLocal();
    if (usedLocale != null) {
      Get.updateLocale(usedLocale);
    }
  }

  changePerfermencesURL({required String newSite}) async {
    await SharedPreferences.getInstance().then((value) {
      value.setString(GbsSystemServerStrings.kSiteWeb, newSite);
    });
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
}
