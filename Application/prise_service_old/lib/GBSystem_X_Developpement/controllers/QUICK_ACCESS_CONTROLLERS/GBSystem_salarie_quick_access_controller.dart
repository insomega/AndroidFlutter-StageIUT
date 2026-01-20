import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_quick_acces_model.dart';
import 'package:get/get.dart';

class GBSystemSalarieQuickAccessController extends GetxController {
  SalarieQuickAccessModel? _salarie;
  String? _imageSalarie;

  set setSalarie(SalarieQuickAccessModel salarie) {
    _salarie = salarie;
    update();
  }

  SalarieQuickAccessModel? get getSalarie => _salarie;

  set setImage(String imageUrl) {
    _imageSalarie = imageUrl;
    update();
  }

  String? get getImage => _imageSalarie;
}
