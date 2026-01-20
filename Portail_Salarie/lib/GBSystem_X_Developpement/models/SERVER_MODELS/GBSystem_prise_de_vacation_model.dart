import 'package:intl/intl.dart';

class PriseDeVacationModel {
  final String PLAPSVR_UIDF;
  final String PLAPSVR_IDF;
  final String VAC_IDF;
  final String SVR_IDF;
  final DateTime? PLAPSVR_DEMANDE_DATE;
  final String PLAPSVR_STATE;
  final DateTime? VAC_PUB_DATE;
  final String VAC_VALID_DATE;
  final DateTime? VAC_START_HOUR;
  final DateTime? VAC_END_HOUR;
  final String LIE_IDF;
  final String EVT_IDF;
  final String JOB_IDF;
  final String DOS_IDF;
  final String LIE_CODE;
  final String LIE_LIB;
  final String EVT_CODE;
  final String EVT_LIB;
  final String JOB_CODE;
  final String JOB_LIB;
  final String ROW_ID;

  const PriseDeVacationModel({
    required this.VAC_IDF,
    required this.JOB_LIB,
    required this.LIE_LIB,
    required this.DOS_IDF,
    required this.EVT_CODE,
    required this.EVT_IDF,
    required this.EVT_LIB,
    required this.JOB_CODE,
    required this.JOB_IDF,
    required this.LIE_CODE,
    required this.LIE_IDF,
    required this.PLAPSVR_DEMANDE_DATE,
    required this.PLAPSVR_IDF,
    required this.PLAPSVR_STATE,
    required this.PLAPSVR_UIDF,
    required this.ROW_ID,
    required this.SVR_IDF,
    required this.VAC_END_HOUR,
    required this.VAC_PUB_DATE,
    required this.VAC_START_HOUR,
    required this.VAC_VALID_DATE,
  });

  static PriseDeVacationModel fromJson(json) {
    DateTime? PLAPSVR_DEMANDE_DATE, VAC_PUB_DATE, VAC_START_HOUR, VAC_END_HOUR;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    DateFormat originalFormat2 = DateFormat('dd/MM/yyyy');

    if (json["PLAPSVR_DEMANDE_DATE"].toString().isNotEmpty) {
      PLAPSVR_DEMANDE_DATE = originalFormat.parse(json["PLAPSVR_DEMANDE_DATE"]);
    }
    if (json["VAC_PUB_DATE"].toString().isNotEmpty) {
      VAC_PUB_DATE = originalFormat2.parse(json["VAC_PUB_DATE"]);
    }
    if (json["VAC_START_HOUR"].toString().isNotEmpty) {
      VAC_START_HOUR = originalFormat.parse(json["VAC_START_HOUR"]);
    }
    if (json["VAC_END_HOUR"].toString().isNotEmpty) {
      VAC_END_HOUR = originalFormat.parse(json["VAC_END_HOUR"]);
    }

    return PriseDeVacationModel(
      PLAPSVR_UIDF: json['PLAPSVR_UIDF'] ?? '',
      PLAPSVR_IDF: json['PLAPSVR_IDF'] ?? '',
      VAC_IDF: json['VAC_IDF'] ?? '',
      SVR_IDF: json['SVR_IDF'] ?? '',
      PLAPSVR_DEMANDE_DATE: PLAPSVR_DEMANDE_DATE,
      PLAPSVR_STATE: json['PLAPSVR_STATE'] ?? '',
      VAC_PUB_DATE: VAC_PUB_DATE,
      VAC_VALID_DATE: json['VAC_VALID_DATE'] ?? '',
      VAC_START_HOUR: VAC_START_HOUR,
      VAC_END_HOUR: VAC_END_HOUR,
      LIE_IDF: json['LIE_IDF'] ?? '',
      EVT_IDF: json['EVT_IDF'] ?? '',
      JOB_IDF: json['JOB_IDF'] ?? '',
      DOS_IDF: json['DOS_IDF'] ?? '',
      LIE_CODE: json['LIE_CODE'] ?? '',
      LIE_LIB: json['LIE_LIB'] ?? '',
      EVT_CODE: json['EVT_CODE'] ?? '',
      EVT_LIB: json['EVT_LIB'] ?? '',
      JOB_CODE: json['JOB_CODE'] ?? '',
      JOB_LIB: json['JOB_LIB'] ?? '',
      ROW_ID: json['ROW_ID'] ?? '',
    );
  }

  static List<PriseDeVacationModel> convertDynamictoListPriseDeVacations(
      List<dynamic> vacationsDynamic) {
    List<PriseDeVacationModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(PriseDeVacationModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
