import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_formulaire_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_qcm_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_salarie_quick_access_with_image_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_list_qcm_with_his_reponses_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/evaluation_status_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_memo_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_type_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_quick_acces_with_image_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_question_type_with_his_questions_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/formulaire_signature_page/GBSystem_formulaire_signature_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_local_database_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemListSalariesController extends GetxController {
  BuildContext context;
  GBSystemListSalariesController({required this.context});

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();

  RxBool isLoading = false.obs;
  final FormulaireController formulaireController =
      Get.put(FormulaireController());
  final QCMController qcmController = Get.put(QCMController());
  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());
  final GBSystemSalarieQuickAccessWithImageController
      salarieQuickAccessWithImageController =
      Get.put(GBSystemSalarieQuickAccessWithImageController());

  List<GBSystemSalarieQuickAccessWithPhotoModel> usedListSalaries() {
    List<GBSystemSalarieQuickAccessWithPhotoModel> tempList =
        (salarieQuickAccessWithImageController.getAllSalaries ?? []);
    List<GBSystemSalarieQuickAccessWithPhotoModel> resultList = [];

    if (text?.value != null && text!.value.isNotEmpty) {
      // 1 test with lower case
      // 2 show empty data
      resultList = tempList
          .where(
            (element) => element.salarieModel.SVR_LIB
                .toLowerCase()
                .contains(text!.value.toLowerCase()),
          )
          .toList();
    } else {
      resultList = tempList;
    }

    return resultList;
  }

  Future getQCMData(
      {required GBSystemSalarieQuickAccessWithPhotoModel salarie}) async {
    try {
      isLoading.value = true;

      await GBSystem_AuthService(context)
          .getFormulaireQuestionsTypeDataQuickAccess(
        CLI_IDF: salarie.salarieModel.CLI_IDF,
        SVR_IDF: salarie.salarieModel.SVR_IDF,
        LIE_IDF: salarie.salarieModel.LIE_IDF,
        LIEINSPQSNR_IDF: evaluationSurSiteController
                .getSelectedQuestionnaire?.LIEINSPQSNR_IDF ??
            "1",
        // salarie: salarie.salarieModel
      )
          .then((questionTypeList) async {
        if (questionTypeList != null) {
          print("qsttype qcm ${questionTypeList.length}");
          await getQuestionsOfTypeAndHisReponsesAndUpdateController(
                  listQuestionsType: questionTypeList)
              .then((value) {
            isLoading.value = false;
// eval status
            final status = LocalDatabaseService.getByIdfEval(
                formulaireController.get_LIEINSPSVR_IDF ?? "");
            EvaluationStatus? oldStatus;
            if (status != null) {
              oldStatus = EvaluationStatus(
                LIEINSPSVR_IDF: status['LIEINSPSVR_IDF'] as String,
                questionIndex: status['questionIndex'] as int,
                questionTypeIndex: status['questionTypeIndex'] as int,
              );
            }

            Get.to(
              GBSystemFormulaireSignatureScreen(
                evaluationStatus: oldStatus,
                evaluationEnCoursModel_LIEINSPSVR_IDF:
                    formulaireController.get_LIEINSPSVR_IDF ?? "",
                salarie_idf: salarie.salarieModel.SVR_IDF,
                salarie_lib: salarie.salarieModel.SVR_LIB,
              ),
            );
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
        method: "getQCMData",
        page: "GBSystem_list_salaries_controller",
      );
    }
  }

  Future getFormulaireData(
      {required GBSystemSalarieQuickAccessWithPhotoModel salarie}) async {
    try {
      isLoading.value = true;

      await GBSystem_AuthService(context)
          .getFormulaireQuestionsTypeDataQuickAccess(
        CLI_IDF: salarie.salarieModel.CLI_IDF,
        SVR_IDF: salarie.salarieModel.SVR_IDF,
        LIE_IDF: salarie.salarieModel.LIE_IDF,
        LIEINSPQSNR_IDF: evaluationSurSiteController
                .getSelectedQuestionnaire?.LIEINSPQSNR_IDF ??
            "1",
        // salarie: salarie.salarieModel
      )
          .then((questionTypeList) async {
        if (questionTypeList != null) {
          await getQuestionsOfTypeAndUpdateController(
                  listQuestionsType: questionTypeList)
              .then((value) {
            isLoading.value = false;
// eval status
            final status = LocalDatabaseService.getByIdfEval(
                formulaireController.get_LIEINSPSVR_IDF ?? "");
            EvaluationStatus? oldStatus;
            if (status != null) {
              oldStatus = EvaluationStatus(
                LIEINSPSVR_IDF: status['LIEINSPSVR_IDF'] as String,
                questionIndex: status['questionIndex'] as int,
                questionTypeIndex: status['questionTypeIndex'] as int,
              );
            }
            Get.to(
              GBSystemFormulaireSignatureScreen(
                evaluationStatus: oldStatus,
                evaluationEnCoursModel_LIEINSPSVR_IDF:
                    formulaireController.get_LIEINSPSVR_IDF ?? "",
                salarie_idf: salarie.salarieModel.SVR_IDF,
                salarie_lib: salarie.salarieModel.SVR_LIB,
              ),
            );
          }).catchError((e) {
            isLoading.value = false;

            showErrorDialog(context, e.toString());
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
        method: "getFormulaireData",
        page: "GBSystem_list_salaries_controller",
      );
    }
  }

  Future<void> getQuestionsOfTypeAndUpdateController(
      {required List<QuestionTypeModel> listQuestionsType}) async {
    try {
      List<QuestionTypeWithHisQuestionsModel> listQustionsTypeWithHisQuestions =
          [];
      for (var i = 0; i < listQuestionsType.length; i++) {
        await GBSystem_AuthService(context)
            .getFormulaireQuestionDataQuickAccess(
                questionTypeModel: listQuestionsType[i])
            .then((questions) {
          listQustionsTypeWithHisQuestions
              .add(QuestionTypeWithHisQuestionsModel(
                  questionType: listQuestionsType[i],
                  //  questions: questions!
                  questions: filtreMemoQuestion(questions!)));
        });
      }
      formulaireController.setAllQuestionTypeWithHisQuestionsModel =
          listQustionsTypeWithHisQuestions;
      //all questions have the same LIEINSPSVR_IDF so i get the first value
      formulaireController.set_LIEINSPSVR_IDF =
          listQustionsTypeWithHisQuestions[0]
              .questions[0]
              .questionWithoutMemoModel
              .LIEINSPSVR_IDF;
    } catch (e) {
      isLoading.value = false;

      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "getQuestionsOfTypeAndUpdateController",
        page: "GBSystem_list_salaries_controller",
      );
    }
  }

  Future<void> getQuestionsOfTypeAndHisReponsesAndUpdateController(
      {required List<QuestionTypeModel> listQuestionsType}) async {
    try {
      List<QCMWithHisReponsesModel> listQuestionsWithReponses = [];
      for (var i = 0; i < listQuestionsType.length; i++) {
        await GBSystem_AuthService(context)
            .getFormulaireQuestionDataQuickAccess(
                questionTypeModel: listQuestionsType[i])
            .then((questions) async {
          if (questions != null) {
            for (var j = 0; j < questions.length; j++) {
              await GBSystem_AuthService(context)
                  .getQCMQuestionReponsesDataQuickAccess(
                      questionModel: questions[j])
                  .then((reponses) {
                if (reponses != null) {
                  listQuestionsWithReponses.add(QCMWithHisReponsesModel(
                      questionsFocus: true,
                      questionTypeModel: listQuestionsType[i],
                      qcmQuestion: questions[j],
                      reponses: reponses));
                }
              });
            }
          }
        });
      }
      qcmController.setAllQCMWithHisReponses = listQuestionsWithReponses;
      //all questions have the same LIEINSPSVR_IDF so i get the first value
      formulaireController.set_LIEINSPSVR_IDF = listQuestionsWithReponses[0]
          .qcmQuestion
          .questionWithoutMemoModel
          .LIEINSPSVR_IDF;
    } catch (e) {
      isLoading.value = false;

      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "getQuestionsOfTypeAndHisReponsesAndUpdateController",
        page: "GBSystem_list_salaries_controller",
      );
    }
  }

  List<QuestionModel> filtreMemoQuestion(List<QuestionModel> oldQuestions) {
    // List<QuestionModel> newQuestions = [];
    // List<MemoQuestionModel>? newListMemo = [];
    // for (var i = 0; i < oldQuestions.length; i++) {
    //   newListMemo = [];
    //   List<MemoQuestionModel>? oldListMemo = oldQuestions[i].LIEINSQMMO;
    //   for (var j = 0; j < (oldListMemo?.length ?? 0); j++) {
    //     if (!checkExistMemo(list: newListMemo, element: oldListMemo![j])) {
    //       newListMemo.add(oldListMemo[j]);
    //     }
    //   }
    //   newQuestions.add(QuestionModel(
    //       nombreImages: 0,
    //       LIEINSQMMO: newListMemo,
    //       questionWithoutMemoModel: oldQuestions[i].questionWithoutMemoModel));
    // }
    // return newQuestions;
    return oldQuestions;
  }

  bool checkExistMemo(
      {required List<MemoQuestionModel> list,
      required MemoQuestionModel element}) {
    bool check = false;
    for (var i = 0; i < list.length; i++) {
      if (list[i].LIEINSMMO_IDF == element.LIEINSMMO_IDF &&
          list[i].LIEINSMMO_CODE == element.LIEINSMMO_CODE &&
          list[i].LIEINSMMO_LIB == element.LIEINSMMO_LIB) {
        check = true;
      }
    }
    return check;
  }
}
