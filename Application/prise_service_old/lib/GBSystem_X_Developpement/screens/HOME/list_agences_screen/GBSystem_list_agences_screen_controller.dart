import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_salarie_quick_access_with_image_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_quick_acces_with_image_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_agence_salarie_quick_acces_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_quick_acces_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/list_salarie_screen/GBSystem_list_salaries_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemListAgencesScreenController extends GetxController {
  BuildContext context;
  GBSystemListAgencesScreenController({required this.context});

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();

  RxBool isLoading = false.obs;
  final GBSystemSalarieQuickAccessWithImageController
      salarieQuickAccessWithImageController =
      Get.put(GBSystemSalarieQuickAccessWithImageController());
  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());
  List<AgenceSalarieQuickAccesModel> usedListAgences() {
    List<AgenceSalarieQuickAccesModel> tempList =
        (salarieQuickAccessWithImageController.getAllAgences ?? []);
    List<AgenceSalarieQuickAccesModel> resultList = [];

    if (text?.value != null && text!.value.isNotEmpty) {
      resultList = tempList
          .where(
            (element) => (element.LIE_LIB ?? "")
                .toLowerCase()
                .contains(text!.value.toLowerCase()),
          )
          .toList();
    } else {
      resultList = tempList;
    }

    return resultList;
  }

  Future chargerDataQuestionnaireFromUtilisateur() async {
    if (evaluationSurSiteController.getSelectedQuestionnaire != null &&
        evaluationSurSiteController.getSelectedTypeQuestionnaire != null &&
        salarieQuickAccessWithImageController.getSelectedAgences != null) {
      isLoading.value = true;

      await GBSystem_AuthService(context)
          .getSalariesQuickAccess(
              utilisateur_LIE_IDF: salarieQuickAccessWithImageController
                  .getSelectedAgences!.LIE_IDF,
              questionnaireModel:
                  evaluationSurSiteController.getSelectedQuestionnaire!,
              typeQuestionnaire:
                  evaluationSurSiteController.getSelectedTypeQuestionnaire!,
              siteQuickAccesModel: evaluationSurSiteController.getSelectedSite,
              type: GbsSystemStrings.str_utilisateur)
          .then((salaries) async {
        if (salaries != null) {
          await getImageOfSalariesAndUpdateController(
              salarieQuickAccessModel: salaries);

          isLoading.value = false;
          Get.to(GBSystemListSalariesScreen());
        } else {
          isLoading.value = false;
          showErrorDialog(context, GbsSystemStrings.str_no_salarie);
        }
      });
    } else {
      showErrorDialog(context, GbsSystemStrings.str_remplie_cases);
    }
  }

  Future getImageOfSalariesAndUpdateController(
      {required List<SalarieQuickAccessModel> salarieQuickAccessModel}) async {
    List<GBSystemSalarieQuickAccessWithPhotoModel> listSalariesImage = [];

    /// this boucle remplace the lines below (get salaries without his photos)
    for (var i = 0; i < salarieQuickAccessModel.length; i++) {
      listSalariesImage.add(GBSystemSalarieQuickAccessWithPhotoModel(
          salarieModel: salarieQuickAccessModel[i], imageSalarie: null));
    }

    salarieQuickAccessWithImageController.setAllSalaries = listSalariesImage;
  }
}
