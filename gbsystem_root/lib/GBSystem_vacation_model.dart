import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:gbsystem_root/GBSystem_Root_DataModel.dart';

class GBSystem_Vacation_Model extends GBSystem_Root_DataModel {
  final String VAC_IDF;
  final String JOB_LIB;
  final String LIE_ADR;
  String LIE_LIB;
  final String EVT_LIB;
  final String LIE_CODE;
  final String EVT_CODE;
  String? SVR_TELPH;

  String LIE_TLPH;
  TimeOfDay HEURE_DEBUT;
  TimeOfDay HEURE_FIN;
  String VAC_HOUR_CALC;
  final String NOM_NUM_JOUR;
  final String? DAY_COLOR;
  final String TITLE;
  String? VAC_BREAK;
  String VAC_DURATION;
  String LIE_LATITUDE;
  String LIE_LONGITUDE;
  String? LIE_PS_TYPE;
  String SVR_CODE_LIB;
  String? PNTG_START_HOUR;
  String? PNTG_END_HOUR;
  String? PNTGS_IN_NBR;
  String? PNTGS_OUT_NBR;
  DateTime? PNTGS_START_HOUR_IN;
  DateTime? PNTGS_START_HOUR_OUT;
  //
  final DateTime? VAC_START_HOUR;
  final DateTime? VAC_END_HOUR;
  final String? VAC_DURATION_SECONDS;
  //
  final String? TPH_PSA;

  String LIE_IDF;
  String EVT_IDF;
  String JOB_IDF;
  DateTime? VAC_BREAKSTART_HOUR;
  DateTime? VAC_BREAKEND_HOUR;

  String get Safe_VAC_BREAK => VAC_BREAK ?? '';

  /*
  final String PLAPSVR_UIDF;
  final String PLAPSVR_IDF;
  final String SVR_IDF;
  final DateTime? PLAPSVR_DEMANDE_DATE;
  final String PLAPSVR_STATE;
  final DateTime? VAC_PUB_DATE;
  final String VAC_VALID_DATE;
  

  final String DOS_IDF;
  final String LIE_CODE;
  final String EVT_CODE;
  final String EVT_LIB;
  final String JOB_CODE;
  final String ROW_ID;

*/

  GBSystem_Vacation_Model({
    required this.TPH_PSA,
    required this.VAC_IDF,
    required this.VAC_START_HOUR,
    required this.VAC_END_HOUR,
    required this.VAC_DURATION_SECONDS,
    this.DAY_COLOR,
    required this.HEURE_DEBUT,
    required this.HEURE_FIN,
    required this.JOB_LIB,
    required this.LIE_ADR,
    required this.LIE_LATITUDE,
    required this.LIE_LIB,
    required this.EVT_LIB,
    required this.LIE_CODE,
    required this.EVT_CODE,
    required this.SVR_TELPH,
    required this.LIE_LONGITUDE,
    this.LIE_PS_TYPE,
    required this.LIE_TLPH,
    required this.NOM_NUM_JOUR,
    required this.PNTGS_IN_NBR,
    this.PNTGS_OUT_NBR,
    this.PNTGS_START_HOUR_IN,
    this.PNTGS_START_HOUR_OUT,
    this.PNTG_END_HOUR,
    this.PNTG_START_HOUR,
    required this.SVR_CODE_LIB,
    required this.TITLE,
    this.VAC_BREAK,
    required this.VAC_DURATION,
    required this.VAC_HOUR_CALC,
    required this.LIE_IDF,
    required this.EVT_IDF,
    required this.JOB_IDF,
    required this.VAC_BREAKSTART_HOUR,
    required this.VAC_BREAKEND_HOUR,
  });

