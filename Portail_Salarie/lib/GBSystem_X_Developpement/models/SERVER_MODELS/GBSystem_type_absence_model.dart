class TypeAbsenceModel {
  final String TPH_IDF;
  final String TPH_CODE;
  final String TPH_LIB;
  final String CLR_CODE;
  final String? TPH_WEB_ORDRE;
  final String? TPH_WEB_HOUR;
  final String? TPH_WEB_ATTACH;
  final String TPH_CTRL_SHIFT;
  final String? TPH_WEB_MMO;
  final String? PTPH_IDF;
  final String? TPH_GRP;
  final String? TPH_WEB_RC;
  final String? TPH_WEB_CP;
  final String ROW_ID;
  final String CLR_CODE_colorweb;

  TypeAbsenceModel({
    required this.TPH_IDF,
    required this.TPH_CODE,
    required this.TPH_LIB,
    required this.CLR_CODE,
    required this.TPH_WEB_ORDRE,
    required this.TPH_WEB_HOUR,
    required this.TPH_WEB_ATTACH,
    required this.TPH_CTRL_SHIFT,
    required this.TPH_WEB_MMO,
    required this.PTPH_IDF,
    required this.TPH_GRP,
    required this.TPH_WEB_RC,
    required this.TPH_WEB_CP,
    required this.ROW_ID,
    required this.CLR_CODE_colorweb,
  });

  static TypeAbsenceModel fromJson(Map<String, dynamic> json) {
    return TypeAbsenceModel(
      TPH_IDF: json['TPH_IDF'],
      TPH_CODE: json['TPH_CODE'],
      TPH_LIB: json['TPH_LIB'],
      CLR_CODE: json['CLR_CODE'],
      TPH_WEB_ORDRE: json['TPH_WEB_ORDRE'],
      TPH_WEB_HOUR: json['TPH_WEB_HOUR'],
      TPH_WEB_ATTACH: json['TPH_WEB_ATTACH'],
      TPH_CTRL_SHIFT: json['TPH_CTRL_SHIFT'],
      TPH_WEB_MMO: json['TPH_WEB_MMO'],
      PTPH_IDF: json['PTPH_IDF'],
      TPH_GRP: json['TPH_GRP'],
      TPH_WEB_RC: json['TPH_WEB_RC'],
      TPH_WEB_CP: json['TPH_WEB_CP'],
      ROW_ID: json['ROW_ID'],
      CLR_CODE_colorweb: json['CLR_CODE_colorweb'],
    );
  }

  static List<TypeAbsenceModel> convertDynamicToList(List<dynamic> data) {
    List<TypeAbsenceModel> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(TypeAbsenceModel.fromJson(data[i]));
    }
    return list;
  }
}
