import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_prise_de_vacation_model.dart';

class GBSystemPriseDeVacationController extends GetxController {
  List<PriseDeVacationModel>? _allVacations;
  PriseDeVacationModel? _currentVacation;

  set setVacation(PriseDeVacationModel vacation) {
    _allVacations?.add(vacation);
    update();
  }

  set setCurrentVacationVacation(PriseDeVacationModel? vacation) {
    _currentVacation = vacation;
    update();
  }

  set setVacationToLeft(PriseDeVacationModel vacation) {
    _allVacations?.insert(0, vacation);
    update();
  }

  set setVacationToRight(PriseDeVacationModel vacation) {
    _allVacations?.insert(_allVacations!.length, vacation);
    update();
  }

  set setAllVacation(List<PriseDeVacationModel>? vacations) {
    _allVacations = vacations;
    update();
  }

  List<PriseDeVacationModel>? get getAllVacations => _allVacations;
  PriseDeVacationModel? get getCurrentVacation => _currentVacation;
}
