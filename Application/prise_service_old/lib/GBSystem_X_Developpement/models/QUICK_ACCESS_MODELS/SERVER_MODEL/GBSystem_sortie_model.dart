import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SortieModel {
  final String VAC_IDF;
  final String JOB_LIB;
  final String LIE_ADR;
  final String LIE_LIB;
  final String LIE_TLPH;
  final TimeOfDay HEURE_DEBUT;
  final TimeOfDay HEURE_FIN;
  final String VAC_HOUR_CALC;
  final String NOM_NUM_JOUR;
  final DateTime? PNTGS_START_HOUR_IN;
  final DateTime? PNTGS_START_HOUR_OUT;
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
  final String PNTGS_IN_NBR;
  final String? PNTGS_OUT_NBR;
 
  const SortieModel({
     this.DAY_COLOR,
    required this.HEURE_DEBUT,
    required this.HEURE_FIN,
    required this.LIE_LIB,
    required this.JOB_LIB,
    required this.LIE_ADR,
    required this.LIE_LATITUDE,
    required this.LIE_LONGITUDE,
    required this.VAC_IDF,
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

  static SortieModel fromJson(json) {
   DateTime? dateTimeStartOut,dateTimeStartIn;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
   if (json["PNTGS_START_HOUR_OUT"] != null) {
     dateTimeStartIn = originalFormat.parse(json["PNTGS_START_HOUR_IN"]);
   }
   if (json["PNTGS_START_HOUR_OUT"] != null) {
   dateTimeStartOut = originalFormat.parse(json["PNTGS_START_HOUR_OUT"]); 
   }
    
     List<String> splitDebut = json["HEURE_DEBUT"].toString().split(':');
  int hours = int.parse(splitDebut[0]);
  int minutes = int.parse(splitDebut[1]);
  TimeOfDay heureDebut =  TimeOfDay(hour: hours, minute: minutes);
   List<String> splitFin = json["HEURE_FIN"].toString().split(':');
  int hoursFin = int.parse(splitFin[0]);
  int minutesFin = int.parse(splitFin[1]);

TimeOfDay heureFin =  TimeOfDay(hour: hoursFin, minute: minutesFin);

    return SortieModel(
      HEURE_DEBUT: heureDebut,
      HEURE_FIN: heureFin,
      JOB_LIB: json["JOB_LIB"],
      LIE_ADR: json["LIE_ADR"],
      LIE_LATITUDE: json["LIE_LATITUDE"],
      LIE_LONGITUDE: json["LIE_LONGITUDE"],
      LIE_TLPH: json["LIE_TLPH"],
      LIE_LIB: json["LIE_LIB"],
      NOM_NUM_JOUR: json["NOM_NUM_JOUR"],
      PNTGS_IN_NBR: json["PNTGS_IN_NBR"],
      PNTGS_START_HOUR_IN:dateTimeStartIn,
      SVR_CODE_LIB: json["SVR_CODE_LIB"],
      TITLE: json["TITLE"],
      VAC_DURATION: json["VAC_DURATION"],
      VAC_IDF: json["VAC_IDF"],
      VAC_HOUR_CALC: json["VAC_HOUR_CALC"],
      DAY_COLOR: json["DAY_COLOR"],
      LIE_PS_TYPE: json["LIE_PS_TYPE"],
      PNTGS_OUT_NBR: json["PNTGS_OUT_NBR"],
      PNTGS_START_HOUR_OUT: dateTimeStartOut,
      PNTG_END_HOUR: json["PNTG_END_HOUR"],
      PNTG_START_HOUR: json["PNTG_START_HOUR"],
      VAC_BREAK: json["VAC_BREAK"],
      
    );
  }

  static List<SortieModel> convertDynamictoListSortie(
      List<dynamic> sortieDynamic) {
    List<SortieModel> listSortie = [];
    for (var i = 0; i < sortieDynamic.length; i++) {
      listSortie.add(SortieModel.fromJson(sortieDynamic[i]));
    }
    return listSortie;
  }

}
