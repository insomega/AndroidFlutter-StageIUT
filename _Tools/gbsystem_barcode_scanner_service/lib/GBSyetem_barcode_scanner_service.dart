import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';

/// Service générique pour scanner des codes-barres ou QR codes.
/// Utilisable dans n’importe quel projet Flutter/GetX.
class BarcodeScannerService extends GetxService {
  final isScanning = false.obs;

  /// Lance le scanner et retourne la valeur du code scanné.
  Future<String?> scanBarcode(BuildContext context) async {
    try {
      String? result;

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => Obx(
            () => Stack(
              children: [
                AiBarcodeScanner(
                  controller: MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates),
                  validator: (p0) => p0.barcodes.first.rawValue != null,
                  onDetect: (capture) {
                    final code = capture.barcodes.first.rawValue;
                    if (code != null) {
                      log("✅ Code détecté : $code", name: "BarcodeScanner");
                      result = code;
                      Get.back(); // Fermer après détection
                    }
                  },
                  onDispose: () => debugPrint("Scanner fermé."),
                ),
                isScanning.value ? const Center(child: CircularProgressIndicator()) : Container(),
              ],
            ),
          ),
        ),
      );

      return result;
    } catch (e) {
      log("❌ Erreur lors du scan: $e", name: "BarcodeScanner");
      return null;
    }
  }
}
