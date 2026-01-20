import 'package:get/get.dart';
import 'GBSystem_LocalData_Controller .dart';

//Exemple d’utilisation
Future<void> a_main() async {
  final localController = Get.put(GBSystem_LocalData_Controller());

  await localController.init("user123", "dossier456");

  final data = await localController.loadOrFetch(
    entityName: "Planning_Vacations",
    fetchFromServer: () async {
      // appel API → retourne Map<String, dynamic>
      return {
        "ClientData": {"id": 1, "vacation": "été"},
        "USRLD_IDF": "user123",
        "USRLD_LOAD_DATE": DateTime.now().toIso8601String(),
      };
    },
    userId: "user123",
    dossierId: "dossier456",
  );

  print("Données récupérées: ${data?.clientData}");
}
