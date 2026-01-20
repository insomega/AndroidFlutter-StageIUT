import 'package:intl/intl.dart';

class SalarieUpdateDataModel {
  final String SVR_IDF;
  final String SVR_CIV;
  final String? SVR_NSS;
  final DateTime? SVR_NAIDATE;
  final String SVR_AGE;
  final String NAT_IDF;
  final String NAT_LIB;
  final DateTime? START_DATE;
  final String SVR_EMAIL_1;
  final String USER_IDF;
  final DateTime? LAST_UPDT;
  final String? SVR_HAUTEUR;
  final String? SVR_HANCHE;
  final String? SVR_POINTURE;
  final String? TCHEV_LIB;
  final String? SVR_CHEV_COLOR_CODE;
  final String? SVR_CHEV_COLOR_LIB;
  final String? SVR_EYE_COLOR_CODE;
  final String? SVR_EYE_COLOR_LIB;
  final String? DOS_SVR_PLA_DEFAULT;
  final String SVR_NOM;
  final String SVR_PRNOM;
  final String SVR_ADR1;
  final String SVR_TELPOR;
  final String SVR_EMAIL;
  final String SVR_LATITUDE;
  final String SVR_LONGITUDE;
  final String? SVR_TELPH;
  final String SVR_ADR2;
  final String VIL_IDF;
  final String VIL_CODE;
  final String VIL_LIB;

  const SalarieUpdateDataModel({
    required this.VIL_LIB,
    required this.SVR_NOM,
    required this.SVR_PRNOM,
    required this.SVR_IDF,
    required this.DOS_SVR_PLA_DEFAULT,
    required this.SVR_ADR1,
    required this.SVR_TELPOR,
    required this.VIL_IDF,
    required this.VIL_CODE,
    required this.SVR_ADR2,
    required this.SVR_EMAIL,
    required this.SVR_LATITUDE,
    required this.SVR_LONGITUDE,
    required this.SVR_TELPH,
    required this.LAST_UPDT,
    required this.NAT_IDF,
    required this.NAT_LIB,
    required this.START_DATE,
    required this.SVR_AGE,
    required this.SVR_CHEV_COLOR_CODE,
    required this.SVR_CHEV_COLOR_LIB,
    required this.SVR_CIV,
    required this.SVR_EMAIL_1,
    required this.SVR_EYE_COLOR_CODE,
    required this.SVR_EYE_COLOR_LIB,
    required this.SVR_HANCHE,
    required this.SVR_HAUTEUR,
    required this.SVR_NAIDATE,
    required this.SVR_NSS,
    required this.SVR_POINTURE,
    required this.TCHEV_LIB,
    required this.USER_IDF,
  });

  static SalarieUpdateDataModel fromJson(json) {
    DateTime? LAST_UPDT, START_DATE, SVR_NAIDATE;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');

    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = originalFormat.parse(json["LAST_UPDT"]);
    }
    if (json["START_DATE"].toString().isNotEmpty) {
      START_DATE = originalFormat.parse(json["START_DATE"]);
    }
    if (json["SVR_NAIDATE"].toString().isNotEmpty) {
      SVR_NAIDATE = originalFormat.parse(json["SVR_NAIDATE"]);
    }

    return SalarieUpdateDataModel(
      LAST_UPDT: LAST_UPDT,
      START_DATE: START_DATE,
      SVR_NAIDATE: SVR_NAIDATE,
      DOS_SVR_PLA_DEFAULT: json["DOS_SVR_PLA_DEFAULT"],
      VIL_CODE: json["VIL_CODE"],
      SVR_TELPOR: json["SVR_TELPOR"],
      SVR_IDF: json["SVR_IDF"],
      VIL_IDF: json["VIL_IDF"],
      SVR_ADR1: json["SVR_ADR1"],
      SVR_NOM: json["SVR_NOM"],
      SVR_PRNOM: json["SVR_PRNOM"],
      VIL_LIB: json["VIL_LIB"],
      SVR_ADR2: json["SVR_ADR2"],
      SVR_EMAIL: json["SVR_EMAIL"],
      SVR_LATITUDE: json["SVR_LATITUDE"],
      SVR_LONGITUDE: json["SVR_LONGITUDE"],
      SVR_TELPH: json["SVR_TELPH"],
      NAT_IDF: json["NAT_IDF"],
      NAT_LIB: json["NAT_LIB"],
      SVR_AGE: json["SVR_AGE"],
      SVR_CHEV_COLOR_CODE: json["SVR_CHEV_COLOR_CODE"],
      SVR_CHEV_COLOR_LIB: json["SVR_CHEV_COLOR_LIB"],
      SVR_CIV: json["SVR_CIV"],
      SVR_EMAIL_1: json["SVR_EMAIL_1"],
      SVR_EYE_COLOR_CODE: json["SVR_EYE_COLOR_CODE"],
      SVR_EYE_COLOR_LIB: json["SVR_EYE_COLOR_LIB"],
      SVR_HANCHE: json["SVR_HANCHE"],
      SVR_HAUTEUR: json["SVR_HAUTEUR"],
      SVR_NSS: json["SVR_NSS"],
      SVR_POINTURE: json["SVR_POINTURE"],
      TCHEV_LIB: json["TCHEV_LIB"],
      USER_IDF: json["USER_IDF"],
    );
  }

  static List<SalarieUpdateDataModel> convertDynamictoListSalaries(
      List<dynamic> salariesDynamic) {
    List<SalarieUpdateDataModel> listSalaries = [];
    for (var i = 0; i < salariesDynamic.length; i++) {
      listSalaries.add(SalarieUpdateDataModel.fromJson(salariesDynamic[i]));
    }
    return listSalaries;
  }
}
