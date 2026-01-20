import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/home_screen/GBSystem_home_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/APP_BAR_WIDGETS/GBSystem_custom_app_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_button_entrer_sortie.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_user_entrer_sortie.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_user_welcome.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class GBSystem_Home_Screen extends StatefulWidget {
  GBSystem_Home_Screen({super.key, this.valideAuth = false});
  final bool valideAuth;
  @override
  State<GBSystem_Home_Screen> createState() => _GBSystem_Home_ScreenState();
}

class _GBSystem_Home_ScreenState extends State<GBSystem_Home_Screen> {
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
    final m =
        Get.put<GBSystem_Home_Controller>(GBSystem_Home_Controller(context));
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
                appBar: GBSystemCustomAppBar(
                    onDeconnexionTap: () async {
                      showWarningSnackBar(
                          context, GbsSystemStrings.str_deconnexion_question,
                          () async {
                        try {
                          await m.deconnexion();
                        } catch (e) {
                          m.loading.value = false;
                          GBSystem_ManageCatchErrors().catchErrors(
                            context,
                            message: e.toString(),
                            method: "deconnexion",
                            page: "GBSystem_home_quick_access_screen",
                          );
                        }
                      });
                    },
                    imageSalarie: m.imageSalarie,
                    salarie: m.salarie!),
                resizeToAvoidBottomInset: false,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                          context,
                          0.025,
                        ),
                        vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                            context, 0.02)),
                    child: Column(
                      children: [
                        //pavé information du salarié
                        UserWelcome(
                            imageBase: m.imageSalarie!, salarie: m.salarie!),
                        //pavé information de la vacation
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical:
                                GBSystem_ScreenHelper.screenHeightPercentage(
                                    context, 0.02),
                          ),
                          child: UserEnterSortie(
                            isUpdatePause: true,
                            desconnectAfterSuccess: true,
                            afficherPrecSuiv: true,
                            afficherOpertaionsBar: true,
                          ),
                        ),

                        Visibility(
                          visible: false,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              // horizontal:
                              //     GBSystem_ScreenHelper.screenWidthPercentage(
                              //         context, 0.05),
                              vertical:
                                  GBSystem_ScreenHelper.screenHeightPercentage(
                                      context, 0.01),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ButtonEntrerSortieWithIconAndText(
                                    shadowBool: true,
                                    onTap: () async {
                                      showWarningSnackBar(
                                          context,
                                          GbsSystemStrings
                                              .str_deconnexion_question,
                                          () async {
                                        Get.back();
                                        await m.deconnexion();
                                      });
                                    },
                                    verPadd: GBSystem_ScreenHelper
                                        .screenHeightPercentage(context, 0.01),
                                    horPadd: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.02),
                                    icon: const Icon(
                                      Icons.logout_rounded,
                                      color: Colors.white,
                                    ),
                                    text: GbsSystemStrings.str_deconnecter,
                                    color: GbsSystemServerStrings
                                        .str_primary_color,
                                    number: null),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            m.loading.value ? Waiting() : Container()
          ],
        ),
      ),
    );
  }
}
