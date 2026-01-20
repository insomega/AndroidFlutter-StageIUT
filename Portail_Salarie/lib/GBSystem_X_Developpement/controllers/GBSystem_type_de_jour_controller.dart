import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_de_jour_model.dart';

class GBSystemTypeDeJourController extends GetxController {
  List<TypeDeJourModel>? _allTypeDeJour;
  TypeDeJourModel? _currentTypeDeJour;

  set setTypeDeJour(TypeDeJourModel TypeDeJour) {
    _allTypeDeJour?.add(TypeDeJour);
    update();
  }

  set setCurrentTypeDeJour(TypeDeJourModel? TypeDeJour) {
    _currentTypeDeJour = TypeDeJour;
    update();
  }

  set setTypeDeJourToLeft(TypeDeJourModel TypeDeJour) {
    _allTypeDeJour?.insert(0, TypeDeJour);
    update();
  }

  set setTypeDeJourToRight(TypeDeJourModel TypeDeJour) {
    _allTypeDeJour?.insert(_allTypeDeJour!.length, TypeDeJour);
    update();
  }

  set setAllTypeDeJour(List<TypeDeJourModel>? TypeDeJours) {
    _allTypeDeJour = TypeDeJours;
    update();
  }

  List<TypeDeJourModel>? get getAllTypeDeJours => _allTypeDeJour;
  TypeDeJourModel? get getCurrentTypeDeJour => _currentTypeDeJour;
}
