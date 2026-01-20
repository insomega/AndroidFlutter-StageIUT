
class NombreJourMaxModel {
                 final String?      NBJ_MAX_CP; 
                  final String?   NBJ_MAX_RC;
                 final String?    NBJ_MAX_RTT;
                  final String?   NBRE_MAX_RACHAT; 
                 final String?    RC_POSSIBLE; 
       
 
  const NombreJourMaxModel({
    required this.NBJ_MAX_CP,
    required this.NBJ_MAX_RC,
    required this.NBJ_MAX_RTT,
    required this.NBRE_MAX_RACHAT,
    required this.RC_POSSIBLE,
  });

  static NombreJourMaxModel fromJson(Map<String, dynamic> json) {
  
    return NombreJourMaxModel(
      NBJ_MAX_CP: json['NBJ_MAX_CP'],
      NBJ_MAX_RC: json['NBJ_MAX_RC'],
      NBJ_MAX_RTT: json['NBJ_MAX_RTT'],
      NBRE_MAX_RACHAT: json['NBRE_MAX_RACHAT'],
      RC_POSSIBLE: json['SYSDAY_LNGGE'],
     );
  }

  static List<NombreJourMaxModel> convertDynamicToList(List<dynamic> data) {
    List<NombreJourMaxModel> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(NombreJourMaxModel.fromJson(data[i]));
    }
    return list;
  }
}
