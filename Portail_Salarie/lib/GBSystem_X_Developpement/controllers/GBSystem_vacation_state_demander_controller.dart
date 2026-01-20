import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_state_demander_model.dart';

class GBSystemVacationStateDemanderController extends GetxController {
  Rx<List<VacationStateDemanderModel>?> _allVacationsStateDemander =
      Rx<List<VacationStateDemanderModel>?>(null);
  Rx<VacationStateDemanderModel?> _currentVacationStateDemander =
      Rx<VacationStateDemanderModel?>(null);

  set setVacation(VacationStateDemanderModel vacation) {
    _allVacationsStateDemander.value?.add(vacation);
    update();
  }

  set setCurrentVacationDemander(VacationStateDemanderModel? vacation) {
    _currentVacationStateDemander.value = vacation;
    update();
  }

  set setVacationToLeft(VacationStateDemanderModel vacation) {
    _allVacationsStateDemander.value?.insert(0, vacation);
    update();
  }

  set setVacationToRight(VacationStateDemanderModel vacation) {
    _allVacationsStateDemander.value
        ?.insert(_allVacationsStateDemander.value!.length, vacation);
    update();
  }

  set setAllVacationDemander(List<VacationStateDemanderModel>? vacations) {
    _allVacationsStateDemander.value = vacations;
    update();
  }

  Rx<List<VacationStateDemanderModel>?> get getAllVacationsStateDemander =>
      _allVacationsStateDemander;

  Rx<List<VacationStateDemanderModel>?>
      get getAllVacationsStateDemanderDepasser {
    Rx<List<VacationStateDemanderModel>?> allVacationsStateDepasser =
        Rx<List<VacationStateDemanderModel>?>([]);
    _allVacationsStateDemander.value?.forEach(
      (element) {
        if (element.PLAPSVR_STATE == "DP") {
          allVacationsStateDepasser.value?.add(element);
        }
      },
    );
    return allVacationsStateDepasser;
  }

  Rx<VacationStateDemanderModel?> get getCurrentVacationStateDemander =>
      _currentVacationStateDemander;

  void updateVacation(VacationStateDemanderModel vacation,
      VacationStateDemanderModel newVacation) {
    int index = _allVacationsStateDemander.value!.indexOf(vacation);
    _allVacationsStateDemander.value![index] = newVacation;

    update();
  }
}
