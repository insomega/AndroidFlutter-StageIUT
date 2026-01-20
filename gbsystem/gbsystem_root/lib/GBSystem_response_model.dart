import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_error_controller.dart';
import 'package:gbsystem_root/GBSystem_error_server_model.dart';
import 'package:gbsystem_root/GBSystem_Root_DataModel.dart';

class ResponseModel {
  final int? statusCode;
  final String status;
  final dynamic data;
  final String? cookies;

  const ResponseModel({this.statusCode, this.cookies, required this.status, required this.data});

  List get dataList => (data["Data"] ?? []) as List;
  List get errorsList => (data["Errors"] ?? []) as List;

  Map<String, dynamic>? get firstError {
    if (errorsList.isEmpty) return null;
    final defaultError = errorsList[0]["DefaultError"];
    if (defaultError != null && defaultError is List && defaultError.isNotEmpty) {
      return defaultError[0] as Map<String, dynamic>;
    }
    return null;
  }

  bool isRequestSucces() => dataList.isNotEmpty && errorsList.isEmpty;

  bool isDataAndErrorsEmpty() => dataList.isEmpty && errorsList.isEmpty;

  bool isDataPlacesApiIsNotEmpty() => data["features"] != null && (data["features"] as List).isNotEmpty;

  bool validerDocumentsCase() {
    final error = firstError;
    if (error != null) {
      Get.put<GBSystemErrorController>(GBSystemErrorController()).setCurrentError = GbsystemErrorServerModel(code: error["CODE"], message: error["MESSAGES"]);
      return error["CODE"] == "0605";
    }
    return false;
  }

  bool sessionExpirerCase() {
    final error = firstError;
    if (error != null) {
      Get.put<GBSystemErrorController>(GBSystemErrorController()).setCurrentError = GbsystemErrorServerModel(code: error["CODE"], message: error["MESSAGES"]);
      return error["CODE"] == "0538";
    }
    return false;
  }

  /// Récupère un élément de type List à partir de la clé donnée (ex : "ClientData")
  dynamic getElementFromDataList({String elementName = "ClientData"}) {
    for (final item in dataList) {
      if (item is Map && item[elementName] != null) {
        return item[elementName];
      }
    }
    return null;
  }

  /// Récupère le premier élément d'une liste contenue dans la clé (ex : "ClientData")
  dynamic get_Response_ClientData({String elementName = "ClientData"}) {
    final result = getElementFromDataList(elementName: elementName);
    return (result is List && result.isNotEmpty) ? result.first : null;
  }

  T? get_Response_in_Datamodel<T extends GBSystem_Root_DataModel>({String elementName = "ClientData", required T Function(Map<String, dynamic>) fromJson}) {
    final jsonData = getElementFromDataList(elementName: elementName);

    if (jsonData == null) return null;

    if (jsonData is List && jsonData.isNotEmpty) {
      if (T.toString().startsWith("List<")) {
        return jsonData.map<T>((e) => fromJson(e)).toList() as T;
      } else {
        return fromJson(jsonData.first);
      }
    } else if (jsonData is Map<String, dynamic>) {
      return fromJson(jsonData);
    }

    return null;
  }

  /// Méthode générique qui retourne soit un objet T soit une List<T>
  /// Elle s'adapte selon le type passé via le paramètre `asList`
  /// pour une cas d'un element simple
  /// final client = response.getResponseData<ClientDataModel, ClientDataModel>(
  //                       elementName: "ClientData",
  //                       fromJson: ClientDataModel.fromJson,
  //                                                                               );
  //    Pour une liste
  //   final clients = response.getResponseData<ClientDataModel, List<ClientDataModel>>(
  //                           elementName: "ClientData",
  //                           fromJson: ClientDataModel.fromJson,
  //                           asList: true,
  //                            );
  R? get_Response_in_Datamodel_List<T extends GBSystem_Root_DataModel, R>({
    String elementName = "ClientData", //
    required T Function(Map<String, dynamic>) fromJson,
    bool asList = true,
  }) {
    final jsonData = getElementFromDataList(elementName: elementName);

    if (jsonData == null) return null;

    if (asList) {
      if (jsonData is List) {
        return jsonData.whereType<Map<String, dynamic>>().map((json) => fromJson(json)).toList() as R;
      }
      return null;
    } else {
      if (jsonData is Map<String, dynamic>) {
        return fromJson(jsonData) as R;
      } else if (jsonData is List && jsonData.isNotEmpty) {
        final first = jsonData.first;
        if (first is Map<String, dynamic>) {
          return fromJson(first) as R;
        }
      }
      return null;
    }
  }
}

/*

class ResponseModel {
  final int? statusCode;
  final String status;
  final dynamic data;
  final String? cookies;

  const ResponseModel({this.statusCode, this.cookies, required this.status, required this.data});

  bool isRequestSucces() {
    return (data["Data"] as List).isNotEmpty && (data["Errors"] as List).isEmpty;
  }

  bool isDataAndErrorsEmpty() {
    return (data["Data"] as List).isEmpty && (data["Errors"] as List).isEmpty;
  }

  bool isDataPlacesApiIsNotEmpty() {
    return data["features"] != null && (data["features"] as List).isNotEmpty;
  }

  bool validerDocumentsCase() {
    final errorController = Get.put<GBSystemErrorController>(GBSystemErrorController());

    if (data["Errors"] != null && data["Errors"]!.isNotEmpty) {
      errorController.setCurrentError = GbsystemErrorServerModel(code: data["Errors"][0]["DefaultError"][0]["CODE"], message: data["Errors"][0]["DefaultError"][0]["MESSAGES"]);
    }

    return data["Errors"] != null && data["Errors"]!.isNotEmpty && (data["Errors"][0]["DefaultError"][0]["CODE"]) == "0605";
  }

  bool sessionExpirerCase() {
    final errorController = Get.put<GBSystemErrorController>(GBSystemErrorController());
    if (data["Errors"] != null && data["Errors"]!.isNotEmpty) {
      errorController.setCurrentError = GbsystemErrorServerModel(code: data["Errors"][0]["DefaultError"][0]["CODE"], message: data["Errors"][0]["DefaultError"][0]["MESSAGES"]);
    }

    return data["Errors"] != null && data["Errors"]!.isNotEmpty && (data["Errors"][0]["DefaultError"][0]["CODE"]) == "0538";
  }

  dynamic getElementFromDataList({String? elementName}) {
    dynamic result;
    for (var i = 0; i < (data["Data"] as List).length; i++) {
      if (data["Data"][i] != null && data["Data"][i] is Map && (data["Data"][i] as Map).containsKey(elementName ?? "ClientData") && data["Data"][i][elementName ?? "ClientData"] != null) {
        result = data["Data"][i][elementName ?? "ClientData"];
      }
    }
    return result;
  }

  dynamic get_Response_ClientData({String? elementName}) {
    dynamic result;
    for (var i = 0; i < (data["Data"] as List).length; i++) {
      if (data["Data"][i] != null && data["Data"][i] is Map && data["Data"][i][elementName ?? "ClientData"] != null) {
        result = data["Data"][i][elementName ?? "ClientData"];
      }
    }
    return (result as List).first;
  }
  

}
*/
