import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_entrer_model.dart';
import 'package:get/get.dart';

class GBSystemEntrerController extends GetxController {
  List<EntrerModel>? _allEntrer;

  set setEntrer(EntrerModel enter) {
    _allEntrer?.add(enter);
    update();
  }

  setAllEnter(List<EntrerModel> enters) {
    _allEntrer = enters;
    update();
  }

  List<EntrerModel>? get getAllEnters => _allEntrer;
}
