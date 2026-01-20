class SalariePlanningModel {
  final String SVR_IDF;
  final String SVR_CODE;
  final String? SVR_LIB;
  final String SVR_TELPOR;
  final String VIL_IDF;
  final String VIL_CODE;
  final String VIL_LIB;
  final String SVR_NOM;
  final String SVR_PRNOM;
  
  

  const SalariePlanningModel( {
   required this.VIL_LIB,required this.SVR_NOM,required this.SVR_PRNOM,
    required this.SVR_IDF,
    required this.SVR_CODE,
    this.SVR_LIB,
    required this.SVR_TELPOR,
    required this.VIL_IDF,
    required this.VIL_CODE,
  });

  static SalariePlanningModel fromJson(json) {

    return SalariePlanningModel(
     SVR_CODE: json["SVR_CODE"],
     VIL_CODE: json["VIL_CODE"],
     SVR_TELPOR: json["SVR_TELPOR"],
     SVR_IDF: json["SVR_IDF"],
     VIL_IDF: json["VIL_IDF"],
     SVR_LIB: json["SVR_LIB"],
     SVR_NOM: json["SVR_NOM"],
     SVR_PRNOM: json["SVR_PRNOM"],
     VIL_LIB: json["VIL_LIB"]
     );  
 }

  static List<SalariePlanningModel> convertDynamictoListSalaries(List<dynamic> salariesDynamic) {
    List<SalariePlanningModel> listSalaries = [];
    for (var i = 0; i < salariesDynamic.length; i++) {
      listSalaries.add(SalariePlanningModel.fromJson(salariesDynamic[i]));
    }
    return listSalaries;
  }

 
}
