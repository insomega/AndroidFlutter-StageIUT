// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';

import 'package:gbsystem_root/GBSystem_response_model.dart';

import 'package:gbsystem_root/GBSystem_Root_Params.dart';
import 'package:gbsystem_root/GBSystem_Application_Config.dart';
//import '../GBSystem_Login/GBSystem_Login_Exchange_Server.dart';
import 'GBSystem_Login_Models.dart';
// import 'GBSystem_UserConnexion_DataModel.dart';
// import 'GBSystem_Login_Config.dart';

//import 'package:gbsystem_root/GBSystem_Root_Params.dart';

//import 'package:gbsystem_root/GBSystem_System_Strings.dart';

import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_lookup/GBSystem_Dossier_Lookup.dart';
import 'package:gbsystem_nfc/GBSystem_NFC_Manager.dart';

//import '../GBSystem_Application/Routes/GBSystem_Application_Routes.dart';

//import '../GBSystem_Login/GBSystem_Login_Models.dart';

class GBSystem_Login_Controller extends GBSystem_Root_Controller {
  final RxInt identificationTapCount = 0.obs;
  GBSystem_Login_Controller();
  static const routeName = '/login';

  final GBSystem_NFC_Manager nfcService = GBSystem_NFC_Manager.instance;
  final isReadingNfc = false.obs;
  final nfcTagId = ''.obs;
  String NFC_Code = '';

  late final GBSystem_Dossier_Lookup_Controller dossierLookupController;

  @override
  void onInit() {
    super.onInit();

    CodeEntreprise_Visibility.value = !CodeEntreprise_Exits();
    controllerEmail.text = _storage.getEmail();
    selectedLanguage.value = _storage.getLocal()!;
    // Vérifier si le device supporte NFC
    //checkNfcAvailability();
    dossierLookupController = Get.put(GBSystem_Dossier_Lookup_Controller(controllerEmail: controllerEmail, controllerPassword: controllerPassword));
  }

  void startNfcAuthentication() async {
    isReadingNfc.value = true;

    try {
      await nfcService.readTextOnly(
        onTextDetected: (text) async {
          nfcTagId.value = text; // Tag lu
          isReadingNfc.value = false;

          // ✅ Utiliser le texte lu comme identifiant de login
          NFC_Code = text;

          // Lancer automatiquement la connexion
          await login_NFC();
          NFC_Code = '';
        },
        onError: (error) {
          isReadingNfc.value = false;
          Error_Message.value = "Erreur NFC: $error";
        },
      );
    } catch (e) {
      isReadingNfc.value = false;
      Error_Message.value = "Impossible de lire le tag NFC: $e";
    }
  }

  @override
  void onClose() {
    CodeEntreprise_Controller.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.onClose();
  }

  final formKey = GlobalKey<FormState>();
  final autovalidateMode = AutovalidateMode.disabled.obs;
  final GBSystem_Storage_Service _storage = GBSystem_Storage_Service();
  //final loginExchange = Get.find<GBSystem_Login_Exchange_Server>();

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerAgence = TextEditingController();

  final CodeEntreprise_Controller = TextEditingController();

  final passwordVisibility = false.obs;
  final CodeEntreprise_Visibility = false.obs;
  final selectedLanguage = 'en'.obs;

  final textFieldFocusNodeEmail = FocusNode();
  final textFieldFocusNodePassword = FocusNode();

  final RxnString Succes_Message = RxnString();
  final RxnString Error_Message = RxnString();

  bool CodeEntreprise_Exists_and_Updated() {
    final str_value = _storage.getEntrepriseName();

    return str_value != null && str_value.isNotEmpty && str_value != CodeEntreprise_Controller.text;
  }

  bool CodeEntreprise_Exits() {
    final str_value = _storage.getEntrepriseName();

    return str_value != null && str_value.isNotEmpty;
  }

  Future<void> _CodeEntreprise_DoValidation() async {
    // if (validateCodeClient()) {
    await CodeEntreprise_DoValidation();
  }

