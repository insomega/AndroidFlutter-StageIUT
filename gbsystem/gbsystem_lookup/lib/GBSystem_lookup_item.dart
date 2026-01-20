class GBSystem_LookupItem {
  final String id;
  final String code;
  final String label;

  GBSystem_LookupItem({required this.id, required this.code, required this.label});
}


// Exemple modèle spécifique : salarie_item.dart

// dart
// Copier
// Modifier
// import 'lookup_item.dart';

// class SalarieItem extends LookupItem {
//   final String? departement;

//   SalarieItem({
//     required super.id,
//     required super.code,
//     required super.label,
//     this.departement,
//   });
// }