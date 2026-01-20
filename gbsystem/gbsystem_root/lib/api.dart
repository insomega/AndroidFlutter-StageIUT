// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_Root_Params.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:gbsystem_root/GBSystem_Storage_Service.dart';

import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Api {
  //final GetStorage _storage = GetStorage();

  final GBSystem_Storage_Service _storage = GBSystem_Storage_Service();

  // final BuildContext ActiveContext;

  String _ActiveUrl = '';
  String? _Cookies = '';

  //Api(this.ActiveContext);
  // Api();

  Future<ResponseModel> get({required String url}) async {
    Map<String, String> headers = {};

    // if (token != null) {
    //   headers.addAll({'Authorization': 'Bearer $token'});
    // }

    late http.Response response;
    // Closes all open snackbars
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.dialog(Waiting(), barrierDismissible: false);
    //http.Response response = await http.get(Uri.parse(url), headers: headers);
    try {
      //     response = await http.get(Uri.parse(url), headers: headers);
      try {
        // Appel à une fonctionnalité sensible
        response = await http.get(Uri.parse(url), headers: headers);
      } catch (e) {
        showErrorDialog(e.toString());

        // Ici tu peux vérifier si c'est un manque de permission
      }
    } finally {
      Get.back();
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return ResponseModel(status: GBSystem_System_Strings.kSuccesStatus, data: responseData, statusCode: response.statusCode);
    } else {
      throw Exception("there is an error status Code :  ${response.statusCode}");
    }
  }

  // ApiErrorsManager(dynamic responseData) {
  //   if (sessionExpirerCase()) {
  //   } else if ((responseData["Errors"] as List).isNotEmpty) {
  //     showErrorDialog("${responseData["Errors"][0]["DefaultError"][0]["MESSAGES"]}");
  //   }
  // }
  // ApiErrorsManager(ResponseModel responseModel) {
  //   dynamic responseData = responseModel.data;
  //   //
  //   if ((responseData["Errors"] as List).isNotEmpty) {
  //     showErrorDialog("${responseData["Errors"][0]["DefaultError"][0]["MESSAGES"]}");
  //     if (responseModel.sessionExpirerCase()) {
  //       Get.offAllNamed(GBSystem_Application_Params_Manager.instance.loginRouteName);
  //     }
  //   }
  //   final shiftCalMsg = responseData["SHIFT_CAL_MSG"];

  //   if (shiftCalMsg is List && shiftCalMsg.isNotEmpty) {
  //     final errorMsg = shiftCalMsg[0]?["ERROR_MSG_SHORT"];
  //     if (errorMsg != null) {
  //       showErrorDialog("$errorMsg");
  //     }
  //   }
  // }
  void ApiErrorsManager(ResponseModel responseModel) {
    final responseData = responseModel.data;

    // --- Gestion des erreurs générales ---
    final errors = responseData["Errors"];
    if (errors is List && errors.isNotEmpty) {
      final defaultError = errors[0]?["DefaultError"];
      if (defaultError is List && defaultError.isNotEmpty) {
        final msg = defaultError[0]?["MESSAGES"];
        if (msg != null) {
          showErrorDialog("$msg");
        }
      }

      if (responseModel.sessionExpirerCase()) {
        Get.offAllNamed(GBSystem_Application_Params_Manager.instance.loginRouteName);
      }
    }

    // --- Gestion des erreurs SHIFT_CAL_MSG ---
    final dataList = responseData["Data"];
    if (dataList is List && dataList.isNotEmpty) {
      final firstData = dataList[0];
      final shiftCalMsg = firstData?["SHIFT_CAL_MSG"];

      if (shiftCalMsg is List && shiftCalMsg.isNotEmpty) {
        // Récupérer tous les messages
        final messages = shiftCalMsg.map((item) => item?["ERROR_MSG_SHORT"]).whereType<String>().where((msg) => msg.isNotEmpty).toList();

        if (messages.isNotEmpty) {
          final combinedMsg = messages.join("\n• ");
          showErrorDialog("• $combinedMsg");
        }
      }
    }
  }

  String? extractCookieValue(String cookieString, String key) {
    final regex = RegExp(r'(^|;\s*)' + key + r'=([^;]+)');
    final match = regex.firstMatch(cookieString);
    if (match != null) {
      return match.group(2); // la valeur
    }
    return null;
  }

  Future<bool> saveCookies(String newCookies) async {
    final String? newCookies_value = extractCookieValue(newCookies, GBSystem_System_Strings.kB5512);
    _storage.saveCookies('${GBSystem_System_Strings.kB5512}=${newCookies_value!}');
    //_storage.write(GBSystem_System_Strings.kCookies, newCookies);
    return true;

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool saveStatus = await prefs.setString(GBSystem_System_Strings.kCookies, newCookies);
    // return saveStatus;
  }

  String? getCookies() {
    return _storage.getCookies();
    //return _storage.read<String>(GBSystem_System_Strings.kCookies);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // _Cookies = prefs.getString(GBSystem_System_Strings.kCookies);
    // return _Cookies;
  }

  void initApiData() {
    // _ActiveUrl = _storage.read<String>(GBSystem_System_Strings.kSiteWeb) ?? GBSystem_System_Strings.kMyBaseUrlStandard;
    // _Cookies = _storage.read<String>(GBSystem_System_Strings.kCookies);

    _Cookies = _storage.getCookies();
    _ActiveUrl = (_storage.getsiteWeb() ?? _storage.getBaseUrlStandard())!;
  }

  void add_WID_To_Data({required Map<String, String> data}) {
    String? Wid = _storage.getWid();
    //_storage.read(GBSystem_System_Strings.kToken);

    if (Wid != null) {
      data["Wid"] = Wid;
    } else {
      data["Wid"] = "";
    }
  }

  void add_S19_To_Data({required Map<String, String> data}) {
    String? Wid = _storage.getS19();
    //  String? Wid = _storage.read(GBSystem_System_Strings.kS19);

    if (Wid != null) {
      data["S19"] = Wid;
    } else {
      data["S19"] = "";
    }
  }

  Future<void> showLoadingDialogSafely() async {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();

      // 🔁 attendre la prochaine frame ou un court délai pour que la fermeture soit propre
      await Future.delayed(const Duration(milliseconds: 300));
    }

    // ✅ maintenant on peut afficher la modale en toute sécurité
    if (!Get.isDialogOpen!) {
      Get.dialog(
        Waiting(), // ton widget personnalisé
        barrierDismissible: false,
      );
    }
  }

  Future<ResponseModel> post({required Map<String, String> data}) async {
    //Get.log("----API.post----*********************-------1------initApiData  ");
    initApiData();
    //Get.log("----API.post----*********************-------2------initApiData  ");

    Map<String, String> headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    headers.addAll({'Accept': 'application/x-www-form-urlencoded'});
    // set token if existe (en generale in this app not exists (sended in the json data not header))
    // if (token != null) {
    //   headers.addAll({'Authorization': 'Bearer $token'});
    // }
    //set cookies to action
    if (_Cookies != null) {
      headers.addAll({"Cookie": _Cookies!});
    } else {
      add_S19_To_Data(data: data);
    }
    add_WID_To_Data(data: data);
    //Get.log("----API.post----*********************-------3------initApiData  ");
    try {
      http.Response? response;
      //Get.log("----API.post----*********************-------4------showLoadingDialogSafely  ");
      //await showLoadingDialogSafely();
      //Get.log("----API.post----*********************-------5------data : $data ");
      //Get.log("----API.post----*********************-------6------_Cookies : $_Cookies ");
      //Get.log("----API.post----*********************-------7------_ActiveUrl : $_ActiveUrl ");

      response = await http.post(Uri.parse(_ActiveUrl), headers: headers, body: data);
      // try {
      //   response = await http.post(Uri.parse(_ActiveUrl), headers: headers, body: data);
      // } finally {
      //   // 🔐 Sécuriser la fermeture : si et seulement si une modale est encore ouverte
      //   if (Get.isDialogOpen!) {
      //     Get.back(); // ferme le dialog
      //   }
      // }

      // if (response.statusCode == 201 || response.statusCode == 200) {
      //   String responseBody = utf8.decode(response.bodyBytes);
      //   //Get.log("----API.post----*********************-------7-1------responseBody : $responseBody ");
      //   Map<String, dynamic> responseData = jsonDecode(responseBody);

      //   ApiErrorsManager(responseData);

      //   saveCookies(response.headers['set-cookie']!);

      //   //a rajouter ici le save du Wid
      //   _storage.saveWid(responseData["Wid"]);
      //   String www = responseData["Wid"];

      //   //Get.log("----API.post----*********************-------8------responseData[Wid] : $www ");

      //   return ResponseModel(statusCode: response.statusCode, status: GBSystem_System_Strings.kSuccesStatus, data: responseData, cookies: response.headers['set-cookie']);
      // }

      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseBody = utf8.decode(response.bodyBytes);
        //Get.log("📥 Réponse brute: [$responseBody]");

        if (responseBody.trim().isEmpty) {
          throw Exception("❌ Réponse vide du serveur à l'appel POST.");
        }

        late Map<String, dynamic> responseData;
        try {
          responseData = jsonDecode(responseBody);
        } catch (e) {
          throw Exception("❌ JSON invalide dans la réponse : $e \nBody: $responseBody");
        }

        final ResponseModel responseModel = ResponseModel(
          statusCode: response.statusCode, //
          status: GBSystem_System_Strings.kSuccesStatus,
          data: responseData,
          cookies: response.headers['set-cookie'],
        );

        ApiErrorsManager(responseModel);

        saveCookies(response.headers['set-cookie'] ?? '');

        _storage.saveWid(responseData["Wid"]);
        //Get.log("✅ Wid reçu : ${responseData["Wid"]}");
        return responseModel;
        // return ResponseModel(
        //   statusCode: response.statusCode, //
        //   status: GBSystem_System_Strings.kSuccesStatus,
        //   data: responseData,
        //   cookies: response.headers['set-cookie'],
        // );
      } else {
        //Get.log("----API.post----*********************-------9------else ---responseData[Wid] ");
        String responseBody = utf8.decode(response.bodyBytes);

        Map<String, dynamic> errorResponse = jsonDecode(responseBody);

        final ResponseModel aesponseModel = ResponseModel(statusCode: response.statusCode, status: GBSystem_System_Strings.kFailedStatus, data: errorResponse);
        ApiErrorsManager(aesponseModel);

        saveCookies(response.headers['set-cookie']!);
        return aesponseModel;
        //return ResponseModel(statusCode: response.statusCode, status: GBSystem_System_Strings.kFailedStatus, data: errorResponse);
      }
    } catch (e) {
      //  String s = e.toString();
      //Get.log("----API.post----*********************------10----- ---Error sending POST request $s ");
      throw Exception("Error sending POST request: $e");
    }
  }

  Future<ResponseModel> put({required String url, Map<String, dynamic>? data, required String token}) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    String jsonData = jsonEncode(data);

    try {
      final response = await http.put(Uri.parse(url), headers: headers, body: jsonData);

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return ResponseModel(status: GBSystem_System_Strings.kSuccesStatus, data: responseData);
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);

        return ResponseModel(status: GBSystem_System_Strings.kFailedStatus, data: errorResponse);
      }
    } catch (e) {
      throw Exception("Error sending PUT request: $e");
    }
  }

  Future<ResponseModel> delete({required String url, @required token}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    try {
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Map<String, dynamic> responseData = jsonDecode(response.body);
        return const ResponseModel(status: GBSystem_System_Strings.kSuccesStatus, data: null);
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);

        return ResponseModel(status: GBSystem_System_Strings.kFailedStatus, data: errorResponse);
      }
    } catch (e) {
      throw Exception("Error sending DELETE request: $e");
    }
  }
}
