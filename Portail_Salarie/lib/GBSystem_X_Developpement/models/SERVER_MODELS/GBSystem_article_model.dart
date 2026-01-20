import 'package:intl/intl.dart';

class GbsystemArticleModel {
  final String? EVT_LIB;
  final String? SVR_CIV;
  final String? SVR_CODE;
  final String? SVR_LIB;
  final String? SVR_TELPOR;
  final String? ARTAFFEC_UIDF;
  final String? ARTAFFEC_IDF;
  final String? ART_UIDF;
  final String? ART_IDF;
  final String? ARTREF_CODE;
  final String? ARTREF_LIB;
  final String? EVT_IDF;
  final String? CLR_LIB;
  final String? CLR_CODE;
  final String? SVRCON_IDF;
  final String? TPOI_CODE;
  final String? TPOI_LIB;
  final String? QTE;
  final String? LIE_CODE;
  final String? LIE_LIB;
  final String? ART_ARENDRE;
  final DateTime? ARTAFFEC_END_DATE;
  final DateTime? ARTAFFEC_START_DATE;
  final String? SVR_EMAIL;
  final String? SVR_IDF;
  final String? ENTR_CODE;
  final String? ENTR_LIB;
  final String? CLR_CODE_colorweb;

  const GbsystemArticleModel({
    required this.ARTAFFEC_END_DATE,
    required this.ARTAFFEC_IDF,
    required this.ARTAFFEC_START_DATE,
    required this.ARTAFFEC_UIDF,
    required this.ARTREF_CODE,
    required this.ARTREF_LIB,
    required this.ART_ARENDRE,
    required this.ART_IDF,
    required this.ART_UIDF,
    required this.CLR_CODE,
    required this.CLR_CODE_colorweb,
    required this.CLR_LIB,
    required this.ENTR_CODE,
    required this.ENTR_LIB,
    required this.EVT_IDF,
    required this.EVT_LIB,
    required this.LIE_CODE,
    required this.LIE_LIB,
    required this.QTE,
    required this.SVRCON_IDF,
    required this.SVR_CIV,
    required this.SVR_CODE,
    required this.SVR_EMAIL,
    required this.SVR_IDF,
    required this.SVR_LIB,
    required this.SVR_TELPOR,
    required this.TPOI_CODE,
    required this.TPOI_LIB,
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

  static GbsystemArticleModel fromJson(json) {
    DateTime? ARTAFFEC_END_DATE, ARTAFFEC_START_DATE;

    if (json["ARTAFFEC_END_DATE"].toString().isNotEmpty) {
      ARTAFFEC_END_DATE =
          DateFormat(detecteDateFormat(json["ARTAFFEC_END_DATE"]))
              .parse(json["ARTAFFEC_END_DATE"]);
    }
    if (json["ARTAFFEC_START_DATE"].toString().isNotEmpty) {
      ARTAFFEC_START_DATE =
          DateFormat(detecteDateFormat(json["ARTAFFEC_START_DATE"]))
              .parse(json["ARTAFFEC_START_DATE"]);
    }

    return GbsystemArticleModel(
      ARTAFFEC_END_DATE: ARTAFFEC_END_DATE,
      ARTAFFEC_START_DATE: ARTAFFEC_START_DATE,
      ARTAFFEC_IDF: json["ARTAFFEC_IDF"],
      ARTAFFEC_UIDF: json["ARTAFFEC_UIDF"],
      ARTREF_CODE: json["ARTREF_CODE"],
      ARTREF_LIB: json["ARTREF_LIB"],
      ART_ARENDRE: json["ART_ARENDRE"],
      ART_IDF: json["ART_IDF"],
      ART_UIDF: json["ART_UIDF"],
      CLR_CODE: json["CLR_CODE"],
      CLR_CODE_colorweb: json["CLR_CODE_colorweb"],
      CLR_LIB: json["CLR_LIB"],
      ENTR_CODE: json["ENTR_CODE"],
      ENTR_LIB: json["ENTR_LIB"],
      EVT_IDF: json["EVT_IDF"],
      EVT_LIB: json["EVT_LIB"],
      LIE_CODE: json["LIE_CODE"],
      LIE_LIB: json["LIE_LIB"],
      QTE: json["QTE"],
      SVRCON_IDF: json["SVRCON_IDF"],
      SVR_CIV: json["SVR_CIV"],
      SVR_CODE: json["SVR_CODE"],
      SVR_EMAIL: json["SVR_EMAIL"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      SVR_TELPOR: json["SVR_TELPOR"],
      TPOI_CODE: json["TPOI_CODE"],
      TPOI_LIB: json["TPOI_LIB"],
    );
  }

  static List<GbsystemArticleModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<GbsystemArticleModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(GbsystemArticleModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
