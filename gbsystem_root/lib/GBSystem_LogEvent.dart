import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gbsystem_root/GBSystem_Package_Info_Service.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:gbsystem_root/api.dart';

void GBSystem_Add_LogEvent({required String page, required String method, required String message}) {
  GBSystem_LogEvent().logEvent(message: message, method: method, page: page);
}

class GBSystem_LogEvent {
  // static void GBSystem_Add_LogEvent({required String page, required String method, required String message}) {
  //   GBSystem_LogEvent().logEvent(message: message, method: method, page: page);
  // }

  Future<void> logEvent({required String page, required String method, required String message}) async {
    await GBSystem_LogEvent_ToServer(page: page, functionName: method, msg: message);
    return;
  }

  Future<bool> GBSystem_LogEvent_ToServer({required String page, required String functionName, required String msg}) async {
    String appVersion = await PackageInfoService().getAppVersion();
    String appVersionCode = await PackageInfoService().getAppVersionCode();
    String androidVersion = await PackageInfoService().getAndroidVersion();
    ResponseModel responseServer = await Api().post(
      data: {
        "OKey": "39A5552F5E2B49F8959D3CA7468D2D67", //
        "sender": page,
        "functionName": "$functionName :  appVersion:$appVersionCode($appVersion)|$androidVersion)",
        "msg": msg,
        "LOG_SERVER": "1",
      },
    );
    if (responseServer.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

//   void _handleError(Object error, StackTrace? stack) {
//     String errorMsg = error.toString().toLowerCase();

//     // Liste de mots-clés souvent présents dans les erreurs de permission
//     List<String> permissionKeywords = ["permission", "securityexception", "denied", "missing", "requires permission"];

//     bool isPermissionError = permissionKeywords.any((kw) => errorMsg.contains(kw));

//     if (isPermissionError) {
//       print("⚠️ Problème de permission détecté !");
//       // Ici tu peux afficher un dialog ou snackbar global
//       // Exemple :
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         showDialog(
//           context: navigatorKey.currentContext!,
//           builder: (_) => AlertDialog(
//             title: const Text("Permission manquante"),
//             content: const Text("Cette fonctionnalité nécessite une permission. Veuillez l'activer dans les paramètres."),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(navigatorKey.currentContext!),
//                 child: const Text("OK"),
//               ),
//             ],
//           ),
//         );
//       });
//     } else {
//       print("Erreur normale : $error");
//     }
//   }
// }
}

class ErrorHandlerService extends GetxService {
  static ErrorHandlerService get to => Get.find<ErrorHandlerService>();

  Future<ErrorHandlerService> init() async {
    return this;
  }

  void handleError(Object error, StackTrace? stack) {
    String errorMsg = error.toString().toLowerCase();

    // Mots-clés fréquents dans les erreurs de permission
    List<String> permissionKeywords = ["permission", "securityexception", "denied", "missing", "requires permission"];

    bool isPermissionError = permissionKeywords.any((kw) => errorMsg.contains(kw));

    if (isPermissionError) {
      print("⚠️ Problème de permission détecté !");
      _showPermissionDialog();
    } else {
      print("Erreur normale : $error");
    }
  }

  void _showPermissionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Permission manquante"),
        content: const Text("Cette fonctionnalité nécessite une permission. Veuillez l'activer dans les paramètres."),
        actions: [
          TextButton(
            onPressed: () async {
              await openAppSettings();
              Get.back();
            },
            child: const Text("Ouvrir paramètres"),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Annuler"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
