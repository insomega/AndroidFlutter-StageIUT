import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_model.dart';
import 'package:get/get.dart';

class GBSystemSalarieController extends GetxController {
  SalarieModel? _salarie;
  String? _imageSalarie;

  set setSalarie(SalarieModel salarie) {
    _salarie = salarie;
    update();
  }

  SalarieModel? get getSalarie => _salarie;

  set setImage(String imageUrl) {
    _imageSalarie = imageUrl;
    update();
  }

  String? get getImage => _imageSalarie;
}
