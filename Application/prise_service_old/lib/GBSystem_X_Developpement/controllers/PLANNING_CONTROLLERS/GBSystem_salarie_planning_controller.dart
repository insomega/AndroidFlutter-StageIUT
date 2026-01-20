import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_planning_model.dart';
import 'package:get/get.dart';

class GBSystemSalariePlanningController extends GetxController {
  
   List<SalariePlanningModel>? _allSalaries ;
  Rx<SalariePlanningModel?> _currentSalarie = Rx<SalariePlanningModel?>(null);

  set setCurrentSalarie(SalariePlanningModel salarie) {
    _currentSalarie.value = salarie;
    update();
  }

  set setSalarie(SalariePlanningModel salarie) {
    _allSalaries?.add(salarie);
     update();
  }

 set setAllSalaries(List<SalariePlanningModel> salaries) {
    _allSalaries=salaries;
     update();
  }
  List<SalariePlanningModel>? get getAllSalaries => _allSalaries;
  SalariePlanningModel? get getCurrentSalarie => _currentSalarie.value;

}