import 'package:intl/intl.dart';

class GbsystemAgenceModel {
  final String DOS_CODE;
  final String DOS_LIB;
  final String DOS_IDF;
  final DateTime? DOS_CLOSEDPLNG;
  final String PRF_IDF;
  final DateTime? USRDOS_END_DATE;
  final DateTime? USRDOS_START_DATE;
  final String? SYSTMZN_LIB;
  const GbsystemAgenceModel({
    required this.DOS_CLOSEDPLNG,
    required this.DOS_CODE,
    required this.DOS_IDF,
    required this.DOS_LIB,
    required this.PRF_IDF,
    required this.SYSTMZN_LIB,
    required this.USRDOS_END_DATE,
    required this.USRDOS_START_DATE,
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

  static GbsystemAgenceModel fromJson(json) {
    DateTime? dosClosedplng, usrdosStartDate, usrdosEndDate;

    if (json["DOS_CLOSEDPLNG"].toString().isNotEmpty) {
      dosClosedplng = DateFormat(detecteDateFormat(json["DOS_CLOSEDPLNG"]))
          .parse(json["DOS_CLOSEDPLNG"]);
    }

    if (json["USRDOS_START_DATE"].toString().isNotEmpty) {
      usrdosStartDate =
          DateFormat(detecteDateFormat(json["USRDOS_START_DATE"]))
              .parse(json["USRDOS_START_DATE"]);
    }

    if (json["USRDOS_END_DATE"].toString().isNotEmpty) {
      usrdosEndDate = DateFormat(detecteDateFormat(json["USRDOS_END_DATE"]))
          .parse(json["USRDOS_END_DATE"]);
    }

    return GbsystemAgenceModel(
      DOS_CLOSEDPLNG: dosClosedplng,
      USRDOS_END_DATE: usrdosEndDate,
      USRDOS_START_DATE: usrdosStartDate,
      DOS_CODE: json["DOS_CODE"],
      DOS_IDF: json["DOS_IDF"],
      DOS_LIB: json["DOS_LIB"],
      PRF_IDF: json["PRF_IDF"],
      SYSTMZN_LIB: json["SYSTMZN_LIB"],
    );
  }

  static List<GbsystemAgenceModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<GbsystemAgenceModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(GbsystemAgenceModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
