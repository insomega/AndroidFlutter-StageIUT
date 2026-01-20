import 'package:intl/intl.dart';

class DocumentEntrepriseModel {
  final String DOCAN_SEL_IDF;
  final String DOCAN_IDF;
  final String DOCAN_CODE;
  final String DOCAN_LIB;
  final String TYPDOC_CODE;
  final String ENT_CODE;
  final DateTime? LAST_UPDT;
  final String DOCAN_DWNLD_NBR;
  final DateTime? DOCAN_DATE_CREATED;
  final String ROW_ID;

  const DocumentEntrepriseModel({
    required this.DOCAN_CODE,
    required this.LAST_UPDT,
    required this.DOCAN_DATE_CREATED,
    required this.DOCAN_DWNLD_NBR,
    required this.DOCAN_IDF,
    required this.DOCAN_LIB,
    required this.DOCAN_SEL_IDF,
    required this.ENT_CODE,
    required this.TYPDOC_CODE,
    required this.ROW_ID,
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

  static DocumentEntrepriseModel fromJson(json) {
    DateTime? DOCAN_DATE_CREATED, LAST_UPDT;

    if (json["DOCAN_DATE_CREATED"].toString().isNotEmpty) {
      DOCAN_DATE_CREATED =
          DateFormat(detecteDateFormat(json["DOCAN_DATE_CREATED"]))
              .parse(json["DOCAN_DATE_CREATED"]);
    }

    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = DateFormat(detecteDateFormat(json["LAST_UPDT"]))
          .parse(json["LAST_UPDT"]);
    }

    return DocumentEntrepriseModel(
      DOCAN_DATE_CREATED: DOCAN_DATE_CREATED,
      LAST_UPDT: LAST_UPDT,
      DOCAN_CODE: json["DOCAN_CODE"],
      DOCAN_DWNLD_NBR: json["DOCAN_DWNLD_NBR"],
      DOCAN_IDF: json["DOCAN_IDF"],
      DOCAN_LIB: json["DOCAN_LIB"],
      DOCAN_SEL_IDF: json["DOCAN_SEL_IDF"],
      ENT_CODE: json["ENT_CODE"],
      TYPDOC_CODE: json["TYPDOC_CODE"],
      ROW_ID: json["ROW_ID"],
    );
  }

  static List<DocumentEntrepriseModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<DocumentEntrepriseModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(DocumentEntrepriseModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
