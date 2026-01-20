import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_vacation_model.dart';
import 'package:get/get.dart';

class GBSystemVacationPlanningController extends GetxController {
  List<VacationModel>? _allVacations;
  DateTime? _entrer, _sortie;
  VacationModel? _currentVacation;

  set setVacation(VacationModel vacation) {
    _allVacations?.add(vacation);
    update();
  }

  set setCurrentVacationVacation(VacationModel vacation) {
    _currentVacation = vacation;
    update();
  }

  set setVacationToLeft(VacationModel vacation) {
    _allVacations?.insert(0, vacation);
    update();
  }

  set setVacationToRight(VacationModel vacation) {
    _allVacations?.insert(_allVacations!.length, vacation);
    update();
  }

  set setVacationEntrer(DateTime entrer) {
    _entrer = entrer;
    update();
  }

  set setVacationSortie(DateTime sortie) {
    _sortie = sortie;
    update();
  }

  set setAllVacation(List<VacationModel> vacations) {
    _allVacations = vacations;
    update();
  }

  List<VacationModel>? get getAllVacations => _allVacations;
  VacationModel? get getCurrentVacation => _currentVacation;

  DateTime? get getEntrer => _entrer;
  DateTime? get getSortie => _sortie;
}
