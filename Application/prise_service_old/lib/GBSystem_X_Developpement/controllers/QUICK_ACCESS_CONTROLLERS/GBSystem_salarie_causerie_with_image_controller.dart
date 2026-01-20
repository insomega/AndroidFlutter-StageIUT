import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_photo_causerie_model.dart';
import 'package:get/get.dart';

class GBSystemSalarieCauserieWithImageController extends GetxController {
  List<GBSystemSalarieWithPhotoCauserieModel>? _listSalaries;

  List<GBSystemSalarieWithPhotoCauserieModel>? _listSelectedSalaries;

  set setSalarie(GBSystemSalarieWithPhotoCauserieModel salarie) {
    _listSalaries?.add(salarie);
    update();
  }

  set setSelectedSalarie(GBSystemSalarieWithPhotoCauserieModel salarie) {
    _listSelectedSalaries?.add(salarie);
    update();
  }

  void removeSelectedSalarie(GBSystemSalarieWithPhotoCauserieModel salarie) {
    int index = _listSelectedSalaries!.indexOf(salarie);
    _listSelectedSalaries?.removeAt(index);
    update();
  }

  set setAllSalaries(List<GBSystemSalarieWithPhotoCauserieModel>? salaries) {
    _listSalaries = salaries;
    update();
  }

  set setAllSelectedSalaries(
      List<GBSystemSalarieWithPhotoCauserieModel> salaries) {
    _listSelectedSalaries = [];
    _listSelectedSalaries = salaries;
    update();
  }

  List<GBSystemSalarieWithPhotoCauserieModel>? get getAllSalaries =>
      _listSalaries;
  List<GBSystemSalarieWithPhotoCauserieModel>? get getAllSelectedSalaries =>
      _listSelectedSalaries;
}
