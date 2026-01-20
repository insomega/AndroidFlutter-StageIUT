import 'package:intl/intl.dart';

class GbsystemColorModel {
  final String CLR_UIDF;
  final String CLR_IDF;
  final String CLR_CODE;
  final String CLR_LIB;
  final String CLR_CTGR;
  final String CLR_CAT;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final DateTime? CLR_END_DATE;
  final DateTime? CLR_START_DATE;
  final String DGRP_IDF;
  final String CLRCAT_LIB;
  final String DGRP_CODE;
  final String DGRP_LIB;
  final String USR_LIB;
  final String ROW_ID;
  final String CLR_CODE_colorweb;

  const GbsystemColorModel({
    required this.CLRCAT_LIB,
    required this.CLR_CAT,
    required this.CLR_CODE_colorweb,
    required this.CLR_CTGR,
    required this.CLR_END_DATE,
    required this.CLR_START_DATE,
    required this.CLR_UIDF,
    required this.DGRP_IDF,
    required this.DGRP_CODE,
    required this.DGRP_LIB,
    required this.CLR_CODE,
    required this.CLR_IDF,
    required this.LAST_UPDT,
    required this.CLR_LIB,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.ROW_ID,
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

  static GbsystemColorModel fromJson(json) {
    DateTime? CLR_END_DATE, CLR_START_DATE, LAST_UPDT;

    if (json["CLR_START_DATE"].toString().isNotEmpty) {
      CLR_START_DATE = DateFormat(detecteDateFormat(json["CLR_START_DATE"]))
          .parse(json["CLR_START_DATE"]);
    }
    if (json["CLR_END_DATE"].toString().isNotEmpty) {
      CLR_END_DATE = DateFormat(detecteDateFormat(json["CLR_END_DATE"]))
          .parse(json["CLR_END_DATE"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    return GbsystemColorModel(
      CLRCAT_LIB: json["CLRCAT_LIB"],
      CLR_CAT: json["CLR_CAT"],
      CLR_CODE_colorweb: json["CLR_CODE_colorweb"],
      CLR_CTGR: json["CLR_CTGR"],
      CLR_UIDF: json["CLR_UIDF"],
      DGRP_CODE: json["DGRP_CODE"],
      DGRP_IDF: json["DGRP_IDF"],
      DGRP_LIB: json["DGRP_LIB"],
      CLR_CODE: json["CLR_CODE"],
      CLR_IDF: json["CLR_IDF"],
      LAST_UPDT: LAST_UPDT,
      CLR_LIB: json["CLR_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      ROW_ID: json["ROW_ID"],
      CLR_END_DATE: CLR_END_DATE,
      CLR_START_DATE: CLR_START_DATE,
    );
  }

  static List<GbsystemColorModel> convertDynamictoListColor(
      List<dynamic> sitesDynamic) {
    List<GbsystemColorModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(GbsystemColorModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
