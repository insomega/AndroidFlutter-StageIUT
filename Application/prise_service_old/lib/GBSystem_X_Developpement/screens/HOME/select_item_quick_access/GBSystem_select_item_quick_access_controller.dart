import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_questionnaire_quick_acces_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_quick_access_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_type_questionnaire_quick_access_model.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemSelectItemQuickAccessController extends GetxController {
  GBSystemSelectItemQuickAccessController({
    required this.type,
    required this.context,
    this.isCauserie = false,
  });
  BuildContext context;
  String type;
  final bool isCauserie;

  RxBool isLoading = RxBool(false);
//////
  RxList<TypeQuestionnaireModel> typeQuestionnaires =
      RxList<TypeQuestionnaireModel>([]);
  RxList<TypeQuestionnaireModel> filtredTypeQuestionnaire =
      RxList<TypeQuestionnaireModel>([]);

  RxList<QuestionnaireModel> questionnaires = RxList<QuestionnaireModel>([]);
  RxList<QuestionnaireModel> filtredQuestionnaire =
      RxList<QuestionnaireModel>([]);

  RxList<SiteQuickAccesModel> sites = RxList<SiteQuickAccesModel>([]);
  RxList<SiteQuickAccesModel> filtredSites = RxList<SiteQuickAccesModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();

  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());
/////////

  void updateString(String str) {
    text?.value = str;
    update();
  }

  initDataQuickAccess() {
    if (type == GbsSystemStrings.str_type_site) {
      sites.value = evaluationSurSiteController.getAllSites ?? [];
    } else if (type == GbsSystemStrings.str_type_questionnaire) {
      if (evaluationSurSiteController.getSelectedTypeQuestionnaire != null) {
        questionnaires.value = evaluationSurSiteController.getAllQuestionnaires!
            .where((questionnaire) {
          return questionnaire.LIEINSQUESTYP_IDF ==
              evaluationSurSiteController
                  .getSelectedTypeQuestionnaire!.LIEINSQUESTYP_IDF;
        }).toList();
      } else {
        questionnaires.value =
            evaluationSurSiteController.getAllQuestionnaires!;
      }
    } else if (type == GbsSystemStrings.str_type_type_questionnaire) {
      typeQuestionnaires.value =
          evaluationSurSiteController.getAllTypeQuestionnaires!;
    }
  }

  initDataCauserie() {
    if (type == GbsSystemStrings.str_type_site) {
      sites.value = evaluationSurSiteController.getAllSites ?? [];
    } else if (type == GbsSystemStrings.str_type_questionnaire) {
      if (evaluationSurSiteController.getSelectedTypeQuestionnaire != null) {
        questionnaires.value =
            evaluationSurSiteController.getAllQuestionnaires!;
        //     .where((questionnaire) {
        //   // return questionnaire.LIEINSQUESTYP_IDF ==
        //   //     evaluationSurSiteController
        //   //         .getSelectedTypeQuestionnaire!.LIEINSQUESTYP_IDF;
        // }).toList();
      } else {
        questionnaires.value =
            evaluationSurSiteController.getAllQuestionnaires!;
      }
    } else if (type == GbsSystemStrings.str_type_type_questionnaire) {
      typeQuestionnaires.value =
          evaluationSurSiteController.getAllTypeQuestionnaires!;
    }
  }

  @override
  void onInit() {
    isCauserie ? initDataCauserie() : initDataQuickAccess();
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredSites.value = sites.where((site) {
      return site.LIE_LIB
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          site.LIE_CODE.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void filterDataQuestionnaire(String query) {
    text?.value = query;

    filtredQuestionnaire.value = questionnaires.where((questionnaire) {
      return questionnaire.LIEINSPQSNR_CODE
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          questionnaire.LIEINSPQSNR_LIB
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  void filterDataTypeQuestionnaire(String query) {
    text?.value = query;
    // LIEINSQUESTYP_LIB

    filtredTypeQuestionnaire.value =
        typeQuestionnaires.where((typeQuestionnaire) {
      return typeQuestionnaire.LIEINSQUESTYP_LIB
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          typeQuestionnaire.LIEINSQUESTYP_CODE
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  void onSelectedQuestionnaire(QuestionnaireModel questionnaireModel) {
    evaluationSurSiteController.setSelectedQuestionnaire = questionnaireModel;
    update();

    Get.back();
  }

  void onSelectedSite(SiteQuickAccesModel siteQuickAccesModel) {
    evaluationSurSiteController.setSelectedSite = siteQuickAccesModel;
    update();

    Get.back();
  }

  void onSelectedTypeQuestionnaire(
      TypeQuestionnaireModel typeQuestionnaireModel) {
    evaluationSurSiteController.setSelectedTypeQuestionnaire =
        typeQuestionnaireModel;
    evaluationSurSiteController.setSelectedQuestionnaire = null;
    evaluationSurSiteController.setSelectedSite = null;

    update();
    Get.back();
  }
}
