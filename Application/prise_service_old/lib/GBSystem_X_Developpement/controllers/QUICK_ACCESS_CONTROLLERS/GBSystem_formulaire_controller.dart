import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_type_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_question_type_with_his_questions_model.dart';
import 'package:get/get.dart';

class FormulaireController extends GetxController {
  List<QuestionTypeWithHisQuestionsModel>? _listQuestionTypeWithQuestions;
  List<QuestionTypeModel>? _listQuestionType;
  String? _value_LIEINSPSVR_IDF;

  set setNewQuestionTypeWithHisQuestions(
      QuestionTypeWithHisQuestionsModel questionTypeWithQuestions) {
    _listQuestionTypeWithQuestions?.add(questionTypeWithQuestions);
    update();
  }

  set setNewQuestionType(QuestionTypeModel questionType) {
    _listQuestionType?.add(questionType);
    update();
  }

  set set_LIEINSPSVR_IDF(String LIEINSPSVR_IDF) {
    _value_LIEINSPSVR_IDF = LIEINSPSVR_IDF;
    update();
  }

  set setAllQuestionTypeWithHisQuestionsModel(
      List<QuestionTypeWithHisQuestionsModel> listQuestionTypeWithQuestions) {
    _listQuestionTypeWithQuestions = listQuestionTypeWithQuestions;
    update();
  }

  set setAllQuestionType(List<QuestionTypeModel> listQuestionType) {
    _listQuestionType = listQuestionType;
    update();
  }

  List<QuestionTypeWithHisQuestionsModel>?
      get getAllQuestionTypeWithHisQuestionsModel =>
          _listQuestionTypeWithQuestions;
  List<QuestionTypeModel>? get getAllQuestionType => _listQuestionType;

  String? get get_LIEINSPSVR_IDF => _value_LIEINSPSVR_IDF;

  bool isLastQuestionTypeWithHisQuestions(
      QuestionTypeWithHisQuestionsModel QuestionTypeWithHisQuestionsModel) {
    int? indexOfElement = _listQuestionTypeWithQuestions
        ?.indexOf(QuestionTypeWithHisQuestionsModel);
    int? lastIndex = _listQuestionTypeWithQuestions?.length;

    if (indexOfElement != null && lastIndex != null) {
      if (indexOfElement == (lastIndex - 1)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool buttonSuivantVisibility(
      QuestionTypeWithHisQuestionsModel questionTypeWithHisQuestionsModel,
      QuestionModel question) {
    //test if we are in last qst type
    bool isLastQstType = (_listQuestionType
            ?.indexOf(questionTypeWithHisQuestionsModel.questionType) ==
        _listQuestionType?.length);

    bool isLastQuestion =
        (question == questionTypeWithHisQuestionsModel.questions.length);
    print(isLastQuestion);

    return !(isLastQuestion && isLastQstType);
  }
}
