import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_list_qcm_with_his_reponses_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_reponse_qcm_model.dart';

class QCMReponseModel {
  QCMWithHisReponsesModel questionModel;
  ReponseQCMModel selectedReponse;
  QCMReponseModel({required this.questionModel, required this.selectedReponse});
}