  Future<EntrepriseCode_URL_S19_Model?> _get_URL_and_S19_For_EntrepriseCode(String EntrepriseCode) async {
    final String SYSMENT_APPNAME = GBSystem_Application_Params_Manager.instance.CNX_APPLICATION;

    final String aURL = "${GBSystem_Application_Config.apiUrl}/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$EntrepriseCode&SYSMENT_APPNAME=$SYSMENT_APPNAME";
    //   "https://192.168.1.30:8010/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$entrepriseName&SYSMENT_APPNAME=BMSERVER-MBLN",
    ResponseModel responseServer = await Execute_Server_get(url: aURL);

    //return   responseServer.get_Response_in_Datamodel<EntrepriseCode_URL_S19_Model>(fromJson: (json) => EntrepriseCode_URL_S19_Model.fromJson(json));
    return EntrepriseCode_URL_S19_Model.fromResponse(responseServer);
    //return

    //return EntrepriseCode_Info;
  }

  Future<void> CodeEntreprise_DoValidation() async {
    //await Do_URL_and_S19_For_EntrepriseCode(EntrepriseCode: CodeEntreprise_Controller.text);
    String EntrepriseCode = CodeEntreprise_Controller.text.trim();
    if (EntrepriseCode.isEmpty) {
      Error_Message.value = GBSystem_Application_Strings.str_validat_svp_code_entreprise_invalid.tr;
      return;
    }
    final EntrepriseCode_Info = await _get_URL_and_S19_For_EntrepriseCode(EntrepriseCode);

    if (EntrepriseCode_Info != null) {
      _saveClientInfo(EntrepriseCode_Info);
      CodeEntreprise_Visibility.value = false;
    } else {
      Error_Message.value = GBSystem_Application_Strings.str_validat_svp_code_entreprise_invalid.tr;
    }
    return;
  }

  /// Stocke les infos en local
  void _saveClientInfo(EntrepriseCode_URL_S19_Model EntrepriseCode_Info) {
    final url = EntrepriseCode_Info.SYSMENT_URL;
    final s19 = EntrepriseCode_Info.SYSMENT_S19;

    //GBSystem_System_Strings.kMyBaseUrlStandard = url;
    //GBSystem_System_Strings.kMyS19Standard = s19 != null ? "$url/BMServerR.dll/BMRest" : "";

    _storage.saveS19(s19 ?? "");
    _storage.saveSiteWeb("$url/BMServerR.dll/BMRest");
    _storage.saveEntrepriseName(EntrepriseCode_Info.SYSMENT_CODE);

    // storage.write(GBSystem_System_Strings.kS19, s19 ?? "");
    // storage.write(GBSystem_System_Strings.kSiteWeb, "$url/BMServerR.dll/BMRest");
    // storage.write(GBSystem_System_Strings.kEntrepriseName, EntrepriseCode_Info.SYSMENT_CODE);
  }

  bool verifierExistUrlS19() {
    //final prefs = await SharedPreferences.getInstance();
    //final siteWeb = prefs.getString(GBSystem_System_Strings.kSiteWeb);

    final str_value = _storage.getsiteWeb();

    return str_value != null && str_value.isNotEmpty;
  }

  void togglePasswordVisibility() => passwordVisibility.toggle();

  void Change_CodeEntreprise_Visibility() {
    if (!CodeEntreprise_Visibility.value) {
      if (CodeEntreprise_Controller.text.isEmpty) {
        String? code = _storage.getEntrepriseName();
        if (code != null && code.isNotEmpty) {
          CodeEntreprise_Controller.text = code;
        }
      }
      CodeEntreprise_Visibility.value = true;
      return;
    }

    if (CodeEntreprise_Controller.text.isEmpty || _storage.getEntrepriseName() == null || _storage.getEntrepriseName() != CodeEntreprise_Controller.text.trim()) {
      Error_Message.value = GBSystem_Application_Strings.str_validat_svp_code_entreprise_invalid.tr;
      return;
    }

    CodeEntreprise_Visibility.value = !CodeEntreprise_Visibility.value;
    return;
  }

