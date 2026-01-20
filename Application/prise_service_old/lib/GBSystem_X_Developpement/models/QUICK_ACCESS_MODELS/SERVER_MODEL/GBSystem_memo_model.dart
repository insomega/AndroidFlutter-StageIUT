import 'package:intl/intl.dart';

class MemoModel {
  int? nombreImage;

  final String LIEINSPSVRQU_UIDF;
  final String LIEINSPSVRQU_IDF;
  final String LIEINSPSVRQU_NOTE;
  final String LIEINSPSVRQU_ACTION_LONG;
  final String LIEINSPSVRQU_ACTION_SHORT;
  final String? LIEINSPSVRQU_MEMO;
  final String LIEINSPSVRQU_STATUT;
  final String? LIEINSQMMO_IDF_ALONG;
  final String? LIEINSQMMO_IDF_ASHORT;
  final DateTime? LIEINSPSVRQU_ALONG_DATE;
  final String LIEINSPSVR_IDF;
  final DateTime? LIEINSPSVR_START_DATE;
  final DateTime? LIEINSPSVR_END_DATE;
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String LIE_IDF;
  final String LIE_CODE;
  final String LIE_LIB;
  final String LIEINSPQU_IDF;
  final String LIEINSPQU_CODE;
  final String LIEINSPQU_LIB;
  final String LIEINSPQU_MAX;
  final String LIEINSPQU_ORDER_NUM;
  final String LIEINSPQU_NOTATION_TYPE;
  final String? LIEINSPEVAL_COLOR;
  final String LIEINSPCAT_IDF;
  final String LIEINSPCAT_CODE;
  final String LIEINSPCAT_LIB;
  final String LIEINSPCAT_COEF;
  final String? LIEINSPCAT_CLR;
  final String? LIEINSPQU_HELP;
  final String NBR_PHOTO;
  final DateTime? LIEINSPSVRQU_CLOSED_DATE;

