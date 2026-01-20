import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_user_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/choose_mode_planning_screen/choose_mode_planning_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/choose_mode_screen/choose_mode_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/choose_mode_stock_screen/choose_mode_stock_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/home_screen/GBSystem_home_screen.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

//boubaker 13/05/2025 For Build APK #PS1 #PS2 Update this
var KApplication_Active =
    int.parse(const String.fromEnvironment('APP_NUMBER', defaultValue: "4"));
const KAA_BMPriseService = 1;
GBSystem_Root_Application_Params ActiveApplication_Params =
    get_Root_Application_Params();

abstract class GBSystem_Root_Application_Params {
  GBSystem_Root_Application_Params();
  String Title = '';
  String CNX_APPLICATION = '';
  String CNX_TYPE = '';
  String CNX_OKey = '';
  String CNX_OKey_Login = '';

  int appNumber = 1;
  Widget MaterialApp_LoginPage();
  Widget AfterConnexion_HomePage();
  Map<String, String> get_ConnexionData(UserModel userModel, String? Key_S19);
  String get_Application_Name_Entreprise();
}

class GBSystem_BMPriseService_V1_Application_Params
    extends GBSystem_Root_Application_Params {
  GBSystem_BMPriseService_V1_Application_Params() {
    this.Title = GbsSystemStrings.str_app_name;
    this.CNX_TYPE = GbsSystemServerStrings.CNX_TYPE_Server;
    this.CNX_APPLICATION = GbsSystemServerStrings.bmServer_PriseService;
    this.CNX_OKey = 'CACB4E292F3F44319D411C16184883A3';
    this.CNX_OKey_Login = '38DE973EC4ED455AAD1E12E8E2593481';
    this.appNumber = 1;
  }
  @override
  String get_Application_Name_Entreprise() {
    return CNX_APPLICATION;
  }

  @override
  Widget MaterialApp_LoginPage() {
    return GBSystemLoginScreen();
  }

  @override
  Widget AfterConnexion_HomePage() {
    return GBSystem_Home_Screen();
  }

  @override
  Map<String, String> get_ConnexionData(UserModel userModel, String? Key_S19) {
    Map<String, String> Result = {
      "OKey": CNX_OKey_Login,
      "CNX_TYPE":
          CNX_TYPE, // GBSys_System_Strings.CNX_TYPE_Server, // "server",
      "CNX_APPLICATION":
          CNX_APPLICATION, //GBSys_System_Strings.bmServer_PriseService, //"BMServer-MBLN-PS",
      "SVR_CODE": userModel.email,
      "SVR_PASSWORD": userModel.password,
      "USR_LANGUE": "fr",
      //"s19": 'myS19',
    };
    Key_S19 == '' && Key_S19 == null ? Result : Result["s19"] = Key_S19!;

    return Result;
  }
}

class GBSystem_BMPriseService_V2_Application_Params
    extends GBSystem_Root_Application_Params {
  final GBSystemAgenceQuickAccessController agencesController =
      Get.put(GBSystemAgenceQuickAccessController());
  GBSystem_BMPriseService_V2_Application_Params() {
    this.Title = GbsSystemStrings.str_app2_name;
    this.CNX_TYPE = GbsSystemServerStrings.CNX_TYPE_Planner;
    this.CNX_APPLICATION = GbsSystemServerStrings.bmPlanning_PriseService;
    this.CNX_OKey = 'E2D6CD60D6D7449881986DB57B07CF85';
    this.CNX_OKey_Login = 'E2D6CD60D6D7449881986DB57B07CF85';
    this.appNumber = 2;
  }
  @override
  String get_Application_Name_Entreprise() {
    return CNX_APPLICATION;
  }

  @override
  Widget MaterialApp_LoginPage() {
    return GBSystemLoginScreen();
  }

  @override
  Widget AfterConnexion_HomePage() {
    return ChooseModePlanningScreen();
    // return GBSystemHomePlanningScreen();
  }

  @override
  Map<String, String> get_ConnexionData(UserModel userModel, String? Key_S19) {
    // prefs.setString(GbsSystemServerStrings.kDOS_CODE, selectedAgence.DOS_CODE);

    Map<String, String> Result = {
      "OKey": CNX_OKey_Login,
      "CNX_TYPE":
          CNX_TYPE, // GBSys_System_Strings.CNX_TYPE_Server, // "server",
      "CNX_APPLICATION":
          CNX_APPLICATION, //GBSys_System_Strings.bmServer_PriseService, //"BMServer-MBLN-PS",
      "USR_CODE": userModel.email,
      "USR_PASS": userModel.password,
      // "DOS_CODE": "BM-MOBILE",
      "DOS_CODE": agencesController.getLoginAgence?.DOS_CODE ?? "BM-MOBILE",
      "USR_LANGUE": "fr",
      //"s19": 'myS19',
    };
    Key_S19 == '' && Key_S19 == null ? Result : Result["s19"] = Key_S19!;

    return Result;
  }
}

