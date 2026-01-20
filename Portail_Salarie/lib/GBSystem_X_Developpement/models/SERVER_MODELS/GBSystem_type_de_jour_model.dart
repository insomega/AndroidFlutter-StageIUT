import 'package:intl/intl.dart';

class TypeDeJourModel {
  final String? SYSDAY_UIDF;
  final String SYSDAY_IDF;
  final String SYSDAY_NUM;
  final String SYSDAY_SHORTDESC;
  final String SYSDAY_LONGDESC;
  final String SYSDAY_LNGGE;
  final DateTime? LAST_UPDT;
  final String? USER_IDF;
  final String? DGRP_IDF;
  final DateTime? SYSDAY_END_DATE;
  final DateTime? SYSDAY_START_DATE;
  final String? DGRP_CODE;
  final String? DGRP_LIB;
  final String? USR_LIB;
  final String? ROW_ID;

  const TypeDeJourModel({
    required this.DGRP_CODE,
    required this.DGRP_IDF,
    required this.DGRP_LIB,
    required this.ROW_ID,
    required this.SYSDAY_END_DATE,
    required this.SYSDAY_LNGGE,
    required this.SYSDAY_LONGDESC,
    required this.SYSDAY_START_DATE,
    required this.SYSDAY_UIDF,
    required this.SYSDAY_IDF,
    required this.SYSDAY_NUM,
    required this.SYSDAY_SHORTDESC,
    required this.USR_LIB,
    required this.LAST_UPDT,
    required this.USER_IDF,
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

  static TypeDeJourModel fromJson(Map<String, dynamic> json) {
    DateTime? SYSDAY_END_DATE, SYSDAY_START_DATE, LAST_UPDT;

    if (json["SYSDAY_END_DATE"].toString().isNotEmpty) {
      SYSDAY_END_DATE = DateFormat(detecteDateFormat(json["SYSDAY_END_DATE"]))
          .parse(json["SYSDAY_END_DATE"]);
    }
    if (json["SYSDAY_START_DATE"].toString().isNotEmpty) {
      SYSDAY_START_DATE =
          DateFormat(detecteDateFormat(json["SYSDAY_START_DATE"]))
              .parse(json["SYSDAY_START_DATE"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    return TypeDeJourModel(
      SYSDAY_START_DATE: SYSDAY_START_DATE,
      DGRP_CODE: json['DGRP_CODE'],
      DGRP_IDF: json['DGRP_IDF'],
      SYSDAY_END_DATE: SYSDAY_END_DATE,
      DGRP_LIB: json['DGRP_LIB'],
      ROW_ID: json['ROW_ID'],
      SYSDAY_LNGGE: json['SYSDAY_LNGGE'],
      SYSDAY_LONGDESC: json['SYSDAY_LONGDESC'],
      SYSDAY_UIDF: json['SYSDAY_UIDF'],
      SYSDAY_IDF: json['SYSDAY_IDF'],
      SYSDAY_NUM: json['SYSDAY_NUM'],
      SYSDAY_SHORTDESC: json['SYSDAY_SHORTDESC'],
      USR_LIB: json['USR_LIB'],
      LAST_UPDT: LAST_UPDT,
      USER_IDF: json['USER_IDF'],
    );
  }

  static List<TypeDeJourModel> convertDynamicToList(List<dynamic> data) {
    List<TypeDeJourModel> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(TypeDeJourModel.fromJson(data[i]));
    }
    return list;
  }
}
