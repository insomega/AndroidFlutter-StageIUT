import 'package:isar/isar.dart';

part 'GBSystem_LocalData_DataToStore.g.dart';

@collection
class DataToStore {
  Id id = Isar.autoIncrement;

  late String entityName; // ex: "Planning_Vacations"
  late String clientData; // JSON brut (String)
  late String userId; // identifiant utilisateur
  late String dossierId; // identifiant dossier
  late DateTime loadDate;
}
