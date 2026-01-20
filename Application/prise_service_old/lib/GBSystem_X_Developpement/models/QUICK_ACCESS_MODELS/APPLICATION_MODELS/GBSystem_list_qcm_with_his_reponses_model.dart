import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_type_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_reponse_qcm_model.dart';

class QCMWithHisReponsesModel {
  QuestionTypeModel questionTypeModel;
  QuestionModel qcmQuestion;
  List<ReponseQCMModel> reponses;
  bool questionsFocus;

  QCMWithHisReponsesModel(
      {required this.qcmQuestion,
      required this.reponses,
      required this.questionTypeModel,
      required this.questionsFocus});
}
