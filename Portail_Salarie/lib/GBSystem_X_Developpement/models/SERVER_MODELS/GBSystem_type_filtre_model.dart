
class TypeFiltreModel {
  final String TYPDOC_IDF;
  final String TYPDOC_CODE;
  final String TYPDOC_LIB;
 
  const TypeFiltreModel({
    required this.TYPDOC_CODE,
    required this.TYPDOC_IDF,
    required this.TYPDOC_LIB,
  });

  
  static TypeFiltreModel fromJson(json) {
     return TypeFiltreModel(
      TYPDOC_CODE: json["TYPDOC_CODE"],
      TYPDOC_IDF: json["TYPDOC_IDF"],
      TYPDOC_LIB: json["TYPDOC_LIB"],
        );
  }

  static List<TypeFiltreModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<TypeFiltreModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(TypeFiltreModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
