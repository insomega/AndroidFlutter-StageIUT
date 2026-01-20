import 'package:intl/intl.dart';

class GbsystemCatalogueModel {
  final String ARTFOUREF_IDF;
  final String ARTFOUREF_UIDF;
  final String FOU_IDF;
  final String FOU_CODE;
  final String FOU_LIB;
  final String ARTREF_IDF;
  final String ARTREF_CODE;
  final String ARTREF_LIB;
  final String CLR_IDF;
  final String CLR_CODE;
  final String CLR_LIB;
  final String TPOI_IDF;
  final String TPOI_CODE;
  final String TPOI_LIB;
  final String ARTCAT_IDF;
  final String ARTCAT_CODE;
  final String ARTCAT_LIB;
  final String ARTFOUREF_PRIX;
  final DateTime? ARTFOUREF_START_DATE;
  final DateTime? ARTFOUREF_END_DATE;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String USR_LIB;

  const GbsystemCatalogueModel({
    required this.ARTFOUREF_IDF,
    required this.ARTCAT_IDF,
    required this.ARTCAT_LIB,
    required this.ARTCAT_CODE,
    required this.ARTFOUREF_END_DATE,
    required this.ARTREF_CODE,
    required this.ARTREF_IDF,
    required this.ARTREF_LIB,
    required this.ARTFOUREF_PRIX,
    required this.ARTFOUREF_START_DATE,
    required this.ARTFOUREF_UIDF,
    required this.CLR_CODE,
    required this.CLR_IDF,
    required this.LAST_UPDT,
    required this.CLR_LIB,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.FOU_CODE,
    required this.FOU_IDF,
    required this.FOU_LIB,
    required this.TPOI_CODE,
    required this.TPOI_IDF,
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

  static GbsystemCatalogueModel fromJson(json) {
    DateTime? ARTFOUREF_END_DATE, ARTFOUREF_START_DATE, LAST_UPDT;

    if (json["ARTFOUREF_START_DATE"].toString().isNotEmpty) {
      ARTFOUREF_START_DATE =
          DateFormat(detecteDateFormat(json["ARTFOUREF_START_DATE"]))
              .parse(json["ARTFOUREF_START_DATE"]);
    }
    if (json["ARTFOUREF_END_DATE"].toString().isNotEmpty) {
      ARTFOUREF_END_DATE =
          DateFormat(detecteDateFormat(json["ARTFOUREF_END_DATE"]))
              .parse(json["ARTFOUREF_END_DATE"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    return GbsystemCatalogueModel(
      ARTFOUREF_IDF: json["ARTFOUREF_IDF"],
      ARTCAT_IDF: json["ARTCAT_IDF"],
      ARTCAT_LIB: json["ARTCAT_LIB"],
      ARTCAT_CODE: json["ARTCAT_CODE"],
      ARTFOUREF_PRIX: json["ARTFOUREF_PRIX"],
      ARTREF_CODE: json["ARTREF_CODE"],
      ARTREF_IDF: json["ARTREF_IDF"],
      ARTREF_LIB: json["ARTREF_LIB"],
      ARTFOUREF_UIDF: json["ARTFOUREF_UIDF"],
      CLR_CODE: json["CLR_CODE"],
      CLR_IDF: json["CLR_IDF"],
      LAST_UPDT: LAST_UPDT,
      CLR_LIB: json["CLR_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      FOU_CODE: json["FOU_CODE"],
      FOU_IDF: json["FOU_IDF"],
      FOU_LIB: json["FOU_LIB"],
      TPOI_CODE: json["TPOI_CODE"],
      TPOI_IDF: json["TPOI_IDF"],
      TPOI_LIB: json["TPOI_LIB"],
      ARTFOUREF_END_DATE: ARTFOUREF_END_DATE,
      ARTFOUREF_START_DATE: ARTFOUREF_START_DATE,
    );
  }

  static List<GbsystemCatalogueModel> convertDynamictoListCatalogue(
      List<dynamic> sitesDynamic) {
    List<GbsystemCatalogueModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(GbsystemCatalogueModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
