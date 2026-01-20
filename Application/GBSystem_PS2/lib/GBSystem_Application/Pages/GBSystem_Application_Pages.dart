import 'package:bmsoft_ps2/GBSystem_Application/GBSystem_MainForm_PS2_View.dart';
//import 'package:gbsystem_authentification_2fa/gbsystem_authentification_2fa_Controller.dart';

//import 'package:bmsoft_ps2/GBSystem_Application/GBSystem_select_item_vacation_screen.dart';
import 'package:get/get.dart';

// import '../views/dashboard_view.dart';
// import '../bindings/dashboard_binding.dart';

// import '../../GBSystem_Login/GBSystem_Login_View.dart';
// import '../../GBSystem_Login/GBSystem_MDP_Oublier_View.dart';
// import '../../GBSystem_Login/GBSystem_MDP_Change_View.dart';

// import '../../GBSystem_Login/GBSystem_Login_Binding.dart';

// import '../../GBSystem_Onboarding/GBSystem_Onboarding_View.dart';
// import '../../GBSystem_Onboarding/GBSystem_Onboarding_Binding.dart';

import 'package:gbsystem_connexion/GBSystem_Login_Binding.dart';
import 'package:gbsystem_connexion/GBSystem_Login_View.dart';
import 'package:gbsystem_connexion/GBSystem_Login_MDP_Change_View.dart';
import 'package:gbsystem_connexion/GBSystem_Login_MDP_Oublier_View.dart';
import 'package:gbsystem_onboarding/GBSystem_Onboarding_Binding.dart';
import 'package:gbsystem_onboarding/GBSystem_Onboarding_View.dart';
import 'package:gbsystem_splash_screen/gbsystem_splash_binding.dart';
import 'package:gbsystem_splash_screen/gbsystem_splash_view.dart';
import 'package:gbsystem_splash_screen/gbsystem_splash_controller.dart';
// import '../GBSystem_MainForm_PS1_Bindng.dart';
// import '../GBSystem_MainForm_PS2_View.dart';
import '../Routes/GBSystem_Application_Routes.dart';
//import '../App_Main_Controller.dart';

class GBSystem_Application_Pages {
  static final pages = [
    GetPage(name: GBSystem_Application_Routes.onboarding, page: () => GBSystem_Onboarding_View(), binding: GBSystem_Onboarding_Binding()),
    GetPage(name: GBSystem_Application_Routes.login, page: () => GBSystem_Login_View(), binding: LoginBinding()),
    GetPage(name: GBSystem_Application_Routes.mdp_oublier, page: () => GBSystem_MDP_Oublier_View(), binding: GBSystem_Mdp_OublierBinding()),
    GetPage(name: GBSystem_Application_Routes.mdp_change, page: () => GBSystem_MDP_Change_View(), binding: GBSystem_Mdp_ChangeBinding()),
    //GetPage(name: GBSystem_Application_Routes.mainAppView, page: () => GBSystem_Vacation_List_PS2_Wigget()), // binding: GBSystemHomePlanningController()),
    GetPage(name: GBSystem_SplashController.routeName, page: () => GBSystem_SplashView(), binding: GBSystem_splash_binding()),
    GetPage(name: GBSystem_Application_Routes.mainAppView, page: () => GBSystem_MainForm_PS2_View()), //, binding: GBSystem_MainForm_PS1_Binding()),
    //  GetPage(name: GBSystem_Application_Routes.Twofa_setup, page: () => GBSystem_AuthenticatorController()),
    //    GetPage(name: GBSystem_Application_Routes.Twofa_verify, page: () => GBSystem_AuthenticatorController()),
  ];
}
