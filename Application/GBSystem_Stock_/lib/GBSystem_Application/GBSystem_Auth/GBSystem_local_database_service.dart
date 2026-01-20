import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'GBSystem_response_model.dart';
import 'package:hive/hive.dart';
//import 'dart:convert';
//import 'package:http/http.dart' as http;

class LocalDatabaseService {
  // entrer sortie
  Future<void> saveRequestLocally({required String url, required Map<String, String> data, required String? cookies}) async {
    final box = Hive.box(GBSystem_System_Strings.kHiveBox_Requests);

    await box.add({'url': url, 'data': data, 'cookies': cookies ?? ''}).then((value) {
      print("status ajoute locally : $value");
    });
  }

  Future<List<Map>> getAllStoredRequests() async {
    final box = Hive.box(GBSystem_System_Strings.kHiveBox_Requests);
    return box.values.cast<Map>().toList();
  }

  Future<void> retryStoredRequests() async {
    final box = Hive.box(GBSystem_System_Strings.kHiveBox_Requests);

    for (int i = box.length - 1; i >= 0; i--) {
      final request = box.getAt(i);
      try {
        ResponseModel response = await postWithoutContext(token: '', url: request['url'], data: Map<String, String>.from(request['data']), cookies: request['cookies'] ?? '');

        if ((response.statusCode ?? 404) >= 200 && (response.statusCode ?? 404) < 300) {
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

  Future<bool> retrySingleRequests(dynamic request) async {
    try {
      print("retreive : ${Map<String, String>.from(request['data'])}");
      ResponseModel response = await postWithoutContext(token: '', url: request['url'], data: Map<String, String>.from(request['data']), cookies: request['cookies'] ?? '');

      if ((response.statusCode ?? 404) >= 200 && (response.statusCode ?? 404) < 300) {
        print('✅ Sent and removed request');
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
    final box = Hive.box(GBSystem_System_Strings.kHiveBox_Requests);
    await box.clear();
    print('🧹 All stored requests cleared.');
  }

  Future<void> removeStoredRequestAt(int index) async {
    final box = Hive.box(GBSystem_System_Strings.kHiveBox_Requests);
    if (index < box.length) {
      await box.deleteAt(index);
      print('🗑️ Removed request at index $index');
    }
  }

  Future<ResponseModel> postWithoutContext({required String url, required Map<String, String> data, @required String? cookies, @required String? token}) async {
    return ResponseModel(statusCode: 200, status: GBSystem_System_Strings.kFailedStatus, data: null);
    // Map<String, String> headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    // headers.addAll({'Accept': 'application/x-www-form-urlencoded'});
    // if (token != null) {
    //   headers.addAll({'Authorization': 'Bearer $token'});
    // }
    // if (cookies != null) {
    //   headers.addAll({"Cookie": cookies});
    // }
    // print(url);
    // try {
    //   final response = await http.post(Uri.parse(url), headers: headers, body: data);

    //   if (response.statusCode == 201 || response.statusCode == 200) {
    //     String responseBody = utf8.decode(response.bodyBytes);

    //     Map<String, dynamic> responseData = jsonDecode(responseBody);

    //     // ApiErrorsManager(responseData);
    //     return ResponseModel(statusCode: response.statusCode, status: GBSystem_System_Strings.kSuccesStatus, data: responseData, cookies: response.headers['set-cookie']);
    //   } else {
    //     String responseBody = utf8.decode(response.bodyBytes);

    //     Map<String, dynamic> errorResponse = jsonDecode(responseBody);

    //     // ApiErrorsManager(errorResponse);

    //     return ResponseModel(statusCode: response.statusCode, status: GBSystem_System_Strings.kFailedStatus, data: errorResponse);
    //   }
    // } catch (e) {
    //   throw Exception("Error sending POST request: $e");
    // }
  }

  // quick access eval

  static final _box = Hive.box(GBSystem_System_Strings.kHiveBox_Evaluation);

  static Future<void> saveOrUpdateEval({required String LIEINSPSVR_IDF, required int questionTypeIndex, required int questionIndex}) async {
    try {
      // Find index of existing item with same IDF
      final key = _box.keys.firstWhere((k) => _box.get(k)['LIEINSPSVR_IDF'] == LIEINSPSVR_IDF, orElse: () => null);

      final data = {'LIEINSPSVR_IDF': LIEINSPSVR_IDF, 'questionTypeIndex': questionTypeIndex, 'questionIndex': questionIndex};

      if (key != null) {
        await _box.put(key, data);
        print("Updated existing evaluation_status for IDF: $LIEINSPSVR_IDF == $data");
      } else {
        await _box.add(data);
        print("Added new evaluation_status for IDF: $LIEINSPSVR_IDF == $data");
      }
    } catch (e) {
      print(e);
    }
  }

  /// Get by IDF
  static Map<String, dynamic>? getByIdfEval(String LIEINSPSVR_IDF) {
    try {
      return _box.values.firstWhere((element) => element['LIEINSPSVR_IDF'] == LIEINSPSVR_IDF, orElse: () => null);
    } catch (e) {
      return null;
    }
  }

  /// Get all
  static List<Map<String, dynamic>> getAllEval() {
    return _box.values.cast<Map<String, dynamic>>().toList();
  }

  /// Delete by IDF
  static Future<void> deleteByIdfEval(String LIEINSPSVR_IDF) async {
    try {
      final key = _box.keys.firstWhere((k) => _box.get(k)['LIEINSPSVR_IDF'] == LIEINSPSVR_IDF, orElse: () => null);
      if (key != null) {
        await _box.delete(key);
        print("Deleted evaluation_status for IDF: $LIEINSPSVR_IDF");
      }
    } catch (e) {
      print(e);
    }
  }

  /// Delete all
  static Future<void> deleteAllEval() async {
    await _box.clear();
    print("All evaluation_status entries cleared");
  }
}
