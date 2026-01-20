class DataServerModel {
  final String SYSMENT_CODE;
  final String SYSMENT_APPNAME;
  final String SYSMENT_URL;
  final String? SYSMENT_S19;

  const DataServerModel({
    required this.SYSMENT_APPNAME,
    required this.SYSMENT_CODE,
    required this.SYSMENT_S19,
    required this.SYSMENT_URL,
  });

  static DataServerModel fromJson(json) {
    return DataServerModel(
      SYSMENT_APPNAME: json["SYSMENT_APPNAME"],
      SYSMENT_CODE: json["SYSMENT_CODE"],
      SYSMENT_S19: json["SYSMENT_S19"],
      SYSMENT_URL: json["SYSMENT_URL"],
    );
  }

  static List<DataServerModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<DataServerModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(DataServerModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
