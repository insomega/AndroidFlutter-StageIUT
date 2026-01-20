import 'package:intl/intl.dart';

class EventModel {
  final DateTime? start;
  final DateTime? end;
  final String? id;
  final String? constraint;
  final String? groupId;
  final String? LIE_ADR1;
  final DateTime? VAC_START_HOUR;
  final DateTime? VAC_END_HOUR;
  final String? LIE_ADR2;
  final String? VAC_IDF;
  final String? VIL_LIB;
  final String? VAC_COLOR;
  final String? JOB_CODE;
  final String? LIE_LIB;
  final String? VIL_CODE;
  final String? LIE_ADR3;
  final DateTime? END_HOUR;
  final DateTime? START_HOUR;
  final String? backgroundColor;
  final String? borderColor;
  final String? autre_agence;

  const EventModel({
    required this.VAC_IDF,
    required this.END_HOUR,
    required this.LIE_ADR1,
    required this.JOB_CODE,
    required this.LIE_ADR2,
    required this.LIE_ADR3,
    required this.START_HOUR,
    required this.LIE_LIB,
    required this.VAC_COLOR,
    required this.VAC_END_HOUR,
    required this.VAC_START_HOUR,
    required this.VIL_CODE,
    required this.VIL_LIB,
    required this.backgroundColor,
    required this.borderColor,
    required this.constraint,
    required this.end,
    required this.groupId,
    required this.id,
    required this.start,
    required this.autre_agence,
  });

  static EventModel fromJson(json) {
    DateTime? start, end, VAC_START_HOUR, VAC_END_HOUR, END_HOUR, START_HOUR;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    DateFormat originalFormat2 = DateFormat('dd/MM/yyyy');

    if (json["start"].toString().isNotEmpty) {
      start = originalFormat2.parse(json["start"]);
    }
    if (json["end"].toString().isNotEmpty) {
      end = originalFormat2.parse(json["end"]);
    }
    if (json["VAC_START_HOUR"] != null &&
        json["VAC_START_HOUR"].toString().isNotEmpty) {
      VAC_START_HOUR = originalFormat.parse(json["VAC_START_HOUR"]);
    }
    if (json["VAC_END_HOUR"] != null &&
        json["VAC_END_HOUR"].toString().isNotEmpty) {
      VAC_END_HOUR = originalFormat.parse(json["VAC_END_HOUR"]);
    }
    if (json["END_HOUR"] != null && json["END_HOUR"].toString().isNotEmpty) {
      END_HOUR = originalFormat.parse(json["END_HOUR"]);
    }
    if (json["START_HOUR"] != null &&
        json["START_HOUR"].toString().isNotEmpty) {
      START_HOUR = originalFormat2.parse(json["START_HOUR"]);
    }

    return EventModel(
      END_HOUR: END_HOUR,
      START_HOUR: START_HOUR,
      JOB_CODE: json["JOB_CODE"],
      LIE_ADR1: json["LIE_ADR1"],
      LIE_ADR2: json["LIE_ADR2"],
      LIE_LIB: json["LIE_LIB"],
      LIE_ADR3: json["LIE_ADR3"],
      VAC_COLOR: json["VAC_COLOR"],
      VAC_END_HOUR: VAC_END_HOUR,
      VAC_START_HOUR: VAC_START_HOUR,
      VIL_CODE: json["VIL_CODE"],
      VIL_LIB: json["VIL_LIB"],
      backgroundColor: json["backgroundColor"],
      borderColor: json["borderColor"],
      VAC_IDF: json["VAC_IDF"],
      constraint: json["constraint"],
      end: end,
      groupId: json["groupId"],
      start: start,
      id: json["id"],
      autre_agence: json["autre_agence"],
    );
  }

  static List<EventModel> convertDynamictoListEvent(
      List<dynamic> vacationsDynamic) {
    List<EventModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(EventModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
