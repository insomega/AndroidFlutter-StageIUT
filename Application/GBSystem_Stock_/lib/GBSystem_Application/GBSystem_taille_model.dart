import 'package:intl/intl.dart';

class GbsystemTailleModel {
  final String TPOI_UIDF;
  final String TPOI_IDF;
  final String TPOI_CODE;
  final String TPOI_LIB;
  final DateTime? TPOI_START_DATE;
  final DateTime? TPOI_END_DATE;
  final String DGRP_IDF;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String TPOI_CAT;
  final String ARTCAT_IDF;
  final String ARTCAT_CODE;
  final String ARTCAT_LIB;
  final String DGRP_LIB;
  final String DGRP_CODE;
  final String USR_LIB;

  const GbsystemTailleModel({
    required this.ARTCAT_CODE,
    required this.ARTCAT_IDF,
    required this.ARTCAT_LIB,
    required this.DGRP_CODE,
    required this.DGRP_IDF,
    required this.DGRP_LIB,
    required this.TPOI_CAT,
    required this.TPOI_CODE,
    required this.TPOI_END_DATE,
    required this.TPOI_IDF,
    required this.TPOI_LIB,
    required this.TPOI_START_DATE,
    required this.TPOI_UIDF,
    required this.LAST_UPDT,
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

  static GbsystemTailleModel fromJson(json) {
    DateTime? TPOI_END_DATE, TPOI_START_DATE, LAST_UPDT;

    if (json["TPOI_START_DATE"].toString().isNotEmpty) {
      TPOI_START_DATE = DateFormat(detecteDateFormat(json["TPOI_START_DATE"]))
          .parse(json["TPOI_START_DATE"]);
    }
    if (json["TPOI_END_DATE"].toString().isNotEmpty) {
      TPOI_END_DATE = DateFormat(detecteDateFormat(json["TPOI_END_DATE"]))
          .parse(json["TPOI_END_DATE"]);
    }
    return GbsystemTailleModel(
      ARTCAT_CODE: json["ARTCAT_CODE"],
      ARTCAT_IDF: json["ARTCAT_IDF"],
      ARTCAT_LIB: json["ARTCAT_LIB"],
      DGRP_CODE: json["DGRP_CODE"],
      DGRP_IDF: json["DGRP_IDF"],
      DGRP_LIB: json["DGRP_LIB"],
      TPOI_CAT: json["TPOI_CAT"],
      TPOI_CODE: json["TPOI_CODE"],
      TPOI_IDF: json["TPOI_IDF"],
      TPOI_LIB: json["TPOI_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      TPOI_UIDF: json["TPOI_UIDF"],
      TPOI_END_DATE: TPOI_END_DATE,
      LAST_UPDT: LAST_UPDT,
      TPOI_START_DATE: TPOI_START_DATE,
    );
  }

  static List<GbsystemTailleModel> convertDynamictoListTailles(
      List<dynamic> sitesDynamic) {
    List<GbsystemTailleModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(GbsystemTailleModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
