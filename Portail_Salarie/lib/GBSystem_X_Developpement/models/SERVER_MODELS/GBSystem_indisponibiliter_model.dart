import 'package:intl/intl.dart';

class IndisponibiliterModel {
  final String    SVRHOR_UIDF;
   final String                  SVRHOR_IDF;
     final String                SYSDAY_IDF;
     final String                SVR_IDF;
     final String                SVRHOR_HEUD; 
     final String                SVRHOR_HEUF; 
     final DateTime?                SVRHOR_DATD; 
     final DateTime?                SVRHOR_DATF; 
     final String                SVRHOR_LIB;
     final DateTime?                LAST_UPDT;
     final String                USER_IDF; 
     final String?                SVRHOR_INDISPO; 
     final String                SYSDAY_NUM; 
     final String                SYSDAY_SHORTDESC;
     final String                SVR_CODE; 
     final String                SVR_LIB; 
     final String?                USR_LIB; 
 
  const IndisponibiliterModel({
    required this.SVRHOR_DATD,
    required this.SVR_CODE,
    required this.SVR_LIB,
    required this.SVRHOR_DATF,
    required this.SVRHOR_HEUD,
    required this.SVRHOR_HEUF,
    required this.SVRHOR_IDF,
    required this.SVRHOR_INDISPO,
    required this.SVRHOR_LIB,
    required this.SVRHOR_UIDF,
    required this.SYSDAY_IDF,
    required this.SVR_IDF,
    required this.SYSDAY_NUM,
    required this.SYSDAY_SHORTDESC,
    required this.USR_LIB,
    required this.LAST_UPDT,
    required this.USER_IDF,
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

  static IndisponibiliterModel fromJson(Map<String, dynamic> json) {
    DateTime? SVRHOR_DATD,SVRHOR_DATF,LAST_UPDT;
    DateFormat dateTimeFormat = DateFormat('dd/MM/yyyy');
    // DateFormat dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
if (json["SVRHOR_DATD"].toString().isNotEmpty) {
      SVRHOR_DATD = dateTimeFormat.parse(json["SVRHOR_DATD"]);
    }
    if (json["SVRHOR_DATF"].toString().isNotEmpty) {
      SVRHOR_DATF = dateTimeFormat.parse(json["SVRHOR_DATF"]);
    }
    if (json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = dateTimeFormat.parse(json["LAST_UPDT"]);
    }
    return IndisponibiliterModel(
      SVRHOR_DATD: SVRHOR_DATD,
      SVR_CODE: json['SVR_CODE'],
      SVR_LIB: json['SVR_LIB'],
      SVRHOR_DATF:SVRHOR_DATF,
      SVRHOR_HEUD: json['SVRHOR_HEUD'],
      SVRHOR_HEUF: json['SVRHOR_HEUF'],
      SVRHOR_IDF: json['SVRHOR_IDF'],
      SVRHOR_INDISPO: json['SVRHOR_INDISPO'],
      SVRHOR_LIB: json['SVRHOR_LIB'],
      SVRHOR_UIDF: json['SVRHOR_UIDF'],
      SYSDAY_IDF: json['SYSDAY_IDF'],
      SVR_IDF: json['SVR_IDF'],
      SYSDAY_NUM: json['SYSDAY_NUM'],
      SYSDAY_SHORTDESC: json['SYSDAY_SHORTDESC'],
      USR_LIB: json['USR_LIB'],
      LAST_UPDT: LAST_UPDT,
      USER_IDF: json['USER_IDF'],
    );
  }

  static List<IndisponibiliterModel> convertDynamicToList(List<dynamic> data) {
    List<IndisponibiliterModel> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(IndisponibiliterModel.fromJson(data[i]));
    }
    return list;
  }
}
