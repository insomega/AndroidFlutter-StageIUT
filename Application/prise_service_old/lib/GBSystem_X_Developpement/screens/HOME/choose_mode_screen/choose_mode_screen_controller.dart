import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_en_cours_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_formulaire_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseModeScreenController extends GetxController {
  BuildContext context;
  RxBool isLoading = RxBool(false);
  ChooseModeScreenController({required this.context});

  final FormulaireController formulaireController =
      Get.put(FormulaireController());
  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());
  final GbsystemEvaluationEnCoursController evaluationEnCoursController =
      Get.put(GbsystemEvaluationEnCoursController());

  Future deconnexion() async {
    isLoading.value = true;
    final GBSystemAgenceQuickAccessController agencesController =
        Get.put(GBSystemAgenceQuickAccessController());
    agencesController.setLoginAgence = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(GbsSystemServerStrings.kToken, "");
    await preferences.setString(GbsSystemServerStrings.kCookies, "");
    isLoading.value = false;
    Get.offAll(GBSystemLoginScreen());
  }

  void viderPreviousData() {
    // evaluationSurSiteController.setSelectedTypeQuestionnaire = null;
    evaluationSurSiteController.setSelectedQuestionnaire = null; //
    evaluationSurSiteController.setSelectedSite = null; //
  }
}
