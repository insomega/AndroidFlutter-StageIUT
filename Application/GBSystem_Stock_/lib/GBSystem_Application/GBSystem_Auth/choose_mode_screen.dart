import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_LogEvent.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

import 'choose_mode_screen_controller.dart';
import 'home_couserie_screen.dart';
import 'GBSystem_home_quick_access_screen.dart';
import 'GBSystem_list_evaluation_non_terminer_screen.dart';
import 'GBSystem_auth_service.dart';
import 'choose_mode_button_widget.dart';

import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({super.key, this.valideAuth = false});
  final bool valideAuth;
  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  String _authStatus = GBSystem_Application_Strings.str_auth_please_authentificate.tr;
  bool authSuccess = false;

  // Check if device supports biometrics
  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    return canCheckBiometrics;
  }

  // Authenticate using biometrics
  Future<bool> _authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(localizedReason: GBSystem_Application_Strings.str_auth_please_authentificate_to_proceed.tr, options: AuthenticationOptions(useErrorDialogs: true, stickyAuth: true));
      setState(() {
        _authStatus = authenticated ? GBSystem_Application_Strings.str_auth_auth_success.tr : GBSystem_Application_Strings.str_auth_auth_failed.tr;
      });
      authSuccess = authenticated;
      return authenticated;
    } catch (e) {
      setState(() {
        _authStatus = "${GBSystem_Application_Strings.str_dialog_erreur.tr}: ${e.toString()}";
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
        _authStatus = GBSystem_Application_Strings.str_auth_biometrics_not_available.tr;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(GBSystem_Application_Strings.str_auth_biometrics_not_available.tr),
            content: Text(GBSystem_Application_Strings.str_device_dont_support_biometrics.tr),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  authSuccess = true;
                },
                child: Text(GBSystem_Application_Strings.str_fermer.tr),
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
    final ChooseModeScreenController m = Get.put(ChooseModeScreenController(context: context));
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
                title: const Text(GBSystem_Application_Strings.str_selectioner_mode, style: TextStyle(color: Colors.white)),
                actions: [
                  InkWell(
                    onTap: () async {
                      showWarningSnackBar(context, GBSystem_Application_Strings.str_deconnexion_question, () async {
                        try {
                          await m.deconnexion();
                        } catch (e) {
                          m.isLoading.value = false;
                          GBSystem_Add_LogEvent(message: e.toString(), method: "deconnexion", page: "GBSystem_home_quick_access_screen");
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.logout_outlined, color: Colors.white, size: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.08)),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ChooseModeButtonWidget(
                        onTap: () async {
                          try {
                            m.viderPreviousData();
                            m.evaluationSurSiteController.setSelectedTypeQuestionnaire = null;

                            m.isLoading.value = true;
                            await GBSystem_AuthService(context).getQuestionnaireQuickAccess().then((questionnaire) async {
                              m.isLoading.value = false;

                              if (questionnaire != null) {
                                m.evaluationSurSiteController.setAllQuestionnaire = questionnaire;
                              }
                            });
                            Get.to(GBSystemHomeQuickAccessScreen());
                          } catch (e) {
                            m.isLoading.value = false;
                            GBSystem_Add_LogEvent(message: e.toString(), method: "getQuestionnaireQuickAccess", page: "choose_mode_screen");
                          }
                        },
                        icon: Icon(CupertinoIcons.doc_chart_fill, color: Colors.black, size: 80),
                        text: GBSystem_Application_Strings.str_evaluation_sur_site,
                      ),
                      SizedBox(height: 5),
                      ChooseModeButtonWidget(
                        onTap: () async {
                          try {
                            m.viderPreviousData();
                            m.isLoading.value = true;
                            await GBSystem_AuthService(context).getQuestionnaireCauserie(dateDebut: DateTime(DateTime.now().year, DateTime.now().month, 1)).then((value) {
                              m.isLoading.value = false;
                              // final GBSystemEvaluationSurSiteController
                              //     evaluationSurSiteController =
                              //     Get.put(GBSystemEvaluationSurSiteController());
                              m.evaluationSurSiteController.setAllQuestionnaire = value ?? [];
                              if ((m.evaluationSurSiteController.getAllQuestionnaires ?? []).isNotEmpty && (m.evaluationSurSiteController.getAllQuestionnaires ?? []).length == 1) {
                                m.evaluationSurSiteController.setSelectedQuestionnaire = (m.evaluationSurSiteController.getAllQuestionnaires ?? []).first;
                              }
                            });

                            Get.to(HomeCouserieScreen());
                          } catch (e) {
                            m.isLoading.value = false;
                            GBSystem_Add_LogEvent(message: e.toString(), method: "HomeCouserieScreen", page: "choose_mode_screen");
                          }
                        },
                        icon: Icon(Icons.person, color: Colors.black, size: 80),
                        text: "${GBSystem_Application_Strings.str_salaries_evaluation} (${GBSystem_Application_Strings.str_causerie})",
                      ),
                      const SizedBox(height: 5),
                      ChooseModeButtonWidget(
                        onTap: () async {
                          try {
                            m.viderPreviousData();

                            m.isLoading.value = true;
                            await GBSystem_AuthService(context).getListEvaluationEnCours().then((evals) async {
                              m.isLoading.value = false;

                              if (evals != null) {
                                m.evaluationEnCoursController.setAllEval = evals;
                                //init type quest
                                m.evaluationSurSiteController.setSelectedTypeQuestionnaire = (m.evaluationSurSiteController.getAllTypeQuestionnaires ?? []).firstWhere((element) => element.LIEINSQUESTYP_IDF == "1");
                              }
                            });
                            Get.to(GbsystemListEvaluationNonTerminerScreen());
                          } catch (e) {
                            m.isLoading.value = false;
                            GBSystem_Add_LogEvent(message: e.toString(), method: "getQuestionnaireQuickAccess", page: "choose_mode_screen");
                          }
                        },
                        icon: Stack(
                          children: [
                            Icon(CupertinoIcons.doc_chart_fill, color: Colors.black, size: 80),
                            Positioned(top: 0, right: 0, child: Icon(CupertinoIcons.clock_fill, color: Colors.black, size: 20)),
                          ],
                        ),
                        text: GBSystem_Application_Strings.str_evaluations_encours,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            m.isLoading.value ? Waiting() : Container(),
          ],
        ),
      ),
    );
  }
}
