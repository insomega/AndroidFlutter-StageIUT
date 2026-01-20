class SiteGestionStockModel {
  final String DOS_CODE;
  final String DOS_LIB;
  final String? DOS_IDF;

  const SiteGestionStockModel({
    required this.DOS_CODE,
    required this.DOS_LIB,
    required this.DOS_IDF,
  });

  static SiteGestionStockModel fromJson(json) {
    return SiteGestionStockModel(
      DOS_CODE: json["DOS_CODE"],
      DOS_IDF: json["DOS_IDF"],
      DOS_LIB: json["DOS_LIB"],
    );
  }

  static List<SiteGestionStockModel> convertDynamictoListSites(
      List<dynamic> sitesDynamic) {
    List<SiteGestionStockModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(SiteGestionStockModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
