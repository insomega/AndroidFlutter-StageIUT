import 'package:intl/intl.dart';

class PlanningDisponibleModel {
  final String? YEAR_NAME;
  final DateTime? SVRPPH_START_DATE;
  final String? SVRPPH_IDF;
  final String? MONTH_NAME;

  const PlanningDisponibleModel({
    required this.MONTH_NAME,
    required this.YEAR_NAME,
    required this.SVRPPH_IDF,
    required this.SVRPPH_START_DATE,
  });

  static PlanningDisponibleModel fromJson(json) {
    DateTime? SVRPPH_START_DATE;

    DateFormat originalFormat = DateFormat('dd/MM/yyyy');

    if (json["SVRPPH_START_DATE"].toString().isNotEmpty) {
      SVRPPH_START_DATE = originalFormat.parse(json["SVRPPH_START_DATE"]);
    }

    return PlanningDisponibleModel(
      SVRPPH_IDF: json["SVRPPH_IDF"],
      MONTH_NAME: json["MONTH_NAME"],
      YEAR_NAME: json["YEAR_NAME"],
      SVRPPH_START_DATE: SVRPPH_START_DATE,
    );
  }

  static List<PlanningDisponibleModel> convertDynamictoListPlanningDispo(
      List<dynamic> salariesDynamic) {
    List<PlanningDisponibleModel> listSalaries = [];
    for (var i = 0; i < salariesDynamic.length; i++) {
      listSalaries.add(PlanningDisponibleModel.fromJson(salariesDynamic[i]));
    }
    return listSalaries;
  }
}
