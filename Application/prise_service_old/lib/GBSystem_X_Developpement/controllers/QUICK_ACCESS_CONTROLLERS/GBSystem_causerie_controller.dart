import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_type_model.dart';
import 'package:get/get.dart';

class CauserieController extends GetxController {
  List<QuestionModel>? _listQuestion;
  List<QuestionTypeModel>? _listQuestionType;
  String? _value_LIEINSPSVR_IDF;

  set setNewQuestion(QuestionModel qcmWithReponses) {
    _listQuestion?.add(qcmWithReponses);
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

  set setAllQuestions(List<QuestionModel> listQuestionQCMWithReponses) {
    _listQuestion = listQuestionQCMWithReponses;
    update();
  }

  set setAllQuestionType(List<QuestionTypeModel> listQuestionType) {
    _listQuestionType = listQuestionType;
    update();
  }

  List<QuestionModel>? get getAllQuestions => _listQuestion;
  List<QuestionTypeModel>? get getAllQuestionType => _listQuestionType;

  String? get get_LIEINSPSVR_IDF => _value_LIEINSPSVR_IDF;
}
