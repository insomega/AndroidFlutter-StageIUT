import 'package:gbsystem_root/GBSystem_Root_DataModel.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'GBSystem_Serveur_Info_Model.dart';

class GBSystem_Serveur_Info_Photo_Model extends GBSystem_Root_DataModel {
  final GBSystem_Serveur_Info_Model Serveur_Info;
  final String? imageSalarie;

  GBSystem_Serveur_Info_Photo_Model({required this.Serveur_Info, required this.imageSalarie});

  factory GBSystem_Serveur_Info_Photo_Model.fromJson(Map<String, dynamic> json) {
    GBSystem_Serveur_Info_Model Serveur_Info = GBSystem_Serveur_Info_Model.fromJson(json);
    return GBSystem_Serveur_Info_Photo_Model(Serveur_Info: Serveur_Info, imageSalarie: null);
  }

  /// 🔁 Crée une copie avec possibilité de remplacer des champs
  GBSystem_Serveur_Info_Photo_Model copyWith({GBSystem_Serveur_Info_Model? Serveur_Info, String? imageSalarie}) {
    return GBSystem_Serveur_Info_Photo_Model(
      Serveur_Info: Serveur_Info ?? this.Serveur_Info, //
      imageSalarie: imageSalarie ?? this.imageSalarie,
    );
  }

  static GBSystem_Serveur_Info_Photo_Model? fromResponse(ResponseModel response) {
    GBSystem_Serveur_Info_Photo_Model? aResponse = response.get_Response_in_Datamodel<GBSystem_Serveur_Info_Photo_Model>(fromJson: (json) => GBSystem_Serveur_Info_Photo_Model.fromJson(json));

    String aimageSalarie = response.getElementFromDataList(elementName: "BinaryData").toString();

    return aResponse?.copyWith(imageSalarie: aimageSalarie);
  }
}
