import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_error_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_map_token_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_nombre_notifications_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_valider_document_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_toast.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_user_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAIN_SCREEN/GBSystem_Main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/VALIDER_DOCUMENTS_SCREEN/GBSysetm_valider_documents_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/entreprise_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/firebase_serivce.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/topic_manager.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class GBSystem_Login_controller extends GetxController {
  RxString selectedLanguage = RxString("fr");
  TextEditingController controllerCodeClient = TextEditingController();

  TextEditingController controllerEmail = TextEditingController();

  TextEditingController controllerPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  RxBool passwordVisibility = false.obs;
  RxBool codeClientFieldVisibility = false.obs;
  RxBool canAuth = false.obs;

  RxBool loading = false.obs, addSiteWebBool = false.obs;
  RxInt numberTap = 0.obs;
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
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

  final FocusNode textFieldFocusNodeEmail = FocusNode();
  final FocusNode textFieldFocusNodePassword = FocusNode();

  @override
  void onInit() async {
    selectedLanguage.value = getLocaleApplication();
    // codeClientFieldVisibility.value = await verifierExistUrlS19();
    super.onInit();
  }

  bool validateCodeClient(
    BuildContext context,
    String? data,
  ) {
    if (data == null || data.isEmpty) {
      showErrorDialog(
          context, GbsSystemStrings.str_validat_svp_enter_code_client.tr);
      return false;
    } else if (!EntrepriseService().checkExisteClient(agenceCode: data)) {
      showErrorDialog(
          context, GbsSystemStrings.str_validat_svp_code_entreprise_invalid.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> verifierExistUrlS19() async {
    bool verifier = false;
    await SharedPreferences.getInstance().then((value) {
      print(
          "siiiiiiiiiiit :${value.getString(GbsSystemServerStrings.kSiteWeb)}");
      if (value.getString(GbsSystemServerStrings.kSiteWeb) != null &&
          value.getString(GbsSystemServerStrings.kSiteWeb)!.isNotEmpty) {
        verifier = true;
      } else {
        verifier = false;
      }
    });
    return verifier;
  }

  void verifierExistUrlS19InitState() async {
    await SharedPreferences.getInstance().then((value) {
      print(
          "siiiiiiiiiiit :${value.getString(GbsSystemServerStrings.kSiteWeb)}");
      if (value.getString(GbsSystemServerStrings.kSiteWeb) != null &&
          value.getString(GbsSystemServerStrings.kSiteWeb)!.isNotEmpty) {
        codeClientFieldVisibility.value = false;
        canAuth.value = true;
      } else {
        codeClientFieldVisibility.value = true;
        canAuth.value = false;
      }
    });
  }

  Future<String?> getSharedPerfermenceLocalString() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    String? localeString =
        await prefs2.getString(GbsSystemServerStrings.kLocale);
    if (localeString != null) {
      return localeString;
    } else {
      return null;
    }
  }

  Future<String> getCurrentLocale() async {
    String? usedLocale = await getSharedPerfermenceLocalString();
    if (usedLocale != null) {
      print("looococ $usedLocale");
      return usedLocale;
    } else {
      List<String> myLocales = ["fr", "en", "de", "es", "el", "pt", "ro", "tr"];
      if (myLocales.contains(ui.window.locale.toString().substring(0, 2))) {
        return ui.window.locale.toString().substring(0, 2);
      } else {
        return "fr";
      }
    }
  }

  void dialogServerDetails({
    required List<String> topics,
    required String? url,
    required String? s19,
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
                text: "${GbsSystemStrings.str_site} : ",
                fontWeight: FontWeight.bold,
              ),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: url != null && url.isNotEmpty
                        ? url
                        : GbsSystemStrings.str_aucune_site_utiliser,
                    // GbsSystemServerStrings.kMyBaseUrlStandard,
                    maxLines: 5),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GBSystem_TextHelper().smallText(
                text: "${GbsSystemStrings.str_s19} : ",
                fontWeight: FontWeight.bold,
              ),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: s19 != null && s19.isNotEmpty
                        ? s19
                        : GbsSystemStrings.str_aucune_s19_utiliser,
                    //  GbsSystemServerStrings.kMyS19Standard.isNotEmpty
                    //     ? GbsSystemServerStrings.kMyS19Standard
                    //     : GbsSystemStrings.str_aucune_s19_utiliser,
                    maxLines: 10),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GBSystem_TextHelper().smallText(
                text: "${GbsSystemStrings.str_topic} : ",
                fontWeight: FontWeight.bold,
              ),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: topics.isNotEmpty
                        ? topics.join(",")
                        : GbsSystemStrings.str_aucune_topic_utiliser,
                    maxLines: 10),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              GbsSystemStrings.str_fermer,
              style: TextStyle(color: GbsSystemStrings.str_primary_color),
            ))
      ],
    ));
  }

  String getLocaleApplication() {
    List<String> myLocales = ["fr", "en", "de", "es", "gr", "pt", "ro", "tr"];
    if (myLocales.contains(Get.locale?.languageCode)) {
      return Get.locale?.languageCode ?? "fr";
    } else {
      return "fr";
    }
  }

  void afficheNumberTap(int numberTap) {
    return showToast(
        text:
            "${GbsSystemStrings.str_appyier.tr} ${7 - numberTap + 1} ${GbsSystemStrings.str_fois_pour_activer_mode.tr}");
  }

  void incrimentNumber() {
    numberTap++;
  }

  Future<void> enregistrerServerFunction(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      loading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs
          .setString(GbsSystemServerStrings.kSiteWeb, controllerEmail.text)
          .then((value) {
        if (controllerPassword.text.isNotEmpty) {
          prefs.setString(GbsSystemServerStrings.kS19, controllerPassword.text);
        }
        loading.value = false;
        addSiteWebBool.value = false;
        numberTap.value = 0;
        controllerEmail.clear();
        controllerPassword.clear();
        autovalidateMode = AutovalidateMode.disabled;

        showSuccesDialog(
            context,
            controllerPassword.text.isNotEmpty
                ? GbsSystemStrings.str_site_s19_changed
                : GbsSystemStrings.str_site_changed);
      });
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  Future<void> loginFunction(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        bool verifier = await verifierExistUrlS19();

        if (verifier) {
          loading.value = true;
          await GBSystem_AuthService(context)
              .loginUser(
            userModel: UserModel(
                email: controllerEmail.text, password: controllerPassword.text),
          )
              .then((value) async {
            if (value.data["Wid"] != null &&
                value.data["Wid"].toString().isNotEmpty) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  GbsSystemServerStrings.kToken, value.data["Wid"]);
              await prefs
                  .setString(GbsSystemServerStrings.kCookies, value.cookies!)
                  .then((value) async {
                // Firebase Messaging Token
                FirebaseSerivce(context).getToken();

                await GBSystem_AuthService(context)
                    .getInfoSalarie()
                    .then((infoSalarie) async {
                  if (infoSalarie != null) {
                    salarieController.setSalarie = infoSalarie;

                    //boubaker 14/04/2025
                    await FirebaseSerivce(context)
                        .subscribeTopicsAndDisubscribeOld();

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

                    //vider previous code pin if exist to make sur there is new code pin
                    // await prefs.setString(GbsSystemServerStrings.kPINCode, "");
                    // loading.value = false;

                    // not sso
                    await prefs.setBool(GbsSystemServerStrings.kSSO, false);

                    if (Get.isSnackbarOpen) {
                      try {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Get.closeAllSnackbars();
                        });
                      } catch (e) {
                        GBSystem_ManageCatchErrors().catchErrors(
                          context,
                          message: e.toString(),
                          method: "closeAllSnackbars",
                          page: "GBSystem_login_controller",
                        );
                      }
                    }

                    // Get.off(GbsystemPinCodeScreen(
                    //   destination: GBSystemMainScreen(),
                    //   isValideMode: false,
                    // ));

                    Get.off(GBSystemMainScreen());
                  } else {
                    //vider previous code pin if exist to make sur there is new code pin
                    // await prefs.setString(GbsSystemServerStrings.kPINCode, "");
                    // loading.value = false;
                    // not sso
                    await prefs.setBool(GbsSystemServerStrings.kSSO, false);

                    if (Get.isSnackbarOpen) {
                      Get.closeAllSnackbars();
                    }

                    if (errorController.getCurrentError?.code == "0605") {
                      Get.off(GBSystemValiderDocumentsScreen());
                      // Get.off(GbsystemPinCodeScreen(
                      //   destination: GBSystemValiderDocumentsScreen(),
                      //   isValideMode: false,
                      // ));
                    }
                  }
                });
              });
            } else {
              loading.value = false;
            }
          });
        } else {
          showErrorDialog(context, GbsSystemStrings.str_saisie_code_client.tr);
        }
      } else {
        autovalidateMode = AutovalidateMode.always;
      }
    } catch (e) {
      loading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(context,
          message: e.toString(),
          method: "loginFunction",
          page: "GBSystem_login_controller");
    }
  }

  void changeModeFunction(BuildContext context) async {
    if (numberTap.value < 7) {
      incrimentNumber();
      if (numberTap.value > 4) {
        afficheNumberTap(numberTap.value);
      }
    } else if (numberTap.value == 7) {
      // addSiteWebBool.value = true;
      // autovalidateMode = AutovalidateMode.disabled;
      List<String> listTopics = await TopicManager().getSubscribedTopics();
      String? url, s19;
      await SharedPreferences.getInstance().then((value) {
        s19 = value.getString(GbsSystemServerStrings.kS19);
        url = value.getString(GbsSystemServerStrings.kSiteWeb);
      });
      dialogServerDetails(
        topics: listTopics,
        url: url,
        s19: s19,
      );

      // showToast(text: GbsSystemStrings.str_mode_enregistrer_server_active.tr);
    } else {
      // addSiteWebBool.value = true;
      List<String> listTopics = await TopicManager().getSubscribedTopics();
      String? url, s19;
      await SharedPreferences.getInstance().then((value) {
        s19 = value.getString(GbsSystemServerStrings.kS19);
        url = value.getString(GbsSystemServerStrings.kSiteWeb);
      });
      dialogServerDetails(
        topics: listTopics,
        url: url,
        s19: s19,
      );

      // showToast(text: GbsSystemStrings.str_mode_enregistrer_server_active.tr);
    }
  }

  void changeModeFunction_URL_S19(BuildContext context) {
    if (numberTap.value < 7) {
      incrimentNumber();
      if (numberTap.value > 4) {
        afficheNumberTap(numberTap.value);
      }
    } else if (numberTap.value == 7) {
      addSiteWebBool.value = true;
      autovalidateMode = AutovalidateMode.disabled;
      // dialogServerDetails();

      showToast(text: GbsSystemStrings.str_mode_enregistrer_server_active.tr);
    } else {
      addSiteWebBool.value = true;
      // dialogServerDetails();

      showToast(text: GbsSystemStrings.str_mode_enregistrer_server_active.tr);
    }
  }

  Future<void> changeSharedPerfermenceLocal(String newLocal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(GbsSystemServerStrings.kLocale, newLocal);
  }
}
