// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// import 'package:gbsystem_root/GBSystem_snack_bar.dart';
// import 'package:gbsystem_root/GBSystem_auth_service.dart';
// import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
// import 'package:gbsystem_root/GBSystem_System_Strings.dart';
// import 'package:gbsystem_root/data_server_model.dart';

// class EntrepriseService {
//   final GetStorage _storage = GetStorage();

//   /// Tente de récupérer les infos client. Retourne null si code invalide
//   Future<DataServerModel?> accessUrlAndS19({required String agenceCode}) async {
//     final clientInfo = await GBSystem_AuthService().getSiteS19Client(clientName: agenceCode);

//     // if (clientInfo != null) {
//     //   _saveClientInfo(clientInfo);
//     //   return clientInfo;
//     // } else {
//     //   return null;
//     // }
//   }

//   /// Stocke les infos en local
//   void _saveClientInfo(DataServerModel clientInfo) {
//     final url = clientInfo.SYSMENT_URL;
//     final s19 = clientInfo.SYSMENT_S19;

//     GBSystem_System_Strings.kMyBaseUrlStandard = url;
//     GBSystem_System_Strings.kMyS19Standard = s19 != null ? "$url/BMServerR.dll/BMRest" : "";

//     _storage.write(GBSystem_System_Strings.kS19, s19 ?? "");
//     _storage.write(GBSystem_System_Strings.kSiteWeb, "$url/BMServerR.dll/BMRest");
//     _storage.write(GBSystem_System_Strings.kEntrepriseName, clientInfo.SYSMENT_CODE);
//   }

//   String? getCurrentClientName() => _storage.read<String>(GBSystem_System_Strings.kEntrepriseName);
// }

// class EntrepriseController extends GetxController {
//   final EntrepriseService _service = EntrepriseService();

//   Future<void> validateCode(String agenceCode) async {
//     final clientInfo = await _service.accessUrlAndS19(agenceCode: agenceCode);

//     if (clientInfo != null) {
//       showSuccesDialog(Get.context!, GBSystem_Application_Strings.str_operation_effectuer.tr);
//       // Get.offAllNamed(AppRoutes.login); // ex: redirection
//     } else {
//       showErrorDialog(GBSystem_Application_Strings.str_validat_svp_code_entreprise_invalid.tr);
//     }
//   }
// }
