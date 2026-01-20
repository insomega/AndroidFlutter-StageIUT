import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/qcm_reponse_model.dart';
import 'package:get/get.dart';

class QCMWidgetController extends GetxController {
  Rx<List<QCMReponseModel>> selectedReponseList = Rx<List<QCMReponseModel>>([]);

  void updateSelectedReponse({
    required QCMReponseModel questionWithSelectedReponse,
  }) {
    bool alreadySelected = false;
    for (var i = 0; i < selectedReponseList.value.length; i++) {
      if (selectedReponseList.value[i].questionModel ==
          questionWithSelectedReponse.questionModel) {
        alreadySelected = true;
        selectedReponseList.value[i] = questionWithSelectedReponse;
        break;
      }
    }
    if (alreadySelected == false) {
      selectedReponseList.value.add(questionWithSelectedReponse);
    }
  }
}