  void validateCodeEntreprise() {
    if (CodeEntreprise_Exits()) {
      if (CodeEntreprise_Exists_and_Updated()) {
        //showWarningSnackBar(
        //      GBSystem_Application_Strings.str_are_you_sure_want_change_entreprise, //
        //   btnOkOnPress: () => _CodeEntreprise_DoValidation(),
        //   btnCancelOnPress: () => Change_CodeEntreprise_Visibility(),
        // );
        showWarningDialog(GBSystem_Application_Strings.str_are_you_sure_want_change_entreprise.tr);
      } else {
        Change_CodeEntreprise_Visibility();
      }
    } else {
      _CodeEntreprise_DoValidation();
    }
  }

  void changeLanguage(String code) {
    selectedLanguage.value = code;
    Get.updateLocale(Locale(code));
    changeSharedPerfermenceLocal(code);
  }

  Map<String, String> get_ConnexionData({bool with_NFC_Connetion = false}) {
    final appParams = GBSystem_Application_Params_Manager.instance;

    final result = <String, String>{
      //
      "OKey": with_NFC_Connetion ? appParams.CNX_OKey_Login_NFC : appParams.CNX_OKey_Login,
      "CNX_TYPE": appParams.CNX_TYPE,
      "CNX_APPLICATION": appParams.CNX_APPLICATION,
      appParams.CNX_USR_CODE: with_NFC_Connetion ? NFC_Code : controllerEmail.text, //controllerEmail.text,
      appParams.CNX_USR_PASSWORD: controllerPassword.text,
      "USR_LANGUE": "fr",
    };

    if (appParams.SelectUserDossier) {
      final controllerLookup = Get.find<GBSystem_Dossier_Lookup_Controller>();
      if (controllerLookup.dos_code.isNotEmpty) {
        result["DOS_CODE"] = controllerLookup.dos_code;
      }
    }

    return result;
  }

  Future<bool> do_login_After_validate({bool with_NFC_Connetion = false}) async {
    //final AppParams = GBSystem_Application_Params_Manager.instance;
    //GBSystem_Login_DataModel userModel = GBSystem_Login_DataModel(email: controllerEmail.text, password: controllerPassword.text);

    _storage.clearSessionData();

    await Execute_Server_post(data: get_ConnexionData(with_NFC_Connetion: with_NFC_Connetion));
    if (_storage.hasSessionData()) {
      _storage.saveEmail(controllerEmail.text);
      return true;
    } else {
      return false;
    }
  }

  Future<void> login_NFC() async {
    final bool connectionOk = await do_login_After_validate(with_NFC_Connetion: true);
    if (connectionOk) {
      Get.offAllNamed(GBSystem_Application_Params_Manager.instance.mainAppView);
    }
  }

  Future<void> loginFunction() async {
    //if (formKey.currentState!.validate() && _storage.hasSessionData()) {
    if (formKey.currentState!.validate()) {
      final bool connectionOk = await do_login_After_validate();
      if (connectionOk) {
        Get.offAllNamed(GBSystem_Application_Params_Manager.instance.mainAppView);
      }
    } else {
      autovalidateMode.value = AutovalidateMode.always;
    }
  }

  void changeSharedPerfermenceLocal(String alocal) {
    // Save language
    _storage.saveLocal(alocal);
  }

