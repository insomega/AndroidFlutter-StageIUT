import 'package:gbsystem_root/GBSystem_Root_DataModel.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:intl/intl.dart';

class GbsystemArticleRefModel extends GBSystem_Root_DataModel {
  final String ARTREF_IDF;
  final String ARTCAT_IDF;
  final String ARTCAT_CODE;
  final String ARTCAT_LIB;
  final String ARTREF_CODE;
  final String ARTREF_LIB;
  final String ARTREF_TYPE;
  final DateTime? ARTREF_START_DATE;
  final DateTime? ARTREF_END_DATE;
  final String ARTREF_DUREE_VIE_TYPE;
  final String ARTREF_DUREE_VIE_UNIT;

  final String? ARTREF_UIDF;
  final String? USER_IDF;
  final DateTime? LAST_UPDT;
  final String? USR_LIB;
  final String? MGP_IDF;

  GbsystemArticleRefModel({
    required this.ARTCAT_IDF,
    required this.ARTCAT_LIB,
    required this.ARTCAT_CODE,
    required this.ARTREF_DUREE_VIE_TYPE,
    required this.ARTREF_CODE,
    required this.ARTREF_IDF,
    required this.ARTREF_LIB,
    required this.ARTREF_DUREE_VIE_UNIT,
    required this.ARTREF_END_DATE,
    required this.ARTREF_START_DATE,
    required this.ARTREF_TYPE,
    required this.ARTREF_UIDF,
    required this.LAST_UPDT,
    required this.MGP_IDF,
    required this.USER_IDF,
    required this.USR_LIB,
  });

  static GbsystemArticleRefModel? fromResponse(ResponseModel response) {
    return response.get_Response_in_Datamodel<GbsystemArticleRefModel>(fromJson: (json) => GbsystemArticleRefModel.fromJson(json));
  }

  // static List<GbsystemArticleRefModel>? fromResponse_List(ResponseModel response) {
  //   return response.get_Response_in_Datamodel_List<GbsystemArticleRefModel, List<GbsystemArticleRefModel>>(fromJson: (json) => GbsystemArticleRefModel.fromJson(json));
  // }

  static String Add_zero(int? value) {
    if (value! < 10) {
      return "0$value";
    } else {
      return "$value";
    }
  }

  static String convertTime(DateTime dateTime) {
    return "${Add_zero(dateTime.hour)}:${Add_zero(dateTime.minute)}";
  }

  static String convertDate(DateTime dateTime) {
    return "${Add_zero(dateTime.day)}/${Add_zero(dateTime.month)}/${Add_zero(dateTime.year)}";
  }

  static String convertDateAndTime(DateTime dateTime) {
    return "${Add_zero(dateTime.day)}/${Add_zero(dateTime.month)}/${Add_zero(dateTime.year)} ${Add_zero(dateTime.hour)}:${Add_zero(dateTime.minute)}";
  }

  static String detecteDateFormat(String dateString) {
    List<String> formats = ['dd/MM/yyyy HH:mm:ss', 'dd/MM/yyyy', 'dd/MM/yyyy HH:mm:ss.SSS'];
    for (var format in formats) {
      try {
        DateFormat(format).parseStrict(dateString);
        return format;
      } catch (e) {
        // print(e.toString());
      }
    }
    return 'dd/MM/yyyy';
  }

  static GbsystemArticleRefModel fromJson(json) {
    DateTime? ARTREF_END_DATE, ARTREF_START_DATE, LAST_UPDT;

    if (json["ARTREF_START_DATE"].toString().isNotEmpty) {
      ARTREF_START_DATE = DateFormat(detecteDateFormat(json["ARTREF_START_DATE"])).parse(json["ARTREF_START_DATE"]);
    }
    if (json["ARTREF_END_DATE"].toString().isNotEmpty) {
      ARTREF_END_DATE = DateFormat(detecteDateFormat(json["ARTREF_END_DATE"])).parse(json["ARTREF_END_DATE"]);
    }
    if (json["LAST_UPDT"] != null && json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"])).parse(json["LAST_UPDT"]);
    }
    return GbsystemArticleRefModel(
      ARTCAT_IDF: json["ARTCAT_IDF"],
      ARTCAT_LIB: json["ARTCAT_LIB"],
      ARTCAT_CODE: json["ARTCAT_CODE"],
      ARTREF_DUREE_VIE_TYPE: json["ARTREF_DUREE_VIE_TYPE"],
      ARTREF_CODE: json["ARTREF_CODE"],
      ARTREF_IDF: json["ARTREF_IDF"],
      ARTREF_LIB: json["ARTREF_LIB"],
      ARTREF_DUREE_VIE_UNIT: json["ARTREF_DUREE_VIE_UNIT"],
      ARTREF_TYPE: json["ARTREF_TYPE"],
      ARTREF_UIDF: json["ARTREF_UIDF"],
      MGP_IDF: json["MGP_IDF"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      ARTREF_END_DATE: ARTREF_END_DATE,
      ARTREF_START_DATE: ARTREF_START_DATE,
      LAST_UPDT: LAST_UPDT,
    );
  }

  static List<GbsystemArticleRefModel> convertDynamictoListArticles(List<dynamic> sitesDynamic) {
    List<GbsystemArticleRefModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(GbsystemArticleRefModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
