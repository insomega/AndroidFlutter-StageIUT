import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_response_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabaseService {
  // entrer sortie
  Future<void> saveRequestLocally({
    required String url,
    required Map<String, String> data,
    required String? cookies,
  }) async {
    final box = Hive.box(GbsSystemServerStrings.kHiveBox_Requests);

    await box.add({
      'url': url,
      'data': data,
      'cookies': cookies ?? '',
    }).then(
      (value) {
        print("status ajoute locally : $value");
      },
    );
  }

  Future<List<Map>> getAllStoredRequests() async {
    final box = Hive.box(GbsSystemServerStrings.kHiveBox_Requests);
    return box.values.cast<Map>().toList();
  }

  Future<void> retryStoredRequests() async {
    final box = Hive.box(GbsSystemServerStrings.kHiveBox_Requests);

    for (int i = box.length - 1; i >= 0; i--) {
      final request = box.getAt(i);
      try {
        ResponseModel response = await postWithoutContext(
            url: request['url'],
            data: Map<String, String>.from(request['data']),
            cookies: request['cookies'] ?? '');

        if ((response.statusCode ?? 404) >= 200 &&
            (response.statusCode ?? 404) < 300) {
          await box.deleteAt(i);
          print('✅ Sent and removed request at index $i');
        } else {
          print('❌ Server error: ${response.statusCode}');
        }
      } catch (e) {
        print('⚠️ Failed to send request: $e');
      }
    }
  }

  Future<String?> getCookies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Cookies = prefs.getString(GbsSystemServerStrings.kCookies);
    return Cookies;
  }

  Future<bool> retrySingleRequests(dynamic request) async {
    try {
      print(
          "retreive : ${request['url']} |${request['cookies']} | ${Map<String, String>.from(request['data'])}");
      String? lastCookies = await getCookies();
      print("last cookies ${lastCookies}");
      ResponseModel response = await postWithoutContext(
          url: request['url'],
          data: Map<String, String>.from(request['data']),
          cookies: lastCookies ?? request['cookies'] ?? '');

      if ((response.statusCode ?? 404) >= 200 &&
          (response.statusCode ?? 404) < 300) {
        print('✅ Sent and removed request ${response.data}');
        return true;
      } else {
        print('❌ Server error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('⚠️ Failed to send request: $e');
      return false;
    }
  }

  Future<void> clearAllStoredRequests() async {
    final box = Hive.box(GbsSystemServerStrings.kHiveBox_Requests);
    await box.clear();
    print('🧹 All stored requests cleared.');
  }

  Future<void> removeStoredRequestAt(int index) async {
    final box = Hive.box(GbsSystemServerStrings.kHiveBox_Requests);
    if (index < box.length) {
      await box.deleteAt(index);
      print('🗑️ Removed request at index $index');
    }
  }

  Future<ResponseModel> postWithoutContext(
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

        // ApiErrorsManager(responseData);
        return ResponseModel(
            statusCode: response.statusCode,
            status: GbsSystemServerStrings.kSuccesStatus,
            data: responseData,
            cookies: response.headers['set-cookie']);
      } else {
        String responseBody = utf8.decode(response.bodyBytes);

        Map<String, dynamic> errorResponse = jsonDecode(responseBody);

        // ApiErrorsManager(errorResponse);

        return ResponseModel(
            statusCode: response.statusCode,
            status: GbsSystemServerStrings.kFailedStatus,
            data: errorResponse);
      }
    } catch (e) {
      throw Exception("Error sending POST request: $e");
    }
  }
}
