// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
// import 'package:gbsystem_root/GBSystem_LogEvent.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_ref_model.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_catalogue_model.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_taille_model.dart';

// class GBSystem_Ajout_Article_To_Stock_Controller extends GetxController {
//   // États réactifs
//   final isLoading = false.obs;
//   final isLoadingMain = false.obs;
//   final selectedArticle = Rx<GbsystemArticleRefModel?>(null);
//   final catalogues = <GbsystemCatalogueModel>[].obs;

//   // Contrôleurs de texte
//   final referentialController = TextEditingController();
//   final categorieController = TextEditingController();
//   final prixController = TextEditingController();
//   final fournisseurController = TextEditingController();
//   final couleurController = TextEditingController();
//   final qteStockController = TextEditingController();
//   final parResponsableController = TextEditingController();
//   final enterpotController = TextEditingController();

//   // Dates sélectionnées
//   final selectedDateDebut = Rx<DateTime?>(null);
//   final selectedDateFin = Rx<DateTime?>(null);
//   final selectedDateUpdate = Rx<DateTime?>(null);

//   // Données sélectionnées
//   final selectedFournisseur = Rx<dynamic>(null);
//   final selectedColor = Rx<dynamic>(null);
//   final selectedEnterpot = Rx<dynamic>(null);
//   final selectedTailles = <GbsystemTailleModel>[].obs;

//   @override
//   void onClose() {
//     referentialController.dispose();
//     categorieController.dispose();
//     prixController.dispose();
//     fournisseurController.dispose();
//     couleurController.dispose();
//     qteStockController.dispose();
//     parResponsableController.dispose();
//     enterpotController.dispose();
//     super.onClose();
//   }

//   // ======================
//   // 🔹 Logique Métier
//   // ======================

//   Future<void> scanBarcode(BuildContext context) async {
//     try {
//       await Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => Obx(
//             () => Stack(
//               children: [
//                 AiBarcodeScanner(
//                   onDispose: () => debugPrint("Barcode scanner disposed!"),
//                   controller: MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates),
//                   onDetect: (p0) => onBarcodeDetected(p0, context),
//                   validator: (p0) => p0.barcodes.first.rawValue != null,
//                 ),
//                 isLoading.value ? const Center(child: CircularProgressIndicator()) : Container(),
//               ],
//             ),
//           ),
//         ),
//       );
//     } catch (e) {
//       GBSystem_Add_LogEvent(message: e.toString(), method: "scanBarcode", page: "GBSystem_Ajout_Article_To_Stock_View");
//     }
//   }

//   void onBarcodeDetected(dynamic p0, BuildContext context) async {
//     try {
//       final barcodeValue = p0.barcodes.first.rawValue.toString();
//       log(barcodeValue, name: 'Barcode');

//       isLoading.value = true;
//       // TODO : Appeler ton service pour chercher l’article
//       isLoading.value = false;

//       Get.back();
//     } catch (e) {
//       isLoading.value = false;
//       GBSystem_Add_LogEvent(message: e.toString(), method: "onBarcodeDetected", page: "GBSystem_Ajout_Article_To_Stock_View");
//     }
//   }

//   void onArticleButtonTap() async {
//     try {
//       isLoadingMain.value = true;
//       // TODO : logique (par ex. récupérer les tailles disponibles)
//     } finally {
//       isLoadingMain.value = false;
//     }
//   }

//   Future<void> onConfirmAddCatalogue() async {
//     if (validateAddCatalogue()) {
//       try {
//         isLoading.value = true;
//         // TODO : logique ajout catalogue
//       } finally {
//         isLoading.value = false;
//       }
//     } else {
//       Get.snackbar("Erreur", "Veuillez remplir toutes les cases obligatoires.");
//     }
//   }

//   // ======================
//   // 🔹 Méthodes de validation
//   // ======================

//   bool validateAddCatalogue() {
//     return selectedFournisseur.value != null && selectedDateDebut.value != null && prixController.text.isNotEmpty && selectedTailles.isNotEmpty;
//   }

//   bool validateAddToStock() {
//     return selectedEnterpot.value != null && selectedDateDebut.value != null && qteStockController.text.isNotEmpty;
//   }

//   bool validateUpdateCatalogue() {
//     return selectedDateDebut.value != null && prixController.text.isNotEmpty;
//   }

//   // ======================
//   // 🔹 Helpers
//   // ======================

//   void resetDialogData() {
//     referentialController.clear();
//     categorieController.clear();
//     prixController.clear();
//     fournisseurController.clear();
//     couleurController.clear();
//     qteStockController.clear();
//     parResponsableController.clear();
//     enterpotController.clear();
//     selectedDateDebut.value = null;
//     selectedDateFin.value = null;
//     selectedDateUpdate.value = null;
//     selectedFournisseur.value = null;
//     selectedColor.value = null;
//     selectedEnterpot.value = null;
//     selectedTailles.clear();
//   }
// }

// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gbsystem_barcode_scanner_service/GBSyetem_barcode_scanner_service.dart';
import 'package:get/get.dart';
// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
// import 'package:gbsystem_root/GBSystem_LogEvent.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_ref_model.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_catalogue_model.dart';
// import 'package:gbsystem_stock/GBSystem_Application/GBSystem_taille_model.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class GBSystem_Ajout_Article_To_Stock_Controller extends GetxController {
  final isLoadingMain = false.obs;
  final selectedBarcode = Rx<String?>(null);

  /// Service de scan (depuis ton package local)
  final BarcodeScannerService barcodeService = Get.put(BarcodeScannerService());

  /// Lance le scan et récupère le code scanné
  Future<void> scanAndFetchArticle(BuildContext context) async {
    try {
      isLoadingMain.value = true;

      final code = await barcodeService.scanBarcode(context);

      if (code != null) {
        selectedBarcode.value = code;

        // TODO : Ici tu appelles ton API / service métier pour chercher l’article
        // Exemple :
        // selectedArticle.value = await articleRepository.findByBarcode(code);
      } else {
        Get.snackbar("Erreur", "Aucun code détecté.");
      }
    } finally {
      isLoadingMain.value = false;
    }
  }
}
