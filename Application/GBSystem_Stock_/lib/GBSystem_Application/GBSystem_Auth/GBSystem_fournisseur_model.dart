import 'package:intl/intl.dart';

class GbsystemFournisseurModel {
  final String FOU_UIDF;
  final String FOU_IDF;
  final String FOU_CODE;
  final String VIL_IDF;
  final String FOU_LIB;
  final String FOU_ADR1;
  final String FOU_ADR2;
  final String FOU_RESP;
  final String FOU_TEL;
  final String FOU_TELPOR;
  final String FOU_FAX;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final DateTime? FOU_START_DATE;
  final DateTime? FOU_END_DATE;
  final String VIL_CODE;
  final String VIL_LIB;
  final String USR_LIB;

  const GbsystemFournisseurModel({
    required this.FOU_ADR1,
    required this.FOU_ADR2,
    required this.FOU_CODE,
    required this.FOU_END_DATE,
    required this.FOU_FAX,
    required this.FOU_IDF,
    required this.FOU_LIB,
    required this.FOU_RESP,
    required this.FOU_START_DATE,
    required this.FOU_TEL,
    required this.FOU_TELPOR,
    required this.FOU_UIDF,
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

  static GbsystemFournisseurModel fromJson(json) {
    DateTime? FOU_END_DATE, FOU_START_DATE, LAST_UPDT;

    if (json["FOU_START_DATE"].toString().isNotEmpty) {
      FOU_START_DATE = DateFormat(detecteDateFormat(json["FOU_START_DATE"]))
          .parse(json["FOU_START_DATE"]);
    }
    if (json["FOU_END_DATE"].toString().isNotEmpty) {
      FOU_END_DATE = DateFormat(detecteDateFormat(json["FOU_END_DATE"]))
          .parse(json["FOU_END_DATE"]);
    }
    return GbsystemFournisseurModel(
      FOU_ADR1: json["FOU_ADR1"],
      FOU_ADR2: json["FOU_ADR2"],
      FOU_CODE: json["FOU_CODE"],
      FOU_FAX: json["FOU_FAX"],
      FOU_IDF: json["FOU_IDF"],
      FOU_LIB: json["FOU_LIB"],
      FOU_RESP: json["FOU_RESP"],
      FOU_TEL: json["FOU_TEL"],
      FOU_TELPOR: json["FOU_TELPOR"],
      FOU_UIDF: json["FOU_UIDF"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      VIL_CODE: json["VIL_CODE"],
      VIL_IDF: json["VIL_IDF"],
      VIL_LIB: json["VIL_LIB"],
      FOU_END_DATE: FOU_END_DATE,
      LAST_UPDT: LAST_UPDT,
      FOU_START_DATE: FOU_START_DATE,
    );
  }

  static List<GbsystemFournisseurModel> convertDynamictoListFournisseur(
      List<dynamic> sitesDynamic) {
    List<GbsystemFournisseurModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(GbsystemFournisseurModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
