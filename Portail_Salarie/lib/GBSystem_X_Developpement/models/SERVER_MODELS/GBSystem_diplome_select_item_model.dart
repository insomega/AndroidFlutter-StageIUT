import 'package:intl/intl.dart';

class getDiplomeSelectItemModel {
  final String DIP_UIDF;
  final String DIP_IDF;
  final String DIP_CODE;
  final String DIP_LIB;
  final DateTime? LAST_UPDT;
  final String? USER_IDF;
  final DateTime? DIP_START_DATE;
  final DateTime? DIP_END_DATE;
  final String? DGRP_IDF;
  final String? DGRP_CODE;
  final String? DGRP_LIB;
  final String? USR_LIB;
  final String ROW_ID;

  const getDiplomeSelectItemModel({
    required this.DGRP_CODE,
    required this.LAST_UPDT,
    required this.DGRP_IDF,
    required this.DGRP_LIB,
    required this.DIP_CODE,
    required this.DIP_END_DATE,
    required this.DIP_IDF,
    required this.DIP_LIB,
    required this.DIP_START_DATE,
    required this.DIP_UIDF,
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

  static getDiplomeSelectItemModel fromJson(json) {
    DateTime? DIP_START_DATE, DIP_END_DATE, LAST_UPDT;

    if (json["DIP_START_DATE"].toString().isNotEmpty) {
      DIP_START_DATE = DateFormat(detecteDateFormat(json["DIP_START_DATE"]))
          .parse(json["DIP_START_DATE"]);
    }

    if (json["DIP_END_DATE"].toString().isNotEmpty) {
      DIP_END_DATE = DateFormat(detecteDateFormat(json["DIP_END_DATE"]))
          .parse(json["DIP_END_DATE"]);
    }

    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }

    return getDiplomeSelectItemModel(
      DIP_START_DATE: DIP_START_DATE,
      LAST_UPDT: LAST_UPDT,
      DIP_END_DATE: DIP_END_DATE,
      DGRP_CODE: json["DGRP_CODE"],
      DGRP_IDF: json["DGRP_IDF"],
      DGRP_LIB: json["DGRP_LIB"],
      DIP_CODE: json["DIP_CODE"],
      DIP_IDF: json["DIP_IDF"],
      DIP_LIB: json["DIP_LIB"],
      DIP_UIDF: json["DIP_UIDF"],
      ROW_ID: json["ROW_ID"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
    );
  }

  static List<getDiplomeSelectItemModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<getDiplomeSelectItemModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations
          .add(getDiplomeSelectItemModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
