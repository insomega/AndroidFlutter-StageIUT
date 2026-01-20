class GbsystemPlaceModel {
  final double? latitude;
  final double? longitude;
  final String? label;
  final String? type;
  final String? adress;
  final String? postcode;
  final String? city;
  final String? cityCode;
  final String? street;

  const GbsystemPlaceModel({
    required this.adress,
    required this.city,
    required this.cityCode,
    required this.label,
    required this.latitude,
    required this.longitude,
    required this.postcode,
    required this.street,
    required this.type,
  });

  static GbsystemPlaceModel fromJson(json) {
    print("(---------------------)");
    print("name ${json["properties"]["name"]}");
    print("city ${json["properties"]["city"]}");
    print(
        "lat long ${(json["geometry"]["coordinates"] as List)[1]} ${(json["geometry"]["coordinates"] as List)[0]}");
    print("label ${json["properties"]["label"]}");
    print("cityCode ${json["properties"]["citycode"]}");
    print("postCode ${json["properties"]["postcode"]}");
    print("street ${json["properties"]["context"]}");
    print("type ${json["properties"]["type"]}");

    return GbsystemPlaceModel(
      adress: json["properties"]["name"],
      city: json["properties"]["city"],
      label: json["properties"]["label"],
      cityCode: json["properties"]["citycode"],
      latitude: (json["geometry"]["coordinates"] as List)[1],
      longitude: (json["geometry"]["coordinates"] as List)[0],
      postcode: json["properties"]["postcode"],
      street: json["properties"]["context"],
      type: json["properties"]["type"],
    );
  }

  static List<GbsystemPlaceModel> convertDynamictoList(
      List<dynamic> vacationsDynamic) {
    List<GbsystemPlaceModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(GbsystemPlaceModel.fromJson(vacationsDynamic[i]));
    }
    print("lenght ; ${listVacations.length}");
    return listVacations;
  }
}
