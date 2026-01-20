import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VacationModel {
  final String VAC_IDF;
  final String JOB_LIB;
  final String LIE_ADR;
  final String LIE_LIB;
  final String LIE_TLPH;
  final TimeOfDay HEURE_DEBUT;
  final TimeOfDay HEURE_FIN;
  final String VAC_HOUR_CALC;
  final String NOM_NUM_JOUR;
  final String? DAY_COLOR;
  final String TITLE;
  final String? VAC_BREAK;
  final String VAC_DURATION;
  final String LIE_LATITUDE;
  final String LIE_LONGITUDE;
  final String? LIE_PS_TYPE;
  final String SVR_CODE_LIB;
  final String? PNTG_START_HOUR;
  final String? PNTG_END_HOUR;
  final String? PNTGS_IN_NBR;
  final String? PNTGS_OUT_NBR;
  final DateTime? PNTGS_START_HOUR_IN;
  final DateTime? PNTGS_START_HOUR_OUT;
  //
  final DateTime? VAC_START_HOUR;
  final DateTime? VAC_END_HOUR;
  final String? VAC_DURATION_SECONDS;
  //

  final String? TPH_PSA;

  const VacationModel({
    required this.TPH_PSA,
    required this.VAC_IDF,
    required this.VAC_START_HOUR,
    required this.VAC_END_HOUR,
    required this.VAC_DURATION_SECONDS,
    this.DAY_COLOR,
    required this.HEURE_DEBUT,
    required this.HEURE_FIN,
    required this.JOB_LIB,
    required this.LIE_ADR,
    required this.LIE_LATITUDE,
    required this.LIE_LIB,
    required this.LIE_LONGITUDE,
    this.LIE_PS_TYPE,
    required this.LIE_TLPH,
    required this.NOM_NUM_JOUR,
    required this.PNTGS_IN_NBR,
    this.PNTGS_OUT_NBR,
    this.PNTGS_START_HOUR_IN,
    this.PNTGS_START_HOUR_OUT,
    this.PNTG_END_HOUR,
    this.PNTG_START_HOUR,
    required this.SVR_CODE_LIB,
    required this.TITLE,
    this.VAC_BREAK,
    required this.VAC_DURATION,
    required this.VAC_HOUR_CALC,
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

  int? get Pointage_In_NBR => PNTGS_IN_NBR != null && PNTGS_IN_NBR!.isNotEmpty
      ? int.parse(PNTGS_IN_NBR!)
      : null;
  int? get Pointage_Out_NBR =>
      PNTGS_OUT_NBR != null && PNTGS_OUT_NBR!.isNotEmpty
          ? int.parse(PNTGS_OUT_NBR!)
          : null;
  String? get Pointage_In_Time => PNTGS_START_HOUR_IN != null
      ? Add_zero(PNTGS_START_HOUR_IN?.hour) +
          ":" +
          Add_zero(PNTGS_START_HOUR_IN?.minute)
      : null;
  String? get Pointage_Out_Time => PNTGS_START_HOUR_OUT != null
      ? Add_zero(PNTGS_START_HOUR_OUT?.hour) +
          ":" +
          Add_zero(PNTGS_START_HOUR_OUT?.minute)
      : null;

  String? Pointage_InOut_Time(String Sens) {
    return Sens == "1" ? Pointage_In_Time : Pointage_Out_Time;
  }

  String get PointageIn {
    String result = "";
    if (PNTGS_START_HOUR_IN != null) {
      result = "${PNTGS_START_HOUR_IN?.hour}:${PNTGS_START_HOUR_IN?.minute}";
    }

    //return PNTGS_START_HOUR_IN != null ? "${PNTGS_START_HOUR_IN?.hour}:${PNTGS_START_HOUR_IN?.minute}" : "";
    return result;
  }

  String get PointageOut {
    return PNTGS_START_HOUR_OUT != null
        ? "${PNTGS_START_HOUR_OUT?.hour}:${PNTGS_START_HOUR_OUT?.minute}"
        : "";
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

  static VacationModel fromJson(json) {
    DateTime? PNTGS_START_HOUR_IN,
        PNTGS_START_HOUR_OUT,
        VAC_START_HOUR,
        VAC_END_HOUR;

    if (json["PNTGS_START_HOUR_IN"].toString().isNotEmpty) {
      PNTGS_START_HOUR_IN =
          DateFormat(detecteDateFormat(json["PNTGS_START_HOUR_IN"]))
              .parse(json["PNTGS_START_HOUR_IN"]);
    }
    if (json["PNTGS_START_HOUR_OUT"].toString().isNotEmpty) {
      PNTGS_START_HOUR_OUT =
          DateFormat(detecteDateFormat(json["PNTGS_START_HOUR_OUT"]))
              .parse(json["PNTGS_START_HOUR_OUT"]);
    }

    if (json["VAC_START_HOUR"].toString().isNotEmpty) {
      VAC_START_HOUR = DateFormat(detecteDateFormat(json["VAC_START_HOUR"]))
          .parse(json["VAC_START_HOUR"]);
    }
    if (json["VAC_END_HOUR"].toString().isNotEmpty) {
      VAC_END_HOUR = DateFormat(detecteDateFormat(json["VAC_END_HOUR"]))
          .parse(json["VAC_END_HOUR"]);
    }

    List<String> splitDebut = json["HEURE_DEBUT"].toString().split(':');
    int hours = int.parse(splitDebut[0]);
    int minutes = int.parse(splitDebut[1]);
    TimeOfDay heureDebut = TimeOfDay(hour: hours, minute: minutes);
    List<String> splitFin = json["HEURE_FIN"].toString().split(':');
    int hoursFin = int.parse(splitFin[0]);
    int minutesFin = int.parse(splitFin[1]);

    TimeOfDay heureFin = TimeOfDay(hour: hoursFin, minute: minutesFin);

    return VacationModel(
      HEURE_DEBUT: heureDebut,
      HEURE_FIN: heureFin,
      VAC_START_HOUR: VAC_START_HOUR,
      VAC_END_HOUR: VAC_END_HOUR,
      VAC_DURATION_SECONDS: json["VAC_DURATION_SECONDS"],
      JOB_LIB: json["JOB_LIB"],
      TPH_PSA: json["TPH_PSA"],
      LIE_ADR: json["LIE_ADR"],
      LIE_LATITUDE: json["LIE_LATITUDE"],
      LIE_LIB: json["LIE_LIB"],
      LIE_LONGITUDE: json["LIE_LONGITUDE"],
      LIE_TLPH: json["LIE_TLPH"],
      NOM_NUM_JOUR: json["NOM_NUM_JOUR"],
      PNTGS_IN_NBR: json["PNTGS_IN_NBR"],
      SVR_CODE_LIB: json["SVR_CODE_LIB"],
      TITLE: json["TITLE"],
      VAC_DURATION: json["VAC_DURATION"],
      VAC_HOUR_CALC: json["VAC_HOUR_CALC"],
      VAC_IDF: json["VAC_IDF"],
      DAY_COLOR: json["DAY_COLOR"],
      LIE_PS_TYPE: json["LIE_PS_TYPE"],
      PNTGS_OUT_NBR: json["PNTGS_OUT_NBR"],
      PNTGS_START_HOUR_IN: PNTGS_START_HOUR_IN,
      PNTGS_START_HOUR_OUT: PNTGS_START_HOUR_OUT,
      PNTG_END_HOUR: json["PNTG_END_HOUR"],
      PNTG_START_HOUR: json["PNTG_START_HOUR"],
      VAC_BREAK: json["VAC_BREAK"],
    );
  }

  static List<VacationModel> convertDynamictoListVacations(
      List<dynamic> vacationsDynamic) {
    List<VacationModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(VacationModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
