import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_response_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final BuildContext ActiveContext;
  String _ActiveUrl = '';

  String? _Cookies = '';

  Api(this.ActiveContext);

  Future<ResponseModel> get(
      {required String url, @required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return ResponseModel(
          status: GbsSystemServerStrings.kSuccesStatus,
          data: responseData,
          statusCode: response.statusCode);
    } else {
      throw Exception(
          "there is an error status Code :  ${response.statusCode}");
    }
  }

  ApiErrorsManager(dynamic responseData) {
    if ((responseData["Errors"] as List).isNotEmpty) {
      //(responseData["Errors"] as List).isNotEmpty ? showErrorSnackBar(ActiveContext, "${responseData["Errors"][0]["DefaultError"][0]["MESSAGES"]}") : showErrorSnackBar(ActiveContext, "quelque chose est mal tourné");
      // var a = responseData["Errors"][0]["DefaultError"][0]["MESSAGES"];
      // print(a);

      showErrorDialog(ActiveContext,
          "${responseData["Errors"][0]["DefaultError"][0]["MESSAGES"]}");
    }
  }

  Future<bool> saveCookies(String newCookies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool saveStatus =
        await prefs.setString(GbsSystemServerStrings.kCookies, newCookies);
    return saveStatus;
  }

  Future<String?> getCookies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _Cookies = prefs.getString(GbsSystemServerStrings.kCookies);
    return _Cookies;
  }

  Future initApiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _ActiveUrl = prefs.getString(GbsSystemServerStrings.kSiteWeb) ??
        GbsSystemServerStrings.kMyBaseUrlStandard;

    _Cookies = prefs.getString(GbsSystemServerStrings.kCookies);
  }

  Future<ResponseModel> post(
      {required Map<String, String> data, @required String? token}) async {
    await initApiData();

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    headers.addAll({'Accept': 'application/x-www-form-urlencoded'});
    // set token if existe (en generale in this app not exists (sended in the json data not header))
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    //set cookies to action
    if (_Cookies != null) {
      headers.addAll({"Cookie": _Cookies!});
    }

    try {
      print("active url : $_ActiveUrl");
      final response = await http.post(
        Uri.parse(_ActiveUrl),
        headers: headers,
        body: data,
      );
      print("statusCode url : ${response.statusCode}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);

        Map<String, dynamic> responseData = jsonDecode(responseBody);

        ApiErrorsManager(responseData);

        await saveCookies(response.headers['set-cookie']!);

        return ResponseModel(
            statusCode: response.statusCode,
            status: GbsSystemServerStrings.kSuccesStatus,
            data: responseData,
            cookies: response.headers['set-cookie']);
      } else {
        String responseBody = utf8.decode(response.bodyBytes);

        Map<String, dynamic> errorResponse = jsonDecode(responseBody);

        ApiErrorsManager(errorResponse);

        await saveCookies(response.headers['set-cookie']!);

        return ResponseModel(
            statusCode: response.statusCode,
            status: GbsSystemServerStrings.kFailedStatus,
            data: errorResponse);
      }
    } catch (e) {
      throw Exception("Error sending POST request: $e");
    }
  }

  Future<ResponseModel> put(
      {required String url,
      Map<String, dynamic>? data,
      required String token}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    String jsonData = jsonEncode(data);

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonData,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return ResponseModel(
            status: GbsSystemServerStrings.kSuccesStatus, data: responseData);
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);

        return ResponseModel(
            status: GbsSystemServerStrings.kFailedStatus, data: errorResponse);
      }
    } catch (e) {
      throw Exception("Error sending PUT request: $e");
    }
  }

  Future<ResponseModel> delete({required String url, @required token}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Map<String, dynamic> responseData = jsonDecode(response.body);
        return const ResponseModel(
            status: GbsSystemServerStrings.kSuccesStatus, data: null);
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);

        return ResponseModel(
            status: GbsSystemServerStrings.kFailedStatus, data: errorResponse);
      }
    } catch (e) {
      throw Exception("Error sending DELETE request: $e");
    }
  }
}
