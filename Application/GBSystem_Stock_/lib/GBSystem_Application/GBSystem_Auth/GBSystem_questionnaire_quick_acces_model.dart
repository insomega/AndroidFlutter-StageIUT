import 'package:intl/intl.dart';

class QuestionnaireModel {
  final String LIEINSPQSNR_IDF;
  final String LIEINSPQSNR_LIB;
  final String LIEINSPQSNR_UIDF;
  final String LIEINSQUESTYP_IDF;
  final String LIEINSQUESTYP_CODE;
  final String LIEINSQUESTYP_LIB;
  final String? LIEINSPQSNR_RANDOM;
  final String? LIEINSPQSNR_NBRECATEGO;
  final String? LIEINSPQSNR_NBREQUEST;
  final DateTime START_DATE;
  final DateTime? END_DATE;
  final String LIEINSTYP_IDF;
  final String LIEINSTYP_CODE;
  final String LIEINSTYP_LIB;
  final String LIEINSPQSNR_ORDER_NUM;
  final String LIEINSPQSNR_NBR_UNIT;
  final String LIEINSPQSNR_TYP_UNIT;
  final DateTime? LAST_UPDT;
  final String LIEINSPQSNR_NOTATION_TYPE;
  final String USER_IDF;
  final String USR_LIB;
  final String LIEINSPQSNR_CODE;
  const QuestionnaireModel({
    required this.LIEINSPQSNR_UIDF,
    required this.LIEINSQUESTYP_IDF,
    required this.END_DATE,
    required this.LIEINSQUESTYP_CODE,
    required this.LIEINSQUESTYP_LIB,
    required this.LAST_UPDT,
    required this.LIEINSPQSNR_CODE,
    required this.LIEINSPQSNR_NBRECATEGO,
    required this.LIEINSPQSNR_NBREQUEST,
    required this.LIEINSPQSNR_NBR_UNIT,
    required this.LIEINSPQSNR_NOTATION_TYPE,
    required this.LIEINSPQSNR_ORDER_NUM,
    required this.LIEINSPQSNR_RANDOM,
    required this.LIEINSPQSNR_TYP_UNIT,
    required this.LIEINSTYP_CODE,
    required this.LIEINSTYP_IDF,
    required this.LIEINSTYP_LIB,
    required this.START_DATE,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.LIEINSPQSNR_IDF,
    required this.LIEINSPQSNR_LIB,
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

  static QuestionnaireModel fromJson(json) {
    DateTime? dateStart, dateEnd, lastUpdt;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    if (json["START_DATE"] != null &&
        json["START_DATE"].toString().isNotEmpty) {
      dateStart = originalFormat.parse(json["START_DATE"]);
    }
    if (json["END_DATE"] != null && json["END_DATE"].toString().isNotEmpty) {
      dateEnd = originalFormat.parse(json["END_DATE"]);
    }
    if (json["LAST_UPDT"] != null && json["LAST_UPDT"].toString().isNotEmpty) {
      dateEnd = originalFormat.parse(json["LAST_UPDT"]);
    }

    return QuestionnaireModel(
      LIEINSPQSNR_IDF: json["LIEINSPQSNR_IDF"],
      LIEINSPQSNR_LIB: json["LIEINSPQSNR_LIB"],
      LIEINSPQSNR_UIDF: json["LIEINSPQSNR_UIDF"],
      LAST_UPDT: lastUpdt,
      LIEINSQUESTYP_CODE: json["LIEINSQUESTYP_CODE"],
      LIEINSQUESTYP_IDF: json["LIEINSQUESTYP_IDF"],
      LIEINSQUESTYP_LIB: json["LIEINSQUESTYP_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      END_DATE: dateEnd,
      LIEINSPQSNR_CODE: json["LIEINSPQSNR_CODE"],
      LIEINSPQSNR_NBRECATEGO: json["LIEINSPQSNR_NBRECATEGO"],
      LIEINSPQSNR_NBREQUEST: json["LIEINSPQSNR_NBREQUEST"],
      LIEINSPQSNR_NBR_UNIT: json["LIEINSPQSNR_NBR_UNIT"],
      LIEINSPQSNR_NOTATION_TYPE: json["LIEINSPQSNR_NOTATION_TYPE"],
      LIEINSPQSNR_ORDER_NUM: json["LIEINSPQSNR_ORDER_NUM"],
      LIEINSPQSNR_RANDOM: json["LIEINSPQSNR_RANDOM"],
      LIEINSPQSNR_TYP_UNIT: json["LIEINSPQSNR_TYP_UNIT"],
      LIEINSTYP_CODE: json["LIEINSTYP_CODE"],
      LIEINSTYP_IDF: json["LIEINSTYP_IDF"],
      LIEINSTYP_LIB: json["LIEINSTYP_LIB"],
      START_DATE: dateStart!,
    );
  }

  static List<QuestionnaireModel> convertDynamictoListQuestions(
      List<dynamic> vacationsDynamic) {
    List<QuestionnaireModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(QuestionnaireModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
