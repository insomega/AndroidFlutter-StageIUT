/// Classe de base abstraite pour tous les modèles de données
abstract class GBSystem_Root_DataModel {
  /// Doit être implémentée dans tous les modèles
  static GBSystem_Root_DataModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError("fromJson() doit être implémentée");
  }
}

abstract class GBSystem_Root_DataModel_Lookup extends GBSystem_Root_DataModel {
  String get id;
  String get code;
  String get libelle;

  // @override
  // bool operator ==(Object other) => identical(this, other) || other is LookupModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson();
}
