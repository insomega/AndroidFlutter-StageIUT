class SalarieDataSetGestionStockModel {
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String? SVR_ADR1;
  final String? SVR_TELPH;
  final String? SVR_TAILLE_VESTE;
  final String? SVR_TAILLE_PANTALON;
  final String? SVR_TAILLE_JUPE;
  final String? SVR_POINTURE;

  const SalarieDataSetGestionStockModel({
    required this.SVR_IDF,
    required this.SVR_CODE,
    required this.SVR_LIB,
    required this.SVR_ADR1,
    required this.SVR_POINTURE,
    required this.SVR_TAILLE_JUPE,
    required this.SVR_TAILLE_PANTALON,
    required this.SVR_TAILLE_VESTE,
    required this.SVR_TELPH,
  });

  static SalarieDataSetGestionStockModel fromJson(json) {
    return SalarieDataSetGestionStockModel(
      SVR_CODE: json["SVR_CODE"] as String,
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      SVR_ADR1: json["SVR_ADR1"],
      SVR_POINTURE: json["SVR_POINTURE"],
      SVR_TAILLE_JUPE: json["SVR_TAILLE_JUPE"],
      SVR_TAILLE_PANTALON: json["SVR_TAILLE_PANTALON"],
      SVR_TAILLE_VESTE: json["SVR_TAILLE_VESTE"],
      SVR_TELPH: json["SVR_TELPH"],
    );
  }

  static List<SalarieDataSetGestionStockModel>
      convertDynamictoListSalariesDataSet(List<dynamic> salariesDynamic) {
    List<SalarieDataSetGestionStockModel> listSalaries = [];
    for (var i = 0; i < salariesDynamic.length; i++) {
      listSalaries
          .add(SalarieDataSetGestionStockModel.fromJson(salariesDynamic[i]));
    }
    return listSalaries;
  }
}
