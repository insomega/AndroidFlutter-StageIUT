import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DOCUMENTS_SCREENS/DOCUMENT_MAIN_SCREEN/GBSystem_document_main_screen_controller.dart';

class GBSystemDocumentMainScreen extends StatefulWidget {
  GBSystemDocumentMainScreen({super.key, required this.selectedIndexFromOut});
  final int selectedIndexFromOut;
  @override
  State<GBSystemDocumentMainScreen> createState() =>
      _GBSystemDocumentMainScreenState();
}

class _GBSystemDocumentMainScreenState
    extends State<GBSystemDocumentMainScreen> {
  final m = Get.put<GBSystemDocumentMainScreenController>(
      GBSystemDocumentMainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: m.screens[widget.selectedIndexFromOut]),
        ],
      ),
      // Obx(
      //   () => Column(
      //     children: [
      //       Expanded(child: m.screens[m.currentIndex.value]),
      //     ],
      //   ),
      // )
    );
  }
}
