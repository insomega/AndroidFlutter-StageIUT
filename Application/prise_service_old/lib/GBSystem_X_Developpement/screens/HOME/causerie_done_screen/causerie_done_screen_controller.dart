import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_formulaire_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_salarie_causerie_with_image_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_signature_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_question_type_with_his_questions_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_photo_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/signature_salarie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_type_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBsystem_salarie_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class CauserieDoneScreenController extends GetxController {
  RxBool isLoading = RxBool(false);
  CauserieDoneScreenController(this.context);
  BuildContext context;
  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());
  final FormulaireController formulaireController =
      Get.put(FormulaireController());
  //////////////////////////////////////////////////////
  final GBSystemSalarieCauserieWithImageController
      salarieCauserieWithImageController =
      Get.put(GBSystemSalarieCauserieWithImageController());
  final signatureController =
      Get.put<GBSystemSignatureController>(GBSystemSignatureController());

  Future getCauserieData() async {
    try {
      isLoading.value = true;

      await GBSystem_AuthService(context)
          .getAllQuestionTypeCauserie(
              questionnaire_LIEINSPQSNR_IDF: evaluationSurSiteController
                  .getSelectedQuestionnaire!.LIEINSPQSNR_IDF,
              site_LIE_IDF:
                  evaluationSurSiteController.getSelectedSite!.LIE_IDF)
          .then((questionTypeList) async {
        if (questionTypeList != null) {
          await getQuestionsOfTypeAndHisReponsesAndUpdateController(
                  listQuestionsType: questionTypeList)
              .then((value) {
            isLoading.value = false;
          });
        } else {
          isLoading.value = false;
          showErrorDialog(context, GbsSystemStrings.str_no_type_questions);
        }
      });
    } catch (e) {
      isLoading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "getCauserieData",
        page: "GBSystem_list_salaries_causerie_controller",
      );
    }
  }

  Future getCauserieDataView({required CauserieModel causerieModel}) async {
    try {
      isLoading.value = true;

      await GBSystem_AuthService(context)
          .getAllQuestionTypeCauserie(
              detectLocation: false,
              questionnaire_LIEINSPQSNR_IDF: causerieModel.LIEINSPQSNR_IDF,
              site_LIE_IDF: causerieModel.LIE_IDF)
          .then((questionTypeList) async {
        if (questionTypeList != null) {
          await getQuestionsOfTypeAndHisReponsesAndUpdateControllerView(
                  causerieModel: causerieModel,
                  listQuestionsType: questionTypeList)
              .then((value) {
            isLoading.value = false;
          });
        } else {
          isLoading.value = false;
          showErrorDialog(context, GbsSystemStrings.str_no_type_questions);
        }
      });
    } catch (e) {
      isLoading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "getCauserieData",
        page: "GBSystem_list_salaries_causerie_controller",
      );
    }
  }

  Future<void> getQuestionsOfTypeAndHisReponsesAndUpdateControllerView({
    required List<QuestionTypeModel> listQuestionsType,
    required CauserieModel causerieModel,
  }) async {
    try {
      List<QuestionTypeWithHisQuestionsModel> listQuestionsTypeWithQuestions =
          [];

      for (var i = 0; i < listQuestionsType.length; i++) {
        await GBSystem_AuthService(context)
            .getAllQuestionsOfQuestionTypeCauserie(
          questionType: listQuestionsType[i],
          questionnaire: evaluationSurSiteController.getSelectedQuestionnaire!,
        )
            .then((questions) async {
          if (questions != null) {
            listQuestionsTypeWithQuestions
                .add(QuestionTypeWithHisQuestionsModel(
              questionType: listQuestionsType[i],
              questions: questions,
            ));
          }
        });
      }
      formulaireController.setAllQuestionTypeWithHisQuestionsModel =
          listQuestionsTypeWithQuestions;
      formulaireController.setAllQuestionType = listQuestionsType;

      //all questions have the same LIEINSPSVR_IDF so i get the first value
      formulaireController.set_LIEINSPSVR_IDF =
          listQuestionsTypeWithQuestions[0]
              .questions[0]
              .questionWithoutMemoModel
              .LIEINSPSVR_IDF;
/////////////////////////// addededdede

      List<GBSystemSalarieWithPhotoCauserieModel> salariesWithPhoto = [];
      await GBSystem_AuthService(context)
          .getAllSalariesCauserieFormulaire(causerieModel: causerieModel)
          .then(
        (salariesForm) async {
          print("sal causerie : ${salariesForm?.length}");
          List<SignatureSalarieModel> allSignatureSalarie = [];

          for (var i = 0; i < (salariesForm?.length ?? 0); i++) {
            await GBSystem_AuthService(context)
                .getPhotoSalarieCauserie(
                    salarieCauserieModel_SVR_IDF: salariesForm![i].SVR_IDF)
                .then(
              (value) {
                salariesWithPhoto.add(
                  GBSystemSalarieWithPhotoCauserieModel(
                      salarieCauserieModel: SalarieCuaserieModel(
                          SVR_IDF: salariesForm[i].SVR_IDF,
                          SVR_CODE: salariesForm[i].SVR_CODE,
                          SVR_LIB: salariesForm[i].SVR_LIB,
                          ROW_ID: "1",
                          VAC_END_HOUR: DateTime.now(),
                          VAC_START_HOUR: DateTime.now()),
                      imageSalarie: value),
                );
              },
            );
            await GBSystem_AuthService(context)
                .getSignatureSalarieCauserie(
                    causerieModel: causerieModel,
                    salarie_SVR_IDF: salariesForm[i].SVR_IDF)
                .then(
              (value) {
                if (value != null) {
                  allSignatureSalarie.add(value);
                }
              },
            );

            signatureController.setAllSignatureSalaries = allSignatureSalarie;
          }
          salarieCauserieWithImageController.setAllSelectedSalaries =
              salariesWithPhoto;
        },
      );

      await GBSystem_AuthService(context)
          .getSignatureResponsableCauserie(causerieModel: causerieModel)
          .then(
        (value) {
          if (value != null) {
            signatureController.setSignatureBase64 = value;
          }
        },
      );
    } catch (e) {
      isLoading.value = false;

      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "getQuestionsOfTypeAndHisReponsesAndUpdateController",
        page: "GBSystem_list_salaries_causerie_controller",
      );
    }
  }

  Future<void> getQuestionsOfTypeAndHisReponsesAndUpdateController(
      {required List<QuestionTypeModel> listQuestionsType}) async {
    try {
      List<QuestionTypeWithHisQuestionsModel> listQuestionsTypeWithQuestions =
          [];

      for (var i = 0; i < listQuestionsType.length; i++) {
        await GBSystem_AuthService(context)
            .getAllQuestionsOfQuestionTypeCauserie(
          questionType: listQuestionsType[i],
          questionnaire: evaluationSurSiteController.getSelectedQuestionnaire!,
        )
            .then((questions) async {
          if (questions != null) {
            listQuestionsTypeWithQuestions
                .add(QuestionTypeWithHisQuestionsModel(
              questionType: listQuestionsType[i],
              questions: questions,
            ));
          }
        });
      }
      formulaireController.setAllQuestionTypeWithHisQuestionsModel =
          listQuestionsTypeWithQuestions;
      formulaireController.setAllQuestionType = listQuestionsType;

      //all questions have the same LIEINSPSVR_IDF so i get the first value
      formulaireController.set_LIEINSPSVR_IDF =
          listQuestionsTypeWithQuestions[0]
              .questions[0]
              .questionWithoutMemoModel
              .LIEINSPSVR_IDF;
/////////////////////////// addededdede
      await GBSystem_AuthService(context)
          .getListSalariesFormulaireCauserie(
              site_CLI_IDF:
                  evaluationSurSiteController.getSelectedSite!.CLI_IDF,
              site_LIE_IDF:
                  evaluationSurSiteController.getSelectedSite!.LIE_IDF,
              questionnaire:
                  evaluationSurSiteController.getSelectedQuestionnaire!,
              salaries: [],
              // salaries: listSalarieSelected
              //     .map(
              //       (e) => e.salarieCauserieModel,
              //     )
              //     .toList(),
              questionType: formulaireController.getAllQuestionType!.first)
          .then(
            (value) {},
          );
      /////////////////////////////
    } catch (e) {
      isLoading.value = false;

      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "getQuestionsOfTypeAndHisReponsesAndUpdateController",
        page: "GBSystem_list_salaries_causerie_controller",
      );
    }
  }
}
