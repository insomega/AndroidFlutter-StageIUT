import 'package:intl/intl.dart';

class VacationStateDemanderModel {
  final String PLAPSVR_UIDF;
  final String PLAPSVR_IDF;
  final String VAC_IDF;
  final String SVR_IDF;
  final DateTime? PLAPSVR_DEMANDE_DATE;
  final String PLAPSVR_STATE;
  final DateTime? VAC_PUB_DATE;
  final DateTime? VAC_VALID_DATE;
  final DateTime? VAC_START_HOUR;
  final DateTime? VAC_END_HOUR;
  final String LIE_IDF;
  final String? EVT_IDF;
  final String JOB_IDF;
  final String DOS_IDF;
  final String LIE_CODE;
  final String LIE_LIB;
  final String? EVT_CODE;
  final String? EVT_LIB;
  final String JOB_CODE;
  final String JOB_LIB;
  final String ROW_ID;
  const VacationStateDemanderModel({
    required this.DOS_IDF,
    required this.EVT_CODE,
    required this.EVT_IDF,
    required this.EVT_LIB,
    required this.JOB_CODE,
    required this.JOB_IDF,
    required this.JOB_LIB,
    required this.LIE_CODE,
    required this.LIE_IDF,
    required this.LIE_LIB,
    required this.PLAPSVR_DEMANDE_DATE,
    required this.PLAPSVR_IDF,
    required this.PLAPSVR_STATE,
    required this.PLAPSVR_UIDF,
    required this.ROW_ID,
    required this.SVR_IDF,
    required this.VAC_END_HOUR,
    required this.VAC_IDF,
    required this.VAC_PUB_DATE,
    required this.VAC_START_HOUR,
    required this.VAC_VALID_DATE,
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

  static VacationStateDemanderModel fromJson(json) {
    DateTime? PLAPSVR_DEMANDE_DATE,
        VAC_PUB_DATE,
        VAC_VALID_DATE,
        VAC_START_HOUR,
        VAC_END_HOUR;

    if (json["PLAPSVR_DEMANDE_DATE"].toString().isNotEmpty) {
      PLAPSVR_DEMANDE_DATE =
          DateFormat(detecteDateFormat(json["PLAPSVR_DEMANDE_DATE"]))
              .parse(json["PLAPSVR_DEMANDE_DATE"]);
    }
    if (json["VAC_PUB_DATE"].toString().isNotEmpty) {
      VAC_PUB_DATE = DateFormat(detecteDateFormat(json["VAC_PUB_DATE"]))
          .parse(json["VAC_PUB_DATE"]);
    }
    if (json["VAC_VALID_DATE"].toString().isNotEmpty) {
      VAC_VALID_DATE = DateFormat(detecteDateFormat(json["VAC_VALID_DATE"]))
          .parse(json["VAC_VALID_DATE"]);
    }
    if (json["VAC_START_HOUR"].toString().isNotEmpty) {
      VAC_START_HOUR = DateFormat(detecteDateFormat(json["VAC_START_HOUR"]))
          .parse(json["VAC_START_HOUR"]);
    }
    if (json["VAC_END_HOUR"].toString().isNotEmpty) {
      VAC_END_HOUR = DateFormat(detecteDateFormat(json["VAC_END_HOUR"]))
          .parse(json["VAC_END_HOUR"]);
    }

    return VacationStateDemanderModel(
      PLAPSVR_DEMANDE_DATE: PLAPSVR_DEMANDE_DATE,
      VAC_END_HOUR: VAC_END_HOUR,
      VAC_PUB_DATE: VAC_PUB_DATE,
      VAC_START_HOUR: VAC_START_HOUR,
      VAC_VALID_DATE: VAC_VALID_DATE,
      DOS_IDF: json["DOS_IDF"],
      EVT_CODE: json["EVT_CODE"],
      EVT_IDF: json["EVT_IDF"],
      EVT_LIB: json["EVT_LIB"],
      JOB_CODE: json["JOB_CODE"],
      JOB_IDF: json["JOB_IDF"],
      JOB_LIB: json["JOB_LIB"],
      LIE_CODE: json["LIE_CODE"],
      LIE_IDF: json["LIE_IDF"],
      LIE_LIB: json["LIE_LIB"],
      PLAPSVR_IDF: json["PLAPSVR_IDF"],
      PLAPSVR_STATE: json["PLAPSVR_STATE"],
      PLAPSVR_UIDF: json["PLAPSVR_UIDF"],
      ROW_ID: json["ROW_ID"],
      SVR_IDF: json["SVR_IDF"],
      VAC_IDF: json["VAC_IDF"],
    );
  }

  static List<VacationStateDemanderModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<VacationStateDemanderModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations
          .add(VacationStateDemanderModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
