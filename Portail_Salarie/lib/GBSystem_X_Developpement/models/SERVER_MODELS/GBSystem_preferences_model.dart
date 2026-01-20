import 'package:intl/intl.dart';

class PreferencesModel {
  final String PLAPSVRPRFR_UIDF;
  final String PLAPSVRPRFR_IDF;
  final String SVR_IDF;
  final DateTime? START_DATE_EXCLU;
  final DateTime? END_DATE_EXCLU;
  final DateTime? START_DATE_EXCLU1;
  final DateTime? END_DATE_EXCLU1;
  final String DAY1_PRFR;
  final String DAY2_PRFR;
  final String DAY3_PRFR;
  final String DAY4_PRFR;
  final String DAY5_PRFR;
  final String DAY6_PRFR;
  final String DAY7_PRFR;
  final String DAY_FER_PRFR;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String PLAPSVRPRFR_TYPE;
  final String PRFR_DISPO1_EXCLU0;
  final String PLAPSVRPRFR_DFNTF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String USR_CODE;
  final String USR_LIB;
  final String TYPE_PREFERENCE;
  final String STATE;
  final String DISPONIBILITE_LIB;
  final String EXCLUSION_LIB;

  const PreferencesModel({
    required this.PLAPSVRPRFR_UIDF,
    required this.PLAPSVRPRFR_IDF,
    required this.SVR_IDF,
    required this.START_DATE_EXCLU,
    required this.END_DATE_EXCLU,
    required this.START_DATE_EXCLU1,
    required this.END_DATE_EXCLU1,
    required this.DAY1_PRFR,
    required this.DAY2_PRFR,
    required this.DAY3_PRFR,
    required this.DAY4_PRFR,
    required this.DAY5_PRFR,
    required this.DAY6_PRFR,
    required this.DAY7_PRFR,
    required this.DAY_FER_PRFR,
    required this.LAST_UPDT,
    required this.USER_IDF,
    required this.PLAPSVRPRFR_TYPE,
    required this.PRFR_DISPO1_EXCLU0,
    required this.PLAPSVRPRFR_DFNTF,
    required this.SVR_CODE,
    required this.SVR_LIB,
    required this.USR_CODE,
    required this.USR_LIB,
    required this.TYPE_PREFERENCE,
    required this.STATE,
    required this.DISPONIBILITE_LIB,
    required this.EXCLUSION_LIB,
  });

  static PreferencesModel fromJson(Map<String, dynamic> json) {
    DateTime? START_DATE_EXCLU,
        END_DATE_EXCLU,
        START_DATE_EXCLU1,
        END_DATE_EXCLU1,
        LAST_UPDT;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    DateFormat originalFormatWithTime = DateFormat('dd/MM/yyyy HH:mm:ss.SSS');

    if (json["START_DATE_EXCLU"] != null &&
        json["START_DATE_EXCLU"].toString().isNotEmpty) {
      START_DATE_EXCLU = originalFormat.parse(json["START_DATE_EXCLU"]);
    }
    if (json["END_DATE_EXCLU"] != null &&
        json["END_DATE_EXCLU"].toString().isNotEmpty) {
      END_DATE_EXCLU = originalFormat.parse(json["END_DATE_EXCLU"]);
    }
    if (json["START_DATE_EXCLU1"] != null &&
        json["START_DATE_EXCLU1"].toString().isNotEmpty) {
      START_DATE_EXCLU1 = originalFormat.parse(json["START_DATE_EXCLU1"]);
    }
    if (json["END_DATE_EXCLU1"] != null &&
        json["END_DATE_EXCLU1"].toString().isNotEmpty) {
      END_DATE_EXCLU1 = originalFormat.parse(json["END_DATE_EXCLU1"]);
    }
    if (json["LAST_UPDT"] != null && json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = originalFormatWithTime.parse(json["LAST_UPDT"]);
    }

    return PreferencesModel(
      PLAPSVRPRFR_UIDF: json['PLAPSVRPRFR_UIDF'] ?? '',
      PLAPSVRPRFR_IDF: json['PLAPSVRPRFR_IDF'] ?? '',
      SVR_IDF: json['SVR_IDF'] ?? '',
      START_DATE_EXCLU: START_DATE_EXCLU,
      END_DATE_EXCLU: END_DATE_EXCLU,
      START_DATE_EXCLU1: START_DATE_EXCLU1,
      END_DATE_EXCLU1: END_DATE_EXCLU1,
      DAY1_PRFR: json['DAY1_PRFR'] ?? '',
      DAY2_PRFR: json['DAY2_PRFR'] ?? '',
      DAY3_PRFR: json['DAY3_PRFR'] ?? '',
      DAY4_PRFR: json['DAY4_PRFR'] ?? '',
      DAY5_PRFR: json['DAY5_PRFR'] ?? '',
      DAY6_PRFR: json['DAY6_PRFR'] ?? '',
      DAY7_PRFR: json['DAY7_PRFR'] ?? '',
      DAY_FER_PRFR: json['DAY_FER_PRFR'] ?? '',
      LAST_UPDT: LAST_UPDT,
      USER_IDF: json['USER_IDF'] ?? '',
      PLAPSVRPRFR_TYPE: json['PLAPSVRPRFR_TYPE'] ?? '',
      PRFR_DISPO1_EXCLU0: json['PRFR_DISPO1_EXCLU0'] ?? '',
      PLAPSVRPRFR_DFNTF: json['PLAPSVRPRFR_DFNTF'] ?? '',
      SVR_CODE: json['SVR_CODE'] ?? '',
      SVR_LIB: json['SVR_LIB'] ?? '',
      USR_CODE: json['USR_CODE'] ?? '',
      USR_LIB: json['USR_LIB'] ?? '',
      TYPE_PREFERENCE: json['TYPE_PREFERENCE'] ?? '',
      STATE: json['STATE'] ?? '',
      DISPONIBILITE_LIB: json['DISPONIBILITE_LIB'] ?? '',
      EXCLUSION_LIB: json['EXCLUSION_LIB'] ?? '',
    );
  }

  static List<PreferencesModel> convertDynamictoListPreferences(
      List<dynamic> vacationsDynamic) {
    List<PreferencesModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(PreferencesModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
