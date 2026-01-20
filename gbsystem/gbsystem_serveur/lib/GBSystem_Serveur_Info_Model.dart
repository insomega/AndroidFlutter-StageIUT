class GBSystem_Serveur_Info_Model {
  final String SVR_IDF;
  final String SVR_NOM;
  final String SVR_PRNOM;
  final String SVR_ADR1;
  final String SVR_TELPOR;
  final String SVR_EMAIL;
  final String SVR_LATITUDE;
  final String SVR_LONGITUDE;
  final String? SVR_TELPH;
  final String SVR_ADR2;
  final String VIL_IDF;
  final String VIL_CODE;
  final String VIL_LIB;
  final String CLIENT_ID;

  const GBSystem_Serveur_Info_Model({
    required this.VIL_LIB,
    required this.SVR_NOM,
    required this.SVR_PRNOM,
    required this.SVR_IDF,
    required this.CLIENT_ID,
    required this.SVR_ADR1,
    required this.SVR_TELPOR,
    required this.VIL_IDF,
    required this.VIL_CODE,
    required this.SVR_ADR2,
    required this.SVR_EMAIL,
    required this.SVR_LATITUDE,
    required this.SVR_LONGITUDE,
    required this.SVR_TELPH,
  });

  static GBSystem_Serveur_Info_Model fromJson(json) {
    return GBSystem_Serveur_Info_Model(
      CLIENT_ID: json["CLIENT_ID"],
      VIL_CODE: json["VIL_CODE"],
      SVR_TELPOR: json["SVR_TELPOR"],
      SVR_IDF: json["SVR_IDF"],
      VIL_IDF: json["VIL_IDF"],
      SVR_ADR1: json["SVR_ADR1"],
      SVR_NOM: json["SVR_NOM"],
      SVR_PRNOM: json["SVR_PRNOM"],
      VIL_LIB: json["VIL_LIB"],
      SVR_ADR2: json["SVR_ADR2"],
      SVR_EMAIL: json["SVR_EMAIL"],
      SVR_LATITUDE: json["SVR_LATITUDE"],
      SVR_LONGITUDE: json["SVR_LONGITUDE"],
      SVR_TELPH: json["SVR_TELPH"],
    );
  }

  static List<GBSystem_Serveur_Info_Model> convertDynamictoListSalaries(List<dynamic> salariesDynamic) {
    List<GBSystem_Serveur_Info_Model> listSalaries = [];
    for (var i = 0; i < salariesDynamic.length; i++) {
      listSalaries.add(GBSystem_Serveur_Info_Model.fromJson(salariesDynamic[i]));
    }
    return listSalaries;
  }
}
