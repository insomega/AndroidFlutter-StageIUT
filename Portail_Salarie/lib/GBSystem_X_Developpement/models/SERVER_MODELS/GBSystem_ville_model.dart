import 'package:intl/intl.dart';

class GbsystemVilleModel {
  final String? VIL_UIDF;
  final String VIL_IDF;
  final String VIL_CODE;
  final String VIL_LIB;
  final String? VIL_DEPART;
  final String? VIL_REGION;
  final String? USER_IDF;
  final DateTime? LAST_UPDT;
  final DateTime? VIL_START_DATE;
  final DateTime? VIL_END_DATE;
  final String? DGRP_IDF;
  final String? VILREG_IDF;
  final String? DEP_IDF;
  final String? PYS_IDF;
  final String? USR_LIB;
  final String? DGRP_CODE;
  final String? DGRP_LIB;
  final String? VILREG_CODE;
  final String? VILREG_LIB;
  final String? DEP_CODE;
  final String? DEP_LIB;
  final String? PYS_CODE;
  final String? PYS_LIB;
  final String? ROW_ID;

  const GbsystemVilleModel({
    required this.DEP_CODE,
    required this.DEP_IDF,
    required this.DEP_LIB,
    required this.DGRP_CODE,
    required this.DGRP_IDF,
    required this.DGRP_LIB,
    required this.LAST_UPDT,
    required this.PYS_CODE,
    required this.PYS_IDF,
    required this.PYS_LIB,
    required this.ROW_ID,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.VILREG_CODE,
    required this.VILREG_IDF,
    required this.VILREG_LIB,
    required this.VIL_CODE,
    required this.VIL_DEPART,
    required this.VIL_END_DATE,
    required this.VIL_IDF,
    required this.VIL_LIB,
    required this.VIL_REGION,
    required this.VIL_START_DATE,
    required this.VIL_UIDF,
  });

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
    List<String> formats = [
      'dd/MM/yyyy HH:mm:ss',
      'dd/MM/yyyy',
      'dd/MM/yyyy HH:mm:ss.SSS'
    ];
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

  static GbsystemVilleModel fromJson(json) {
    DateTime? LAST_UPDT, VIL_START_DATE, VIL_END_DATE;

    if (json["LAST_UPDT"] != null && json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    if (json["VIL_START_DATE"] != null &&
        json["VIL_START_DATE"].toString().isNotEmpty) {
      VIL_START_DATE = DateFormat(detecteDateFormat(json["VIL_START_DATE"]))
          .parse(json["VIL_START_DATE"]);
    }
    if (json["VIL_END_DATE"] != null &&
        json["VIL_END_DATE"].toString().isNotEmpty) {
      VIL_END_DATE = DateFormat(detecteDateFormat(json["VIL_END_DATE"]))
          .parse(json["VIL_END_DATE"]);
    }

    return GbsystemVilleModel(
      LAST_UPDT: LAST_UPDT,
      VIL_START_DATE: VIL_START_DATE,
      VIL_END_DATE: VIL_END_DATE,
      DEP_CODE: json["DEP_CODE"],
      DEP_IDF: json["DEP_IDF"],
      DEP_LIB: json["DEP_LIB"],
      DGRP_CODE: json["DGRP_CODE"],
      DGRP_IDF: json["DGRP_IDF"],
      DGRP_LIB: json["DGRP_LIB"],
      PYS_CODE: json["PYS_CODE"],
      PYS_IDF: json["PYS_IDF"],
      PYS_LIB: json["PYS_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      VILREG_CODE: json["VILREG_CODE"],
      VILREG_IDF: json["VILREG_IDF"],
      ROW_ID: json["ROW_ID"],
      VILREG_LIB: json["VILREG_LIB"],
      VIL_CODE: json["VIL_CODE"],
      VIL_DEPART: json["VIL_DEPART"],
      VIL_IDF: json["VIL_IDF"],
      VIL_LIB: json["VIL_LIB"],
      VIL_REGION: json["VIL_REGION"],
      VIL_UIDF: json["VIL_UIDF"],
    );
  }

  static List<GbsystemVilleModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<GbsystemVilleModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(GbsystemVilleModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
