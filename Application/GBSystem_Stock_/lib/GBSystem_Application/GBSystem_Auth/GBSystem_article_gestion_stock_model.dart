class GbsystemArticleGestionStockModel {
  final String? ARTREF_IDF;
  final String ARTREF_CODE; //
  final String ARTREF_LIB; //
  final String FOU_LIB; //
  final String ARTCAT_IDF; //
  final String TPOI_CODE; //
  final String? TPOI_LIB; //new
  final String ARTCAT_LIB; //
  final String ARTFOUREF_IDF; //
  final String ARTFOUREF_PRIX; //
  final String ART_QTE_STOCK; //
  final String ENTR_IDF; //
  final String ENTR_CODE; //
  final String ENTR_LIB; //
  final String CLR_LIB;
  final String CLR_CODE;
  final String? CLR_CODE_colorweb; // new

  const GbsystemArticleGestionStockModel({
    required this.ARTCAT_IDF,
    required this.ARTCAT_LIB,
    required this.ARTFOUREF_IDF,
    required this.ARTFOUREF_PRIX,
    required this.ARTREF_CODE,
    required this.ARTREF_IDF,
    required this.ARTREF_LIB,
    required this.ART_QTE_STOCK,
    required this.CLR_CODE,
    required this.CLR_LIB,
    required this.ENTR_CODE,
    required this.ENTR_IDF,
    required this.ENTR_LIB,
    required this.FOU_LIB,
    required this.TPOI_CODE,
    this.TPOI_LIB,
    this.CLR_CODE_colorweb,
  });

  static GbsystemArticleGestionStockModel fromJson(json) {
    return GbsystemArticleGestionStockModel(
      ARTCAT_IDF: json["ARTCAT_IDF"],
      ARTCAT_LIB: json["ARTCAT_LIB"],
      ARTFOUREF_IDF: json["ARTFOUREF_IDF"],
      ARTFOUREF_PRIX: json["ARTFOUREF_PRIX"],
      ARTREF_CODE: json["ARTREF_CODE"],
      ARTREF_IDF: json["ARTREF_IDF"],
      ARTREF_LIB: json["ARTREF_LIB"],
      ART_QTE_STOCK: json["ART_QTE_STOCK"],
      CLR_CODE: json["CLR_CODE"],
      CLR_LIB: json["CLR_LIB"],
      ENTR_CODE: json["ENTR_CODE"],
      ENTR_IDF: json["ENTR_IDF"],
      ENTR_LIB: json["ENTR_LIB"],
      FOU_LIB: json["FOU_LIB"],
      TPOI_CODE: json["TPOI_CODE"],
      CLR_CODE_colorweb: json["CLR_CODE_colorweb"],
      TPOI_LIB: json["TPOI_LIB"],
    );
  }

  static List<GbsystemArticleGestionStockModel> convertDynamictoListArticles(
      List<dynamic> sitesDynamic) {
    List<GbsystemArticleGestionStockModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(GbsystemArticleGestionStockModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
