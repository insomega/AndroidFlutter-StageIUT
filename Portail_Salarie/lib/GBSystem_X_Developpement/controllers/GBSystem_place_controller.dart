import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/FIND_PLACES_API_MODELS/GBSystem_place_model.dart';

class GBSystemPlaceController extends GetxController {
  List<GbsystemPlaceModel>? _allPlace;
  GbsystemPlaceModel? _currentPlace;

  set setPlace(GbsystemPlaceModel Place) {
    _allPlace?.add(Place);
    update();
  }

  set setCurrentPlace(GbsystemPlaceModel? Place) {
    _currentPlace = Place;
    update();
  }

  set setPlaceToLeft(GbsystemPlaceModel Place) {
    _allPlace?.insert(0, Place);
    update();
  }

  set setPlaceToRight(GbsystemPlaceModel Place) {
    _allPlace?.insert(_allPlace!.length, Place);
    update();
  }

  set setAllPlace(List<GbsystemPlaceModel>? Places) {
    _allPlace = Places;
    update();
  }

  List<GbsystemPlaceModel>? get getAllPlaces => _allPlace;
  GbsystemPlaceModel? get getCurrentPlace => _currentPlace;
}