  void incrementIdentificationTap() {
    identificationTapCount.value++;
    if (identificationTapCount.value >= 7) {
      Get.snackbar("apiUrl", GBSystem_Application_Config.apiUrl, snackPosition: SnackPosition.BOTTOM);
      identificationTapCount.value = 0; // reset après affichage
    }
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
// import 'package:gbsystem_root/GBSystem_snack_bar.dart';
// import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
// import 'package:gbsystem_root/GBSystem_Application_Config.dart';

// import 'package:gbsystem_root/GBSystem_response_model.dart';

// import 'package:gbsystem_root/GBSystem_Root_Params.dart';
// //import '../GBSystem_Login/GBSystem_Login_Exchange_Server.dart';
// import 'GBSystem_Login_Models.dart';
// // import 'GBSystem_UserConnexion_DataModel.dart';
// // import 'GBSystem_Login_Config.dart';

// //import 'package:gbsystem_root/GBSystem_Root_Params.dart';

// import 'package:gbsystem_root/GBSystem_System_Strings.dart';
// import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

// //import '../GBSystem_Application/Routes/GBSystem_Application_Routes.dart';

// //import '../GBSystem_Login/GBSystem_Login_Models.dart';

// class GBSystem_Login_Controller extends GBSystem_Root_Controller {
//   GBSystem_Login_Controller();

//   static const routeName = '/login';

//   @override
//   void onInit() {
//     super.onInit();

//     CodeEntreprise_Visibility.value = !CodeEntreprise_Exits();
//     controllerEmail.text = _storage.getEmail();
//     selectedLanguage.value = _storage.getLocal()!;
//   }

//   @override
//   void onClose() {
//     CodeEntreprise_Controller.dispose();
//     controllerEmail.dispose();
//     controllerPassword.dispose();
//     super.onClose();
//   }

//   final formKey = GlobalKey<FormState>();
//   final autovalidateMode = AutovalidateMode.disabled.obs;
//   final GBSystem_Storage_Service _storage = GBSystem_Storage_Service();
//   //final loginExchange = Get.find<GBSystem_Login_Exchange_Server>();

//   final controllerEmail = TextEditingController();
//   final controllerPassword = TextEditingController();
//   final controllerAgence = TextEditingController();

//   final CodeEntreprise_Controller = TextEditingController();

//   final passwordVisibility = false.obs;
//   final CodeEntreprise_Visibility = false.obs;
//   final selectedLanguage = 'en'.obs;

//   final textFieldFocusNodeEmail = FocusNode();
//   final textFieldFocusNodePassword = FocusNode();

//   final RxnString Succes_Message = RxnString();
//   final RxnString Error_Message = RxnString();

//   bool CodeEntreprise_Exists_and_Updated() {
//     final str_value = _storage.getEntrepriseName();

//     return str_value != null && str_value.isNotEmpty && str_value != CodeEntreprise_Controller.text;
//   }

//   bool CodeEntreprise_Exits() {
//     final str_value = _storage.getEntrepriseName();

//     return str_value != null && str_value.isNotEmpty;
//   }

//   Future<void> _CodeEntreprise_DoValidation() async {
//     // if (validateCodeClient()) {
//     await CodeEntreprise_DoValidation();
//   }

//   Future<EntrepriseCode_URL_S19_Model?> _get_URL_and_S19_For_EntrepriseCode(String EntrepriseCode) async {
//     ResponseModel responseServer = await Execute_Server_get(
//       //boubaker 17/06/2025 For Build APK #Portail_Salarie Update this
//       url: GBSystem_Application_Config.apiUrl + "/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$EntrepriseCode&SYSMENT_APPNAME=BMSERVER-MBLN",
//       //   "https://192.168.1.30:8010/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$entrepriseName&SYSMENT_APPNAME=BMSERVER-MBLN",
//       // "https://192.168.1.60:8010/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$entrepriseName&SYSMENT_APPNAME=BMSERVER-MBLN",
//       //"https://www.bmplanning.com/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$EntrepriseCode&SYSMENT_APPNAME=BMSERVER-MBLN",
//     );

//     //return   responseServer.get_Response_in_Datamodel<EntrepriseCode_URL_S19_Model>(fromJson: (json) => EntrepriseCode_URL_S19_Model.fromJson(json));
//     return EntrepriseCode_URL_S19_Model.fromResponse(responseServer);
//     //return

//     //return EntrepriseCode_Info;
//   }

//   Future<void> CodeEntreprise_DoValidation() async {
//     //await Do_URL_and_S19_For_EntrepriseCode(EntrepriseCode: CodeEntreprise_Controller.text);
//     String EntrepriseCode = CodeEntreprise_Controller.text.trim();
//     if (EntrepriseCode.isEmpty) {
//       Error_Message.value = GBSystem_Application_Strings.str_validat_svp_code_entreprise_invalid.tr;
//       return;
//     }
//     final EntrepriseCode_Info = await _get_URL_and_S19_For_EntrepriseCode(EntrepriseCode);

//     if (EntrepriseCode_Info != null) {
//       _saveClientInfo(EntrepriseCode_Info);
//       CodeEntreprise_Visibility.value = false;
//     } else {
//       Error_Message.value = GBSystem_Application_Strings.str_validat_svp_code_entreprise_invalid.tr;
//     }
//     return;
//   }

//   /// Stocke les infos en local
//   void _saveClientInfo(EntrepriseCode_URL_S19_Model EntrepriseCode_Info) {
//     final url = EntrepriseCode_Info.SYSMENT_URL;
//     final s19 = EntrepriseCode_Info.SYSMENT_S19;

//     GBSystem_System_Strings.kMyBaseUrlStandard = url;
//     GBSystem_System_Strings.kMyS19Standard = s19 != null ? "$url/BMServerR.dll/BMRest" : "";

//     _storage.saveS19(s19 ?? "");
//     _storage.saveSiteWeb("$url/BMServerR.dll/BMRest");
//     _storage.saveEntrepriseName(EntrepriseCode_Info.SYSMENT_CODE);

//     // storage.write(GBSystem_System_Strings.kS19, s19 ?? "");
//     // storage.write(GBSystem_System_Strings.kSiteWeb, "$url/BMServerR.dll/BMRest");
//     // storage.write(GBSystem_System_Strings.kEntrepriseName, EntrepriseCode_Info.SYSMENT_CODE);
//   }

//   bool verifierExistUrlS19() {
//     //final prefs = await SharedPreferences.getInstance();
//     //final siteWeb = prefs.getString(GBSystem_System_Strings.kSiteWeb);

//     final str_value = _storage.getsiteWeb();

//     return str_value != null && str_value.isNotEmpty;
//   }

//   void togglePasswordVisibility() => passwordVisibility.toggle();

//   void Change_CodeEntreprise_Visibility() {
//     if (!CodeEntreprise_Visibility.value) {
//       if (CodeEntreprise_Controller.text.isEmpty) {
//         String? code = _storage.getEntrepriseName();
//         if (code != null && code.isNotEmpty) {
//           CodeEntreprise_Controller.text = code;
//         }
//       }
//       CodeEntreprise_Visibility.value = true;
//       return;
//     }

//     if (CodeEntreprise_Controller.text.isEmpty || _storage.getEntrepriseName() == null || _storage.getEntrepriseName() != CodeEntreprise_Controller.text.trim()) {
//       Error_Message.value = GBSystem_Application_Strings.str_validat_svp_code_entreprise_invalid.tr;
//       return;
//     }

//     CodeEntreprise_Visibility.value = !CodeEntreprise_Visibility.value;
//     return;
//   }

//   void validateCodeEntreprise() {
//     if (CodeEntreprise_Exits()) {
//       if (CodeEntreprise_Exists_and_Updated()) {
//         //showWarningSnackBar(
//         //      GBSystem_Application_Strings.str_are_you_sure_want_change_entreprise, //
//         //   btnOkOnPress: () => _CodeEntreprise_DoValidation(),
//         //   btnCancelOnPress: () => Change_CodeEntreprise_Visibility(),
//         // );
//         showWarningDialog(GBSystem_Application_Strings.str_are_you_sure_want_change_entreprise.tr);
//       } else {
//         Change_CodeEntreprise_Visibility();
//       }
//     } else {
//       _CodeEntreprise_DoValidation();
//     }
//   }

//   // String? validatePassword(String? data) {
//   //   if (data == null || data.isEmpty) {
//   //     return GBSystem_Application_Strings.str_validat_svp_enter_password.tr;
//   //   }

//   //   final password = data.trim();

//   //   if (password.length < 8) {
//   //     return GBSystem_Application_Strings.str_validat_password_length.tr;
//   //   }

//   //   if (!RegExp(r'[A-Z]').hasMatch(password)) {
//   //     return GBSystem_Application_Strings.str_validat_password_MAJ.tr;
//   //   }

//   //   if (!RegExp(r'[a-z]').hasMatch(password)) {
//   //     return GBSystem_Application_Strings.str_validat_password_Min.tr;
//   //   }

//   //   if (!RegExp(r'[0-9]').hasMatch(password)) {
//   //     return GBSystem_Application_Strings.str_validat_password_Chiffre.tr;
//   //   }

//   //   if (!RegExp(r'[!@#\$&*~%^().?_+=<>:;,-]').hasMatch(password)) {
//   //     return GBSystem_Application_Strings.str_validat_password_Speciale.tr;
//   //   }
//   //   return null; // ✅ OK
//   // }

//   // if (data == null || data.isEmpty) {
//   //   return GBSystem_Application_Strings.str_validat_svp_enter_password.tr;
//   // } else if (data.length < 8) {
//   //   return GBSystem_Application_Strings.str_validat_password_length.tr;
//   // }
//   // return null;

//   void changeLanguage(String code) {
//     selectedLanguage.value = code;
//     Get.updateLocale(Locale(code));
//     changeSharedPerfermenceLocal(code);
//   }

//   Map<String, String> get_ConnexionData() {
//     final AppParams = GBSystem_Application_Params_Manager.instance;
//     Map<String, String> Result = {
//       //
//       "OKey": AppParams.CNX_OKey_Login,
//       "CNX_TYPE": AppParams.CNX_TYPE,
//       "CNX_APPLICATION": AppParams.CNX_APPLICATION,
//       "SVR_CODE": controllerEmail.text,
//       "SVR_PASSWORD": controllerPassword.text,
//       "USR_LANGUE": "fr",
//     };
//     return Result;
//   }

//   // Future<void> do_login_After_validate() async {
//   //   //final AppParams = GBSystem_Application_Params_Manager.instance;
//   //   //GBSystem_Login_DataModel userModel = GBSystem_Login_DataModel(email: controllerEmail.text, password: controllerPassword.text);

//   //   _storage.clearSessionData();

//   //   await Execute_Server_post(data: get_ConnexionData());
//   //   if (_storage.hasSessionData()) {
//   //     _storage.saveEmail(controllerEmail.text);
//   //   }
//   // }

//   Future<bool> do_login_After_validate() async {
//     try {
//       _storage.clearSessionData();
//       await Execute_Server_post(data: get_ConnexionData());

//       if (_storage.hasSessionData()) {
//         _storage.saveEmail(controllerEmail.text);
//         return true;
//       }
//     } catch (e) {
//       debugPrint("Erreur de login : $e");
//     }
//     return false;
//   }

//   Future<void> loginFunction() async {
//     //if (formKey.currentState!.validate() && _storage.hasSessionData()) {
//     if (formKey.currentState!.validate()) {
//       bool Cancontinue = await do_login_After_validate();
//       //Get.log("--------####################-------------responseDataZZZZZZZZZZZ ");
//       //Get.offAllNamed(GBSystem_Application_Routes.mainAppView);
//       if (Cancontinue) {
//         Get.offAllNamed(GBSystem_Application_Params_Manager.instance.mainAppView);
//       }
//     } else {
//       autovalidateMode.value = AutovalidateMode.always;
//     }
//   }

//   void changeSharedPerfermenceLocal(String alocal) {
//     // Save language
//     _storage.saveLocal(alocal);
//   }
// }

  // String? validatePassword(String? data) {
  //   if (data == null || data.isEmpty) {
  //     return GBSystem_Application_Strings.str_validat_svp_enter_password.tr;
  //   }

  //   final password = data.trim();

  //   if (password.length < 8) {
  //     return GBSystem_Application_Strings.str_validat_password_length.tr;
  //   }

  //   if (!RegExp(r'[A-Z]').hasMatch(password)) {
  //     return GBSystem_Application_Strings.str_validat_password_MAJ.tr;
  //   }

  //   if (!RegExp(r'[a-z]').hasMatch(password)) {
  //     return GBSystem_Application_Strings.str_validat_password_Min.tr;
  //   }

  //   if (!RegExp(r'[0-9]').hasMatch(password)) {
  //     return GBSystem_Application_Strings.str_validat_password_Chiffre.tr;
  //   }

  //   if (!RegExp(r'[!@#\$&*~%^().?_+=<>:;,-]').hasMatch(password)) {
  //     return GBSystem_Application_Strings.str_validat_password_Speciale.tr;
  //   }
  //   return null; // ✅ OK
  // }

  // if (data == null || data.isEmpty) {
  //   return GBSystem_Application_Strings.str_validat_svp_enter_password.tr;
  // } else if (data.length < 8) {
  //   return GBSystem_Application_Strings.str_validat_password_length.tr;
  // }
  // return null;