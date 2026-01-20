import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_evaluation_en_cours_model.dart';
import 'package:get/get.dart';

class GbsystemEvaluationEnCoursController extends GetxController {
  List<EvaluationEnCoursModel>? _allEvalEncours;
  Rx<EvaluationEnCoursModel?> _selectedEvalEnCours =
      Rx<EvaluationEnCoursModel?>(null);

  set setSelectedEval(EvaluationEnCoursModel? type) {
    _selectedEvalEnCours.value = type;
    update();
  }

  set setAllEval(List<EvaluationEnCoursModel>? evals) {
    _allEvalEncours = evals;
    update();
  }

  List<EvaluationEnCoursModel>? get getAllEvals => _allEvalEncours;
  Rx<EvaluationEnCoursModel?> get getSelectedEval => _selectedEvalEnCours;
}
