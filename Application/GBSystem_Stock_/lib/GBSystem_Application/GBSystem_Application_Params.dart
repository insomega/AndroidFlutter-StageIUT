import 'package:gbsystem_root/GBSystem_Root_Params.dart';
import 'package:gbsystem_root/GBSystem_Root_SplashStep.dart';
//import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'Routes/GBSystem_Application_Routes.dart';
import 'package:gbsystem_onboarding/GBSystem_Onboarding_splash_step.dart';
import 'package:gbsystem_connexion/gnsystem_Login_splash_step.dart';

//import 'package:gbsystem_root/GBSystem_UserConnexion_DataModel.dart';

class GBSystem_PS2_Application_Params extends GBSystem_Root_Application_Params {
  @override
  String get Title => "BMSoft Stock";
  @override
  String get CNX_APPLICATION => GBSystem_System_Strings.bmServer_gestion_stock;
  @override
  String get CNX_TYPE => GBSystem_System_Strings.CNX_TYPE_Planner;
  // @override
  // String get CNX_OKey => 'CACB4E292F3F44319D411C16184883A3';
  @override
  String get CNX_OKey_Login => "E2D6CD60D6D7449881986DB57B07CF85";
  @override
  String get CNX_OKey_Login_NFC => "DA24F46C47804B569A49364ECFFC3E54";
  @override
  String get CNX_USR_CODE => 'USR_CODE';
  @override
  String get CNX_USR_PASSWORD => 'USR_PASS';
  @override
  bool get CanChangePassword => false;
  @override
  bool get SelectUserDossier => true;

  @override
  // TODO: implement login
  String get loginRouteName => GBSystem_Application_Routes.login;

  @override
  // TODO: implement mainAppView
  String get mainAppView => GBSystem_Application_Routes.mainAppView;

  @override
  // TODO: implement mdp_change
  String get mdp_change => GBSystem_Application_Routes.mdp_change;

  @override
  // TODO: implement mdp_oublier
  String get mdp_oublier => GBSystem_Application_Routes.mdp_oublier;

  @override
  // TODO: implement steps
  List<GBSystem_Root_SplashStep> get splash_steps => [
    GBSystem_OnboardingStep(), //
    GBSystem_Login_SplashStep(), //
    // AuthStep(),
    //    DocumentStep(),
  ];

  @override
  bool get ReadingNfc_Identifacation => false;

  //@override
  // Map<String, String> get_ConnexionData(GBSystem_UserConnexion_DataModel userModel) {
  //   Map<String, String> Result = {
  //     //
  //     "OKey": CNX_OKey_Login,
  //     "CNX_TYPE": CNX_TYPE,
  //     "CNX_APPLICATION": CNX_APPLICATION,
  //     "SVR_CODE": userModel.email,
  //     "SVR_PASSWORD": userModel.password,
  //     "USR_LANGUE": "fr",
  //   };
  //   return Result;
  // }
}
