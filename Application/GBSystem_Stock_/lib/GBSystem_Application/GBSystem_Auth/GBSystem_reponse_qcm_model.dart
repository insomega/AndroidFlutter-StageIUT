import 'package:intl/intl.dart';

class ReponseQCMModel {
  final String LIEINSPSVRQUQCMRESP_UIDF;
  final String LIEINSPSVRQUQCMRESP_IDF;
  final String LIEINSPQCM_CODE;
  final String LIEINSPQCM_LIB;
  final String LIEINSPQCMRES_ORDER_NUM;
  final String LIEINSPQCMRES_VALUE;
  final String LIEINSPSVRQU_IDF;
  final String SELECTION_STATE;
  final String USER_IDF;
  final DateTime? LAST_UPDT;

  const ReponseQCMModel({
    required this.LAST_UPDT,
    required this.LIEINSPQCMRES_ORDER_NUM,
    required this.LIEINSPQCMRES_VALUE,
    required this.LIEINSPQCM_CODE,
    required this.LIEINSPQCM_LIB,
    required this.LIEINSPSVRQUQCMRESP_IDF,
    required this.LIEINSPSVRQUQCMRESP_UIDF,
    required this.LIEINSPSVRQU_IDF,
    required this.SELECTION_STATE,
    required this.USER_IDF,
  });

  static ReponseQCMModel fromJson(json) {
    DateTime? LAST_UPDT;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    if (json["LAST_UPDT"] != null && json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = originalFormat.parse(json["LAST_UPDT"]);
    }

    return ReponseQCMModel(
      LIEINSPQCMRES_ORDER_NUM: json["LIEINSPQCMRES_ORDER_NUM"],
      LIEINSPQCMRES_VALUE: json["LIEINSPQCMRES_VALUE"],
      LIEINSPQCM_CODE: json["LIEINSPQCM_CODE"],
      LIEINSPQCM_LIB: json["LIEINSPQCM_LIB"],
      LIEINSPSVRQUQCMRESP_IDF: json["LIEINSPSVRQUQCMRESP_IDF"],
      LIEINSPSVRQUQCMRESP_UIDF: json["LIEINSPSVRQUQCMRESP_UIDF"],
      LIEINSPSVRQU_IDF: json["LIEINSPSVRQU_IDF"],
      SELECTION_STATE: json["SELECTION_STATE"],
      USER_IDF: json["USER_IDF"],
      LAST_UPDT: LAST_UPDT,
    );
  }

  static List<ReponseQCMModel> convertDynamictoListReponseQCM(
      List<dynamic> reponseDynamic) {
    List<ReponseQCMModel> listReponse = [];
    for (var i = 0; i < reponseDynamic.length; i++) {
      listReponse.add(ReponseQCMModel.fromJson(reponseDynamic[i]));
    }
    return listReponse;
  }
}
