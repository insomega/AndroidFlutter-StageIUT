import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'GBSystem_text_helper.dart';

class GBSystem_NetworkController extends GetxController {
  final RxBool isConnected = true.obs; // true par défaut
  final _snackbarHelper = GBSystem_Connecxion_SnackBar();

  GBSystem_NetworkController() {
    _initConnectivity();
    _listenConnectivityChanges();
  }

  Future<void> _initConnectivity() async {
    await checkNow();
  }

  void _listenConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((result) {
      bool connected = result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);
      isConnected.value = connected;

      // 🔹 Afficher/mettre à jour la snackbar
      _snackbarHelper.afficherSnackBarConnection(isConnected: connected);
    });
  }

  Future<void> checkNow() async {
    final result = await Connectivity().checkConnectivity();
    bool connected = result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);
    isConnected.value = connected;

    // 🔹 Afficher l'état réseau au démarrage
    _snackbarHelper.afficherSnackBarConnection(isConnected: connected);
  }
}

// class GBSystem_NetworkController extends GetxController {
//   final RxBool isConnected = true.obs; // true par défaut

//   GBSystem_NetworkController() {
//     _initConnectivity();
//     _listenConnectivityChanges();
//   }

//   Future<void> _initConnectivity() async {
//     await checkNow();
//   }

//   void _listenConnectivityChanges() {
//     Connectivity().onConnectivityChanged.listen((result) {
//       isConnected.value = result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);
//     });
//   }

//   Future<void> checkNow() async {
//     final result = await Connectivity().checkConnectivity();
//     isConnected.value = result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);
//   }
// }

// class GBSystem_NetworkBanner extends StatelessWidget {
//   final controller = Get.put(GBSystem_NetworkController());

//   @override
//   Widget build(BuildContext context) {
//     String Msg_info = GBSystem_Application_Strings.str_error_no_connection_title.tr;

//     return Obx(() {
//       final connected = Get.find<GBSystem_NetworkController>().isConnected.value;
//       return AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         height: connected ? 0 : 128, // Bandeau fin
//         width: double.infinity,
//         margin: const EdgeInsets.all(6), // espace autour
//         decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(8), // 🔹 arrondi
//         ),
//         alignment: Alignment.center,
//         child: connected
//             ? null
//             : Text(
//                 Msg_info,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   decoration: TextDecoration.none,
//                 ),
//               ),
//       );
//     });

//   }
// }

class GBSystem_Connecxion_SnackBar {
  void afficherSnackBarConnection({
    required bool isConnected,
    final void Function()? whenConnextionReturn,
  }) {
    if (!isConnected) {
      // 🔴 Pas de connexion → afficher snackbar rouge persistante
      Get.closeCurrentSnackbar();
      Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        messageText: GBSystem_TextHelper().smallText(
          text: GBSystem_Application_Strings.str_error_no_connection_title,
          textColor: Colors.white,
        ),
        icon: const Icon(Icons.wifi_off, color: Colors.white),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red,
      );
    } else {
      // 🟢 Connexion rétablie
      if (whenConnextionReturn != null) {
        Get.closeAllSnackbars();
        whenConnextionReturn();
      } else {
        if (Get.isSnackbarOpen) {
          Get.closeAllSnackbars();
          Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            messageText: GBSystem_TextHelper().smallText(
              text: GBSystem_Application_Strings.str_error_connection_returned_title,
              textColor: Colors.white,
            ),
            icon: const Icon(Icons.wifi, color: Colors.white),
            shouldIconPulse: false,
            isDismissible: false,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          );
          // Get.closeAllSnackbars();
        }
      }
    }
  }
}

/*import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class GBSystem_NetworkController extends GetxController {
  final RxBool isConnected = false.obs;

  GBSystem_NetworkController() {
    _initConnectivity(); // vérifie au démarrage
  }

  /// Méthode interne appelée au démarrage
  Future<void> _initConnectivity() async {
    await checkNow(); // réutilise la méthode publique
  }

  /// Méthode publique pour vérifier l'état de la connexion à tout moment
  Future<void> checkNow() async {
    final result = await Connectivity().checkConnectivity();
    //isConnected.value = result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
    isConnected.value = result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);

   // update(); // utile si vous utilisez GetBuilder
  }
}*/
/*import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class GBSystemInternatController extends GetxController {
  bool _isConnected = false;

  GBSystemInternatController() {
    initConnectivity();
  }

  bool get isConnected => _isConnected;

  Future<void> initConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      _isConnected = true;
    } else {
      _isConnected = false;
    }

    update();
  }
}
*/

// Obx(() {
    //   final connected = Get.find<GBSystem_NetworkController>().isConnected.value;
    //   return AnimatedContainer(
    //     duration: const Duration(milliseconds: 300),
    //     height: connected ? 0 : 100, // 🔹 Bandeau fin (28px)
    //     width: double.infinity,
    //     color: Colors.red,
    //     alignment: Alignment.center,
    //     child: connected
    //         ? null
    //         : Text(
    //             Msg_info,
    //             style: const TextStyle(
    //               color: Colors.white,
    //               fontSize: 18, // 🔹 Plus petit texte
    //               fontWeight: FontWeight.w500,
    //               decoration: TextDecoration.none,
    //             ),
    //           ),
    //   );
    // });

    // Obx(() {
    //   if (controller.isConnected.value) {
    //     return const SizedBox.shrink(); // rien si connecté
    //   }
    //   return Container(
    //     width: double.infinity,
    //     color: Colors.red,
    //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    //     child: SafeArea(
    //       child: Text(
    //         Msg_info,
    //         style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //   );
    // });