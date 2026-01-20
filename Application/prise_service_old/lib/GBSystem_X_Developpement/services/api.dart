import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_response_model.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:http/http.dart' as http;

class Api {
  final BuildContext ActiveContext;
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
      showErrorDialog(ActiveContext,
          "${responseData["Errors"][0]["DefaultError"][0]["MESSAGES"]}");
    }
  }

  Future<ResponseModel> post(
      {required String url,
      required Map<String, String> data,
      @required String? cookies,
      @required String? token}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    headers.addAll({'Accept': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    if (cookies != null) {
      headers.addAll({"Cookie": cookies});
    }
    print(url);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);

        Map<String, dynamic> responseData = jsonDecode(responseBody);

        ApiErrorsManager(responseData);
        return ResponseModel(
            statusCode: response.statusCode,
            status: GbsSystemServerStrings.kSuccesStatus,
            data: responseData,
            cookies: response.headers['set-cookie']);
      } else {
        String responseBody = utf8.decode(response.bodyBytes);

        Map<String, dynamic> errorResponse = jsonDecode(responseBody);

        ApiErrorsManager(errorResponse);

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
