import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_salarie_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_salarie_quick_access_with_image_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_questionnaire_quick_acces_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_quick_acces_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_quick_acces_with_image_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_quick_access_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_type_questionnaire_quick_access_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/list_agences_screen/GBSystem_list_agences_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/list_salarie_screen/GBSystem_list_salaries_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystemHomeQuickAccessController extends GetxController {
  BuildContext context;
  RxBool isLoading = RxBool(false);
  GBSystemHomeQuickAccessController({required this.context});
  Rx<SiteQuickAccesModel?> selectedSite = Rx<SiteQuickAccesModel?>(null);
  Rx<QuestionnaireModel?> selectedQuestionnaire = Rx<QuestionnaireModel?>(null);
  Rx<TypeQuestionnaireModel?> selectedTypeQuestionnaire =
      Rx<TypeQuestionnaireModel?>(null);

  List<TypeQuestionnaireModel>? listTypeQuestionnaire;
  List<QuestionnaireModel>? listQuestionnaire;
  List<SiteQuickAccesModel>? listSites;
  List<String> listType = [
    GbsSystemStrings.str_periodique,
    GbsSystemStrings.str_libre,
    GbsSystemStrings.str_utilisateur
  ];
  RxString selectedType = GbsSystemStrings.str_periodique.obs;

  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());

  final GBSystemSalarieQuickAccessController salarieQuickAccessController =
      Get.put(GBSystemSalarieQuickAccessController());
  final GBSystemSalarieQuickAccessWithImageController
      salarieQuickAccessWithImageController =
      Get.put(GBSystemSalarieQuickAccessWithImageController());

  @override
  void onInit() {
    listTypeQuestionnaire =
        evaluationSurSiteController.getAllTypeQuestionnaires;

    listQuestionnaire = evaluationSurSiteController.getAllQuestionnaires;

    listSites = evaluationSurSiteController.getAllSites;

    super.onInit();
  }

  void changeDataType(String type) {
    selectedType.value = type;
    evaluationSurSiteController.setSelectedType = type;
    update();
  }

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

  Future chargerDataAgenceQuestionnaire() async {
    if (evaluationSurSiteController.getSelectedQuestionnaire != null &&
        evaluationSurSiteController.getSelectedTypeQuestionnaire != null) {
      isLoading.value = true;
      // getAgencesSalariesQuickAccess
      await GBSystem_AuthService(context)
          .getAgencesSalariesQuickAccess(
              questionnaireModel:
                  evaluationSurSiteController.getSelectedQuestionnaire!,
              typeQuestionnaire:
                  evaluationSurSiteController.getSelectedTypeQuestionnaire!,
              siteQuickAccesModel: evaluationSurSiteController.getSelectedSite,
              type: selectedType.value)
          .then((agences) async {
        if (agences != null) {
          salarieQuickAccessWithImageController.setAllAgences = agences;

          isLoading.value = false;
          Get.to(GBSystemListAgencesScreen());
        } else {
          isLoading.value = false;
          showErrorDialog(context, GbsSystemStrings.str_no_lieu);
        }
      });
    } else {
      showErrorDialog(context, GbsSystemStrings.str_remplie_cases);
    }
  }

  Future chargerDataQuestionnaire() async {
    if (evaluationSurSiteController.getSelectedQuestionnaire != null &&
        evaluationSurSiteController.getSelectedTypeQuestionnaire != null) {
      isLoading.value = true;
      // getAgencesSalariesQuickAccess
      await GBSystem_AuthService(context)
          .getSalariesQuickAccess(
              questionnaireModel:
                  evaluationSurSiteController.getSelectedQuestionnaire!,
              typeQuestionnaire:
                  evaluationSurSiteController.getSelectedTypeQuestionnaire!,
              siteQuickAccesModel: evaluationSurSiteController.getSelectedSite,
              type: selectedType.value)
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

    /// this lines get the photo of chaque salarie i do it as comment because it take long time

    // for (var i = 0; i < salarieQuickAccessModel.length; i++) {
    //   await GBSystem_AuthService(context)
    //       .getPhotoSalarieQuickAccess(
    //           salarieQuickAccessModel: salarieQuickAccessModel[i])
    //       .then((image) {
    //     listSalariesImage.add(GBSystemSalarieQuickAccessWithPhotoModel(
    //         salarieModel: salarieQuickAccessModel[i], imageSalarie: image));
    //   });
    // }

    salarieQuickAccessWithImageController.setAllSalaries = listSalariesImage;
  }
}
