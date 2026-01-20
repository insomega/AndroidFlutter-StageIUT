import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_LogEvent.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'GBSystem_sites_planning_controller.dart';
import 'GBSystem_vacation_controller.dart';

import 'GBSystem_site_planning_model.dart';
import 'choose_mode_planning_screen_controller.dart';
import 'GBSystem_home_planning_screen.dart';
import 'GBSystem_select_item_vacation_screen.dart';
import 'GBSystem_auth_service.dart';
import 'choose_mode_button_widget.dart';

import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class ChooseModePlanningScreen extends StatefulWidget {
  const ChooseModePlanningScreen({super.key, this.valideAuth = false});

  final bool valideAuth;
  @override
  State<ChooseModePlanningScreen> createState() => _ChooseModePlanningScreenState();
}

class _ChooseModePlanningScreenState extends State<ChooseModePlanningScreen> {
  int value = 0;
  void updateUI() {
    setState(() {});
  }

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
    final ChooseModePlanningScreenController m = Get.put(ChooseModePlanningScreenController(context: context));
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
                backgroundColor: GBSystem_Application_Strings.str_primary_color,
                title: const Text(
                  GBSystem_Application_Strings.str_selectioner_mode,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  InkWell(
                    onTap: () async {
                      showWarningSnackBar(
                        GBSystem_Application_Strings.str_deconnexion_question,
                        btnOkOnPress: () async {
                          try {
                            await m.deconnexion();
                          } catch (e) {
                            m.isLoading.value = false;
                            GBSystem_Add_LogEvent(message: e.toString(), method: "deconnexion", page: "GBSystem_home_quick_access_screen");
                          }
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.logout_outlined, color: Colors.white, size: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.08)),
                          GBSystem_TextHelper().superSmallText(text: GBSystem_Application_Strings.str_deconnecter, textColor: Colors.white),
                        ],
                      ),
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
                          final GBSystemSitesPlanningController sitePlanningController = Get.put(GBSystemSitesPlanningController());

                          try {
                            //vider previous vacations (all vacation) and get vacations of first site (initial vacations)
                            m.isLoading.value = true;

                            m.viderPreviousData();

                            // added
                            await GBSystem_AuthService(context).getAllEvenements().then((value) {
                              if (value != null) {
                                m.sitePlanningController.setAllEvenements = value;
                              }
                            });

                            await GBSystem_AuthService(context).getAllSites().then((allSites) async {
                              if (allSites != null && allSites.isNotEmpty) {
                                sitePlanningController.setAllSite = allSites;
                              }
                            });
                            // first end added

                            if (m.sitePlanningController.getCurrentSite != null) {
                              await GBSystem_AuthService(context).getVacationPlanning(sitePlanningModel: m.sitePlanningController.getCurrentSite!).then((vacations) {
                                if (vacations != null && vacations.isNotEmpty) {
                                  m.vacationController.setAllVacation = vacations;
                                  m.vacationController.setCurrentVacationVacation = vacations.first;
                                }
                              });
                            }
                            // lieu
                            m.addFilterSitesDependCurrentVacations();
                            //  end added

                            m.isLoading.value = false;

                            Get.to(GBSystemHomePlanningScreen());
                          } catch (e) {
                            m.isLoading.value = false;
                            GBSystem_Add_LogEvent(message: e.toString(), method: "getAllEvenements", page: "choose_mode_planning_screen");
                          }
                        },
                        icon: Icon(CupertinoIcons.bag_fill, color: Colors.black, size: 80),
                        text: "${GBSystem_Application_Strings.str_select_vacation}",
                      ),
                      SizedBox(height: 5),
                      ChooseModeButtonWidget(
                        onTap: () async {
                          try {
                            //vider previous vacations (initial vacations ) and get all vacations

                            m.viderPreviousData();
                            final GBSystemVacationController vacationController = Get.put(GBSystemVacationController());
                            final GBSystemSitesPlanningController sitePlanningController = Get.put(GBSystemSitesPlanningController());
                            m.isLoading.value = true;
                            await GBSystem_AuthService(context).getAllEvenements().then((value) {
                              if (value != null) {
                                m.sitePlanningController.setAllEvenements = value;
                                // vacationController.setFilterEvenementsBool =
                                //     true;
                                // vacationController.setAllFiltredEvenements =
                                //     value;
                              }
                            });
                            await GBSystem_AuthService(context).getAllSites().then((allSites) async {
                              if (allSites != null && allSites.isNotEmpty) {
                                sitePlanningController.setCurrentSite = allSites[0];
                                sitePlanningController.setAllSite = allSites;
                              }
                            });

                            await GBSystem_AuthService(context).getAllVacationPlanning(isGetAll: true, evenementList: m.sitePlanningController.getAllEvenements ?? [], searchText: null, sitePlanningList: sitePlanningController.getAllSites ?? []).then((vacations) async {
                              vacationController.setAllVacation = vacations;
                              print(vacations);
                            });

                            // lieu
                            List<String> list_LIE_IDF = (vacationController.getAllVacations ?? []).map((e) {
                              print("aavacation ${e.VAC_IDF} his lieu is : ${e.LIE_LIB} | ${e.LIE_IDF}");

                              return e.LIE_LIB;
                            }).toList();

                            list_LIE_IDF = list_LIE_IDF.toSet().toList();
                            print(list_LIE_IDF);

                            List<SitePlanningModel> allLieu = (sitePlanningController.getAllSites ?? [])
                                .where((element) {
                                  print("compare ${element.LIE_LIB}");
                                  return list_LIE_IDF.contains(element.LIE_LIB);
                                })
                                .toSet()
                                .toList();

                            vacationController.setAllLieu = allLieu;
                            m.isLoading.value = false;
                            Get.to(GBSystem_SelectItemVacationScreen(destination: ChooseModePlanningScreen(valideAuth: false), toListVacations: true));
                          } catch (e) {
                            m.isLoading.value = false;
                            print("error get vacs : $e");
                            GBSystem_Add_LogEvent(message: e.toString(), method: "getAllEvenements", page: "choose_mode_planning_screen");
                          }
                        },
                        icon: Icon(CupertinoIcons.bag_fill_badge_plus, color: Colors.black, size: 80),
                        text: GBSystem_Application_Strings.str_tout_vacation,
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
