import 'package:get/get.dart';
import 'GBSystem_vacation_state_model.dart';

class GBSystemVacationStateController extends GetxController {
  Rx<List<VacationStateModel>?> _allVacationsState = Rx<List<VacationStateModel>?>(null);
  Rx<VacationStateModel?> _currentVacationState = Rx<VacationStateModel?>(null);

  set setVacation(VacationStateModel vacation) {
    _allVacationsState.value?.add(vacation);
    update();
  }

  set setCurrentVacationVacation(VacationStateModel? vacation) {
    _currentVacationState.value = vacation;
    update();
  }

  set setVacationToLeft(VacationStateModel vacation) {
    _allVacationsState.value?.insert(0, vacation);
    update();
  }

  set setVacationToRight(VacationStateModel vacation) {
    _allVacationsState.value?.insert(_allVacationsState.value!.length, vacation);
    update();
  }

  set setAllVacation(List<VacationStateModel>? vacations) {
    _allVacationsState.value = vacations;
    update();
  }

  Rx<List<VacationStateModel>?> get getAllVacations => _allVacationsState;
  Rx<List<VacationStateModel>?> get getAllVacationsEnAttente {
    Rx<List<VacationStateModel>?> allVacationsStateEnAttente = Rx<List<VacationStateModel>?>([]);
    _allVacationsState.value?.forEach((element) {
      if (element.STATE == "str_en_attente") {
        allVacationsStateEnAttente.value?.add(element);
      }
    });

    return allVacationsStateEnAttente;
  }

  Rx<List<VacationStateModel>?> get getAllVacationsOthers {
    Rx<List<VacationStateModel>?> allVacationsStateOthers = Rx<List<VacationStateModel>?>([]);
    _allVacationsState.value?.forEach((element) {
      if (element.STATE != "str_en_attente") {
        allVacationsStateOthers.value?.add(element);
      }
    });

    return allVacationsStateOthers;
  }

  Rx<VacationStateModel?> get getCurrentVacation => _currentVacationState;

  void updateVacation(VacationStateModel vacation, VacationStateModel newVacation) {
    int index = _allVacationsState.value!.indexOf(vacation);
    _allVacationsState.value![index] = newVacation;

    update();
  }
}
