import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/choose_mode_stock_screen/choose_mode_stock_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/home_add_article_screen/home_add_article_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/home_gestion_de_stock/GBSystem_home_gestion_stock_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_article/select_item_article_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/choose_mode_button_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../home_affectuer_articles_gestion_de_stock/GBSystem_home_affectuer_articles_gestion_stock_screen.dart';

class ChooseModeStockScreen extends StatefulWidget {
  const ChooseModeStockScreen({super.key, this.valideAuth = false});
  final bool valideAuth;
  @override
  State<ChooseModeStockScreen> createState() => _ChooseModeStockScreenState();
}

class _ChooseModeStockScreenState extends State<ChooseModeStockScreen> {
  int value = 0;

  final LocalAuthentication _localAuth = LocalAuthentication();
  String _authStatus = GbsSystemStrings.str_auth_please_authentificate.tr;
  bool authSuccess = false;

  // Check if device supports biometrics
  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    return canCheckBiometrics;
  }

  // Authenticate using biometrics
  Future<bool> _authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason:
            GbsSystemStrings.str_auth_please_authentificate_to_proceed.tr,
        options: AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _authStatus = authenticated
            ? GbsSystemStrings.str_auth_auth_success.tr
            : GbsSystemStrings.str_auth_auth_failed.tr;
      });
      authSuccess = authenticated;
      return authenticated;
    } catch (e) {
      setState(() {
        _authStatus =
            "${GbsSystemStrings.str_dialog_erreur.tr}: ${e.toString()}";
      });
      authSuccess = true;

      return false;
    }
  }

  Future<void> resultAuth() async {
    bool canAuthenticate = await _checkBiometrics();

    if (canAuthenticate) {
      // Loop until authentication succeeds
      if (!authSuccess) {
        await _authenticate();
        if (authSuccess) {
          // Authentication succeeded, print success message
          print("auth success -----");
        } else {
          exit(0);
        }
      }
    } else {
      setState(() {
        _authStatus = GbsSystemStrings.str_auth_biometrics_not_available.tr;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(GbsSystemStrings.str_auth_biometrics_not_available.tr),
            content:
                Text(GbsSystemStrings.str_device_dont_support_biometrics.tr),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  authSuccess = true;
                },
                child: Text(GbsSystemStrings.str_fermer.tr),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    if (widget.valideAuth) {
      resultAuth();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ChooseModeStockScreenController m =
        Get.put(ChooseModeStockScreenController(context: context));
    return WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Obx(
          () => Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  elevation: 4.0,
                  centerTitle: true,
                  leading: Container(),
                  shadowColor: Colors.grey.withOpacity(0.5),
                  toolbarHeight: 80,
                  backgroundColor: GbsSystemServerStrings.str_primary_color,
                  title: const Text(
                    GbsSystemStrings.str_selectioner_mode,
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    InkWell(
                        onTap: () async {
                          showWarningSnackBar(context,
                              GbsSystemStrings.str_deconnexion_question,
                              () async {
                            try {
                              await m.deconnexion();
                            } catch (e) {
                              m.isLoading.value = false;
                              GBSystem_ManageCatchErrors().catchErrors(
                                context,
                                message: e.toString(),
                                method: "deconnexion",
                                page: "GBSystem_home_quick_access_screen",
                              );
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                            size: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.08),
                          ),
                        )),
                  ],
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ChooseModeButtonWidget(
                          onTap: () async {
                            try {
                              m.viderPreviousData();
                              Get.to(HomeAddArticleScreen());
                            } catch (e) {
                              m.isLoading.value = false;
                              GBSystem_ManageCatchErrors().catchErrors(
                                context,
                                message: e.toString(),
                                method: "HomeAddArticleScreen",
                                page: "choose_mode_stock_screen",
                              );
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.add_circled_solid,
                            color: Colors.black,
                            size: 80,
                          ),
                          text: "${GbsSystemStrings.str_ajouter_articles}",
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ChooseModeButtonWidget(
                          onTap: () async {
                            try {
                              m.viderPreviousData();
                              m.viderDataAgenceSalarie();

                              // m.isLoading.value = true;
                              // await GBSystem_AuthService(context)
                              //     .getQuestionnaireQuickAccess()
                              //     .then((questionnaire) async {
                              //   m.isLoading.value = false;

                              //   if (questionnaire != null) {
                              //     m.evaluationSurSiteController
                              //         .setAllQuestionnaire = questionnaire;
                              //   }
                              // });
                              Get.to(GBSystemHomeGestionStockScreen());
                            } catch (e) {
                              m.isLoading.value = false;
                              GBSystem_ManageCatchErrors().catchErrors(
                                context,
                                message: e.toString(),
                                method: "GBSystemHomeGestionStockScreen",
                                page: "choose_mode_stock_screen",
                              );
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.bag_fill,
                            color: Colors.black,
                            size: 80,
                          ),
                          text: GbsSystemStrings.str_article_affectuer,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ChooseModeButtonWidget(
                          onTap: () async {
                            try {
                              m.viderPreviousData();
                              m.viderDataAgenceSalarie();
                              Get.to(
                                  GBSystemHomeAffectuerArticlesGestionStockScreen());
                            } catch (e) {
                              m.isLoading.value = false;
                              GBSystem_ManageCatchErrors().catchErrors(
                                context,
                                message: e.toString(),
                                method: "GBSystemHomeGestionStockScreen",
                                page: "choose_mode_stock_screen",
                              );
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.bag_fill_badge_plus,
                            color: Colors.black,
                            size: 80,
                          ),
                          text: GbsSystemStrings.str_affecter_article,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ChooseModeButtonWidget(
                          onTap: () async {
                            try {
                              m.viderPreviousData();

                              m.isLoading.value = true;
                              await GBSystem_AuthService(context)
                                  .getAllArticlesRef()
                                  .then((articlesRef) async {
                                m.isLoading.value = false;

                                if (articlesRef != null) {
                                  m.articlesController.setAllArticles =
                                      articlesRef;
                                }
                              });

                              Get.to(GBSystem_SelectItemArticleScreen());
                            } catch (e) {
                              m.isLoading.value = false;
                              GBSystem_ManageCatchErrors().catchErrors(
                                context,
                                message: e.toString(),
                                method: "GBSystem_SelectItemArticleScreen",
                                page: "choose_mode_stock_screen",
                              );
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.barcode,
                            color: Colors.black,
                            size: 80,
                          ),
                          text:
                              "${GbsSystemStrings.str_generation} ${GbsSystemStrings.str_qr_code} / ${GbsSystemStrings.str_bar_code}",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              m.isLoading.value ? Waiting() : Container()
            ],
          ),
        ));
  }
}
