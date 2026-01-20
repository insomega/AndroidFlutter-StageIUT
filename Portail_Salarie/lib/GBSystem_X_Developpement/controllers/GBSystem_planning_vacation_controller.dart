import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_planning_vacation_model.dart';

class GBSystemPlanningVacationController extends GetxController {
  List<PlanningVacationModel>? _allVacations;
  PlanningVacationModel? _currentVacation;
  RxBool _showPrec = RxBool(true);

  set setVacation(PlanningVacationModel vacation) {
    _allVacations?.add(vacation);
    update();
  }

  set setCurrentVacationVacation(PlanningVacationModel? vacation) {
    _currentVacation = vacation;
    update();
  }

  set setVacationToLeft(PlanningVacationModel vacation) {
    _allVacations?.insert(0, vacation);
    update();
  }

  set setVacationToRight(PlanningVacationModel vacation) {
    _allVacations?.insert(_allVacations!.length, vacation);
    update();
  }

  set setAllVacation(List<PlanningVacationModel>? vacations) {
    _allVacations = vacations;
    update();
  }

  set addListVacation(List<PlanningVacationModel>? vacations) {
    vacations?.forEach(
      (element) => _allVacations?.add(element),
    );
    update();
  }

  set setPrecBool(bool precBool) {
    _showPrec.value = precBool;
    update();
  }

  List<PlanningVacationModel>? get getAllVacations => _allVacations;
  PlanningVacationModel? get getCurrentVacation => _currentVacation;
  RxBool get getPrecBool => _showPrec;
}
