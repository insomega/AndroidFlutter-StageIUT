import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_absence_model.dart';

class GBSystemTypeAbsenceIndisponibiliterController extends GetxController {
   Rx<List<TypeAbsenceModel>?>? _allTypes = Rx<List<TypeAbsenceModel>?>(null);
 Rx<TypeAbsenceModel?>? _currentType = Rx<TypeAbsenceModel?>(null);

  set setTypeAbsenceIndisponibiliter(TypeAbsenceModel TypeAbsence) {
    _allTypes?.value?.add(TypeAbsence);
    update();
  }

  set setCurrentTypeAbsenceIndisponibiliter(TypeAbsenceModel? TypeAbsence) {
    _currentType?.value = TypeAbsence;
    update();
  }

  set setTypeAbsenceToLeft(TypeAbsenceModel TypeAbsence) {
    _allTypes?.value?.insert(0, TypeAbsence);
    update();
  }

  set setTypeAbsenceToRight(TypeAbsenceModel TypeAbsence) {
    _allTypes?.value?.insert(_allTypes!.value!.length, TypeAbsence);
    update();
  }

  set setAllTypeAbsence(List<TypeAbsenceModel>? TypeAbsences) {
    _allTypes?.value = TypeAbsences;
    update();
  }

  List<TypeAbsenceModel>? get getAllTypeAbsencesIndisponibiliter => _allTypes?.value;
  TypeAbsenceModel? get getCurrentTypeAbsenceIndisponibiliter => _currentType?.value;
}
