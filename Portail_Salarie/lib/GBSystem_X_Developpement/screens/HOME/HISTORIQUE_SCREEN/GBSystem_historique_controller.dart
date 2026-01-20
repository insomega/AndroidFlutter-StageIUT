import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_historique_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GBSystemHistoriqueScreenController extends GetxController {
  final GBSystemHistoriqueController historiqueController =
      Get.put(GBSystemHistoriqueController());
  WebViewController? controller;

  @override
  void onInit() {
    // if (historiqueController.getAllHistoriques != null) {
    //   controller = WebViewController()
    //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //     ..setBackgroundColor(const Color(0x00000000))
    //     ..addJavaScriptChannel(
    //       "myChannel",
    //       onMessageReceived: (p0) {
    //         showToast(text: p0.message);
    //       },
    //     )
    //     ..loadHtmlString(historiqueController.getAllHistoriques!
    //         .replaceAll(r"${str_demande_absence_du}",
    //             GbsSystemStrings.str_demande_absence_du.tr)
    //         .replaceAll(r"${str_au}", GbsSystemStrings.str_au.tr)
    //         .replaceAll(
    //             r"${str_effectuee_le}", GbsSystemStrings.str_effectuee_le.tr)
    //         .replaceAll(
    //             r"${str_clotures_le}", GbsSystemStrings.str_clotures_le.tr)
    //         .replaceAll(
    //             r"${str_refuser_le}", GbsSystemStrings.str_refuser_le.tr)
    //         .replaceAll(r"${str_acceptation_le}",
    //             GbsSystemStrings.str_acceptation_le.tr));
    // }

    super.onInit();
  }
}
