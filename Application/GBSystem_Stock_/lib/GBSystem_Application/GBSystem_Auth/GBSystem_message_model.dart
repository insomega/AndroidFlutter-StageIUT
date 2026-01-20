import 'package:intl/intl.dart';

class MessageModel {
  final String SYSUM_IDF;
  final String SEND_SVR_IDF;
  final String? SEND_USR_IDF;
  final String? RECEIV_SVR_IDF;
  final String? RECEIV_USR_IDF;
  final String RECEIV_DOS_IDF;
  final String SYSUM_MESSAGE;
  final DateTime SYSUM_SEND_DATE;
  final DateTime? SYSUM_READ_DATE;
  final String SYSUM_MSG_TYPE;
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String? CHATGRP_IDF;
  final String? EVT_IDF;
  final String? USR_IDF;
  final String? USR_CODE;
  final String? USR_LIB;
  final String? PSYSUM_IDF;
  final String? PSYSUM_MESSAGE;
  final String? MSG_DESCP;
  final String? ROW_ID;

  MessageModel({
    required this.SYSUM_IDF,
    required this.SEND_SVR_IDF,
    required this.SEND_USR_IDF,
    required this.RECEIV_SVR_IDF,
    required this.RECEIV_USR_IDF,
    required this.RECEIV_DOS_IDF,
    required this.SYSUM_MESSAGE,
    required this.SYSUM_SEND_DATE,
    required this.SYSUM_READ_DATE,
    required this.SYSUM_MSG_TYPE,
    required this.SVR_IDF,
    required this.SVR_CODE,
    required this.SVR_LIB,
    required this.CHATGRP_IDF,
    required this.EVT_IDF,
    required this.USR_IDF,
    required this.USR_CODE,
    required this.USR_LIB,
    required this.PSYSUM_IDF,
    required this.PSYSUM_MESSAGE,
    required this.MSG_DESCP,
    required this.ROW_ID,
  });

  // static DateTime parseDate(String dateString) {
  //   return DateFormat('dd/MM/yyyy HH:mm:ss').parse(dateString);
  // }
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

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    DateTime? SYSUM_SEND_DATE, SYSUM_READ_DATE;
    if (json["SYSUM_SEND_DATE"].toString().isNotEmpty) {
      SYSUM_SEND_DATE = DateFormat(detecteDateFormat(json["SYSUM_SEND_DATE"]))
          .parse(json["SYSUM_SEND_DATE"]);
    }
    if (json["SYSUM_READ_DATE"].toString().isNotEmpty) {
      SYSUM_READ_DATE = DateFormat(detecteDateFormat(json["SYSUM_READ_DATE"]))
          .parse(json["SYSUM_READ_DATE"]);
    }
    return MessageModel(
      SYSUM_IDF: json['SYSUM_IDF'],
      SEND_SVR_IDF: json['SEND_SVR_IDF'],
      SEND_USR_IDF: json['SEND_USR_IDF'],
      RECEIV_SVR_IDF: json['RECEIV_SVR_IDF'],
      RECEIV_USR_IDF: json['RECEIV_USR_IDF'],
      RECEIV_DOS_IDF: json['RECEIV_DOS_IDF'],
      SYSUM_MESSAGE: json['SYSUM_MESSAGE'],
      SYSUM_SEND_DATE: SYSUM_SEND_DATE!,
      SYSUM_READ_DATE: SYSUM_READ_DATE,
      SYSUM_MSG_TYPE: json['SYSUM_MSG_TYPE'],
      SVR_IDF: json['SVR_IDF'],
      SVR_CODE: json['SVR_CODE'],
      SVR_LIB: json['SVR_LIB'],
      CHATGRP_IDF: json['CHATGRP_IDF'],
      EVT_IDF: json['EVT_IDF'],
      USR_IDF: json['USR_IDF'],
      USR_CODE: json['USR_CODE'],
      USR_LIB: json['USR_LIB'],
      PSYSUM_IDF: json['PSYSUM_IDF'],
      PSYSUM_MESSAGE: json['PSYSUM_MESSAGE'],
      MSG_DESCP: json['MSG_DESCP'],
      ROW_ID: json['ROW_ID'],
    );
  }

  static List<MessageModel> convertDynamictoListMessages(
      List<dynamic> vacationsDynamic) {
    List<MessageModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(MessageModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }

  static List<MessageModel> convertDynamictoListMessagesInverse(
      List<dynamic> vacationsDynamic) {
    List<MessageModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(MessageModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
