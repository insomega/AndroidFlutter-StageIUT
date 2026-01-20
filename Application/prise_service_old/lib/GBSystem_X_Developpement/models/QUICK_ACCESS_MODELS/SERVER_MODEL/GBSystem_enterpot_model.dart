import 'package:intl/intl.dart';

class GbsystemEnterpotModel {
  final String ENTR_UIDF;
  final String ENTR_IDF;
  final String ENTR_CODE;
  final String ENTR_LIB;
  final String ENTR_ADR1;
  final String ENTR_ADR2;
  final String VIL_IDF;
  final String ENTR_CONT;
  final String ENTR_TELPH;
  final String ENTR_PORT;
  final String ENTR_EMAIL;
  final String ENTR_MMO;
  final DateTime? ENTR_START_DATE;
  final DateTime? ENTR_END_DATE;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String USR_LIB;
  final String VIL_CODE;
  final String VIL_LIB;
  final String ROW_ID;

  const GbsystemEnterpotModel({
    required this.ENTR_ADR1,
    required this.ENTR_ADR2,
    required this.ENTR_CODE,
    required this.ENTR_CONT,
    required this.ENTR_EMAIL,
    required this.ENTR_END_DATE,
    required this.ENTR_IDF,
    required this.ENTR_LIB,
    required this.ENTR_MMO,
    required this.ENTR_PORT,
    required this.ENTR_START_DATE,
    required this.ENTR_TELPH,
    required this.ENTR_UIDF,
    required this.ROW_ID,
    required this.LAST_UPDT,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.VIL_CODE,
    required this.VIL_LIB,
    required this.VIL_IDF,
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

  static GbsystemEnterpotModel fromJson(json) {
    DateTime? ENTR_END_DATE, ENTR_START_DATE, LAST_UPDT;

    if (json["ENTR_START_DATE"].toString().isNotEmpty) {
      ENTR_START_DATE = DateFormat(detecteDateFormat(json["ENTR_START_DATE"]))
          .parse(json["ENTR_START_DATE"]);
    }
    if (json["ENTR_END_DATE"].toString().isNotEmpty) {
      ENTR_END_DATE = DateFormat(detecteDateFormat(json["ENTR_END_DATE"]))
          .parse(json["ENTR_END_DATE"]);
    }
    return GbsystemEnterpotModel(
      ENTR_ADR1: json["ENTR_ADR1"],
      ENTR_ADR2: json["ENTR_ADR2"],
      ENTR_CODE: json["ENTR_CODE"],
      ENTR_CONT: json["ENTR_CONT"],
      ENTR_EMAIL: json["ENTR_EMAIL"],
      ENTR_IDF: json["ENTR_IDF"],
      ENTR_LIB: json["ENTR_LIB"],
      ENTR_MMO: json["ENTR_MMO"],
      ENTR_PORT: json["ENTR_PORT"],
      ENTR_TELPH: json["ENTR_TELPH"],
      ENTR_UIDF: json["ENTR_UIDF"],
      ROW_ID: json["ROW_ID"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      VIL_CODE: json["VIL_CODE"],
      VIL_IDF: json["VIL_IDF"],
      VIL_LIB: json["VIL_LIB"],
      ENTR_END_DATE: ENTR_END_DATE,
      LAST_UPDT: LAST_UPDT,
      ENTR_START_DATE: ENTR_START_DATE,
    );
  }

  static List<GbsystemEnterpotModel> convertDynamictoListEnterpot(
      List<dynamic> sitesDynamic) {
    List<GbsystemEnterpotModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(GbsystemEnterpotModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
