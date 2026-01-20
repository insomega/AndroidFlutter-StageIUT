import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_evaluation_model.dart';
import 'package:get/get.dart';

class EvaluationController extends GetxController {
  Rx<EvaluationModel?>? _currentEvaluation = Rx<EvaluationModel?>(null);
  Rx<EvaluationModel?>? _currentEvaluationView = Rx<EvaluationModel?>(null);
  set setCuurentEvaluation(EvaluationModel evaluationModel) {
    _currentEvaluation?.value = evaluationModel;
    update();
  }

  set setCuurentEvaluationView(EvaluationModel evaluationModel) {
    _currentEvaluationView?.value = evaluationModel;
    update();
  }

  EvaluationModel? get getCurrentEvaluation => _currentEvaluation?.value;
  EvaluationModel? get getCurrentEvaluationView =>
      _currentEvaluationView?.value;
}
