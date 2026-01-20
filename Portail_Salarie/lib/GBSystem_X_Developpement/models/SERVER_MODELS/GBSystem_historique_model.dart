import 'package:intl/intl.dart';

class HistoriqueModel {
  final String SVRHIST_TYP;
  final String? PLATPH_ETAT;
  final DateTime? PUB_DATE;
  final DateTime? DATE_VU;
  final String? TPH_TYPE;
  final DateTime? LAST_UPDT;
  final DateTime? SVRHIST_ACTION_D;
  final DateTime? SVRHIST_ACTION_F;
  final DateTime? SVRHIST_DATE;
  const HistoriqueModel({
    required this.DATE_VU,
    required this.LAST_UPDT,
    required this.PLATPH_ETAT,
    required this.PUB_DATE,
    required this.SVRHIST_ACTION_D,
    required this.SVRHIST_ACTION_F,
    required this.SVRHIST_DATE,
    required this.SVRHIST_TYP,
    required this.TPH_TYPE,
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

  static HistoriqueModel fromJson(json) {
    DateTime? PUB_DATE,
        DATE_VU,
        LAST_UPDT,
        SVRHIST_ACTION_D,
        SVRHIST_ACTION_F,
        SVRHIST_DATE;
    DateFormat originalFormat2 = DateFormat('dd/MM/yyyy');

    if (json["PUB_DATE"].toString().isNotEmpty) {
      PUB_DATE = DateFormat(detecteDateFormat(json["PUB_DATE"]))
          .parse(json["PUB_DATE"]);

      // PUB_DATE = originalFormat.parse(json["PUB_DATE"]);
    }
    if (json["DATE_VU"].toString().isNotEmpty) {
      DATE_VU = originalFormat2.parse(json["DATE_VU"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = originalFormat2.parse(json["LAST_UPDT"]);
    }
    if (json["SVRHIST_ACTION_D"].toString().isNotEmpty) {
      SVRHIST_ACTION_D = originalFormat2.parse(json["SVRHIST_ACTION_D"]);
    }
    if (json["SVRHIST_ACTION_F"].toString().isNotEmpty) {
      SVRHIST_ACTION_F = originalFormat2.parse(json["SVRHIST_ACTION_F"]);
    }

    if (json["SVRHIST_DATE"].toString().isNotEmpty) {
      SVRHIST_DATE = DateFormat(detecteDateFormat(json["SVRHIST_DATE"]))
          .parse(json["SVRHIST_DATE"]);

      // SVRHIST_DATE = originalFormat.parse(json["SVRHIST_DATE"]);
    }

    return HistoriqueModel(
      DATE_VU: DATE_VU,
      LAST_UPDT: LAST_UPDT,
      PUB_DATE: PUB_DATE,
      SVRHIST_ACTION_D: SVRHIST_ACTION_D,
      SVRHIST_ACTION_F: SVRHIST_ACTION_F,
      SVRHIST_DATE: SVRHIST_DATE,
      PLATPH_ETAT: json["PLATPH_ETAT"],
      SVRHIST_TYP: json["SVRHIST_TYP"],
      TPH_TYPE: json["TPH_TYPE"],
    );
  }

  static List<HistoriqueModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<HistoriqueModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(HistoriqueModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
