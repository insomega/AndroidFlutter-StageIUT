class GbsystemAppInfoDetailsModel {
  final String? version;
  final String? play_store_link;
  final String? app_store_link;
  final String? update_required;

  const GbsystemAppInfoDetailsModel({
    required this.app_store_link,
    required this.play_store_link,
    required this.update_required,
    required this.version,
  });

  static GbsystemAppInfoDetailsModel fromJson(json) {
    return GbsystemAppInfoDetailsModel(
      app_store_link: json["app_store_link"],
      play_store_link: json["play_store_link"],
      update_required: json["update_required"],
      version: json["version"],
    );
  }

  static GbsystemAppInfoDetailsModel? parseStringToData(
      {required String? dataString}) {
    Map<String, String> extractedData = {};
    String? data = dataString;
    if (data != null && data.isNotEmpty) {
      data.split(';').forEach(
        (item) {
          if (item.contains('=')) {
            int separatorIndex = item.indexOf('=');
            String key = item.substring(0, separatorIndex).trim();
            String value = item.substring(separatorIndex + 1).trim();
            extractedData[key] = value;
            // var keyValue = item.split('=');
            // extractedData[keyValue[0].trim()] = keyValue[1].trim();
          }
        },
      );
      String? version = extractedData["version"];
      String? playStoreLink = extractedData["play_store_link"];
      String? appStoreLink = extractedData["app_store_link"];
      String? updateRequired = extractedData["update_required"];

      return GbsystemAppInfoDetailsModel(
          app_store_link: appStoreLink,
          play_store_link: playStoreLink,
          update_required: updateRequired,
          version: version);
    }
    return null;
  }

  static List<GbsystemAppInfoDetailsModel> convertDynamictoList(
      List<dynamic> AppInfosDynamic) {
    List<GbsystemAppInfoDetailsModel> listAppInfos = [];
    for (var i = 0; i < AppInfosDynamic.length; i++) {
      listAppInfos
          .add(GbsystemAppInfoDetailsModel.fromJson(AppInfosDynamic[i]));
    }
    return listAppInfos;
  }
}
