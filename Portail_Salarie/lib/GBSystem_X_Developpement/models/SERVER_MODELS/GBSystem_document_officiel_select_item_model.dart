import 'package:intl/intl.dart';

class getDocumentOfficielSelectItemModel {
  final String DOCOFF_UIDF;
  final String DOCOFF_IDF;
  final String DOCOFF_CODE;
  final String DOCOFF_LIB;
  final DateTime? LAST_UPDT;
  final String? USER_IDF;
  final DateTime? DOCOFF_START_DATE;
  final DateTime? DOCOFF_END_DATE;
  final String? DGRP_IDF;
  final String? DGRP_CODE;
  final String? DGRP_LIB;
  final String? USR_LIB;
  final String ROW_ID;

  final String? DOCOFF_CTRL;

  final String? DOCOFF_REG;
  final String? DOCOFF_OBG;
  const getDocumentOfficielSelectItemModel({
    required this.DGRP_CODE,
    required this.LAST_UPDT,
    required this.DGRP_IDF,
    required this.DGRP_LIB,
    required this.DOCOFF_CODE,
    required this.DOCOFF_END_DATE,
    required this.DOCOFF_IDF,
    required this.DOCOFF_LIB,
    required this.DOCOFF_START_DATE,
    required this.DOCOFF_UIDF,
    required this.ROW_ID,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.DOCOFF_CTRL,
    required this.DOCOFF_OBG,
    required this.DOCOFF_REG,
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

  static getDocumentOfficielSelectItemModel fromJson(json) {
    DateTime? DOCOFF_START_DATE, DOCOFF_END_DATE, LAST_UPDT;

    if (json["DOCOFF_START_DATE"].toString().isNotEmpty) {
      DOCOFF_START_DATE =
          DateFormat(detecteDateFormat(json["DOCOFF_START_DATE"]))
              .parse(json["DOCOFF_START_DATE"]);
    }

    if (json["DOCOFF_END_DATE"].toString().isNotEmpty) {
      DOCOFF_END_DATE = DateFormat(detecteDateFormat(json["DOCOFF_END_DATE"]))
          .parse(json["DOCOFF_END_DATE"]);
    }

    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }

    return getDocumentOfficielSelectItemModel(
      DOCOFF_START_DATE: DOCOFF_START_DATE,
      LAST_UPDT: LAST_UPDT,
      DOCOFF_END_DATE: DOCOFF_END_DATE,
      DGRP_CODE: json["DGRP_CODE"],
      DGRP_IDF: json["DGRP_IDF"],
      DGRP_LIB: json["DGRP_LIB"],
      DOCOFF_CODE: json["DOCOFF_CODE"],
      DOCOFF_IDF: json["DOCOFF_IDF"],
      DOCOFF_LIB: json["DOCOFF_LIB"],
      DOCOFF_UIDF: json["DOCOFF_UIDF"],
      ROW_ID: json["ROW_ID"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      DOCOFF_CTRL: json["DOCOFF_CTRL"],
      DOCOFF_OBG: json["DOCOFF_OBG"],
      DOCOFF_REG: json["DOCOFF_REG"],
    );
  }

  static List<getDocumentOfficielSelectItemModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<getDocumentOfficielSelectItemModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(
          getDocumentOfficielSelectItemModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
