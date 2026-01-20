import 'package:intl/intl.dart';

class PublicationModel {
  final String SVRPPH_IDF;
  final DateTime? LAST_UPDT;
  final DateTime? SVRPPH_START_DATE;
  final DateTime? SVRPPH_END_DATE;
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final DateTime? SVRCON_DATD;
  final DateTime? SVRCON_DATF;
  final DateTime? SVRPPH_HIST;
  const PublicationModel({
    required this.SVRCON_DATD,
    required this.LAST_UPDT,
    required this.SVRCON_DATF,
    required this.SVRPPH_END_DATE,
    required this.SVRPPH_HIST,
    required this.SVRPPH_IDF,
    required this.SVRPPH_START_DATE,
    required this.SVR_CODE,
    required this.SVR_IDF,
    required this.SVR_LIB,
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

  static String convertDate(DateTime dateTime, {String separateur = "/"}) {
    return "${Add_zero(dateTime.day)}$separateur${Add_zero(dateTime.month)}$separateur${Add_zero(dateTime.year)}";
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

  static PublicationModel fromJson(json) {
    DateTime? SVRPPH_START_DATE,
        SVRPPH_END_DATE,
        LAST_UPDT,
        SVRCON_DATD,
        SVRCON_DATF,
        SVRPPH_HIST;

    if (json["SVRPPH_START_DATE"].toString().isNotEmpty) {
      SVRPPH_START_DATE =
          DateFormat(detecteDateFormat(json["SVRPPH_START_DATE"]))
              .parse(json["SVRPPH_START_DATE"]);
    }

    if (json["SVRPPH_END_DATE"].toString().isNotEmpty) {
      SVRPPH_END_DATE = DateFormat(detecteDateFormat(json["SVRPPH_END_DATE"]))
          .parse(json["SVRPPH_END_DATE"]);
    }

    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }

    if (json["SVRCON_DATD"].toString().isNotEmpty) {
      SVRCON_DATD = DateFormat(detecteDateFormat(json["SVRCON_DATD"]))
          .parse(json["SVRCON_DATD"]);
    }

    if (json["SVRCON_DATF"].toString().isNotEmpty) {
      SVRCON_DATF = DateFormat(detecteDateFormat(json["SVRCON_DATF"]))
          .parse(json["SVRCON_DATF"]);
    }

    if (json["SVRPPH_HIST"].toString().isNotEmpty) {
      SVRPPH_HIST = DateFormat(detecteDateFormat(json["SVRPPH_HIST"]))
          .parse(json["SVRPPH_HIST"]);
    }

    return PublicationModel(
      SVRCON_DATD: SVRCON_DATD,
      LAST_UPDT: LAST_UPDT,
      SVRCON_DATF: SVRCON_DATF,
      SVRPPH_END_DATE: SVRPPH_END_DATE,
      SVRPPH_HIST: SVRPPH_HIST,
      SVRPPH_START_DATE: SVRPPH_START_DATE,
      SVRPPH_IDF: json["SVRPPH_IDF"],
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
    );
  }

  static List<PublicationModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<PublicationModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(PublicationModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
