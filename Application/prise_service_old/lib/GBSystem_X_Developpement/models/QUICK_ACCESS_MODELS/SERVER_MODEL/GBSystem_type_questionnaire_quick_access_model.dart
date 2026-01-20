import 'package:intl/intl.dart';

class TypeQuestionnaireModel {
  final String LIEINSQUESTYP_UIDF;
  final String LIEINSQUESTYP_IDF;
  final String LIEINSQUESTYP_CODE;
  final String LIEINSQUESTYP_LIB;
  final DateTime? LAST_UPDT;
  final String? USER_IDF;
  final String? USR_LIB;

  const TypeQuestionnaireModel({
    required this.LIEINSQUESTYP_UIDF, 
    required this.LIEINSQUESTYP_IDF,
    this.USER_IDF,
    required this.LIEINSQUESTYP_CODE,
    required this.LIEINSQUESTYP_LIB,
    required this.LAST_UPDT,
    this.USR_LIB,
  });

  static TypeQuestionnaireModel fromJson(json) {
    DateTime? lastUpdt;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    if (json["LAST_UPDT"] != null && json["LAST_UPDT"].toString().isNotEmpty) {
      lastUpdt = originalFormat.parse(json["LAST_UPDT"]);
    }

    return TypeQuestionnaireModel(
      LIEINSQUESTYP_UIDF: json["LIEINSQUESTYP_UIDF"],
      LAST_UPDT: lastUpdt,
      LIEINSQUESTYP_CODE: json["LIEINSQUESTYP_CODE"],
      LIEINSQUESTYP_IDF: json["LIEINSQUESTYP_IDF"],
      LIEINSQUESTYP_LIB: json["LIEINSQUESTYP_LIB"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
    );
  }

  static List<TypeQuestionnaireModel> convertDynamictoListVacations(
      List<dynamic> vacationsDynamic) {
    List<TypeQuestionnaireModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(TypeQuestionnaireModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
