// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
//import 'package:flutter/material.dart';
//import 'package:get_storage/get_storage.dart';
//import 'package:gbsystem_root/GBSystem_System_Strings.dart';

import 'package:gbsystem_root/api.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:gbsystem_root/GBSystem_LogEvent.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
import 'package:gbsystem_root/GBSystem_Root_Params.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
//import 'package:gbsystem_root/GBSystem_waiting.dart';

class GBSystem_Root_Controller extends GetxController {
  var isLoading = false.obs;
  //static const String routeName = '';
  //final GetStorage storage = GetStorage();

  Future<ResponseModel> Execute_Server_get({required String url}) async {
    ResponseModel responseServer = await Api().get(url: url);
    return responseServer;
  }

  Future<ResponseModel> Execute_Server_post({required Map<String, String> data}) async {
    ResponseModel responseServer = await Api().post(data: data);
    return responseServer;
  }

  void GBSystem_Add_LogEvent({required String page, required String method, required String message}) {
    GBSystem_LogEvent().logEvent(message: message, method: method, page: page);
  }

  Future<void> handleLogout() async {
    showWarningSnackBar(
      // Get.context!, //
      GBSystem_Application_Strings.str_deconnexion_question.tr,
      btnOkOnPress: performLogout,
    );
  }

  Future<void> performLogout() async {
    try {
      GBSystem_Storage_Service().clearSessionData();

      await Get.offAllNamed(GBSystem_Application_Params_Manager.instance.loginRouteName);
    } catch (e) {
      GBSystem_Add_LogEvent(message: e.toString(), method: "_performLogout", page: "GBSystem_Root_Controller.dart");
    }
  }
}
