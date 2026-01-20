import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_error_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_error_server_model.dart';

class ResponseModel {
  final int? statusCode;
  final String status;
  final dynamic data;
  final String? cookies;

  const ResponseModel(
      {this.statusCode,
      this.cookies,
      required this.status,
      required this.data});

  bool isRequestSucces() {
    return (data["Data"] as List).isNotEmpty &&
        (data["Errors"] as List).isEmpty;
  }

  bool isDataAndErrorsEmpty() {
    return (data["Data"] as List).isEmpty && (data["Errors"] as List).isEmpty;
  }

  bool isDataPlacesApiIsNotEmpty() {
    return data["features"] != null && (data["features"] as List).isNotEmpty;
  }

  bool validerDocumentsCase() {
    final errorController =
        Get.put<GBSystemErrorController>(GBSystemErrorController());

    if (data["Errors"] != null && data["Errors"]!.isNotEmpty) {
      errorController.setCurrentError = GbsystemErrorServerModel(
          code: data["Errors"][0]["DefaultError"][0]["CODE"],
          message: data["Errors"][0]["DefaultError"][0]["MESSAGES"]);
    }

    return data["Errors"] != null &&
        data["Errors"]!.isNotEmpty &&
        (data["Errors"][0]["DefaultError"][0]["CODE"]) == "0605";
  }

  bool sessionExpirerCase() {
    final errorController =
        Get.put<GBSystemErrorController>(GBSystemErrorController());
    if (data["Errors"] != null && data["Errors"]!.isNotEmpty) {
      errorController.setCurrentError = GbsystemErrorServerModel(
          code: data["Errors"][0]["DefaultError"][0]["CODE"],
          message: data["Errors"][0]["DefaultError"][0]["MESSAGES"]);
    }

    return data["Errors"] != null &&
        data["Errors"]!.isNotEmpty &&
        (data["Errors"][0]["DefaultError"][0]["CODE"]) == "0538";
  }

  dynamic getElementFromDataList({String? elementName}) {
    dynamic result;
    for (var i = 0; i < (data["Data"] as List).length; i++) {
      if (data["Data"][i] != null &&
          data["Data"][i] is Map &&
          (data["Data"][i] as Map).containsKey(elementName ?? "ClientData") &&
          data["Data"][i][elementName ?? "ClientData"] != null) {
        result = data["Data"][i][elementName ?? "ClientData"];
      }
    }
    return result;
  }

  dynamic getFirstElementFromDataList({String? elementName}) {
    dynamic result;
    for (var i = 0; i < (data["Data"] as List).length; i++) {
      if (data["Data"][i] != null &&
          data["Data"][i] is Map &&
          data["Data"][i][elementName ?? "ClientData"] != null) {
        result = data["Data"][i][elementName ?? "ClientData"];
      }
    }
    return (result as List).first;
  }
}
