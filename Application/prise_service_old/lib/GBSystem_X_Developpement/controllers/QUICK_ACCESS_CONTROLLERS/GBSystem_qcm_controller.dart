import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_list_qcm_with_his_reponses_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_type_model.dart';
import 'package:get/get.dart';

class QCMController extends GetxController {
  List<QCMWithHisReponsesModel>? _listQCMWithReponses;
  List<QuestionTypeModel>? _listQCM;
  String? _value_LIEINSPSVR_IDF;

  set setNewQCMWithHisReponses(QCMWithHisReponsesModel qcmWithReponses) {
    _listQCMWithReponses?.add(qcmWithReponses);
    update();
  }

  set setNewQuestionQCM(QuestionTypeModel questionType) {
    _listQCM?.add(questionType);
    update();
  }

  set set_LIEINSPSVR_IDF(String LIEINSPSVR_IDF) {
    _value_LIEINSPSVR_IDF = LIEINSPSVR_IDF;
    update();
  }

  set setAllQCMWithHisReponses(
      List<QCMWithHisReponsesModel> listQuestionQCMWithReponses) {
    _listQCMWithReponses = listQuestionQCMWithReponses;
    update();
  }

  set setAllQuestionQCM(List<QuestionTypeModel> listQuestionType) {
    _listQCM = listQuestionType;
    update();
  }

  List<QCMWithHisReponsesModel>? get getAllQCMWithHisReponses =>
      _listQCMWithReponses;
  List<QuestionTypeModel>? get getAllQuestionQCM => _listQCM;

  String? get get_LIEINSPSVR_IDF => _value_LIEINSPSVR_IDF;
}
