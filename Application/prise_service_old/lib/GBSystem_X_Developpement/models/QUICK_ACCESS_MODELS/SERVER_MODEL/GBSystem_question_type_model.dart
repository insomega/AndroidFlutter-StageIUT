import 'package:intl/intl.dart';

class QuestionTypeModel {
  final String LIEINSPSVR_IDF;
  final DateTime? LIEINSPSVR_START_DATE;
  final DateTime? LIEINSPSVR_END_DATE;
  final String? LIEINSPSVR_MEMO;
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String LIE_IDF;
  final String LIE_IDF_1;
  final String LIE_CODE;
  final String LIE_LIB;
  final String LIEINSPCAT_IDF;
  final String LIEINSPCAT_CODE;
  final String LIEINSPCAT_LIB;
  final String LIEINSPCAT_COEF;
  final String LIEINSPCAT_ORDER_NUM;
  final String? LIEINSPCAT_CLR;
  final String? QBN_NUM;
  final String? LIEINSPCAT_CLR_colorweb;
  const QuestionTypeModel(
      {required this.LIEINSPSVR_IDF,
      required this.LIEINSPSVR_START_DATE,
      required this.LIEINSPSVR_END_DATE,
      required this.LIEINSPCAT_CLR,
      required this.LIEINSPCAT_CODE,
      required this.LIEINSPCAT_COEF,
      required this.LIEINSPCAT_IDF,
      required this.LIEINSPCAT_LIB,
      required this.LIEINSPCAT_CLR_colorweb,
      required this.LIEINSPCAT_ORDER_NUM,
      required this.LIEINSPSVR_MEMO,
      required this.LIE_IDF_1,
      required this.LIE_CODE,
      required this.LIE_IDF,
      required this.LIE_LIB,
      required this.SVR_CODE,
      required this.SVR_IDF,
      required this.SVR_LIB,
      this.QBN_NUM});

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

  static QuestionTypeModel fromJson(json) {
    DateTime? LIEINSPSVR_START_DATE, LIEINSPSVR_END_DATE;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    if (json["LIEINSPSVR_START_DATE"] != null &&
        json["LIEINSPSVR_START_DATE"].toString().isNotEmpty) {
      LIEINSPSVR_START_DATE =
          originalFormat.parse(json["LIEINSPSVR_START_DATE"]);
    }
    if (json["LIEINSPSVR_END_DATE"] != null &&
        json["LIEINSPSVR_END_DATE"].toString().isNotEmpty) {
      LIEINSPSVR_END_DATE = originalFormat.parse(json["LIEINSPSVR_END_DATE"]);
    }

    return QuestionTypeModel(
      LIEINSPCAT_CLR: json["LIEINSPCAT_CLR"],
      LIEINSPCAT_CODE: json["LIEINSPCAT_CODE"],
      LIEINSPCAT_COEF: json["LIEINSPCAT_COEF"],
      LIEINSPCAT_IDF: json["LIEINSPCAT_IDF"],
      LIEINSPCAT_LIB: json["LIEINSPCAT_LIB"],
      LIEINSPCAT_CLR_colorweb: json["LIEINSPCAT_CLR_colorweb"],
      LIEINSPCAT_ORDER_NUM: json["LIEINSPCAT_ORDER_NUM"],
      LIEINSPSVR_MEMO: json["LIEINSPSVR_MEMO"],
      LIE_IDF_1: json["LIE_IDF_1"],
      LIEINSPSVR_START_DATE: LIEINSPSVR_START_DATE,
      LIEINSPSVR_END_DATE: LIEINSPSVR_END_DATE,
      LIEINSPSVR_IDF: json["LIEINSPSVR_IDF"],
      LIE_CODE: json["LIE_CODE"],
      LIE_IDF: json["LIE_IDF"],
      LIE_LIB: json["LIE_LIB"],
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      QBN_NUM: json["QBN_NUM"],
    );
  }

  static List<QuestionTypeModel> convertDynamictoListQuestionsType(
      List<dynamic> vacationsDynamic) {
    List<QuestionTypeModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(QuestionTypeModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
