class GbsystemAppInfoModel {
  final String APP_INFO;

  const GbsystemAppInfoModel({
    required this.APP_INFO,
  });

  static GbsystemAppInfoModel fromJson(json) {
    return GbsystemAppInfoModel(
      APP_INFO: json["APP_INFO"],
    );
  }

  static List<GbsystemAppInfoModel> convertDynamictoList(
      List<dynamic> AppInfosDynamic) {
    List<GbsystemAppInfoModel> listAppInfos = [];
    for (var i = 0; i < AppInfosDynamic.length; i++) {
      listAppInfos.add(GbsystemAppInfoModel.fromJson(AppInfosDynamic[i]));
    }
    return listAppInfos;
  }
}
