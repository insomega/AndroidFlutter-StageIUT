// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gbsystem_stock/GBSystem_Application/home_add_article_screen_controller.dart';
// import 'package:gbsystem_stock/GBSystem_Application/article_widget.dart';
// import 'package:gbsystem_stock/GBSystem_Application/choose_mode_button_widget.dart';
// import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
// import 'package:gbsystem_root/GBSystem_waiting.dart';

// class GBSystem_Ajout_Article_To_Stock_View extends StatelessWidget {
//   GBSystem_Ajout_Article_To_Stock_View({super.key});

//   final GBSystem_Ajout_Article_To_Stock_Controller controller = Get.put(GBSystem_Ajout_Article_To_Stock_Controller());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Stack(
//         children: [
//           Scaffold(
//             appBar: AppBar(
//               leading: InkWell(
//                 onTap: () => Get.back(),
//                 child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
//               ),
//               centerTitle: true,
//               backgroundColor: GBSystem_Application_Strings.str_primary_color,
//               title: Text(GBSystem_Application_Strings.str_ajouter_articles, style: const TextStyle(color: Colors.white)),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(mainAxisSize: MainAxisSize.min, children: [_buildScannerButton(context), _buildArticleWidget(), _buildCataloguesList()]),
//             ),
//           ),
//           controller.isLoadingMain.value ? Waiting() : Container(),
//         ],
//       ),
//     );
//   }

//   Widget _buildScannerButton(BuildContext context) {
//     return Obx(
//       () => Visibility(
//         visible: controller.selectedArticle.value == null,
//         child: ChooseModeButtonWidget(
//           onTap: () => controller.scanBarcode(context),
//           icon: const Icon(Icons.qr_code_scanner, color: Colors.black, size: 80),
//           text: GBSystem_Application_Strings.str_Scanner_un_code.tr,
//         ),
//       ),
//     );
//   }

//   Widget _buildArticleWidget() {
//     return Obx(() => controller.selectedArticle.value != null ? ArticleRefAddWidget(onBtnTap: controller.onArticleButtonTap, article: controller.selectedArticle.value!) : Container());
//   }

//   Widget _buildCataloguesList() {
//     return const SizedBox(height: 5);
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'GBSystem_Ajout_Article_To_Stock_Controller.dart';

class GBSystem_Ajout_Article_To_Stock_View extends StatelessWidget {
  GBSystem_Ajout_Article_To_Stock_View({super.key});

  final GBSystem_Ajout_Article_To_Stock_Controller controller = Get.put(GBSystem_Ajout_Article_To_Stock_Controller());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () => Get.back(),
                child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.blue,
              title: const Text("Ajouter Article", style: TextStyle(color: Colors.white)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [_buildScannerButton(context), const SizedBox(height: 20), _buildScannedCodeWidget()]),
            ),
          ),
          controller.isLoadingMain.value ? const Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }

  Widget _buildScannerButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => controller.scanAndFetchArticle(context),
      icon: const Icon(Icons.qr_code_scanner),
      label: const Text("Scanner un article"),
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20)),
    );
  }

  Widget _buildScannedCodeWidget() {
    return Obx(() {
      final code = controller.selectedBarcode.value;
      if (code == null) return const SizedBox();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Code scanné : $code", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      );
    });
  }
}
