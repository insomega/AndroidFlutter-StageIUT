class SalarieGestionStockModel {
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String? SVR_TELPH1;
  final String? SVR_TELPH;
  final String? SVR_TELPOR;

  const SalarieGestionStockModel({
    required this.SVR_IDF,
    required this.SVR_CODE,
    required this.SVR_LIB,
    required this.SVR_TELPH,
    required this.SVR_TELPH1,
    required this.SVR_TELPOR,
  });

  static SalarieGestionStockModel fromJson(json) {
    return SalarieGestionStockModel(
      SVR_CODE: json["SVR_CODE"],
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      SVR_TELPH: json["SVR_TELPH"],
      SVR_TELPH1: json["SVR_TELPH1"],
      SVR_TELPOR: json["SVR_TELPOR"],
    );
  }

  static List<SalarieGestionStockModel> convertDynamictoListSalaries(
      List<dynamic> salariesDynamic) {
    List<SalarieGestionStockModel> listSalaries = [];
    for (var i = 0; i < salariesDynamic.length; i++) {
      listSalaries.add(SalarieGestionStockModel.fromJson(salariesDynamic[i]));
    }
    return listSalaries;
  }
}
