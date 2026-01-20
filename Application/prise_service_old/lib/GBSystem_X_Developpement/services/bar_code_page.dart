import 'dart:developer';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';

import 'package:flutter/material.dart';

class BarCodePage extends StatefulWidget {
  const BarCodePage({super.key});

  @override
  State<BarCodePage> createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  String barcode = 'Tap  to scan';
  @override
  Widget build(BuildContext context) {
    return AiBarcodeScanner(
      // hideDragHandler: true,
      // hideTitle: true,
      // successColor: Colors.green,
      // errorColor: Colors.red,
      onDispose: () {
        debugPrint("Barcode scanner disposed!");
      },
      controller: MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
      ),
      onDetect: (p0) => setState(() {
        barcode = p0.barcodes.first.rawValue.toString();
        log(barcode, name: 'Barcode');
      }),
      validator: (p0) => p0.barcodes.first.rawValue?.startsWith('https://') ?? false,
    );
  }
}
