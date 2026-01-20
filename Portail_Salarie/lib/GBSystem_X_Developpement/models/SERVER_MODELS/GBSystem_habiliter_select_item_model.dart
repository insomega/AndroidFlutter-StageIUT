import 'package:intl/intl.dart';

class getHabiliterSelectItemModel {
  final String FOR_UIDF;
  final String FOR_IDF;
  final String FOR_CODE;
  final String FOR_LIB;
  final DateTime? LAST_UPDT;
  final String? USER_IDF;
  final DateTime? FOR_START_DATE;
  final DateTime? FOR_END_DATE;
  final String? DGRP_IDF;
  final String? FOR_NB_UNIT;
  final String? FOR_TYP_UNIT;
  final String? DGRP_CODE;
  final String? DGRP_LIB;
  final String? USR_LIB;
  final String ROW_ID;

  const getHabiliterSelectItemModel({
    required this.DGRP_CODE,
    required this.LAST_UPDT,
    required this.DGRP_IDF,
    required this.DGRP_LIB,
    required this.FOR_CODE,
    required this.FOR_END_DATE,
    required this.FOR_IDF,
    required this.FOR_LIB,
    required this.FOR_NB_UNIT,
    required this.FOR_START_DATE,
    required this.FOR_TYP_UNIT,
    required this.FOR_UIDF,
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

  static getHabiliterSelectItemModel fromJson(json) {
    DateTime? FOR_START_DATE, FOR_END_DATE, LAST_UPDT;

    if (json["FOR_START_DATE"].toString().isNotEmpty) {
      FOR_START_DATE = DateFormat(detecteDateFormat(json["FOR_START_DATE"]))
          .parse(json["FOR_START_DATE"]);
    }

    if (json["FOR_END_DATE"].toString().isNotEmpty) {
      FOR_END_DATE = DateFormat(detecteDateFormat(json["FOR_END_DATE"]))
          .parse(json["FOR_END_DATE"]);
    }

    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }

    return getHabiliterSelectItemModel(
      FOR_START_DATE: FOR_START_DATE,
      LAST_UPDT: LAST_UPDT,
      FOR_END_DATE: FOR_END_DATE,
      DGRP_CODE: json["DGRP_CODE"],
      DGRP_IDF: json["DGRP_IDF"],
      DGRP_LIB: json["DGRP_LIB"],
      FOR_CODE: json["FOR_CODE"],
      FOR_IDF: json["FOR_IDF"],
      FOR_LIB: json["FOR_LIB"],
      FOR_NB_UNIT: json["FOR_NB_UNIT"],
      FOR_TYP_UNIT: json["FOR_TYP_UNIT"],
      FOR_UIDF: json["FOR_UIDF"],
      ROW_ID: json["ROW_ID"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
    );
  }

  static List<getHabiliterSelectItemModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<getHabiliterSelectItemModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations
          .add(getHabiliterSelectItemModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
