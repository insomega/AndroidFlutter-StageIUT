import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_Root_Params.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/ERROR/ERROR_SERVER/GBSystem_error_server_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/ERROR/NO_CONNECTION/GBSystem_no_connection_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/ERROR/SSO_ERROR/GBSystem_error_sso_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAIN_SCREEN/GBSystem_Main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/VALIDER_DOCUMENTS_SCREEN/GBSysetm_valider_documents_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/SPLASH_SCREENS/BOARDING_SCREEN/GBSystem_boarding_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/SPLASH_SCREENS/SPLASH_SCREEN/GBSystem_splash_screen_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class GBSystemSplashScreen extends StatelessWidget {
  const GBSystemSplashScreen(
      {super.key, this.toMainChat = false, this.toMainPlanning = false});
  final bool toMainChat, toMainPlanning;
  @override
  Widget build(BuildContext context) {
    final m = Get.put<GBSystemSplashController>(
        GBSystemSplashController(context: context));
    return FutureBuilder(
      future: m.loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashWidget();
        } else if (snapshot.hasError) {
          if (m.isConnected.value == false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.off(NoConnectionPage(
                destination: GBSystemSplashScreen(),
              ));
            });
          } else {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   Get.off(ActiveApplication_Params.MaterialApp_LoginPage());
            // });

            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.off(ErrorServerPage(destination: GBSystemSplashScreen()));
            });
          }

          return const SplashWidget();
        } else {
          if (m.isConnected.value == true) {
            if (m.isFirstTime?.value == true || m.isFirstTime?.value == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.off(GBSystem_BoardingScreen());
              });
            } else {
              if (m.isSignedIn?.value == true) {
                if (m.toValidDocs.value == true) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.off(GBSystemValiderDocumentsScreen(
                      valideAuth: true,
                    )
                        //   LocalAuthScreen(
                        //       destination: GBSystemValiderDocumentsScreen(
                        //     valideAuth: true,
                        //   )),
                        );
                    // Get.off(GbsystemPinCodeScreen(
                    //     isValideMode: m.toValidPIN.value ? true : false,
                    //     destination: GBSystemValiderDocumentsScreen()));
                    // // Get.off(GBSystemValiderDocumentsScreen());
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    toMainChat
                        ? Get.off(GBSystemMainScreen(
                            valideAuth: true,
                            selectedIndexNavBar: 3,
                            selectedIndexPopup: 3,
                          ))
                        : toMainPlanning
                            ? Get.off(GBSystemMainScreen(
                                valideAuth: true,
                                selectedIndexNavBar: 1,
                                selectedIndexPopup: 0,
                              ))
                            : Get.off(
                                // LocalAuthScreen(
                                //   destination: GBSystemMainScreen(
                                //   valideAuth: true,
                                // )
                                //     //  ActiveApplication_Params
                                //     //     .AfterConnexion_HomePage()
                                //     ),
                                GBSystemMainScreen(
                                valideAuth: true,
                              ));
                    //     Get.off(GbsystemPinCodeScreen(
                    //         isValideMode: m.toValidPIN.value ? true : false,
                    //         destination: ActiveApplication_Params
                    //             .AfterConnexion_HomePage()));
                    // // Get.off(ActiveApplication_Params.AfterConnexion_HomePage());
                  });
                }
              } else {
                if (m.isSSO.value) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.off(ErrorSSOPage());
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.off(ActiveApplication_Params.MaterialApp_LoginPage());
                  });
                }
              }
            }
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.off(
                  NoConnectionPage(destination: const GBSystemSplashScreen()));
            });
          }

          return const SplashWidget();
        }
      },
    );
  }
}

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: GbsSystemStrings.str_primary_color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    GbsSystemServerStrings.str_logo_image_path,
                    color: Colors.white,
                    width: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.2),
                    height: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.2),
                  ),
                  Transform.translate(
                      offset: const Offset(5, -17),
                      child: GBSystem_TextHelper().normalText(
                        text: ActiveApplication_Params.Title,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                  LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
