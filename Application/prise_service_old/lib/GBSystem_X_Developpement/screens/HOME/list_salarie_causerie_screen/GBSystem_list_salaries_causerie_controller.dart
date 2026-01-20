import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_formulaire_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_qcm_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_photo_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_type_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_question_type_with_his_questions_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemListSalariesCauserieController extends GetxController {
  BuildContext context;
  GBSystemListSalariesCauserieController({required this.context});
  RxBool isLoading = false.obs;
  List<GBSystemSalarieWithPhotoCauserieModel> listSalarieSelected = [];
  final FormulaireController formulaireController =
      Get.put(FormulaireController());
  final QCMController qcmController = Get.put(QCMController());
  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());

  bool testExistance(
      {required List<GBSystemSalarieWithPhotoCauserieModel> listSalarieSelected,
      required GBSystemSalarieWithPhotoCauserieModel salarie}) {
    bool check = false;
    for (var i = 0; i < listSalarieSelected.length; i++) {
      if (listSalarieSelected[i].salarieCauserieModel.SVR_IDF ==
          salarie.salarieCauserieModel.SVR_IDF) {
        check = true;
      }
    }
    return check;
  }

  Future<List<QuestionTypeModel>?> getCauserieData() async {
    List<QuestionTypeModel>? questionTypeListFinal;
    try {
      isLoading.value = true;

      await GBSystem_AuthService(context)
          .getAllQuestionTypeCauserie(
              questionnaire_LIEINSPQSNR_IDF: evaluationSurSiteController
                  .getSelectedQuestionnaire!.LIEINSPQSNR_IDF,
              site_LIE_IDF:
                  evaluationSurSiteController.getSelectedSite!.LIE_IDF)
          .then((questionTypeList) async {
        if (questionTypeList != null && questionTypeList.isNotEmpty) {
          await getQuestionsOfTypeAndHisReponsesAndUpdateController(
                  listQuestionsType: questionTypeList)
              .then((value) {
            isLoading.value = false;
          });
        } else {
          isLoading.value = false;
          showErrorDialog(context,
              GbsSystemStrings.str_attention_existe_qst_avec_dates_non_valide);
        }
        questionTypeListFinal = questionTypeList;
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
    return questionTypeListFinal;
  }

  // Future getFormulaireData(
  //     {required GBSystemSalarieQuickAccessWithPhotoModel salarie}) async {
  //   print("------------------------Formulaire----------------------------");
  //   try {
  //     isLoading.value = true;

  //     await GBSystem_AuthService(context)
  //         .getFormulaireQuestionsTypeDataQuickAccess(
  //             salarie: salarie.salarieModel)
  //         .then((questionTypeList) async {
  //       if (questionTypeList != null) {
  //         // await GBSystem_AuthService(context).getFormulaireDataQuickAccess();
  //         await getQuestionsOfTypeAndUpdateController(
  //                 listQuestionsType: questionTypeList)
  //             .then((value) {
  //           isLoading.value = false;

  //           Get.to(
  //             GBSystemFormulaireSignatureScreen(salarieWithPhotoModel: salarie),
  //           );
  //         }).catchError((e) {
  //           isLoading.value = false;

  //           showErrorDialog(context, e.toString());
  //         });
  //       } else {
  //         isLoading.value = false;
  //         showErrorDialog(context, GbsSystemStrings.str_no_type_questions);
  //       }
  //     });
  //   } catch (e) {
  //     isLoading.value = false;

  //     GBSystem_ManageCatchErrors().catchErrors(
  //       context,
  //       message: e.toString(),
  //       method: "getFormulaireData",
  //       page: "GBSystem_list_salaries_controller",
  //     );
  //   }
  // }

  // Future<void> getQuestionsOfTypeAndUpdateController(
  //     {required List<QuestionTypeModel> listQuestionsType}) async {
  //   try {
  //     List<QuestionTypeWithHisQuestionsModel> listQustionsTypeWithHisQuestions =
  //         [];
  //     for (var i = 0; i < listQuestionsType.length; i++) {
  //       await GBSystem_AuthService(context)
  //           .getFormulaireQuestionDataQuickAccess(
  //               questionTypeModel: listQuestionsType[i])
  //           .then((questions) {
  //         listQustionsTypeWithHisQuestions.add(
  //             QuestionTypeWithHisQuestionsModel(
  //                 questionType: listQuestionsType[i], questions: questions!));
  //       });
  //     }
  //     formulaireController.setAllQuestionTypeWithHisQuestionsModel =
  //         listQustionsTypeWithHisQuestions;
  //     //all questions have the same LIEINSPSVR_IDF so i get the first value
  //     formulaireController.set_LIEINSPSVR_IDF =
  //         listQustionsTypeWithHisQuestions[0].questions[0].LIEINSPSVR_IDF;
  //   } catch (e) {
  //     isLoading.value = false;

  //     GBSystem_ManageCatchErrors().catchErrors(
  //       context,
  //       message: e.toString(),
  //       method: "getQuestionsOfTypeAndUpdateController",
  //       page: "GBSystem_list_salaries_causerie_controller",
  //     );
  //   }
  // }

  Future<void> getQuestionsOfTypeAndHisReponsesAndUpdateController({
    required List<QuestionTypeModel> listQuestionsType,
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
      await GBSystem_AuthService(context)
          .getListSalariesFormulaireCauserie(
              site_CLI_IDF:
                  evaluationSurSiteController.getSelectedSite!.CLI_IDF,
              site_LIE_IDF:
                  evaluationSurSiteController.getSelectedSite!.LIE_IDF,
              questionnaire:
                  evaluationSurSiteController.getSelectedQuestionnaire!,
              salaries: listSalarieSelected
                  .map(
                    (e) => e.salarieCauserieModel,
                  )
                  .toList(),
              questionType: formulaireController.getAllQuestionType!.first)
          .then(
            (value) {},
          );
      /////////////////////////////

      // print("final type qst : ${evaluationSurSiteController.get?.length}");
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
