import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_type_model.dart';

class QuestionTypeWithHisQuestionsModel {
  QuestionTypeModel questionType;
  List<QuestionModel> questions;
  QuestionTypeWithHisQuestionsModel(
      {required this.questionType, required this.questions});
}
