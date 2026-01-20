import 'package:intl/intl.dart';

class SalarieCuaserieModel {
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final DateTime? VAC_START_HOUR;
  final DateTime? VAC_END_HOUR;
  final String ROW_ID;

  const SalarieCuaserieModel({
    required this.SVR_IDF,
    required this.SVR_CODE,
    required this.SVR_LIB,
    required this.ROW_ID,
    required this.VAC_END_HOUR,
    required this.VAC_START_HOUR,
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

  static SalarieCuaserieModel fromJson(json) {
    DateTime? VAC_START_HOUR, VAC_END_HOUR;

    if (json["VAC_START_HOUR"].toString().isNotEmpty) {
      VAC_START_HOUR = DateFormat(detecteDateFormat(json["VAC_START_HOUR"]))
          .parse(json["VAC_START_HOUR"]);
    }
    if (json["VAC_END_HOUR"].toString().isNotEmpty) {
      VAC_END_HOUR = DateFormat(detecteDateFormat(json["VAC_END_HOUR"]))
          .parse(json["VAC_END_HOUR"]);
    }

    return SalarieCuaserieModel(
      SVR_CODE: json["SVR_CODE"] as String,
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      ROW_ID: json["ROW_ID"],
      VAC_END_HOUR: VAC_END_HOUR,
      VAC_START_HOUR: VAC_START_HOUR,
    );
  }

  static List<SalarieCuaserieModel> convertDynamictoListSalariesDataSet(
      List<dynamic> salariesDynamic) {
    List<SalarieCuaserieModel> listSalaries = [];
    for (var i = 0; i < salariesDynamic.length; i++) {
      listSalaries.add(SalarieCuaserieModel.fromJson(salariesDynamic[i]));
    }
    return listSalaries;
  }
}
