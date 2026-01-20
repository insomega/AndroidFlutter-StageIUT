import 'package:intl/intl.dart';

class AbsenceModel {
  final String? CLR_CODE;
  final String? SVR_CODE;
  final String? SVR_LIB;
  final String? TPH_CODE;
  final String? TPH_LIB;
  final String? SVR_NOM;
  final String? SVR_PRNOM;
  final String? PLATPHD_UIDF;
  final String? PLATPHD_IDF;
  final String? PPLATPHD_IDF;
  final String? TPH_IDF;
  final String? SVR_IDF;
  final DateTime? PLATPH_START_HOUR;
  final DateTime? PLATPH_END_HOUR;
  final String? PLATPH_MMO;
  final String? PLATPH_MMO2;
  final String? PLATPH_ETAT;
  final DateTime? PLATPH_DEMAND_DATE;
  final DateTime? PLATPH_ETAT_DATE;
  final String? MAIL_IDF;
  final String? SMS_IDF;
  final String? PLATPH_VAC_IDF;
  final DateTime? LAST_UPDT;
  final String? USER_IDF;
  final String? USR_CODE;
  final String? CLR_CODE_colorweb;

  const AbsenceModel({
    required this.CLR_CODE,
    required this.SVR_CODE,
    required this.SVR_LIB,
    required this.TPH_CODE,
    required this.TPH_LIB,
    required this.SVR_NOM,
    required this.SVR_PRNOM,
    required this.PLATPHD_UIDF,
    required this.PLATPHD_IDF,
    required this.PPLATPHD_IDF,
    required this.TPH_IDF,
    required this.SVR_IDF,
    required this.PLATPH_START_HOUR,
    required this.PLATPH_END_HOUR,
    required this.PLATPH_MMO,
    required this.PLATPH_MMO2,
    required this.PLATPH_ETAT,
    required this.PLATPH_DEMAND_DATE,
    required this.PLATPH_ETAT_DATE,
    required this.MAIL_IDF,
    required this.SMS_IDF,
    required this.PLATPH_VAC_IDF,
    required this.LAST_UPDT,
    required this.USER_IDF,
    required this.USR_CODE,
    required this.CLR_CODE_colorweb,
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

  static AbsenceModel fromJson(Map<String, dynamic> json) {
    DateTime? PLATPH_START_HOUR,
        PLATPH_END_HOUR,
        PLATPH_DEMAND_DATE,
        PLATPH_ETAT_DATE,
        LAST_UPDT;
    if (json["PLATPH_START_HOUR"].toString().isNotEmpty) {
      PLATPH_START_HOUR =
          DateFormat(detecteDateFormat(json["PLATPH_START_HOUR"]))
              .parse(json["PLATPH_START_HOUR"]);
    }
    if (json["PLATPH_END_HOUR"].toString().isNotEmpty) {
      PLATPH_END_HOUR = DateFormat(detecteDateFormat(json["PLATPH_END_HOUR"]))
          .parse(json["PLATPH_END_HOUR"]);
    }
    if (json["PLATPH_DEMAND_DATE"].toString().isNotEmpty) {
      PLATPH_DEMAND_DATE =
          DateFormat(detecteDateFormat(json["PLATPH_DEMAND_DATE"]))
              .parse(json["PLATPH_DEMAND_DATE"]);
    }
    if (json["PLATPH_ETAT_DATE"].toString().isNotEmpty) {
      PLATPH_ETAT_DATE = DateFormat(detecteDateFormat(json["PLATPH_ETAT_DATE"]))
          .parse(json["PLATPH_ETAT_DATE"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }

    return AbsenceModel(
      CLR_CODE: json['CLR_CODE'],
      SVR_CODE: json['SVR_CODE'],
      SVR_LIB: json['SVR_LIB'],
      TPH_CODE: json['TPH_CODE'],
      TPH_LIB: json['TPH_LIB'],
      SVR_NOM: json['SVR_NOM'],
      SVR_PRNOM: json['SVR_PRNOM'],
      PLATPHD_UIDF: json['PLATPHD_UIDF'],
      PLATPHD_IDF: json['PLATPHD_IDF'],
      PPLATPHD_IDF: json['PPLATPHD_IDF'],
      TPH_IDF: json['TPH_IDF'],
      SVR_IDF: json['SVR_IDF'],
      PLATPH_START_HOUR: PLATPH_START_HOUR,
      PLATPH_END_HOUR: PLATPH_END_HOUR,
      PLATPH_MMO: json['PLATPH_MMO'],
      PLATPH_MMO2: json['PLATPH_MMO2'],
      PLATPH_ETAT: json['PLATPH_ETAT'],
      PLATPH_DEMAND_DATE: PLATPH_DEMAND_DATE,
      PLATPH_ETAT_DATE: PLATPH_ETAT_DATE,
      MAIL_IDF: json['MAIL_IDF'],
      SMS_IDF: json['SMS_IDF'],
      PLATPH_VAC_IDF: json['PLATPH_VAC_IDF'],
      LAST_UPDT: LAST_UPDT,
      USER_IDF: json['USER_IDF'],
      USR_CODE: json['USR_CODE'],
      CLR_CODE_colorweb: json['CLR_CODE_colorweb'],
    );
  }

  static List<AbsenceModel> convertDynamicToList(List<dynamic> data) {
    List<AbsenceModel> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(AbsenceModel.fromJson(data[i]));
    }
    return list;
  }
}
