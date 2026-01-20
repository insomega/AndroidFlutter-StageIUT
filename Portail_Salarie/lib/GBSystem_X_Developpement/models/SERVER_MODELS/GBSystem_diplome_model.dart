import 'package:intl/intl.dart';

class DiplomeModel {
  final String SVRDIP_UIDF;
  final String SVRDIP_IDF;
  final String DIP_IDF;
  final String SVR_IDF;
  final DateTime? SVRDIP_DATD;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String DOCAN_IDF;
  final String DIP_CODE;
  final String DIP_LIB;
  final String SVR_CODE;
  final String SVR_LIB;
  final String? USR_LIB;
  final String DOCAN_CODE;
  final String? DOCAN_LIB;
  final DateTime? VALID_DATE;
  final String ROW_ID;

  const DiplomeModel({
    required this.DOCAN_CODE,
    required this.LAST_UPDT,
    required this.DOCAN_IDF,
    required this.DOCAN_LIB,
    required this.DIP_CODE,
    required this.DIP_IDF,
    required this.DIP_LIB,
    required this.ROW_ID,
    required this.SVRDIP_DATD,
    required this.SVRDIP_IDF,
    required this.SVRDIP_UIDF,
    required this.SVR_CODE,
    required this.SVR_IDF,
    required this.SVR_LIB,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.VALID_DATE,
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

  static DiplomeModel fromJson(json) {
    DateTime? SVRDIP_DATD, LAST_UPDT, VALID_DATE;

    if (json["SVRDIP_DATD"].toString().isNotEmpty) {
      SVRDIP_DATD = DateFormat(detecteDateFormat(json["SVRDIP_DATD"]))
          .parse(json["SVRDIP_DATD"]);
    }

    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    if (json["VALID_DATE"].toString().isNotEmpty) {
      VALID_DATE = DateFormat(detecteDateFormat(json["VALID_DATE"]))
          .parse(json["VALID_DATE"]);
    }

    return DiplomeModel(
      SVRDIP_DATD: SVRDIP_DATD,
      LAST_UPDT: LAST_UPDT,
      DOCAN_CODE: json["DOCAN_CODE"],
      DOCAN_IDF: json["DOCAN_IDF"],
      DOCAN_LIB: json["DOCAN_LIB"],
      DIP_CODE: json["DIP_CODE"],
      DIP_IDF: json["DIP_IDF"],
      DIP_LIB: json["DIP_LIB"],
      ROW_ID: json["ROW_ID"],
      SVRDIP_IDF: json["SVRDIP_IDF"],
      SVRDIP_UIDF: json["SVRDIP_UIDF"],
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      VALID_DATE: VALID_DATE,
    );
  }

  static List<DiplomeModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<DiplomeModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(DiplomeModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
