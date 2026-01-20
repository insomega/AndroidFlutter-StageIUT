class SiteQuickAccesModel {
  final String LIE_IDF;
  final String CLI_IDF;
  final String? PLIE_IDF;
  final String LIE_CODE;
  final String? DOS_IDF;
  final String LIE_LIB;

  const SiteQuickAccesModel({
    required this.LIE_IDF,
    required this.LIE_CODE,
    required this.LIE_LIB,
    required this.CLI_IDF,
    required this.DOS_IDF,
    this.PLIE_IDF,
  });

  static SiteQuickAccesModel fromJson(json) {
    return SiteQuickAccesModel(
      CLI_IDF: json["CLI_IDF"],
      DOS_IDF: json["DOS_IDF"],
      LIE_CODE: json["LIE_CODE"],
      LIE_IDF: json["LIE_IDF"],
      LIE_LIB: json["LIE_LIB"],
      PLIE_IDF: json["PLIE_IDF"],
    );
  }

  static List<SiteQuickAccesModel> convertDynamictoListSites(
      List<dynamic> sitesDynamic) {
    List<SiteQuickAccesModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(SiteQuickAccesModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
