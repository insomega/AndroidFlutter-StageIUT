import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_gestion_stock_model.dart';
import 'package:get/get.dart';

class GBSystemSalarieGestionStockController extends GetxController {
  List<SalarieGestionStockModel>? _allSalaries;
  List<SalarieGestionStockModel>? _allSelectedSalaries = [];
  Rx<SalarieGestionStockModel?>? _currentSalarie =
      Rx<SalarieGestionStockModel?>(null);
  Rx<SalarieGestionStockModel?>? _currentSelectedSalarie =
      Rx<SalarieGestionStockModel?>(null);

  bool testExistSelected(SalarieGestionStockModel Salarie) {
    bool check = false;
    for (var i = 0; i < (_allSelectedSalaries?.length ?? 0); i++) {
      if (_allSelectedSalaries![i].SVR_IDF == Salarie.SVR_IDF) {
        check = true;
      }
    }
    return check;
  }

  set setSalarie(SalarieGestionStockModel Salarie) {
    _allSalaries?.add(Salarie);
    update();
  }

  set setSelectedSalarieToList(SalarieGestionStockModel SelectedSalarie) {
    if (!testExistSelected(SelectedSalarie)) {
      _allSelectedSalaries?.add(SelectedSalarie);
      update();
    }
  }

  set setAllSelectedSalarie(
      List<SalarieGestionStockModel>? ListSelectedSalarie) {
    _allSelectedSalaries = ListSelectedSalarie;
    update();
  }

  set setCurrentSalarieSalarie(SalarieGestionStockModel? Salarie) {
    _currentSalarie?.value = Salarie;
    update();
  }

  set setCurrentSelectedSalarieSalarie(
      SalarieGestionStockModel? SelectedSalarie) {
    _currentSelectedSalarie?.value = SelectedSalarie;
    update();
  }

  set setSalarieToLeft(SalarieGestionStockModel Salarie) {
    _allSalaries?.insert(0, Salarie);
    update();
  }

  set setSalarieToRight(SalarieGestionStockModel Salarie) {
    _allSalaries?.insert(_allSalaries!.length, Salarie);
    update();
  }

  set setAllSalarie(List<SalarieGestionStockModel>? Salaries) {
    _allSalaries = Salaries;
    update();
  }

  void deleteSelectedSalarie(SalarieGestionStockModel salarie) {
    int index = _allSelectedSalaries!.indexOf(salarie);
    _allSelectedSalaries?.removeAt(index);

    update();
  }

  List<SalarieGestionStockModel>? get getAllSalaries => _allSalaries;
  SalarieGestionStockModel? get getCurrentSalarie => _currentSalarie?.value;
  Rx<SalarieGestionStockModel?>? get getCurrentSalarieRx => _currentSalarie;

  List<SalarieGestionStockModel>? get getAllSelectedSalaries =>
      _allSelectedSalaries;
  SalarieGestionStockModel? get getCurrentSelectedSalarie =>
      _currentSelectedSalarie?.value;
  Rx<SalarieGestionStockModel?>? get getCurrentSelectedSalarieRx =>
      _currentSelectedSalarie;
}
