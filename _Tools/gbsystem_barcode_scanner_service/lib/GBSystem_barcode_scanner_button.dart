import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'GBSyetem_barcode_scanner_service.dart';

class BarcodeScannerButton extends StatelessWidget {
  final Function(String code)? onCodeScanned;

  const BarcodeScannerButton({super.key, this.onCodeScanned});

  @override
  Widget build(BuildContext context) {
    final service = Get.put(BarcodeScannerService());

    return ElevatedButton.icon(
      onPressed: () async {
        final code = await service.scanBarcode(context);
        if (code != null && onCodeScanned != null) {
          onCodeScanned!(code);
        }
      },
      icon: const Icon(Icons.qr_code_scanner),
      label: const Text("Scanner un code"),
    );
  }
}
