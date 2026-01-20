import 'package:intl/intl.dart';

class PlanningDownloadModel {
  final String SVRPPH_IDF;
  final DateTime? LAST_UPDT;
  final DateTime? SVRPPH_START_DATE;
  final DateTime? SVRPPH_END_DATE;
  final String SVR_IDF;
  final DateTime? SVRPPH_DATE_VUE;
  final DateTime? SVRPPH_DATE_DWNL;
  const PlanningDownloadModel({
    required this.LAST_UPDT,
    required this.SVRPPH_DATE_DWNL,
    required this.SVRPPH_DATE_VUE,
    required this.SVR_IDF,
    required this.SVRPPH_END_DATE,
    required this.SVRPPH_IDF,
    required this.SVRPPH_START_DATE,
  });

  static PlanningDownloadModel fromJson(json) {
    DateTime? LAST_UPDT,
        SVRPPH_START_DATE,
        SVRPPH_END_DATE,
        SVRPPH_DATE_VUE,
        SVRPPH_DATE_DWNL;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    DateFormat originalFormat2 = DateFormat('dd/MM/yyyy');

    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = originalFormat.parse(json["LAST_UPDT"]);
    }
    if (json["SVRPPH_START_DATE"].toString().isNotEmpty) {
      SVRPPH_START_DATE = originalFormat2.parse(json["SVRPPH_START_DATE"]);
    }
    if (json["SVRPPH_END_DATE"].toString().isNotEmpty) {
      SVRPPH_END_DATE = originalFormat2.parse(json["SVRPPH_END_DATE"]);
    }
    if (json["SVRPPH_DATE_VUE"].toString().isNotEmpty) {
      SVRPPH_DATE_VUE = originalFormat.parse(json["SVRPPH_DATE_VUE"]);
    }
    if (json["SVRPPH_DATE_DWNL"].toString().isNotEmpty) {
      SVRPPH_DATE_DWNL = originalFormat.parse(json["SVRPPH_DATE_DWNL"]);
    }

    return PlanningDownloadModel(
      LAST_UPDT: LAST_UPDT,
      SVRPPH_DATE_DWNL: SVRPPH_DATE_DWNL,
      SVRPPH_DATE_VUE: SVRPPH_DATE_VUE,
      SVR_IDF: json["SVR_IDF"],
      SVRPPH_END_DATE: SVRPPH_END_DATE,
      SVRPPH_IDF: json["SVRPPH_IDF"],
      SVRPPH_START_DATE: SVRPPH_START_DATE,
    );
  }

  static List<PlanningDownloadModel> convertDynamictoListPlanningDown(
      List<dynamic> salariesDynamic) {
    List<PlanningDownloadModel> listSalaries = [];
    for (var i = 0; i < salariesDynamic.length; i++) {
      listSalaries.add(PlanningDownloadModel.fromJson(salariesDynamic[i]));
    }
    return listSalaries;
  }
}