  MemoModel({
    this.nombreImage,
    required this.LIEINSPSVRQU_UIDF,
    required this.LIEINSPCAT_CLR,
    required this.LIEINSPCAT_CODE,
    required this.LIEINSPCAT_COEF,
    required this.LIEINSPCAT_IDF,
    required this.LIEINSPCAT_LIB,
    required this.LIEINSPEVAL_COLOR,
    required this.LIEINSPQU_CODE,
    required this.LIEINSPQU_HELP,
    required this.LIEINSPQU_IDF,
    required this.LIEINSPQU_LIB,
    required this.LIEINSPQU_MAX,
    required this.LIEINSPQU_NOTATION_TYPE,
    required this.LIEINSPQU_ORDER_NUM,
    required this.LIEINSPSVRQU_ACTION_LONG,
    required this.LIEINSPSVRQU_ACTION_SHORT,
    required this.LIEINSPSVRQU_ALONG_DATE,
    required this.LIEINSPSVRQU_CLOSED_DATE,
    required this.LIEINSPSVRQU_IDF,
    required this.LIEINSPSVRQU_MEMO,
    required this.LIEINSPSVRQU_NOTE,
    required this.LIEINSPSVRQU_STATUT,
    required this.LIEINSPSVR_END_DATE,
    required this.LIEINSPSVR_IDF,
    required this.LIEINSPSVR_START_DATE,
    required this.LIEINSQMMO_IDF_ALONG,
    required this.LIEINSQMMO_IDF_ASHORT,
    required this.LIE_CODE,
    required this.LIE_IDF,
    required this.LIE_LIB,
    required this.NBR_PHOTO,
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

  static MemoModel fromJson(json) {
    DateTime? LIEINSPSVRQU_ALONG_DATE,
        LIEINSPSVR_START_DATE,
        LIEINSPSVR_END_DATE,
        LIEINSPSVRQU_CLOSED_DATE;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    if (json["LIEINSPSVRQU_ALONG_DATE"] != null &&
        json["LIEINSPSVRQU_ALONG_DATE"].toString().isNotEmpty) {
      LIEINSPSVRQU_ALONG_DATE =
          originalFormat.parse(json["LIEINSPSVRQU_ALONG_DATE"]);
    }
    if (json["LIEINSPSVR_START_DATE"] != null &&
        json["LIEINSPSVR_START_DATE"].toString().isNotEmpty) {
      LIEINSPSVR_START_DATE =
          originalFormat.parse(json["LIEINSPSVR_START_DATE"]);
    }
    if (json["LIEINSPSVR_END_DATE"] != null &&
        json["LIEINSPSVR_END_DATE"].toString().isNotEmpty) {
      LIEINSPSVR_END_DATE = originalFormat.parse(json["LIEINSPSVR_END_DATE"]);
    }
    if (json["LIEINSPSVRQU_CLOSED_DATE"] != null &&
        json["LIEINSPSVRQU_CLOSED_DATE"].toString().isNotEmpty) {
      LIEINSPSVR_END_DATE =
          originalFormat.parse(json["LIEINSPSVRQU_CLOSED_DATE"]);
    }

    return MemoModel(
      LIEINSPSVRQU_UIDF: json["LIEINSPSVRQU_UIDF"],
      LIEINSPCAT_CLR: json["LIEINSPCAT_CLR"],
      LIEINSPCAT_CODE: json["LIEINSPCAT_CODE"],
      LIEINSPCAT_COEF: json["LIEINSPCAT_COEF"],
      LIEINSPCAT_IDF: json["LIEINSPCAT_IDF"],
      LIEINSPCAT_LIB: json["LIEINSPCAT_LIB"],
      LIEINSPEVAL_COLOR: json["LIEINSPEVAL_COLOR"],
      LIEINSPQU_CODE: json["LIEINSPQU_CODE"],
      LIEINSPQU_HELP: json["LIEINSPQU_HELP"],
      LIEINSPQU_IDF: json["LIEINSPQU_IDF"],
      LIEINSPQU_LIB: json["LIEINSPQU_LIB"],
      LIEINSPQU_MAX: json["LIEINSPQU_MAX"],
      LIEINSPQU_NOTATION_TYPE: json["LIEINSPQU_NOTATION_TYPE"],
      LIEINSPQU_ORDER_NUM: json["LIEINSPQU_ORDER_NUM"],
      LIEINSPSVRQU_ACTION_LONG: json["LIEINSPSVRQU_ACTION_LONG"],
      LIEINSPSVRQU_ACTION_SHORT: json["LIEINSPSVRQU_ACTION_SHORT"],
      LIEINSPSVRQU_ALONG_DATE: LIEINSPSVRQU_ALONG_DATE,
      LIEINSPSVRQU_CLOSED_DATE: LIEINSPSVRQU_CLOSED_DATE,
      LIEINSPSVR_START_DATE: LIEINSPSVR_START_DATE,
      LIEINSPSVR_END_DATE: LIEINSPSVR_END_DATE,
      LIEINSPSVRQU_IDF: json["LIEINSPSVRQU_IDF"],
      LIEINSPSVRQU_MEMO: json["LIEINSPSVRQU_MEMO"],
      LIEINSPSVRQU_NOTE: json["LIEINSPSVRQU_NOTE"],
      LIEINSPSVRQU_STATUT: json["LIEINSPSVRQU_STATUT"],
      LIEINSPSVR_IDF: json["LIEINSPSVR_IDF"],
      LIEINSQMMO_IDF_ALONG: json["LIEINSQMMO_IDF_ALONG"],
      LIEINSQMMO_IDF_ASHORT: json["LIEINSQMMO_IDF_ASHORT"],
      LIE_CODE: json["LIE_CODE"],
      LIE_IDF: json["LIE_IDF"],
      LIE_LIB: json["LIE_LIB"],
      NBR_PHOTO: json["NBR_PHOTO"],
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
    );
  }

  static List<MemoModel> convertDynamictoListMemo(List<dynamic> memoDynamic) {
    List<MemoModel> listMemo = [];
    for (var i = 0; i < memoDynamic.length; i++) {
      listMemo.add(MemoModel.fromJson(memoDynamic[i]));
    }
    return listMemo;
  }
}
