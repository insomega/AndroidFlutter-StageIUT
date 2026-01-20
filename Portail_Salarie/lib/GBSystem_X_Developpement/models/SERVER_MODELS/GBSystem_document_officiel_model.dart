import 'package:intl/intl.dart';

class DocumentOfficielModel {
  final String SDF_UIDF;
  final String SDF_IDF;
  final String SVR_IDF;
  final String DOCOFF_IDF;
  final DateTime? SDF_DATD;
  final DateTime? SDF_DATF;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String SDF_AUT_DELIV;
  final String? SDF_CODE;
  final String SDF_NUM;
  final String SDF_PRO_TYPE;
  final String SDF_PRO_DEPTM;
  final String SDF_PRO_YEAR;
  final String SDF_PRO_MONTH;
  final String SDF_PRO_DAY;
  final String SDF_PRO_NUM;
  final String SDF_NUM_ETRANGE;
  final String? DOCAN_IDF;
  final String DOCOFF_CODE;
  final String DOCOFF_LIB;
  final String SVR_CODE;
  final String SVR_LIB;
  final String USR_LIB;
  final String? DOCAN_CODE;
  final String? DOCAN_LIB;
  final DateTime? VALID_DATE;
  final String ROW_ID;

  const DocumentOfficielModel({
    required this.DOCAN_CODE,
    required this.LAST_UPDT,
    required this.DOCAN_IDF,
    required this.DOCAN_LIB,
    required this.DOCOFF_CODE,
    required this.DOCOFF_IDF,
    required this.DOCOFF_LIB,
    required this.ROW_ID,
    required this.SDF_AUT_DELIV,
    required this.SDF_CODE,
    required this.SDF_DATD,
    required this.SDF_DATF,
    required this.SDF_IDF,
    required this.SDF_NUM,
    required this.SDF_NUM_ETRANGE,
    required this.SDF_PRO_DAY,
    required this.SDF_PRO_DEPTM,
    required this.SDF_PRO_MONTH,
    required this.SDF_PRO_NUM,
    required this.SDF_PRO_TYPE,
    required this.SDF_PRO_YEAR,
    required this.SDF_UIDF,
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

  static DocumentOfficielModel fromJson(json) {
    DateTime? SDF_DATD, SDF_DATF, LAST_UPDT, VALID_DATE;

    if (json["SDF_DATD"].toString().isNotEmpty) {
      SDF_DATD = DateFormat(detecteDateFormat(json["SDF_DATD"]))
          .parse(json["SDF_DATD"]);
    }
    if (json["SDF_DATF"].toString().isNotEmpty) {
      SDF_DATF = DateFormat(detecteDateFormat(json["SDF_DATF"]))
          .parse(json["SDF_DATF"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    if (json["VALID_DATE"].toString().isNotEmpty) {
      VALID_DATE = DateFormat(detecteDateFormat(json["VALID_DATE"]))
          .parse(json["VALID_DATE"]);
    }

    return DocumentOfficielModel(
      SDF_DATD: SDF_DATD,
      LAST_UPDT: LAST_UPDT,
      SDF_DATF: SDF_DATF,
      DOCAN_CODE: json["DOCAN_CODE"],
      DOCAN_IDF: json["DOCAN_IDF"],
      DOCAN_LIB: json["DOCAN_LIB"],
      DOCOFF_CODE: json["DOCOFF_CODE"],
      DOCOFF_IDF: json["DOCOFF_IDF"],
      DOCOFF_LIB: json["DOCOFF_LIB"],
      ROW_ID: json["ROW_ID"],
      SDF_AUT_DELIV: json["SDF_AUT_DELIV"],
      SDF_CODE: json["SDF_CODE"],
      SDF_IDF: json["SDF_IDF"],
      SDF_NUM: json["SDF_NUM"],
      SDF_NUM_ETRANGE: json["SDF_NUM_ETRANGE"],
      SDF_PRO_DAY: json["SDF_PRO_DAY"],
      SDF_PRO_DEPTM: json["SDF_PRO_DEPTM"],
      SDF_PRO_MONTH: json["SDF_PRO_MONTH"],
      SDF_PRO_NUM: json["SDF_PRO_NUM"],
      SDF_PRO_TYPE: json["SDF_PRO_TYPE"],
      SDF_PRO_YEAR: json["SDF_PRO_YEAR"],
      SDF_UIDF: json["SDF_UIDF"],
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      VALID_DATE: VALID_DATE,
    );
  }

  static List<DocumentOfficielModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<DocumentOfficielModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(DocumentOfficielModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
