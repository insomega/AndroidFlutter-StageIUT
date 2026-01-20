import 'package:intl/intl.dart';

class VacationSalarieModel {
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String? VAC_IDF;
  final DateTime? PNTGS_START_HOUR;
  final DateTime? VAC_START_HOUR;
  final DateTime? VAC_END_HOUR;

  const VacationSalarieModel({
    required this.VAC_IDF,
    required this.PNTGS_START_HOUR,
    required this.SVR_CODE,
    required this.SVR_IDF,
    required this.SVR_LIB,
    required this.VAC_END_HOUR,
    required this.VAC_START_HOUR,
  });
  static VacationSalarieModel fromJson(json) {
    DateTime? PNTGS_START_HOUR, VAC_START_HOUR, VAC_END_HOUR;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

    if (json["PNTGS_START_HOUR"].toString().isNotEmpty) {
      PNTGS_START_HOUR = originalFormat.parse(json["PNTGS_START_HOUR"]);
    }
    if (json["VAC_START_HOUR"].toString().isNotEmpty) {
      VAC_START_HOUR = originalFormat.parse(json["VAC_START_HOUR"]);
    }
    if (json["VAC_END_HOUR"].toString().isNotEmpty) {
      VAC_END_HOUR = originalFormat.parse(json["VAC_END_HOUR"]);
    }

    return VacationSalarieModel(
        PNTGS_START_HOUR: PNTGS_START_HOUR,
        VAC_END_HOUR: VAC_END_HOUR,
        VAC_START_HOUR: VAC_START_HOUR,
        SVR_CODE: json["SVR_CODE"],
        SVR_IDF: json["SVR_IDF"],
        SVR_LIB: json["SVR_LIB"],
        VAC_IDF: json["VAC_IDF"]);
  }

  static List<VacationSalarieModel> convertDynamictoListVacationsSalarie(
      List<dynamic> vacationsDynamic) {
    List<VacationSalarieModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(VacationSalarieModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