  @override
  int get hashCode => VAC_IDF.hashCode;

//  compare with lie_idf , to use set()
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GBSystem_Vacation_Model) return false;
    return VAC_IDF == other.VAC_IDF &&
        PNTGS_IN_NBR == other.PNTGS_IN_NBR &&
        PNTGS_OUT_NBR == other.PNTGS_OUT_NBR &&
        PNTGS_START_HOUR_IN == other.PNTGS_START_HOUR_IN &&
        PNTGS_START_HOUR_OUT == other.PNTGS_START_HOUR_OUT &&
        PNTG_END_HOUR == other.PNTG_END_HOUR &&
        PNTG_START_HOUR == other.PNTG_START_HOUR &&
        SVR_CODE_LIB == other.SVR_CODE_LIB &&
        TPH_PSA == other.TPH_PSA &&
        VAC_BREAK == other.VAC_BREAK &&
        VAC_DURATION == other.VAC_DURATION &&
        VAC_HOUR_CALC == other.VAC_HOUR_CALC;
  }

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

  int? get Pointage_In_NBR => PNTGS_IN_NBR != null && PNTGS_IN_NBR!.isNotEmpty ? int.parse(PNTGS_IN_NBR!) : null;
  int? get Pointage_Out_NBR => PNTGS_OUT_NBR != null && PNTGS_OUT_NBR!.isNotEmpty ? int.parse(PNTGS_OUT_NBR!) : null;
  String? get Pointage_In_Time => PNTGS_START_HOUR_IN != null ? Add_zero(PNTGS_START_HOUR_IN?.hour) + ":" + Add_zero(PNTGS_START_HOUR_IN?.minute) : null;
  String? get Pointage_Out_Time => PNTGS_START_HOUR_OUT != null ? Add_zero(PNTGS_START_HOUR_OUT?.hour) + ":" + Add_zero(PNTGS_START_HOUR_OUT?.minute) : null;

  String? Pointage_InOut_Time(String Sens) {
    return Sens == "1" ? Pointage_In_Time : Pointage_Out_Time;
  }

  String get PointageIn {
    String result = "";
    if (PNTGS_START_HOUR_IN != null) {
      result = "${PNTGS_START_HOUR_IN?.hour}:${PNTGS_START_HOUR_IN?.minute}";
    }

    //return PNTGS_START_HOUR_IN != null ? "${PNTGS_START_HOUR_IN?.hour}:${PNTGS_START_HOUR_IN?.minute}" : "";
    return result;
  }

  String get PointageOut {
    return PNTGS_START_HOUR_OUT != null ? "${PNTGS_START_HOUR_OUT?.hour}:${PNTGS_START_HOUR_OUT?.minute}" : "";
  }

  static String detecteDateFormat(String dateString) {
    List<String> formats = ['dd/MM/yyyy HH:mm:ss', 'dd/MM/yyyy', 'dd/MM/yyyy HH:mm:ss.SSS'];
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

  static GBSystem_Vacation_Model fromJson(json) {
    DateTime? PNTGS_START_HOUR_IN, PNTGS_START_HOUR_OUT, VAC_START_HOUR, VAC_END_HOUR, VAC_BREAKSTART_HOUR, VAC_BREAKEND_HOUR;
    String? VAC_BREAK;

    if ((json["PNTGS_START_HOUR_IN"] != null) && (json["PNTGS_START_HOUR_IN"].toString().isNotEmpty)) {
      PNTGS_START_HOUR_IN = DateFormat(detecteDateFormat(json["PNTGS_START_HOUR_IN"])).parse(json["PNTGS_START_HOUR_IN"]);
    }

    if ((json["PNTGS_START_HOUR_OUT"] != null) && (json["PNTGS_START_HOUR_OUT"].toString().isNotEmpty)) {
      PNTGS_START_HOUR_OUT = DateFormat(detecteDateFormat(json["PNTGS_START_HOUR_OUT"])).parse(json["PNTGS_START_HOUR_OUT"]);
    }

    if ((json["VAC_START_HOUR"] != null) && (json["VAC_START_HOUR"].toString().isNotEmpty)) {
      VAC_START_HOUR = DateFormat(detecteDateFormat(json["VAC_START_HOUR"])).parse(json["VAC_START_HOUR"]);
    }

    if ((json["VAC_END_HOUR"] != null) && (json["VAC_END_HOUR"].toString().isNotEmpty)) {
      VAC_END_HOUR = DateFormat(detecteDateFormat(json["VAC_END_HOUR"])).parse(json["VAC_END_HOUR"]);
    }

    if ((json["VAC_BREAKSTART_HOUR"] != null) && (json["VAC_BREAKSTART_HOUR"].toString().isNotEmpty)) {
      VAC_BREAKSTART_HOUR = DateFormat(detecteDateFormat(json["VAC_BREAKSTART_HOUR"])).parse(json["VAC_BREAKSTART_HOUR"]);
    }

    if ((json["VAC_BREAKEND_HOUR"] != null) && (json["VAC_BREAKEND_HOUR"].toString().isNotEmpty)) {
      VAC_BREAKEND_HOUR = DateFormat(detecteDateFormat(json["VAC_BREAKEND_HOUR"])).parse(json["VAC_BREAKEND_HOUR"]);
    }
    if ((json["VAC_BREAK"] != null) && (json["VAC_BREAK"].toString().isNotEmpty)) {
      VAC_BREAK = json["VAC_BREAK"];
    }

    TimeOfDay heureDebut = TimeOfDay.fromDateTime(VAC_START_HOUR as DateTime);
    TimeOfDay heureFin = TimeOfDay.fromDateTime(VAC_END_HOUR as DateTime);

    if ((VAC_BREAKSTART_HOUR != null) & (VAC_BREAKSTART_HOUR != null)) {
      TimeOfDay heureDebut_pause = TimeOfDay.fromDateTime(VAC_BREAKSTART_HOUR as DateTime);
      TimeOfDay heureFin_pause = TimeOfDay.fromDateTime(VAC_BREAKEND_HOUR as DateTime);

      final hour_d = heureDebut_pause.hour.toString().padLeft(2, '0');
      final minute_d = heureDebut_pause.minute.toString().padLeft(2, '0');
      final hour_f = heureFin_pause.hour.toString().padLeft(2, '0');
      final minute_f = heureFin_pause.minute.toString().padLeft(2, '0');

      VAC_BREAK = "$hour_d:$minute_d $hour_f:$minute_f";
    }
    // List<String> splitDebut = json["HEURE_DEBUT"].toString().split(':');
    // int hours = int.parse(splitDebut[0]);
    // int minutes = int.parse(splitDebut[1]);
    // TimeOfDay heureDebut = TimeOfDay(hour: hours, minute: minutes);
    // List<String> splitFin = json["HEURE_FIN"].toString().split(':');
    // int hoursFin = int.parse(splitFin[0]);
    // int minutesFin = int.parse(splitFin[1]);

    // TimeOfDay heureFin = TimeOfDay(hour: hoursFin, minute: minutesFin);

    return GBSystem_Vacation_Model(
      HEURE_DEBUT: heureDebut,
      HEURE_FIN: heureFin,
      VAC_START_HOUR: VAC_START_HOUR,
      VAC_END_HOUR: VAC_END_HOUR,
      VAC_DURATION_SECONDS: json["VAC_DURATION_SECONDS"],
      JOB_LIB: json["JOB_LIB"],
      TPH_PSA: json["TPH_PSA"],
      LIE_ADR: json["LIE_ADR"],
      LIE_LATITUDE: json["LIE_LATITUDE"],
      LIE_LIB: json["LIE_LIB"],
      EVT_LIB: json["EVT_LIB"],
      LIE_CODE: json["LIE_CODE"],
      EVT_CODE: json["EVT_CODE"],
      SVR_TELPH: json["SVR_TELPH"],
      LIE_LONGITUDE: json["LIE_LONGITUDE"],
      LIE_TLPH: json["LIE_TLPH"],
      NOM_NUM_JOUR: json["NOM_NUM_JOUR"],
      PNTGS_IN_NBR: json["PNTGS_IN_NBR"],
      SVR_CODE_LIB: json["SVR_CODE_LIB"],
      TITLE: json["TITLE"],
      VAC_DURATION: json["VAC_DURATION"],
      VAC_HOUR_CALC: json["VAC_HOUR_CALC"],
      VAC_IDF: json["VAC_IDF"],
      DAY_COLOR: json["DAY_COLOR"],
      LIE_PS_TYPE: json["LIE_PS_TYPE"],
      PNTGS_OUT_NBR: json["PNTGS_OUT_NBR"],
      PNTGS_START_HOUR_IN: PNTGS_START_HOUR_IN,
      PNTGS_START_HOUR_OUT: PNTGS_START_HOUR_OUT,
      PNTG_END_HOUR: json["PNTG_END_HOUR"],
      PNTG_START_HOUR: json["PNTG_START_HOUR"],
      VAC_BREAK: VAC_BREAK, //json["VAC_BREAK"],
      LIE_IDF: json["LIE_IDF"],
      EVT_IDF: json["EVT_IDF"],
      JOB_IDF: json["JOB_IDF"],
      VAC_BREAKSTART_HOUR: json["VAC_BREAKSTART_HOUR"],
      VAC_BREAKEND_HOUR: json["VAC_BREAKEND_HOUR"],
    );
  }

  static List<GBSystem_Vacation_Model> convertDynamictoListVacations(List<dynamic> vacationsDynamic) {
    List<GBSystem_Vacation_Model> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(GBSystem_Vacation_Model.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }

  static GBSystem_Vacation_Model? fromResponse(ResponseModel response) {
    return response.get_Response_in_Datamodel<GBSystem_Vacation_Model>(elementName: 'Planning_Vacations', fromJson: (json) => GBSystem_Vacation_Model.fromJson(json));
  }

  static GBSystem_Vacation_Model? fromResponse_Data(ResponseModel response) {
    return response.get_Response_in_Datamodel<GBSystem_Vacation_Model>(fromJson: (json) => GBSystem_Vacation_Model.fromJson(json));
  }

  static List<GBSystem_Vacation_Model>? fromResponse_List(ResponseModel response) {
    return response.get_Response_in_Datamodel_List<GBSystem_Vacation_Model, List<GBSystem_Vacation_Model>>(elementName: 'Planning_Vacations', fromJson: (json) => GBSystem_Vacation_Model.fromJson(json));
  }

  void updateFrom(GBSystem_Vacation_Model other) {
    PNTGS_START_HOUR_IN = other.PNTGS_START_HOUR_IN;
    PNTGS_START_HOUR_OUT = other.PNTGS_START_HOUR_OUT;
    PNTG_START_HOUR = other.PNTG_START_HOUR;
    PNTG_END_HOUR = other.PNTG_END_HOUR;
    PNTGS_IN_NBR = other.PNTGS_IN_NBR;
    PNTGS_OUT_NBR = other.PNTGS_OUT_NBR;
    VAC_BREAK = other.VAC_BREAK;
    VAC_DURATION = other.VAC_DURATION;
    VAC_HOUR_CALC = other.VAC_HOUR_CALC;
    SVR_CODE_LIB = other.SVR_CODE_LIB;
    LIE_IDF = other.LIE_IDF;
    EVT_IDF = other.EVT_IDF;
    JOB_IDF = other.JOB_IDF;
    VAC_BREAKSTART_HOUR = other.VAC_BREAKSTART_HOUR;
    VAC_BREAKEND_HOUR = other.VAC_BREAKEND_HOUR;
    LIE_LATITUDE = other.LIE_LATITUDE;
    LIE_LONGITUDE = other.LIE_LONGITUDE;
    LIE_PS_TYPE = other.LIE_PS_TYPE;
    SVR_TELPH = other.SVR_TELPH;
    HEURE_DEBUT = other.HEURE_DEBUT;
    HEURE_FIN = other.HEURE_FIN;
    LIE_TLPH = other.LIE_TLPH;
    LIE_LIB = other.LIE_LIB;
  }
}
