import 'package:gbsystem_root/GBSystem_Root_DataModel.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';

class EntrepriseCode_URL_S19_Model extends GBSystem_Root_DataModel {
  final String SYSMENT_CODE;
  final String SYSMENT_APPNAME;
  final String SYSMENT_URL;
  final String? SYSMENT_S19;

  EntrepriseCode_URL_S19_Model({required this.SYSMENT_APPNAME, required this.SYSMENT_CODE, required this.SYSMENT_S19, required this.SYSMENT_URL});

  // static EntrepriseCode_URL_S19_Model fromJson(json) {
  //   return EntrepriseCode_URL_S19_Model(SYSMENT_APPNAME: json["SYSMENT_APPNAME"], SYSMENT_CODE: json["SYSMENT_CODE"], SYSMENT_S19: json["SYSMENT_S19"], SYSMENT_URL: json["SYSMENT_URL"]);
  // }

  factory EntrepriseCode_URL_S19_Model.fromJson(Map<String, dynamic> json) {
    return EntrepriseCode_URL_S19_Model(
      SYSMENT_APPNAME: json["SYSMENT_APPNAME"], //
      SYSMENT_CODE: json["SYSMENT_CODE"],
      SYSMENT_S19: json["SYSMENT_S19"],
      SYSMENT_URL: json["SYSMENT_URL"],
    );
  }
  static EntrepriseCode_URL_S19_Model? fromResponse(ResponseModel response) {
    return response.get_Response_in_Datamodel<EntrepriseCode_URL_S19_Model>(fromJson: (json) => EntrepriseCode_URL_S19_Model.fromJson(json));
  }
}

class GBSystem_Login_DataModel {
  String email;
  String password;
  String? dos_code;
  String? dos_idf;
  GBSystem_Login_DataModel({
    required this.email, //
    required this.password,
    this.dos_code,
    this.dos_idf,
  });
}
