import 'package:intl/intl.dart';

class HabilitationModel {
  final String SFOR_UIDF;
  final String SFOR_IDF;
  final String SVR_IDF;
  final String FOR_IDF;
  final String? CRSE_IDF;
  final String? FOR_NOTA_IDF;
  final String? CRSE_STAT_IDF;
  final DateTime? SFOR_DATD;
  final DateTime? SFOR_DATF;
  final String? CRSE_AGENCE;
  final String? AGENCE_LIB;
  final String? SFOR_COMM;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String? DOCAN_IDF;
  final String FOR_CODE;
  final String FOR_LIB;
  final String SVR_CODE;
  final String SVR_LIB;
  final String? CRSE_STAT_CODE;
  final String? CRSE_STAT_LIB;
  final String? FOR_NOTA_CODE;
  final String? FOR_NOTA_LIB;
  final String? USR_LIB;
  final String? DOCAN_CODE;
  final String? DOCAN_LIB;
  final DateTime? VALID_DATE;
  final String ROW_ID;

  const HabilitationModel({
    required this.DOCAN_CODE,
    required this.LAST_UPDT,
    required this.DOCAN_IDF,
    required this.DOCAN_LIB,
    required this.AGENCE_LIB,
    required this.CRSE_AGENCE,
    required this.CRSE_IDF,
    required this.ROW_ID,
    required this.CRSE_STAT_CODE,
    required this.CRSE_STAT_IDF,
    required this.CRSE_STAT_LIB,
    required this.SVR_CODE,
    required this.SVR_IDF,
    required this.SVR_LIB,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.VALID_DATE,
    required this.FOR_CODE,
    required this.FOR_IDF,
    required this.FOR_LIB,
    required this.FOR_NOTA_CODE,
    required this.FOR_NOTA_IDF,
    required this.FOR_NOTA_LIB,
    required this.SFOR_COMM,
    required this.SFOR_DATD,
    required this.SFOR_DATF,
    required this.SFOR_IDF,
    required this.SFOR_UIDF,
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

  static HabilitationModel fromJson(json) {
    DateTime? SFOR_DATD, LAST_UPDT, SFOR_DATF, VALID_DATE;

    if (json["SFOR_DATD"].toString().isNotEmpty) {
      SFOR_DATD = DateFormat(detecteDateFormat(json["SFOR_DATD"]))
          .parse(json["SFOR_DATD"]);
    }
    if (json["SFOR_DATF"].toString().isNotEmpty) {
      SFOR_DATF = DateFormat(detecteDateFormat(json["SFOR_DATF"]))
          .parse(json["SFOR_DATF"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    if (json["VALID_DATE"].toString().isNotEmpty) {
      VALID_DATE = DateFormat(detecteDateFormat(json["VALID_DATE"]))
          .parse(json["VALID_DATE"]);
    }

    return HabilitationModel(
      SFOR_DATD: SFOR_DATD,
      LAST_UPDT: LAST_UPDT,
      SFOR_DATF: SFOR_DATF,
      DOCAN_CODE: json["DOCAN_CODE"],
      DOCAN_IDF: json["DOCAN_IDF"],
      DOCAN_LIB: json["DOCAN_LIB"],
      AGENCE_LIB: json["AGENCE_LIB"],
      CRSE_AGENCE: json["CRSE_AGENCE"],
      CRSE_IDF: json["CRSE_IDF"],
      ROW_ID: json["ROW_ID"],
      CRSE_STAT_CODE: json["CRSE_STAT_CODE"],
      CRSE_STAT_IDF: json["CRSE_STAT_IDF"],
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      CRSE_STAT_LIB: json["CRSE_STAT_LIB"],
      FOR_CODE: json["FOR_CODE"],
      FOR_IDF: json["FOR_IDF"],
      FOR_LIB: json["FOR_LIB"],
      FOR_NOTA_CODE: json["FOR_NOTA_CODE"],
      FOR_NOTA_IDF: json["FOR_NOTA_IDF"],
      FOR_NOTA_LIB: json["FOR_NOTA_LIB"],
      SFOR_COMM: json["SFOR_COMM"],
      SFOR_IDF: json["SFOR_IDF"],
      SFOR_UIDF: json["SFOR_UIDF"],
      VALID_DATE: VALID_DATE,
    );
  }

  static List<HabilitationModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<HabilitationModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(HabilitationModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
