import 'package:intl/intl.dart';

class AgrementModel {
  final String SHAB_UIDF;
  final String SHAB_IDF;
  final String SVR_IDF;
  final String HAB_IDF;
  final DateTime? SHAB_DATD;
  final DateTime? SHAB_DATF;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String? DOCAN_IDF;
  final String HAB_CODE;
  final String HAB_LIB;
  final String SVR_CODE;
  final String SVR_LIB;
  final String? USR_LIB;
  final String? DOCAN_CODE;
  final String? DOCAN_LIB;
  final DateTime? VALID_DATE;
  final String ROW_ID;

  const AgrementModel({
    required this.DOCAN_CODE,
    required this.LAST_UPDT,
    required this.DOCAN_IDF,
    required this.DOCAN_LIB,
    required this.HAB_CODE,
    required this.HAB_IDF,
    required this.HAB_LIB,
    required this.ROW_ID,
    required this.SHAB_DATD,
    required this.SHAB_DATF,
    required this.SHAB_IDF,
    required this.SVR_CODE,
    required this.SVR_IDF,
    required this.SVR_LIB,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.VALID_DATE,
    required this.SHAB_UIDF,
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

  static AgrementModel fromJson(json) {
    DateTime? SHAB_DATD, LAST_UPDT, SHAB_DATF, VALID_DATE;

    if (json["SHAB_DATD"].toString().isNotEmpty) {
      SHAB_DATD = DateFormat(detecteDateFormat(json["SHAB_DATD"]))
          .parse(json["SHAB_DATD"]);
    }
    if (json["SHAB_DATF"].toString().isNotEmpty) {
      SHAB_DATF = DateFormat(detecteDateFormat(json["SHAB_DATF"]))
          .parse(json["SHAB_DATF"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    if (json["VALID_DATE"].toString().isNotEmpty) {
      VALID_DATE = DateFormat(detecteDateFormat(json["VALID_DATE"]))
          .parse(json["VALID_DATE"]);
    }

    return AgrementModel(
      SHAB_DATD: SHAB_DATD,
      LAST_UPDT: LAST_UPDT,
      SHAB_DATF: SHAB_DATF,
      DOCAN_CODE: json["DOCAN_CODE"],
      DOCAN_IDF: json["DOCAN_IDF"],
      DOCAN_LIB: json["DOCAN_LIB"],
      HAB_CODE: json["HAB_CODE"],
      HAB_IDF: json["HAB_IDF"],
      HAB_LIB: json["HAB_LIB"],
      ROW_ID: json["ROW_ID"],
      SHAB_IDF: json["SHAB_IDF"],
      SHAB_UIDF: json["SHAB_UIDF"],
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      VALID_DATE: VALID_DATE,
    );
  }

  static List<AgrementModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<AgrementModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(AgrementModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
