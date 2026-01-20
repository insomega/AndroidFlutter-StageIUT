import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EvaluationEnCoursModel {
  final String LIEINSPSVR_IDF;
  final String CLI_IDF;
  final String CLI_CODE;
  final String CLI_LIB;
  final String LIE_IDF;
  final String LIE_CODE;
  final String LIE_LIB;
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String LIEINSPQSNR_IDF;
  final String LIEINSPQSNR_NOTATION_TYPE;
  final String LIEINSPQSNR_CODE;
  final String LIEINSPQSNR_LIB;
  final DateTime? LIEINSPSVR_START_DATE;
  final DateTime? LIEINSPSVR_END_DATE;
  final String LIEINSPSVRQU_MEMO;
  final String LIEINSPSVR_SIGNATURE;
  final String? LIEINSPSVRQU_ACTION_SHORT;
  final String? LIEINSPSVRQU_ACTION_LONG;
  final String? LIEINSPSVRQU_ALONG_DATE1;
  final String? LIEINSPSVRQU_ALONG_DATE2;
  String EVAL_MOYENNE;
  String EVAL_STAT;
  final String USER_IDF;
  final String USR_LIB;
  final DateTime? LAST_UPDT;

  EvaluationEnCoursModel({
    required this.CLI_CODE,
    required this.CLI_IDF,
    required this.CLI_LIB,
    required this.EVAL_MOYENNE,
    required this.EVAL_STAT,
    required this.LAST_UPDT,
    required this.LIEINSPQSNR_CODE,
    required this.LIEINSPQSNR_IDF,
    required this.LIEINSPQSNR_LIB,
    required this.LIEINSPQSNR_NOTATION_TYPE,
    required this.LIEINSPSVRQU_ACTION_LONG,
    required this.LIEINSPSVRQU_ACTION_SHORT,
    required this.LIEINSPSVRQU_ALONG_DATE1,
    required this.LIEINSPSVRQU_ALONG_DATE2,
    required this.LIEINSPSVRQU_MEMO,
    required this.LIEINSPSVR_END_DATE,
    required this.LIEINSPSVR_IDF,
    required this.LIEINSPSVR_SIGNATURE,
    required this.LIEINSPSVR_START_DATE,
    required this.LIE_CODE,
    required this.LIE_IDF,
    required this.LIE_LIB,
    required this.SVR_CODE,
    required this.SVR_IDF,
    required this.SVR_LIB,
    required this.USER_IDF,
    required this.USR_LIB,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is EvaluationEnCoursModel) {
      return other.LIEINSPSVR_IDF == LIEINSPSVR_IDF;
      // &&
      //     other.LIEINSMMO_LIB == LIEINSMMO_LIB &&
      //     other.LAST_UPDT == LAST_UPDT &&
      //     other.LIEINSMMO_CODE == LIEINSMMO_CODE &&
      //     other.LIEINSMMO_MEMO == LIEINSMMO_MEMO &&
      //     other.LIEINSPQU_CODE == LIEINSPQU_CODE &&
      //     other.LIEINSPQU_IDF == LIEINSPQU_IDF &&
      //     other.LIEINSPQU_LIB == LIEINSPQU_LIB &&
      //     other.LIEINSQMMO_IDF == LIEINSQMMO_IDF &&
      //     other.LIEINSQMMO_UIDF == LIEINSQMMO_UIDF &&
      //     other.USER_IDF == USER_IDF &&
      //     other.USR_LIB == USR_LIB;
    }
    return false;
  }

  @override
  int get hashCode => LIEINSPSVR_IDF.hashCode;
  // ^
  // LIEINSMMO_LIB.hashCode ^
  // LAST_UPDT.hashCode ^
  // LIEINSMMO_CODE.hashCode ^
  // LIEINSMMO_MEMO.hashCode ^
  // LIEINSPQU_CODE.hashCode ^
  // LIEINSPQU_IDF.hashCode ^
  // LIEINSPQU_LIB.hashCode ^
  // LIEINSQMMO_IDF.hashCode ^
  // LIEINSQMMO_UIDF.hashCode ^
  // USER_IDF.hashCode ^
  // USR_LIB.hashCode;

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

  static EvaluationEnCoursModel fromJson(json) {
    DateTime? LIEINSPSVR_START_DATE, LIEINSPSVR_END_DATE, LAST_UPDT;
    if (json["LIEINSPSVR_START_DATE"]
        .toString()
        .removeAllWhitespace
        .isNotEmpty) {
      print("LIEINSPSVR_START_DATE : ${json["LIEINSPSVR_START_DATE"]}");
      LIEINSPSVR_START_DATE =
          DateFormat(detecteDateFormat(json["LIEINSPSVR_START_DATE"]))
              .parse(json["LIEINSPSVR_START_DATE"]);
    }
    if (json["LIEINSPSVR_END_DATE"].toString().removeAllWhitespace.isNotEmpty) {
      print("LIEINSPSVR_END_DATE : ${json["LIEINSPSVR_END_DATE"]}");

      LIEINSPSVR_END_DATE =
          DateFormat(detecteDateFormat(json["LIEINSPSVR_END_DATE"]))
              .parse(json["LIEINSPSVR_END_DATE"]);
    }

    if (json["LAST_UPDT"].toString().removeAllWhitespace.isNotEmpty) {
      print("LAST_UPDT : ${json["LAST_UPDT"]}");

      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }

    return EvaluationEnCoursModel(
      CLI_CODE: json["CLI_CODE"],
      CLI_IDF: json["CLI_IDF"],
      CLI_LIB: json["CLI_LIB"],
      EVAL_MOYENNE: json["EVAL_MOYENNE"],
      EVAL_STAT: json["EVAL_STAT"],
      LIEINSPQSNR_CODE: json["LIEINSPQSNR_CODE"],
      USER_IDF: json["USER_IDF"],
      LIEINSPQSNR_IDF: json["LIEINSPQSNR_IDF"],
      USR_LIB: json["USR_LIB"],
      LIEINSPQSNR_LIB: json["LIEINSPQSNR_LIB"],
      LIEINSPQSNR_NOTATION_TYPE: json["LIEINSPQSNR_NOTATION_TYPE"],
      LIEINSPSVRQU_ACTION_LONG: json["LIEINSPSVRQU_ACTION_LONG"],
      LIEINSPSVRQU_ACTION_SHORT: json["LIEINSPSVRQU_ACTION_SHORT"],
      LIEINSPSVRQU_ALONG_DATE1: json["LIEINSPSVRQU_ALONG_DATE1"],
      LIEINSPSVRQU_ALONG_DATE2: json["LIEINSPSVRQU_ALONG_DATE2"],
      LIEINSPSVRQU_MEMO: json["LIEINSPSVRQU_MEMO"],
      LIEINSPSVR_END_DATE: LIEINSPSVR_END_DATE,
      LIEINSPSVR_IDF: json["LIEINSPSVR_IDF"],
      LIEINSPSVR_SIGNATURE: json["LIEINSPSVR_SIGNATURE"],
      LIEINSPSVR_START_DATE: LIEINSPSVR_START_DATE,
      LIE_CODE: json["LIE_CODE"],
      LIE_IDF: json["LIE_IDF"],
      LIE_LIB: json["LIE_LIB"],
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      LAST_UPDT: LAST_UPDT,
    );
  }

  static List<EvaluationEnCoursModel> convertDynamictoListEval(
      List<dynamic> memoDynamic) {
    List<EvaluationEnCoursModel> listMemo = [];
    for (var i = 0; i < memoDynamic.length; i++) {
      listMemo.add(EvaluationEnCoursModel.fromJson(memoDynamic[i]));
    }
    return listMemo;
  }
}
