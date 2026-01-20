import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_model.dart';

class GBSystemVacationController extends GetxController {
  List<VacationModel>? _allVacations;
  DateTime? _entrer, _sortie;
  // VacationModel? _currentVacation;
  Rx<VacationModel?> _currentVacation = Rx<VacationModel?>(null);
  Rx<List<VacationModel>> _listCurrentVacation = Rx<List<VacationModel>>([]);

  Rx<int?> _numberVacationProposer = Rx<int?>(null);

  set setVacation(VacationModel vacation) {
    _allVacations?.add(vacation);
    update();
  }

  set setNumberVacationsProposer(int? nbr) {
    _numberVacationProposer.value = nbr;
    update();
  }

  set setCurrentVacationVacation(VacationModel? vacation) {
    _currentVacation.value = vacation;
    update();
  }

  set setCurrentVacationList(VacationModel vacation) {
    _listCurrentVacation.value.add(vacation);
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

  set setAllVacation(List<VacationModel>? vacations) {
    _allVacations = vacations;
    update();
  }

  List<VacationModel>? get getAllVacations => _allVacations;
  VacationModel? get getCurrentVacation => _currentVacation.value;
  Rx<VacationModel?> get getCurrentVacationRx => _currentVacation;

  DateTime? get getEntrer => _entrer;
  DateTime? get getSortie => _sortie;
  Rx<int?> get getNumberVacationProposer => _numberVacationProposer;
  Rx<List<VacationModel>?> get getListCurrentVacation => _listCurrentVacation;
}
