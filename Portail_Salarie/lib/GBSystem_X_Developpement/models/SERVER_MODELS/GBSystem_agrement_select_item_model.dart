import 'package:intl/intl.dart';

class getAgrementSelectItemModel {
  final String HAB_UIDF;
  final String HAB_IDF;
  final String HAB_CODE;
  final String HAB_LIB;
  final DateTime? LAST_UPDT;
  final String? USER_IDF;
  final DateTime? HAB_START_DATE;
  final DateTime? HAB_END_DATE;
  final String? DGRP_IDF;
  final String? DGRP_CODE;
  final String? DGRP_LIB;
  final String? USR_LIB;
  final String ROW_ID;

  const getAgrementSelectItemModel({
    required this.DGRP_CODE,
    required this.LAST_UPDT,
    required this.DGRP_IDF,
    required this.DGRP_LIB,
    required this.HAB_CODE,
    required this.HAB_END_DATE,
    required this.HAB_IDF,
    required this.HAB_LIB,
    required this.HAB_START_DATE,
    required this.HAB_UIDF,
    required this.ROW_ID,
    required this.USER_IDF,
    required this.USR_LIB,
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

  static getAgrementSelectItemModel fromJson(json) {
    DateTime? HAB_START_DATE, HAB_END_DATE, LAST_UPDT;

    if (json["HAB_START_DATE"].toString().isNotEmpty) {
      HAB_START_DATE = DateFormat(detecteDateFormat(json["HAB_START_DATE"]))
          .parse(json["HAB_START_DATE"]);
    }

    if (json["HAB_END_DATE"].toString().isNotEmpty) {
      HAB_END_DATE = DateFormat(detecteDateFormat(json["HAB_END_DATE"]))
          .parse(json["HAB_END_DATE"]);
    }

    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }

    return getAgrementSelectItemModel(
      HAB_START_DATE: HAB_START_DATE,
      LAST_UPDT: LAST_UPDT,
      HAB_END_DATE: HAB_END_DATE,
      DGRP_CODE: json["DGRP_CODE"],
      DGRP_IDF: json["DGRP_IDF"],
      DGRP_LIB: json["DGRP_LIB"],
      HAB_CODE: json["HAB_CODE"],
      HAB_IDF: json["HAB_IDF"],
      HAB_LIB: json["HAB_LIB"],
      HAB_UIDF: json["HAB_UIDF"],
      ROW_ID: json["ROW_ID"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
    );
  }

  static List<getAgrementSelectItemModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<getAgrementSelectItemModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations
          .add(getAgrementSelectItemModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
