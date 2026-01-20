import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_shift_model.dart';

class GBSystemVacationShiftController extends GetxController {
  List<VacationShiftModel>? _allVacationsShift;
  VacationShiftModel? _currentVacationShift;
   Rx<DateTime?> _currentDateDebut = Rx<DateTime?>(null);
   Rx<DateTime?> _currentDateFin = Rx<DateTime?>(null);
  
  set setVacationShift(VacationShiftModel vacation) {
    _allVacationsShift?.add(vacation);
    update();
  }

  set setCurrentVacationShift(VacationShiftModel? vacation) {
    _currentVacationShift = vacation;
    update();
  }

   set setCurrentDateDebut(DateTime? debut) {
    _currentDateDebut.value = debut;
    update();
  }
  set setCurrentDateFin(DateTime? fin) {
    _currentDateFin.value = fin;
    update();
  }

  set setVacationToLeft(VacationShiftModel vacation) {
    _allVacationsShift?.insert(0, vacation);
    update();
  }

  set setVacationToRight(VacationShiftModel vacation) {
    _allVacationsShift?.insert(_allVacationsShift!.length, vacation);
    update();
  }


  set setAllVacationShift(List<VacationShiftModel>? vacations) {
    _allVacationsShift = vacations;
    update();
  }

  List<VacationShiftModel>? get getAllVacationsShift => _allVacationsShift;
  VacationShiftModel? get getCurrentVacationShift => _currentVacationShift;
   Rx<DateTime?> get getCurrentDateDebut => _currentDateDebut;
    Rx<DateTime?> get getCurrentDateFin => _currentDateFin;
}
