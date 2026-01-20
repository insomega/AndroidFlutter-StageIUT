import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_Root_Params.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/ERROR/ERROR_SERVER/GBSystem_error_server_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/ERROR/NO_CONNECTION/GBSystem_no_connection_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/choose_mode_planning_screen/choose_mode_planning_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/choose_mode_screen/choose_mode_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/choose_mode_stock_screen/choose_mode_stock_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/home_screen/GBSystem_home_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/SPLASH_SCREENS/boarding_screen/GBSystem_boarding_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/SPLASH_SCREENS/splash_screen/GBSystem_splash_controller.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GBSystemSplashScreen extends StatelessWidget {
  const GBSystemSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final m = Get.put<GBSystemSplashController>(
        GBSystemSplashController(context: context));
    return FutureBuilder(
      future: ActiveApplication_Params.appNumber == 1
          ? m.loadData()
          : ActiveApplication_Params.appNumber == 2
              ? m.loadDataPlanning()
              : ActiveApplication_Params.appNumber == 3
                  ? m.loadDataQuickAcces()
                  : m.loadDataGestionDeStock(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashWidget();
        } else if (snapshot.hasError) {
          if (m.isConnected.value == false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.off(
                  NoConnectionPage(destination: const GBSystemSplashScreen()));
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
              print('isSignedIn : ${m.isSignedIn?.value}');
              if (m.isSignedIn?.value == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (ActiveApplication_Params.appNumber == 1) {
                    Get.off(GBSystem_Home_Screen(
                      valideAuth: true,
                    ));
                  } else if (ActiveApplication_Params.appNumber == 2) {
                    Get.off(ChooseModePlanningScreen(
                      valideAuth: true,
                    ));
                  } else if (ActiveApplication_Params.appNumber == 3) {
                    Get.off(ChooseModeScreen(
                      valideAuth: true,
                    ));
                  } else {
                    Get.off(ChooseModeStockScreen(
                      valideAuth: true,
                    ));
                  }
                  // Get.off(ActiveApplication_Params.AfterConnexion_HomePage(
                  //     authValide: true));
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.off(ActiveApplication_Params.MaterialApp_LoginPage());
                });
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                //   Get.off(GBSystemQCMScreen());
                // });
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
          color: GbsSystemServerStrings.str_primary_color,
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
                    size: 30,
                  ),
                  // Transform.translate(
                  //   offset: const Offset(0, -10),
                  //   child: LoadingAnimationWidget.flickr(
                  //     leftDotColor: Colors.white,
                  //     rightDotColor: Colors.amber,
                  //     size: 30,
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
