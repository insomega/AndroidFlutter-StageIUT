import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'GBSystem_LocalData_DataToStore.dart';

class GBSystem_LocalData_IsarService {
  Isar? _isar;

  /// Ouvre une base spécifique par utilisateur + dossier
  Future<void> open(String userId, String dossierId) async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [DataToStoreSchema],
      directory: dir.path,
      name: '${userId}_$dossierId', // Base unique
    );
  }

  /// Sauvegarde une entité
  Future<void> save(DataToStore data) async {
    if (_isar == null) throw Exception("Isar not opened");
    await _isar!.writeTxn(() async {
      await _isar!.dataToStores.put(data);
    });
  }

  /// Charger une entité par nom
  Future<DataToStore?> getByEntity(String entityName) async {
    if (_isar == null) throw Exception("Isar not opened");
    return await _isar!.dataToStores.filter().entityNameEqualTo(entityName).findFirst();
  }

  /// Supprimer une entité par nom
  Future<void> deleteByEntity(String entityName) async {
    if (_isar == null) throw Exception("Isar not opened");
    await _isar!.writeTxn(() async {
      await _isar!.dataToStores.filter().entityNameEqualTo(entityName).deleteAll();
    });
  }

  /// Récupérer toutes les données
  Future<List<DataToStore>> getAll() async {
    if (_isar == null) throw Exception("Isar not opened");
    return await _isar!.dataToStores.where().findAll();
  }
}


// Génération du code

// Tu te places dans le dossier du package (bmsoft_storage/) et tu exécutes :

// 


// ou en mode watch :

// flutter pub run build_runner watch --delete-conflicting-outputs