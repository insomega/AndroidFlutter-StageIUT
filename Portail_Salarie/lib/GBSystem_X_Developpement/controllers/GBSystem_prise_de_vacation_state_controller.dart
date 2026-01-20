import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_prise_de_vacation_state_model.dart';

class GBSystemPriseDeVacationStateController extends GetxController {
  Rx<List<PriseDeVacationStateModel>?> _allPriseDeVacationsState = Rx<List<PriseDeVacationStateModel>?>(null);
  Rx<PriseDeVacationStateModel?> _currentPriseDeVacationState = Rx<PriseDeVacationStateModel?>(null);
   
  set setVacation(PriseDeVacationStateModel vacation) {
    _allPriseDeVacationsState.value?.add(vacation);
    update();
  }

  set setCurrentVacation(PriseDeVacationStateModel? vacation) {
    _currentPriseDeVacationState.value = vacation;
    update();
  }

  set setVacationToLeft(PriseDeVacationStateModel vacation) {
    _allPriseDeVacationsState.value?.insert(0, vacation);
    update();
  }

  set setVacationToRight(PriseDeVacationStateModel vacation) {
    _allPriseDeVacationsState.value?.insert(_allPriseDeVacationsState.value!.length, vacation);
    update();
  }


  set setAllVacation(List<PriseDeVacationStateModel>? vacations) {
    _allPriseDeVacationsState.value = vacations;
    update();
  }

   Rx<List<PriseDeVacationStateModel>?> get getAllVacationsState => _allPriseDeVacationsState;
  Rx<PriseDeVacationStateModel?> get getCurrentVacationState => _currentPriseDeVacationState;

void updateVacation(PriseDeVacationStateModel vacation , PriseDeVacationStateModel newVacation)
{
 int index = _allPriseDeVacationsState.value!.indexOf(vacation);
_allPriseDeVacationsState.value![index] = newVacation;

update();
}

void removeVacation(PriseDeVacationStateModel vacation)
{
 int index = _allPriseDeVacationsState.value!.indexOf(vacation);
_allPriseDeVacationsState.value!.removeAt(index);

update();
}

}
