import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_salarie_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_sites_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_site_gestion_stock_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_Root_Params.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_toast.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_user_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/choose_mode_screen/choose_mode_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/entreprise_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystem_Login_controller extends GetxController {
  GBSystem_Login_controller({required this.formKey});
  GlobalKey<FormState> formKey;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  TextEditingController controllerAgence = TextEditingController();
  TextEditingController controllerCodeClient = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  RxBool passwordVisibility = false.obs;
  RxBool codeClientFieldVisibility = false.obs;
  RxBool loading = false.obs, addSiteWebBool = false.obs;
  RxInt numberTap = 0.obs;
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());

  final GBSystemSitesPlanningController sitePlanningController =
      Get.put(GBSystemSitesPlanningController());
  final GBSystemSalariePlanningController salariePlanningController =
      Get.put(GBSystemSalariePlanningController());
  final GBSystemAgenceQuickAccessController agencesController =
      Get.put(GBSystemAgenceQuickAccessController());
  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());
// --------------
  final GBSystemSiteGestionStockController siteGestionStockController =
      Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController =
      Get.put(GBSystemSalarieGestionStockController());
  @override
  void onInit() {
    if (agencesController.getLoginAgence != null) {
      controllerAgence.text =
          '${agencesController.getLoginAgence!.DOS_CODE} | ${agencesController.getLoginAgence!.DOS_LIB}';
    }

    super.onInit();
  }

  final FocusNode textFieldFocusNodeEmail = FocusNode();
  final FocusNode textFieldFocusNodePassword = FocusNode();

  void afficheNumberTap(int numberTap) {
    return showToast(
        text:
            "tu est tapez $numberTap fois , tapez 7 fois pour activer mode enregistrer serveur");
  }

  void incrimentNumber() {
    numberTap++;
  }

  Future<void> enregistrerServerFunction(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        loading.value = true;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs
            .setString(GbsSystemServerStrings.kSiteWeb, controllerEmail.text)
            .then((value) {
          if (controllerPassword.text.isNotEmpty) {
            prefs.setString(
                GbsSystemServerStrings.kS19, controllerPassword.text);
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
    } catch (e) {
      loading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "enregistrerServerFunction",
        page: "GBSystem_login_controller",
      );
    }
  }

  Future<void> loginFunction(BuildContext context) async {
    // loading.value = true;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.setString(GbsSystemServerStrings.kToken, "");
    // await preferences.setString(GbsSystemServerStrings.kCookies, "");
    // loading.value = false;

    if (formKey.currentState!.validate()) {
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
            await GBSystem_AuthService(context)
                .getInfoVacation()
                .then((listVacations) async {
              print("list vac : $listVacations");
              if (listVacations != null) {
                vacationController.setAllVacation = listVacations;
                vacationController.setCurrentVacationVacation =
                    listVacations[0];
              }
            });

            await GBSystem_AuthService(context)
                .getInfoSalarie()
                .then((infoSalarie) async {
              print("info sal : $infoSalarie");

              if (infoSalarie != null) {
                salarieController.setSalarie = infoSalarie.salarieModel;
                if (infoSalarie.imageSalarie != null) {
                  salarieController.setImage = infoSalarie.imageSalarie!;
                }
              }
              loading.value = false;
              if (salarieController.getSalarie != null) {
                if (Get.isSnackbarOpen) {
                  Get.closeAllSnackbars();
                }
                Get.off(ActiveApplication_Params.AfterConnexion_HomePage());
                // Get.off(GbsystemPinCodeScreen(
                //   destination:
                //       ActiveApplication_Params.AfterConnexion_HomePage(),
                //   isValideMode: false,
                // ));
                // Get.off(ActiveApplication_Params.AfterConnexion_HomePage());
              }
            });
          });
        } else {
          loading.value = false;
        }
      }).catchError((e) {
        loading.value = false;
        GBSystem_ManageCatchErrors().catchErrors(
          context,
          message: e.toString(),
          method: "loginFunction",
          page: "GBSystem_login_controller",
        );
      });
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  Future<void> loginFunctionPlanning(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (agencesController.getLoginAgence != null) {
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
              await GBSystem_AuthService(context)
                  .getAllEmployer()
                  .then((listEmployee) async {
                if (listEmployee != null && listEmployee.isNotEmpty) {
                  salariePlanningController.setCurrentSalarie = listEmployee[0];
                  salariePlanningController.setAllSalaries = listEmployee;
                }
              });

              await GBSystem_AuthService(context)
                  .getAllSites()
                  .then((allSites) async {
                if (allSites != null && allSites.isNotEmpty) {
                  sitePlanningController.setCurrentSite = allSites[0];
                  sitePlanningController.setAllSite = allSites;

                  await GBSystem_AuthService(context)
                      .getVacationPlanning(sitePlanningModel: allSites[0])
                      .then((vacations) {
                    if (vacations != null && vacations.isNotEmpty) {
                      vacationController.setAllVacation = vacations;
                      vacationController.setCurrentVacationVacation =
                          vacations[0];
                      // loading.value = false;
                      // Get.off(
                      //     ActiveApplication_Params.AfterConnexion_HomePage());
                    } else {
                      // loading.value = false;
                      // if (Get.isSnackbarOpen) {
                      //   Get.closeAllSnackbars();
                      // }
                      // Get.off(
                      //     ActiveApplication_Params.AfterConnexion_HomePage());
                    }
                  });
                }
              });
              loading.value = false;
              if (Get.isSnackbarOpen) {
                Get.closeAllSnackbars();
              }
              Get.off(ActiveApplication_Params.AfterConnexion_HomePage());
            });
          } else {
            loading.value = false;
          }
        }).catchError((e) {
          loading.value = false;
          GBSystem_ManageCatchErrors().catchErrors(
            context,
            message: e.toString(),
            method: "loginFunctionPlanning",
            page: "GBSystem_login_controller",
          );
        });
      } else {
        showWarningDialog(context, GbsSystemStrings.str_svp_choisi_agence);
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  Future<void> loginFunctionQuickAccess(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (agencesController.getLoginAgence != null) {
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
              await GBSystem_AuthService(context)
                  .getTypeQuestionnaireQuickAccess()
                  .then((typeQuestionnaire) async {
                if (typeQuestionnaire != null) {
                  evaluationSurSiteController.setAllTypeQuestionnaire =
                      typeQuestionnaire;
                  // evaluationSurSiteController.setSelectedTypeQuestionnaire =
                  //     typeQuestionnaire[0];
                }
              });
              await GBSystem_AuthService(context)
                  .getQuestionnaireQuickAccess()
                  .then((questionnaire) async {
                if (questionnaire != null) {
                  evaluationSurSiteController.setAllQuestionnaire =
                      questionnaire;
                }
              });

              await GBSystem_AuthService(context)
                  .getSiteQuickAccess()
                  .then((sites) async {
                if (sites != null) {
                  evaluationSurSiteController.setAllSites = sites;
                  loading.value = false;
                  // Get.off(GBSystemHomeQuickAccessScreen());
                  if (Get.isSnackbarOpen) {
                    Get.closeAllSnackbars();
                  }
                  Get.off(ChooseModeScreen());

                  // Get.off(GbsystemPinCodeScreen(
                  //   destination: ChooseModeScreen(),
                  //   isValideMode: false,
                  // ));

                  // Get.off(ChooseModeScreen());
                }
              });
            });
          } else {
            loading.value = false;
          }
        }).catchError((e) {
          loading.value = false;
          GBSystem_ManageCatchErrors().catchErrors(
            context,
            message: e.toString(),
            method: "loginFunctionQuickAccess",
            page: "GBSystem_login_controller",
          );
        });
      } else {
        showWarningDialog(context, GbsSystemStrings.str_svp_choisi_agence);
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  Future<void> loginFunctionGestionDeStock(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (agencesController.getLoginAgence != null) {
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
                  //   }
                  // });
                }
              });

              loading.value = false;
              if (Get.isSnackbarOpen) {
                Get.closeAllSnackbars();
              }

              // Get.off(GbsystemPinCodeScreen(
              //   destination: ActiveApplication_Params.AfterConnexion_HomePage(),
              //   isValideMode: false,
              // ));
              Get.off(ActiveApplication_Params.AfterConnexion_HomePage());
              // Get.off(GBSystemHomeGestionStockScreen());
            });
          } else {
            loading.value = false;
          }
        }).catchError((e) {
          loading.value = false;
          GBSystem_ManageCatchErrors().catchErrors(
            context,
            message: e.toString(),
            method: "loginFunctionQuickAccess",
            page: "GBSystem_login_controller",
          );
        });
      } else {
        showWarningDialog(context, GbsSystemStrings.str_svp_choisi_agence);
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  void changeModeFunction(BuildContext context) {
    if (numberTap.value < 7) {
      incrimentNumber();
      if (numberTap.value > 4) {
        afficheNumberTap(numberTap.value);
      }
    } else if (numberTap.value == 7) {
      dialogServerDetails();
      // addSiteWebBool.value = true;
      // autovalidateMode = AutovalidateMode.disabled;

      // showToast(text: GbsSystemStrings.str_mode_enregistrer_server_active);
    } else {
      dialogServerDetails();

      // addSiteWebBool.value = true;

      // showToast(text: GbsSystemStrings.str_mode_enregistrer_server_active);
    }
  }

  void dialogServerDetails() {
    Get.dialog(AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.info,
            color: GbsSystemServerStrings.str_primary_color,
          ),
          const SizedBox(
            width: 10,
          ),
          GBSystem_TextHelper().normalText(
              text: GbsSystemStrings.str_server_informations,
              textColor: GbsSystemServerStrings.str_primary_color),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GBSystem_TextHelper().smallText(
                text: "${GbsSystemStrings.str_url} : ",
                fontWeight: FontWeight.bold,
              ),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: GbsSystemServerStrings.kMyBaseUrlStandard,
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
                    text: GbsSystemServerStrings.kMyS19Standard.isNotEmpty
                        ? GbsSystemServerStrings.kMyS19Standard
                        : GbsSystemStrings.str_aucune_s19_utiliser,
                    maxLines: 10),
              ),
            ],
          ),
          // const SizedBox(
          //   width: 10,
          // ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              GbsSystemStrings.str_fermer,
              style: TextStyle(color: GbsSystemServerStrings.str_primary_color),
            ))
      ],
    ));
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

  void verifierExistUrlS19InitState() async {
    await SharedPreferences.getInstance().then((value) {
      print(
          "siiiiiiiiiiit :${value.getString(GbsSystemServerStrings.kSiteWeb)}");
      if (value.getString(GbsSystemServerStrings.kSiteWeb) != null &&
          value.getString(GbsSystemServerStrings.kSiteWeb)!.isNotEmpty) {
        codeClientFieldVisibility.value = false;
      } else {
        codeClientFieldVisibility.value = true;
      }
    });
  }
}
