import 'package:intl/intl.dart';

class CauserieModel {
  final String LIEINSPSVR_UIDF;
  final String LIEINSPSVR_IDF;
  final DateTime? LIEINSPSVR_START_DATE;
  // can change after cloture not final
  DateTime? LIEINSPSVR_END_DATE;
  final String LIE_IDF;
  final String LIE_CODE;
  final String LIE_LIB;
  final String? SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String? CLI_IDF;
  final String? CLI_CODE;
  final String? CLI_LIB;
  final String LIEINSTYP_IDF;
  final String LIEINSTYP_CODE;
  final String LIEINSTYP_LIB;
  final String SYSINSTYP_IDF;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String LIEINSPSVR_MEMO;
  final String LIEINSPSVR_LATITUDE;
  final String LIEINSPSVR_LONGITUDE;
  final String? LIECLI_IDF;
  final String? LIECLI_CODE;
  final String? LIECLI_LIB;
  final String LIEINSPQSNR_IDF;
  final String LIEINSPQSNR_NOTATION_TYPE;
  final String ROW_ID;

  CauserieModel({
    required this.CLI_CODE,
    required this.CLI_IDF,
    required this.CLI_LIB,
    required this.LAST_UPDT,
    required this.LIECLI_CODE,
    required this.LIECLI_IDF,
    required this.LIECLI_LIB,
    required this.LIEINSPQSNR_IDF,
    required this.LIEINSPQSNR_NOTATION_TYPE,
    required this.LIEINSPSVR_END_DATE,
    required this.LIEINSPSVR_IDF,
    required this.LIEINSPSVR_LATITUDE,
    required this.LIEINSPSVR_LONGITUDE,
    required this.LIEINSPSVR_MEMO,
    required this.LIEINSPSVR_START_DATE,
    required this.LIEINSPSVR_UIDF,
    required this.LIEINSTYP_CODE,
    required this.LIEINSTYP_IDF,
    required this.LIEINSTYP_LIB,
    required this.LIE_CODE,
    required this.LIE_IDF,
    required this.LIE_LIB,
    required this.ROW_ID,
    required this.SVR_CODE,
    required this.SVR_IDF,
    required this.SVR_LIB,
    required this.SYSINSTYP_IDF,
    required this.USER_IDF,
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

  static CauserieModel fromJson(json) {
    DateTime? LIEINSPSVR_START_DATE, LIEINSPSVR_END_DATE, LAST_UPDT;

    if (json["LAST_UPDT"] != null && json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    if (json["LIEINSPSVR_START_DATE"] != null &&
        json["LIEINSPSVR_START_DATE"].toString().isNotEmpty) {
      LIEINSPSVR_START_DATE =
          DateFormat(detecteDateFormat(json["LIEINSPSVR_START_DATE"]))
              .parse(json["LIEINSPSVR_START_DATE"]);
    }
    if (json["LIEINSPSVR_END_DATE"] != null &&
        json["LIEINSPSVR_END_DATE"].toString().isNotEmpty) {
      LIEINSPSVR_END_DATE =
          DateFormat(detecteDateFormat(json["LIEINSPSVR_END_DATE"]))
              .parse(json["LIEINSPSVR_END_DATE"]);
    }

    return CauserieModel(
      CLI_CODE: json["CLI_CODE"].toString(),
      CLI_IDF: json["CLI_IDF"].toString(),
      CLI_LIB: json["CLI_LIB"].toString(),
      LAST_UPDT: LAST_UPDT,
      LIECLI_CODE: json["LIECLI_CODE"],
      LIECLI_IDF: json["LIECLI_IDF"],
      LIECLI_LIB: json["LIECLI_LIB"],
      LIEINSPQSNR_IDF: json["LIEINSPQSNR_IDF"].toString(),
      LIEINSPQSNR_NOTATION_TYPE: json["LIEINSPQSNR_NOTATION_TYPE"],
      LIEINSPSVR_LATITUDE: json["LIEINSPSVR_LATITUDE"].toString(),
      LIEINSPSVR_LONGITUDE: json["LIEINSPSVR_LONGITUDE"].toString(),
      LIEINSPSVR_MEMO: json["LIEINSPSVR_MEMO"],
      LIEINSPSVR_UIDF: json["LIEINSPSVR_UIDF"],
      LIEINSTYP_CODE: json["LIEINSTYP_CODE"].toString(),
      LIEINSTYP_IDF: json["LIEINSTYP_IDF"].toString(),
      LIEINSTYP_LIB: json["LIEINSTYP_LIB"],
      LIEINSPSVR_START_DATE: LIEINSPSVR_START_DATE,
      LIEINSPSVR_END_DATE: LIEINSPSVR_END_DATE,
      ROW_ID: json["ROW_ID"].toString(),
      SYSINSTYP_IDF: json["SYSINSTYP_IDF"].toString(),
      USER_IDF: json["USER_IDF"].toString(),
      LIEINSPSVR_IDF: json["LIEINSPSVR_IDF"].toString(),
      LIE_CODE: json["LIE_CODE"],
      LIE_IDF: json["LIE_IDF"].toString(),
      LIE_LIB: json["LIE_LIB"],
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
    );
  }

  static List<CauserieModel> convertDynamictoListCauserie(
      List<dynamic> vacationsDynamic) {
    List<CauserieModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(CauserieModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
