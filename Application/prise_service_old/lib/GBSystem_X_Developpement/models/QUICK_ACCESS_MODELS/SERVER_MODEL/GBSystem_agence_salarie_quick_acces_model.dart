import 'package:intl/intl.dart';

class AgenceSalarieQuickAccesModel {
  final String? LIEINSPQUSR_UIDF;
  final String? LIEINSPQUSR_IDF;
  final String? DOS_IDF;
  final String? USR_IDF;
  final String? LIE_IDF;
  final String? SVR_IDF;
  final String? CLI_IDF;
  final String? LIEINSPQSNR_IDF;
  final DateTime? START_PERIODE;
  final DateTime? END_PERIODE;
  final DateTime? CLOSED_DATE;
  final String? USER_IDF;
  final DateTime? LAST_UPDT;
  final DateTime? END_PERIODE_24;
  final String? LIE_CODE;
  final String? LIE_LIB;
  final String? DOS_CODE;
  final String? DOS_LIB;
  final String? USER_CODE;
  final String? USER_LIB;
  final String? LIEINSPQSNR_CODE;
  final String? LIEINSPQSNR_LIB;
  final String? USR_LIB;
  final String? LIEINSPQSNR_NOTATION_TYPE;
  final String? ROW_ID;

  const AgenceSalarieQuickAccesModel({
    required this.CLI_IDF,
    required this.CLOSED_DATE,
    required this.DOS_CODE,
    required this.DOS_IDF,
    required this.DOS_LIB,
    required this.LAST_UPDT,
    required this.LIEINSPQSNR_CODE,
    required this.END_PERIODE,
    required this.END_PERIODE_24,
    required this.LIEINSPQSNR_NOTATION_TYPE,
    required this.LIEINSPQUSR_IDF,
    required this.LIEINSPQUSR_UIDF,
    required this.LIE_CODE,
    required this.LIE_IDF,
    required this.LIE_LIB,
    required this.ROW_ID,
    required this.START_PERIODE,
    required this.SVR_IDF,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.LIEINSPQSNR_IDF,
    required this.LIEINSPQSNR_LIB,
    required this.USER_CODE,
    required this.USER_LIB,
    required this.USR_IDF,
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

  static AgenceSalarieQuickAccesModel fromJson(json) {
    DateTime? START_PERIODE;
    DateTime? END_PERIODE;
    DateTime? CLOSED_DATE;
    DateTime? LAST_UPDT;
    DateTime? END_PERIODE_24;

    if (json["START_PERIODE"].toString().isNotEmpty) {
      START_PERIODE = DateFormat(detecteDateFormat(json["START_PERIODE"]))
          .parse(json["START_PERIODE"]);
    }
    if (json["END_PERIODE"].toString().isNotEmpty) {
      END_PERIODE = DateFormat(detecteDateFormat(json["END_PERIODE"]))
          .parse(json["END_PERIODE"]);
    }
    if (json["CLOSED_DATE"].toString().isNotEmpty) {
      CLOSED_DATE = DateFormat(detecteDateFormat(json["CLOSED_DATE"]))
          .parse(json["CLOSED_DATE"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    if (json["END_PERIODE_24"].toString().isNotEmpty) {
      END_PERIODE_24 = DateFormat(detecteDateFormat(json["END_PERIODE_24"]))
          .parse(json["END_PERIODE_24"]);
    }

    return AgenceSalarieQuickAccesModel(
      LIEINSPQSNR_IDF: json["LIEINSPQSNR_IDF"],
      LIEINSPQSNR_LIB: json["LIEINSPQSNR_LIB"],
      CLI_IDF: json["CLI_IDF"],
      LAST_UPDT: LAST_UPDT,
      DOS_CODE: json["DOS_CODE"],
      DOS_IDF: json["DOS_IDF"],
      DOS_LIB: json["LIEINSQUESTYP_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      CLOSED_DATE: CLOSED_DATE,
      LIEINSPQSNR_CODE: json["LIEINSPQSNR_CODE"],
      LIEINSPQUSR_IDF: json["LIEINSPQUSR_IDF"],
      LIEINSPQUSR_UIDF: json["LIEINSPQUSR_UIDF"],
      LIE_CODE: json["LIE_CODE"],
      LIEINSPQSNR_NOTATION_TYPE: json["LIEINSPQSNR_NOTATION_TYPE"],
      LIE_IDF: json["LIE_IDF"],
      LIE_LIB: json["LIE_LIB"],
      ROW_ID: json["ROW_ID"],
      SVR_IDF: json["SVR_IDF"],
      USER_CODE: json["USER_CODE"],
      USER_LIB: json["USER_LIB"],
      USR_IDF: json["USR_IDF"],
      END_PERIODE: END_PERIODE,
      END_PERIODE_24: END_PERIODE_24,
      START_PERIODE: START_PERIODE,
    );
  }

  static List<AgenceSalarieQuickAccesModel> convertDynamictoListAgences(
      List<dynamic> vacationsDynamic) {
    List<AgenceSalarieQuickAccesModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations
          .add(AgenceSalarieQuickAccesModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
