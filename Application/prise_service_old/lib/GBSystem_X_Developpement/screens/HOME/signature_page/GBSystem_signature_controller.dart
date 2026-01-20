import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_formulaire_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_signature_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_local_database_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemSignaturePageController extends GetxController {
  GBSystemSignaturePageController(this.context,
      {required this.viewMode, required this.causerieModel});
  BuildContext context;
  final CauserieModel? causerieModel;
  final bool viewMode;
  Uint8List? imageSignature;
  RxBool isLoading = RxBool(false);
  String? base64ImageSended;
  TextEditingController controller = TextEditingController();
  final formulaireController =
      Get.put<FormulaireController>(FormulaireController());
  final signatureController =
      Get.put<GBSystemSignatureController>(GBSystemSignatureController());

  Future<void> uploadSignature(
      String? signature, String? evaluationEnCoursModel_LIEINSPSVR_IDF) async {
    try {
      if (signature != null) {
        isLoading.value = true;
        // imageSignature = signature;
        update();
        // String base64Image = base64Encode(signature);
        String base64Image = base64Encode(utf8.encode(signature));

        await GBSystem_AuthService(context)
            .sendReponseSignature(
                LIEINSPSVR_IDF: viewMode
                    ? causerieModel?.LIEINSPSVR_IDF
                    : formulaireController.get_LIEINSPSVR_IDF,
                imageBytes: base64Image,
                commentaire: controller.text)
            .then((value) async {
          base64ImageSended = value;
          signatureController.setSignatureBase64 = base64Image;
          isLoading.value = false;
          if (value != null) {
            // controller.text = "";
            if (evaluationEnCoursModel_LIEINSPSVR_IDF != null) {
              await LocalDatabaseService.deleteByIdfEval(
                  evaluationEnCoursModel_LIEINSPSVR_IDF);
            }
            showSuccesDialog(context, GbsSystemStrings.str_operation_effectuee);
          } else {
            showErrorDialog(context, GbsSystemStrings.str_error_send_data);
          }
        });
      } else {
        showErrorDialog(context, GbsSystemStrings.str_empty_signature);
      }
    } catch (e) {
      isLoading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "sendReponseSignature",
        page: "GBSystem_signature_controller",
      );
    }
  }
}
