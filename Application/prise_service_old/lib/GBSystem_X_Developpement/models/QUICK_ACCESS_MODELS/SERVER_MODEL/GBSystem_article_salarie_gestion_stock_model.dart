import 'package:intl/intl.dart';

class ArticleSalarieGestionStockModel {
  final String ARTAFFEC_UIDF;
  final String ARTAFFEC_IDF;
  final String SVR_IDF;
  final String? EVT_IDF;
  final String ART_IDF;
  final DateTime? ARTAFFEC_START_DATE;
  final DateTime? ARTAFFEC_END_DATE;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String DOS_IDF;
  final String? LIE_IDF;
  final String? VAC_IDF;
  final String? SVRCON_IDF;
  final String ARTCAT_LIB;
  final String FOU_LIB;
  final String TPOI_CODE;
  final String ART_UIDF;
  final String ARTREF_CODE;
  final String ARTREF_LIB;
  final String SVR_CODE;
  final String SVR_LIB;
  final String? LIE_CODE;
  final String? LIE_LIB;
  final String ARTFOUREF_IDF;
  final String ARTFOUREF_PRIX;
  final String ARTETA_IDF;
  final String? STOCK_TYPE;
  final String CLR_LIB;
  final String CLR_CODE;
  final String ENTR_IDF;
  final String ENTR_CODE;
  final String ENTR_LIB;

  const ArticleSalarieGestionStockModel({
    required this.ARTAFFEC_END_DATE,
    required this.ARTCAT_LIB,
    required this.ARTFOUREF_IDF,
    required this.ARTFOUREF_PRIX,
    required this.ARTREF_CODE,
    required this.ARTAFFEC_IDF,
    required this.ARTREF_LIB,
    required this.ARTAFFEC_START_DATE,
    required this.CLR_CODE,
    required this.CLR_LIB,
    required this.ENTR_CODE,
    required this.ENTR_IDF,
    required this.ENTR_LIB,
    required this.FOU_LIB,
    required this.TPOI_CODE,
    required this.ARTAFFEC_UIDF,
    required this.ARTETA_IDF,
    required this.ART_IDF,
    required this.ART_UIDF,
    required this.DOS_IDF,
    required this.EVT_IDF,
    required this.LAST_UPDT,
    required this.LIE_CODE,
    required this.LIE_IDF,
    required this.LIE_LIB,
    required this.STOCK_TYPE,
    required this.SVRCON_IDF,
    required this.SVR_CODE,
    required this.SVR_IDF,
    required this.SVR_LIB,
    required this.USER_IDF,
    required this.VAC_IDF,
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

  static ArticleSalarieGestionStockModel fromJson(json) {
    DateTime? ARTAFFEC_END_DATE, LAST_UPDT, ARTAFFEC_START_DATE;

    if (json["ARTAFFEC_END_DATE"].toString().isNotEmpty) {
      ARTAFFEC_END_DATE =
          DateFormat(detecteDateFormat(json["ARTAFFEC_END_DATE"]))
              .parse(json["ARTAFFEC_END_DATE"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }
    if (json["ARTAFFEC_START_DATE"].toString().isNotEmpty) {
      ARTAFFEC_START_DATE =
          DateFormat(detecteDateFormat(json["ARTAFFEC_START_DATE"]))
              .parse(json["ARTAFFEC_START_DATE"]);
    }

    return ArticleSalarieGestionStockModel(
      ARTAFFEC_END_DATE: ARTAFFEC_END_DATE,

      ///
      ARTCAT_LIB: json["ARTCAT_LIB"],
      ARTFOUREF_IDF: json["ARTFOUREF_IDF"],
      ARTFOUREF_PRIX: json["ARTFOUREF_PRIX"],
      ARTREF_CODE: json["ARTREF_CODE"],
      ARTAFFEC_IDF: json["ARTAFFEC_IDF"],
      ARTREF_LIB: json["ARTREF_LIB"],
      ARTAFFEC_START_DATE: ARTAFFEC_START_DATE, //
      CLR_CODE: json["CLR_CODE"],
      CLR_LIB: json["CLR_LIB"],
      ENTR_CODE: json["ENTR_CODE"],
      ENTR_IDF: json["ENTR_IDF"],
      ENTR_LIB: json["ENTR_LIB"],
      FOU_LIB: json["FOU_LIB"],
      TPOI_CODE: json["TPOI_CODE"],
      ARTAFFEC_UIDF: json["ARTAFFEC_UIDF"],
      ARTETA_IDF: json["ARTETA_IDF"],
      ART_IDF: json["ART_IDF"],
      ART_UIDF: json["ART_UIDF"],
      DOS_IDF: json["DOS_IDF"],
      EVT_IDF: json["EVT_IDF"],
      LAST_UPDT: LAST_UPDT, //
      LIE_CODE: json["LIE_CODE"],
      LIE_IDF: json["LIE_IDF"],
      LIE_LIB: json["LIE_LIB"],
      STOCK_TYPE: json["STOCK_TYPE"],
      SVRCON_IDF: json["SVRCON_IDF"],
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],

      USER_IDF: json["USER_IDF"],
      VAC_IDF: json["VAC_IDF"],
    );
  }

  static List<ArticleSalarieGestionStockModel>
      convertDynamictoListArticlesSalarie(List<dynamic> sitesDynamic) {
    List<ArticleSalarieGestionStockModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(ArticleSalarieGestionStockModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
