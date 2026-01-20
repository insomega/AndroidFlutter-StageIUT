class SalarieFormulaireCuaserieModel {
  final String SVR_IDF;
  final String SVR_CODE;
  final String SVR_LIB;
  final String LIEINSPSVR_IDF;

  const SalarieFormulaireCuaserieModel({
    required this.SVR_IDF,
    required this.SVR_CODE,
    required this.SVR_LIB,
    required this.LIEINSPSVR_IDF,
  });

  static SalarieFormulaireCuaserieModel fromJson(json) {
    return SalarieFormulaireCuaserieModel(
      SVR_CODE: json["SVR_CODE"] as String,
      SVR_IDF: json["SVR_IDF"],
      SVR_LIB: json["SVR_LIB"],
      LIEINSPSVR_IDF: json["LIEINSPSVR_IDF"],
    );
  }

  static List<SalarieFormulaireCuaserieModel>
      convertDynamictoListSalariesFormulaire(List<dynamic> salariesDynamic) {
    List<SalarieFormulaireCuaserieModel> listSalaries = [];
    for (var i = 0; i < salariesDynamic.length; i++) {
      listSalaries
          .add(SalarieFormulaireCuaserieModel.fromJson(salariesDynamic[i]));
    }
    return listSalaries;
  }
}
