// import 'package:gbsystem_root/GBSystem_UserConnexion_DataModel.dart';
import 'GBSystem_Root_SplashStep.dart';

abstract class GBSystem_Root_Application_Params {
  String get Title;

  String get CNX_APPLICATION;
  String get CNX_TYPE;
  // String get CNX_OKey;
  String get CNX_OKey_Login;
  String get CNX_OKey_Login_NFC;
  String get CNX_USR_CODE;
  String get CNX_USR_PASSWORD;

  String get mainAppView;
  String get mdp_change;
  String get mdp_oublier;
  String get loginRouteName;

  bool get CanChangePassword;
  bool get SelectUserDossier;
  bool get ReadingNfc_Identifacation;

  List<GBSystem_Root_SplashStep> get splash_steps; // Déclaration du getter générique

  // Map<String, String> get_ConnexionData(GBSystem_UserConnexion_DataModel userModel);
}

class GBSystem_Application_Params_Manager {
  static late final GBSystem_Root_Application_Params _instance;

  static void initialize(GBSystem_Root_Application_Params config) {
    _instance = config;
  }

  static GBSystem_Root_Application_Params get instance => _instance;
}
