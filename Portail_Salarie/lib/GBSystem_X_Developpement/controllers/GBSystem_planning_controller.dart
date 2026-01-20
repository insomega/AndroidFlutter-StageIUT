import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_planning_model.dart';

class GBSystemPlanningController extends GetxController {
  List<PlanningModel>? _allPlannings;
  PlanningModel? _currentPlanning;

  set setPlanning(PlanningModel Planning) {
    _allPlannings?.add(Planning);
    update();
  }

  set setCurrentPlanningPlanning(PlanningModel? Planning) {
    _currentPlanning = Planning;
    update();
  }

  set setPlanningToLeft(PlanningModel Planning) {
    _allPlannings?.insert(0, Planning);
    update();
  }

  set setPlanningToRight(PlanningModel Planning) {
    _allPlannings?.insert(_allPlannings!.length, Planning);
    update();
  }

  set setAllPlanning(List<PlanningModel>? Plannings) {
    _allPlannings = Plannings;
    update();
  }

  List<PlanningModel>? get getAllPlannings => _allPlannings;
  PlanningModel? get getCurrentPlanning => _currentPlanning;
}
