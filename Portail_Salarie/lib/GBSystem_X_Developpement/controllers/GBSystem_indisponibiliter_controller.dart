import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_absence_model.dart';

class GBSystemIndisponibiliterController extends GetxController {
  List<AbsenceModel>? _allIndisponibiliter;
  AbsenceModel? _currentIndisponibiliter;

  set setIndisponibiliter(AbsenceModel Indisponibiliter) {
    _allIndisponibiliter?.add(Indisponibiliter);
    update();
  }

  set setCurrentIndisponibiliter(AbsenceModel? Indisponibiliter) {
    _currentIndisponibiliter = Indisponibiliter;
    update();
  }

  set setIndisponibiliterToLeft(AbsenceModel Indisponibiliter) {
    _allIndisponibiliter?.insert(0, Indisponibiliter);
    update();
  }

  set setIndisponibiliterToRight(AbsenceModel Indisponibiliter) {
    _allIndisponibiliter?.insert(_allIndisponibiliter!.length, Indisponibiliter);
    update();
  }

  set setAllIndisponibiliter(List<AbsenceModel>? Indisponibiliters) {
    _allIndisponibiliter = Indisponibiliters;
    update();
  }

  List<AbsenceModel>? get getAllIndisponibiliters => _allIndisponibiliter;
  AbsenceModel? get getCurrentIndisponibiliter => _currentIndisponibiliter;
}
