import 'package:intl/intl.dart';

class EventAbsenceModel {
  final DateTime? start;
  final DateTime? end;
  final String? id;
  final String? constraint;
  final String? groupId;

  final String? TPH_CODE;
  final DateTime? PLATPH_START_HOUR;
  final DateTime? PLATPH_END_DAY;
  final DateTime? PLATPH_END_HOUR;

  final String? PLATPH_IDF;
  final String? TPH_COLOR;
  final String? backgroundColor;
  final String? borderColor;

  const EventAbsenceModel({
    required this.PLATPH_END_DAY,
    required this.PLATPH_END_HOUR,
    required this.PLATPH_IDF,
    required this.PLATPH_START_HOUR,
    required this.TPH_CODE,
    required this.TPH_COLOR,
    required this.backgroundColor,
    required this.borderColor,
    required this.constraint,
    required this.end,
    required this.groupId,
    required this.id,
    required this.start,
  });

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

  static EventAbsenceModel fromJson(json) {
    DateTime? start, end, PLATPH_START_HOUR, PLATPH_END_DAY, PLATPH_END_HOUR;
    if (json["start"].toString().isNotEmpty) {
      start = DateFormat(detecteDateFormat(json["start"])).parse(json["start"]);
    }
    if (json["end"].toString().isNotEmpty) {
      end = DateFormat(detecteDateFormat(json["end"])).parse(json["end"]);
    }
    if (json["PLATPH_START_HOUR"].toString().isNotEmpty) {
      PLATPH_START_HOUR =
          DateFormat(detecteDateFormat(json["PLATPH_START_HOUR"]))
              .parse(json["PLATPH_START_HOUR"]);
    }
    if (json["PLATPH_END_DAY"].toString().isNotEmpty) {
      PLATPH_END_DAY = DateFormat(detecteDateFormat(json["PLATPH_END_DAY"]))
          .parse(json["PLATPH_END_DAY"]);
    }
    if (json["PLATPH_END_HOUR"].toString().isNotEmpty) {
      PLATPH_END_HOUR = DateFormat(detecteDateFormat(json["PLATPH_END_HOUR"]))
          .parse(json["PLATPH_END_HOUR"]);
    }
    return EventAbsenceModel(
      PLATPH_END_DAY: PLATPH_END_DAY,
      PLATPH_END_HOUR: PLATPH_END_HOUR,
      PLATPH_START_HOUR: PLATPH_START_HOUR,
      PLATPH_IDF: json["PLATPH_IDF"],
      TPH_CODE: json["TPH_CODE"],
      TPH_COLOR: json["TPH_COLOR"],
      backgroundColor: json["backgroundColor"],
      borderColor: json["borderColor"],
      constraint: json["constraint"],
      end: end,
      groupId: json["groupId"],
      start: start,
      id: json["id"],
    );
  }

  static List<EventAbsenceModel> convertDynamictoListEvent(
      List<dynamic> vacationsDynamic) {
    List<EventAbsenceModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(EventAbsenceModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