class GBSystem_BMPriseService_V3_Application_Params
    extends GBSystem_Root_Application_Params {
  final GBSystemAgenceQuickAccessController agencesController =
      Get.put(GBSystemAgenceQuickAccessController());
  GBSystem_BMPriseService_V3_Application_Params() {
    this.Title = GbsSystemStrings.str_app3_name;
    this.CNX_TYPE = GbsSystemServerStrings.CNX_TYPE_Planner;
    this.CNX_APPLICATION = GbsSystemServerStrings.quick_Access_PriseService;
    this.CNX_OKey = 'E2D6CD60D6D7449881986DB57B07CF85';
    this.CNX_OKey_Login = 'E2D6CD60D6D7449881986DB57B07CF85';

    // this.CNX_OKey_Login = '38DE973EC4ED455AAD1E12E8E2593481';
    this.appNumber = 3;
  }
  @override
  String get_Application_Name_Entreprise() {
    return CNX_APPLICATION;
  }

  @override
  Widget MaterialApp_LoginPage() {
    return GBSystemLoginScreen();
  }

  @override
  Widget AfterConnexion_HomePage() {
    return ChooseModeScreen();
    // return GBSystemHomeQuickAccessScreen();
  }

  @override
  Map<String, String> get_ConnexionData(UserModel userModel, String? Key_S19) {
    Map<String, String> Result = {
      "OKey": CNX_OKey_Login,
      "CNX_TYPE":
          CNX_TYPE, // GBSys_System_Strings.CNX_TYPE_Server, // "planner",
      "CNX_APPLICATION":
          CNX_APPLICATION, //GBSys_System_Strings.bmServer_PriseService, //"BMServer-MBLN-PS",
      "USR_CODE": userModel.email,
      "USR_PASS": userModel.password,
      "DOS_CODE": agencesController.getCurrentAgence?.DOS_CODE ?? "0001",
      "USR_LANGUE": "fr",
      // "S19":
      //     "B61DB9F8475147E8BB9FA4884D82B358F6C612CF6CDB45FBADEDE7EE7C4D891EB88E79894DC94224B65BB94C06AFE4B626095DF3024541AE8ACABDDFD6173765"
    };
    Key_S19 == '' || Key_S19 == null ? Result : Result["s19"] = Key_S19;

    return Result;
  }
}

class GBSystem_BMPriseService_V4_Application_Params
    extends GBSystem_Root_Application_Params {
  final GBSystemAgenceQuickAccessController agencesController =
      Get.put(GBSystemAgenceQuickAccessController());
  GBSystem_BMPriseService_V4_Application_Params() {
    this.Title = GbsSystemStrings.str_app4_name;
    this.CNX_TYPE = GbsSystemServerStrings.CNX_TYPE_Planner;
    this.CNX_APPLICATION = GbsSystemServerStrings.bmPlanning_PriseService;
    this.CNX_OKey = 'E2D6CD60D6D7449881986DB57B07CF85';
    this.CNX_OKey_Login = 'E2D6CD60D6D7449881986DB57B07CF85';

    this.appNumber = 4;
  }
  @override
  String get_Application_Name_Entreprise() {
    return CNX_APPLICATION;
  }

  @override
  Widget MaterialApp_LoginPage() {
    return GBSystemLoginScreen();
  }

  @override
  Widget AfterConnexion_HomePage() {
    return ChooseModeStockScreen();
    // return Container();
  }

  @override
  Map<String, String> get_ConnexionData(UserModel userModel, String? Key_S19) {
    Map<String, String> Result = {
      "OKey": CNX_OKey_Login,
      "CNX_TYPE":
          CNX_TYPE, // GBSys_System_Strings.CNX_TYPE_Server, // "server",
      "CNX_APPLICATION":
          CNX_APPLICATION, //GBSys_System_Strings.bmServer_PriseService, //"BMServer-MBLN-PS",
      "USR_CODE": userModel.email,
      "USR_PASS": userModel.password,
      "DOS_CODE": agencesController.getLoginAgence?.DOS_CODE ?? "BM-MOBILE",
      "USR_LANGUE": "fr",
    };
    Key_S19 == '' && Key_S19 == null ? Result : Result["s19"] = Key_S19!;

    return Result;
  }
}

GBSystem_Root_Application_Params get_Root_Application_Params() {
  switch (KApplication_Active) {
    case 1:
      return GBSystem_BMPriseService_V1_Application_Params();
    case 2:
      return GBSystem_BMPriseService_V2_Application_Params();
    case 3:
      return GBSystem_BMPriseService_V3_Application_Params();
    case 4:
      return GBSystem_BMPriseService_V4_Application_Params();

    default:
      return GBSystem_BMPriseService_V1_Application_Params();
  }
}
