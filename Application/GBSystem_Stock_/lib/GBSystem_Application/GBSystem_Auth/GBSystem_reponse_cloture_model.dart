import 'package:intl/intl.dart';

class GbsystemReponseClotureModel {
  final DateTime? LIEINSPSVR_END_DATE;

  final String LIEINSPSVR_IDF;

  const GbsystemReponseClotureModel({
    required this.LIEINSPSVR_END_DATE,
    required this.LIEINSPSVR_IDF,
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

  static GbsystemReponseClotureModel fromJson(json) {
    DateTime? LIEINSPSVR_END_DATE;

    if (json["LIEINSPSVR_END_DATE"].toString().isNotEmpty) {
      LIEINSPSVR_END_DATE =
          DateFormat(detecteDateFormat(json["LIEINSPSVR_END_DATE"]))
              .parse(json["LIEINSPSVR_END_DATE"]);
    }

    return GbsystemReponseClotureModel(
      LIEINSPSVR_END_DATE: LIEINSPSVR_END_DATE,
      LIEINSPSVR_IDF: json["LIEINSPSVR_IDF"],
    );
  }

  static List<GbsystemReponseClotureModel> convertDynamictoListClotures(
      List<dynamic> vacationsDynamic) {
    List<GbsystemReponseClotureModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations
          .add(GbsystemReponseClotureModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
