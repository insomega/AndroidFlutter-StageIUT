import 'package:get/get.dart';
import 'GBSystem_LocalData_Isar.dart';
import 'GBSystem_LocalData_DataToStore.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';

class GBSystem_LocalData_Controller extends GBSystem_Root_Controller {
  final GBSystem_LocalData_IsarService _IsarService = GBSystem_LocalData_IsarService();
  final RxList<DataToStore> localData = <DataToStore>[].obs;

  Future<void> init(String userId, String dossierId) async {
    await _IsarService.open(userId, dossierId);
    localData.value = await _IsarService.getAll();
  }

  /// Charger local ou sinon serveur
  Future<DataToStore?> loadOrFetch({required String entityName, required Future<Map<String, dynamic>> Function() fetchFromServer, required String userId, required String dossierId}) async {
    // 1. Essayer local
    var local = await _IsarService.getByEntity(entityName);
    if (local != null) return local;

    // 2. Sinon aller serveur
    final serverData = await fetchFromServer();

    final newData = DataToStore()
      ..entityName = entityName
      ..clientData = serverData
          .toString() // ici tu peux encoder en JSON
      ..userId = userId
      ..dossierId = dossierId
      ..loadDate = DateTime.now();

    await _IsarService.save(newData);
    localData.add(newData);

    return newData;
  }

  /// Supprimer
  Future<void> deleteEntity(String entityName) async {
    await _IsarService.deleteByEntity(entityName);
    localData.removeWhere((d) => d.entityName == entityName);
  }
}
