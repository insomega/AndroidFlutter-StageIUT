
class DocumentModel {

   final String      DOCAN_IDF;
    final String                 DOCAN_CODE;
   final String                  DOCAN_LIB;
            
            
             const DocumentModel({
    required this.DOCAN_CODE,
    required this.DOCAN_IDF,
    required this.DOCAN_LIB,
    });

  
  static DocumentModel fromJson(json) {
    return DocumentModel(
      DOCAN_CODE: json["DOCAN_CODE"],
      DOCAN_IDF: json["DOCAN_IDF"],
      DOCAN_LIB: json["DOCAN_LIB"],
      );
  }

  static List<DocumentModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<DocumentModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(DocumentModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
