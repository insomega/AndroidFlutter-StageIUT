import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VacationStateModel {
  final String VAC_IDF;
  final String STATE;
  final String ORDRE;
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
  final DateTime? VAC_PUB_DATE;
  final String? DISTANCE;
  final String STATE_COLOR;
  const VacationStateModel({
    required this.VAC_IDF,
    this.DAY_COLOR,
    required this.HEURE_DEBUT,
    required this.HEURE_FIN,
    required this.JOB_LIB,
    required this.LIE_ADR,
    required this.LIE_LATITUDE,
    required this.LIE_LIB,
    required this.LIE_LONGITUDE,
    required this.DISTANCE,
    required this.LIE_TLPH,
    required this.NOM_NUM_JOUR,
    required this.ORDRE,
   required this.STATE,
   required  this.STATE_COLOR,
   required  this.VAC_PUB_DATE,
    required this.TITLE,
    required this.VAC_BREAK,
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
  static String convertDate(DateTime dateTime) {
    return "${Add_zero(dateTime.day)}/${Add_zero(dateTime.month)}/${Add_zero(dateTime.year)}";
  }

static String convertDateAndTime(DateTime dateTime) {
    return "${Add_zero(dateTime.day)}/${Add_zero(dateTime.month)}/${Add_zero(dateTime.year)} ${Add_zero(dateTime.hour)}:${Add_zero(dateTime.minute)}";
  }


   static VacationStateModel fromJson(json) {
    DateTime? VAC_PUB_DATE;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');

    if (json["VAC_PUB_DATE"].toString().isNotEmpty) {
      VAC_PUB_DATE = originalFormat.parse(json["VAC_PUB_DATE"]);
    }
    
    List<String> splitDebut = json["HEURE_DEBUT"].toString().split(':');
    int hours = int.parse(splitDebut[0]);
    int minutes = int.parse(splitDebut[1]);
    TimeOfDay heureDebut = TimeOfDay(hour: hours, minute: minutes);
    List<String> splitFin = json["HEURE_FIN"].toString().split(':');
    int hoursFin = int.parse(splitFin[0]);
    int minutesFin = int.parse(splitFin[1]);

    TimeOfDay heureFin = TimeOfDay(hour: hoursFin, minute: minutesFin);

    return VacationStateModel(
      HEURE_DEBUT: heureDebut,
      HEURE_FIN: heureFin,
      JOB_LIB: json["JOB_LIB"],
      LIE_ADR: json["LIE_ADR"],
      LIE_LATITUDE: json["LIE_LATITUDE"],
      LIE_LIB: json["LIE_LIB"],
      LIE_LONGITUDE: json["LIE_LONGITUDE"],
      LIE_TLPH: json["LIE_TLPH"],
      NOM_NUM_JOUR: json["NOM_NUM_JOUR"],
      DISTANCE: json["DISTANCE"],
      ORDRE: json["ORDRE"],
      TITLE: json["TITLE"],
      VAC_DURATION: json["VAC_DURATION"],
      VAC_HOUR_CALC: json["VAC_HOUR_CALC"],
      VAC_IDF: json["VAC_IDF"],
      DAY_COLOR: json["DAY_COLOR"],
      STATE: json["STATE"],
      STATE_COLOR: json["STATE_COLOR"],
      VAC_PUB_DATE: VAC_PUB_DATE,
      VAC_BREAK: json["VAC_BREAK"],
    );
  }

  static List<VacationStateModel> convertDynamictoListVacations(
      List<dynamic> vacationsDynamic) {
    List<VacationStateModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(VacationStateModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
