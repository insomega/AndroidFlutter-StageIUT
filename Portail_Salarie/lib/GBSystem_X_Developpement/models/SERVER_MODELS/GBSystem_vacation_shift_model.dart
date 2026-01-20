import 'package:intl/intl.dart';

class VacationShiftModel {
  final DateTime? VAC_START_HOUR;
  final DateTime? VAC_END_HOUR;
  final String vac_idf;
  final String svr_idf;
  const VacationShiftModel({
    required this.VAC_END_HOUR,
    required this.VAC_START_HOUR,
    required this.svr_idf,
    required this.vac_idf,
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

  static VacationShiftModel fromJson(json) {
    DateTime? VAC_START_HOUR, VAC_END_HOUR;

    if (json["VAC_START_HOUR"].toString().isNotEmpty) {
      VAC_START_HOUR = DateFormat(detecteDateFormat(json["VAC_START_HOUR"]))
          .parse(json["VAC_START_HOUR"]);
    }
    if (json["VAC_END_HOUR"].toString().isNotEmpty) {
      VAC_END_HOUR = DateFormat(detecteDateFormat(json["VAC_END_HOUR"]))
          .parse(json["VAC_END_HOUR"]);
    }

    return VacationShiftModel(
      VAC_END_HOUR: VAC_END_HOUR,
      VAC_START_HOUR: VAC_START_HOUR,
      svr_idf: json["svr_idf"],
      vac_idf: json["vac_idf"],
    );
  }

  static List<VacationShiftModel> convertDynamictoListVacations(
      List<dynamic> vacationsDynamic) {
    List<VacationShiftModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(VacationShiftModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
