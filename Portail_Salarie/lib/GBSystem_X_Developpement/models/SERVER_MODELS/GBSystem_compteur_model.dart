import 'package:intl/intl.dart';

class CompteurModel {
  final String? SABSD_UIDF;
  final String? SABSD_IDF;
  final String? SVR_IDF;
  final String? SABSD_CP_ACQUIS;
  final String? SABSD_CP_PRIS;
  final String? CPJOUR;
  final String? CP_REST;
  final String? SABSD_RC_ACQUIS;
  final String? SABSD_RC_PRIS;
  final String? RCJOUR;
  final String? RC_REST;
  final String? SABSD_RTT_ACQUIS;
  final String? SABSD_RTT_PRIS;
  final String? RTTJOUR;
  final String? RTT_REST;
  final String? TPH_CODE_CP;
  final String? TPH_CODE_RC;
  final String? TPH_CODE_RTT;
  final DateTime? START_DATE_CP_CALC;
  final DateTime? END_DATE_CP_CALC;
  final DateTime? START_DATE_RC_CALC;
  final DateTime? END_DATE_RC_CALC;
  final String? RC_DEM;
  final String? CP_DEM;
  final String? CET_EN_COURS_CP;
  final String? CET_EN_COURS_RC;
  final String? CET_EN_COURS_RTT;
  final String? MISE_CET_EN_COURS;
  final String? MISE_CET_ANNEE_EN_COURS;
  final String? CET_RACHAT_EN_COURS;
  final String? CET_RACHAT;
  final String? PRISE_CET_EN_COURS;
  final String? PRISE_CET;
  final String? SABSD_CET_ACQUIS;
  final String? SABSD_CET_SOLDE;
                
  const CompteurModel({
    required this.CET_EN_COURS_CP,
    required this.CET_EN_COURS_RC,
    required this.CET_EN_COURS_RTT,
    required this.CET_RACHAT,
    required this.CET_RACHAT_EN_COURS,
    required this.CPJOUR,
    required this.CP_DEM,
    required this.CP_REST,
    required this.END_DATE_CP_CALC,
    required this.END_DATE_RC_CALC,
    required this.MISE_CET_ANNEE_EN_COURS,
    required this.SVR_IDF,
    required this.MISE_CET_EN_COURS,
    required this.PRISE_CET,
    required this.PRISE_CET_EN_COURS,
    required this.RCJOUR,
    required this.RC_DEM,
    required this.RC_REST,
    required this.RTTJOUR,
    required this.RTT_REST,
    required this.SABSD_CET_ACQUIS,
    required this.SABSD_CET_SOLDE,
    required this.SABSD_CP_ACQUIS,
    required this.SABSD_CP_PRIS,
    required this.SABSD_IDF,
    required this.SABSD_RC_ACQUIS,
    required this.SABSD_RC_PRIS,
    required this.SABSD_RTT_ACQUIS,
    required this.SABSD_RTT_PRIS,
    required this.SABSD_UIDF,
    required this.START_DATE_CP_CALC,
    required this.START_DATE_RC_CALC,
        required this.TPH_CODE_CP,
    required this.TPH_CODE_RC,
    required this.TPH_CODE_RTT,


  });

  static CompteurModel fromJson(Map<String, dynamic> json) {
    DateTime? START_DATE_CP_CALC, END_DATE_CP_CALC,START_DATE_RC_CALC,END_DATE_RC_CALC;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');

    if (json["START_DATE_CP_CALC"].toString().isNotEmpty) {
      START_DATE_CP_CALC = originalFormat.parse(json["START_DATE_CP_CALC"]);
    }
    if (json["END_DATE_CP_CALC"].toString().isNotEmpty) {
      END_DATE_CP_CALC = originalFormat.parse(json["END_DATE_CP_CALC"]);
    }
    if (json["START_DATE_RC_CALC"].toString().isNotEmpty) {
      START_DATE_RC_CALC = originalFormat.parse(json["START_DATE_RC_CALC"]);
    }
    if (json["END_DATE_RC_CALC"].toString().isNotEmpty) {
      END_DATE_RC_CALC = originalFormat.parse(json["END_DATE_RC_CALC"]);
    }
   
    return CompteurModel(
      CET_EN_COURS_CP: json['CET_EN_COURS_CP'],
      CET_EN_COURS_RC: json['CET_EN_COURS_RC'],
      CET_EN_COURS_RTT: json['CET_EN_COURS_RTT'],
      CET_RACHAT: json['CET_RACHAT'],
      CET_RACHAT_EN_COURS: json['CET_RACHAT_EN_COURS'],
      CPJOUR: json['CPJOUR'],
      CP_DEM: json['CP_DEM'],
      CP_REST: json['CP_REST'],
      END_DATE_CP_CALC: END_DATE_CP_CALC,
      END_DATE_RC_CALC: END_DATE_RC_CALC,
      MISE_CET_ANNEE_EN_COURS: json['MISE_CET_ANNEE_EN_COURS'],
      SVR_IDF: json['SVR_IDF'],
      MISE_CET_EN_COURS:json['MISE_CET_EN_COURS'],
      PRISE_CET:json['PRISE_CET'],
      PRISE_CET_EN_COURS: json['PRISE_CET_EN_COURS'],
      RCJOUR: json['RCJOUR'],
      RC_DEM: json['RC_DEM'],
      RC_REST:json['RC_REST'],
      RTTJOUR:json['RTTJOUR'] ,
      RTT_REST: json['RTT_REST'],
      SABSD_CET_ACQUIS: json['SABSD_CET_ACQUIS'],
      SABSD_CET_SOLDE: json['SABSD_CET_SOLDE'],
      SABSD_CP_ACQUIS: json['SABSD_CP_ACQUIS'],
      SABSD_CP_PRIS: json['SABSD_CP_PRIS'],
      SABSD_IDF: json['SABSD_IDF'],
      SABSD_RC_ACQUIS: json['SABSD_RC_ACQUIS'],
      SABSD_RC_PRIS: json['SABSD_RC_PRIS'],
      SABSD_RTT_ACQUIS: json['SABSD_RTT_ACQUIS'],
      SABSD_RTT_PRIS: json['SABSD_RTT_PRIS'],
      SABSD_UIDF: json['SABSD_UIDF'],
      START_DATE_CP_CALC: START_DATE_CP_CALC,
      START_DATE_RC_CALC: START_DATE_RC_CALC,
      TPH_CODE_CP: json['TPH_CODE_CP'],
      TPH_CODE_RC: json['TPH_CODE_RC'],
      TPH_CODE_RTT: json['TPH_CODE_RTT'],
    );
  }

  static List<CompteurModel> convertDynamicToList(List<dynamic> data) {
    List<CompteurModel> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(CompteurModel.fromJson(data[i]));
    }
    return list;
  }
}


