import 'package:intl/intl.dart';

class SalarieQuickAccessModel {
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String SVR_TELPH1;
  final String SVR_TELPH;
  final String SVR_TELPOR;
  final DateTime? SVR_NAIDATE;
  final String SVR_AGE;
  final String VIL_IDF;
  final String SEX_IDF; 
  final String VIL_CODE;
  final String VIL_LIB;
  final String SEX_CODE;
  final String SEX_LIB;
  final String LIE_IDF;
  final String LIE_CODE;
  final String LIE_LIB;
  final String CLI_IDF;
  
  

  const SalarieQuickAccessModel( {
   required this.VIL_LIB,
   required this.CLI_IDF,
   required this.LIE_CODE,
    required this.SVR_IDF,
    required this.SVR_CODE,
   required this.SVR_LIB,
    required this.SVR_TELPOR,
    required this.VIL_IDF,
    required this.VIL_CODE,
    required this.LIE_IDF,
    required this.LIE_LIB,
    required this.SEX_CODE,
    required this.SEX_IDF,
    required this.SEX_LIB,
     required this.SVR_AGE,
    required this.SVR_NAIDATE,
    required this.SVR_TELPH,
    required this.SVR_TELPH1,  
  });

  static SalarieQuickAccessModel fromJson(json) {

 DateTime? naiDate;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    if (json["SVR_NAIDATE"] != null &&
        json["SVR_NAIDATE"].toString().isNotEmpty) {
      naiDate = originalFormat.parse(json["SVR_NAIDATE"]);
    }
   
    return SalarieQuickAccessModel(
     SVR_CODE: json["SVR_CODE"],
     VIL_CODE: json["VIL_CODE"],
     SVR_TELPOR: json["SVR_TELPOR"],
     SVR_IDF: json["SVR_IDF"],
     VIL_IDF: json["VIL_IDF"],
     SVR_LIB: json["SVR_LIB"],
     CLI_IDF: json["CLI_IDF"],
     LIE_CODE: json["LIE_CODE"],
     VIL_LIB: json["VIL_LIB"],
     LIE_IDF: json["LIE_IDF"],
     LIE_LIB: json["LIE_LIB"],
     SEX_CODE: json["SEX_CODE"],
     SEX_IDF: json["SEX_IDF"],
     SEX_LIB: json["SEX_LIB"],
     SVR_AGE: json["SVR_AGE"],
     SVR_NAIDATE: naiDate,
     SVR_TELPH: json["SVR_TELPH"],
     SVR_TELPH1: json["SVR_TELPH1"],
     

     );  
 }

  static List<SalarieQuickAccessModel> convertDynamictoListSalaries(List<dynamic> salariesDynamic) {
    List<SalarieQuickAccessModel> listSalaries = [];
    for (var i = 0; i < salariesDynamic.length; i++) {
      listSalaries.add(SalarieQuickAccessModel.fromJson(salariesDynamic[i]));
    }
    return listSalaries;
  }

 
}
