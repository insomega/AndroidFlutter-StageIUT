import 'package:intl/intl.dart';

class MemoQuestionModel {
  final String LIEINSQMMO_UIDF;
  final String LIEINSQMMO_IDF;
  final String USER_IDF;
  final DateTime? LAST_UPDT;
  final String LIEINSMMO_IDF;
  final String LIEINSMMO_CODE;
  final String LIEINSMMO_LIB;
  final String LIEINSMMO_MEMO;
  final String LIEINSPQU_IDF;
  final String LIEINSPQU_CODE;
  final String LIEINSPQU_LIB;
  final String USR_LIB;

  MemoQuestionModel({
    required this.LAST_UPDT,
    required this.LIEINSMMO_CODE,
    required this.LIEINSMMO_IDF,
    required this.LIEINSMMO_LIB,
    required this.LIEINSMMO_MEMO,
    required this.LIEINSQMMO_IDF,
    required this.LIEINSQMMO_UIDF,
    required this.LIEINSPQU_CODE,
    required this.USER_IDF,
    required this.LIEINSPQU_IDF,
    required this.LIEINSPQU_LIB,
    required this.USR_LIB,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is MemoQuestionModel) {
      return other.LIEINSMMO_IDF == LIEINSMMO_IDF;
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
  int get hashCode => LIEINSMMO_IDF.hashCode;
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

  static MemoQuestionModel fromJson(json) {
    DateTime? LAST_UPDT;
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }

    return MemoQuestionModel(
      LIEINSMMO_CODE: json["LIEINSMMO_CODE"],
      LIEINSMMO_IDF: json["LIEINSMMO_IDF"],
      LIEINSMMO_LIB: json["LIEINSMMO_LIB"],
      LIEINSMMO_MEMO: json["LIEINSMMO_MEMO"],
      LIEINSQMMO_IDF: json["LIEINSQMMO_IDF"],
      LIEINSQMMO_UIDF: json["LIEINSQMMO_UIDF"],
      USER_IDF: json["USER_IDF"],
      LIEINSPQU_CODE: json["LIEINSPQU_CODE"],
      USR_LIB: json["USR_LIB"],
      LIEINSPQU_IDF: json["LIEINSPQU_IDF"],
      LIEINSPQU_LIB: json["LIEINSPQU_LIB"],
      LAST_UPDT: LAST_UPDT,
    );
  }

  static List<MemoQuestionModel> convertDynamictoListMemo(
      List<dynamic> memoDynamic) {
    List<MemoQuestionModel> listMemo = [];
    for (var i = 0; i < memoDynamic.length; i++) {
      listMemo.add(MemoQuestionModel.fromJson(memoDynamic[i]));
    }
    return listMemo;
  }
}
