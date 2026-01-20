import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_absence_model.dart';

class GBSystemAbsenceController extends GetxController {
   Rx<List<AbsenceModel>?>? _allAbsences = Rx<List<AbsenceModel>?>(null);
Rx<AbsenceModel?>? _currentAbsence = Rx<AbsenceModel?>(null);

  set setAbsence(AbsenceModel Absence) {
    _allAbsences?.value?.add(Absence);
    update();
  }

  set setCurrentAbsenceAbsence(AbsenceModel? Absence) {
    _currentAbsence?.value = Absence;
    update();
  }

  set setAbsenceToLeft(AbsenceModel Absence) {
    _allAbsences?.value?.insert(0, Absence);
    update();
  }

  set setAbsenceToRight(AbsenceModel Absence) {
    _allAbsences?.value?.insert(_allAbsences!.value!.length, Absence);
    update();
  }

  set setAllAbsence(List<AbsenceModel>? Absences) {
    _allAbsences?.value = Absences;
    update();
  }

  List<AbsenceModel>? get getAllAbsences => _allAbsences?.value;
  AbsenceModel? get getCurrentAbsence => _currentAbsence?.value;
}
