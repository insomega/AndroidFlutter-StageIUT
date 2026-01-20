import 'GBSystem_question_model.dart';
import 'GBSystem_question_type_model.dart';

class QuestionTypeWithHisQuestionsModel {
  QuestionTypeModel questionType;
  List<QuestionModel> questions;
  QuestionTypeWithHisQuestionsModel({required this.questionType, required this.questions});
}
