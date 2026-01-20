import 'package:flutter/material.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_user_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAIN_SCREEN/GBSystem_Main_screen.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

var KApplication_Active =
    int.parse(const String.fromEnvironment('APP_NUMBER', defaultValue: "1"));
const KAA_BMPriseService = 1;
GBSystem_Root_Application_Params ActiveApplication_Params =
    get_Root_Application_Params();

abstract class GBSystem_Root_Application_Params {
  String Title = '';
  String CNX_APPLICATION = '';
  String CNX_TYPE = '';
  String CNX_OKey = '';
  String CNX_OKey_Login = '';
  // String userKey = "SVR_CODE";
  // String passwordKey = "SVR_PASSWORD";
  int appNumber = 1;
  Widget MaterialApp_LoginPage();
  Widget AfterConnexion_HomePage();
  Map<String, String> get_ConnexionData(UserModel userModel, String? Key_S19);
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
  Widget MaterialApp_LoginPage() {
    return GBSystemLoginScreen();
  }

  @override
  Widget AfterConnexion_HomePage() {
    return GBSystemMainScreen();
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

GBSystem_Root_Application_Params get_Root_Application_Params() {
  switch (KApplication_Active) {
    case 1:
      return GBSystem_BMPriseService_V1_Application_Params();

    default:
      return GBSystem_BMPriseService_V1_Application_Params();
  }
}
