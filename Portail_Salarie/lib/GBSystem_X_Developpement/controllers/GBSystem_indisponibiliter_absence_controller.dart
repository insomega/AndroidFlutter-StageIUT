import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_indisponibiliter_model.dart';

class GBSystemIndisponibiliterAbsenceController extends GetxController {
  List<IndisponibiliterModel>? _allIndisponibiliter;
  IndisponibiliterModel? _currentIndisponibiliter;

  set setIndisponibiliter(IndisponibiliterModel Indisponibiliter) {
    _allIndisponibiliter?.add(Indisponibiliter);
    update();
  }

  set setCurrentIndisponibiliter(IndisponibiliterModel? Indisponibiliter) {
    _currentIndisponibiliter = Indisponibiliter;
    update();
  }

  set setIndisponibiliterToLeft(IndisponibiliterModel Indisponibiliter) {
    _allIndisponibiliter?.insert(0, Indisponibiliter);
    update();
  }

  set setIndisponibiliterToRight(IndisponibiliterModel Indisponibiliter) {
    _allIndisponibiliter?.insert(_allIndisponibiliter!.length, Indisponibiliter);
    update();
  }

  set setAllIndisponibiliter(List<IndisponibiliterModel>? Indisponibiliters) {
    _allIndisponibiliter = Indisponibiliters;
    update();
  }

  void updateIndisponibiliter(IndisponibiliterModel Indisponibiliter , IndisponibiliterModel newIndisponibiliter)
{
 int index = _allIndisponibiliter!.indexOf(Indisponibiliter);
_allIndisponibiliter![index] = newIndisponibiliter;

update();
}

 void deleteIndisponibiliter(IndisponibiliterModel Indisponibiliter)
{
 int index = _allIndisponibiliter!.indexOf(Indisponibiliter);
_allIndisponibiliter?.removeAt(index);

update();
}

  List<IndisponibiliterModel>? get getAllIndisponibiliters => _allIndisponibiliter;
  IndisponibiliterModel? get getCurrentIndisponibiliter => _currentIndisponibiliter;
}
