import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';

class GBSystemSalarieController extends GetxController {
  // GBSystemSalarieWithPhotoModel? _salarie;
  Rx<GBSystemSalarieWithPhotoModel?> _salarie =
      Rx<GBSystemSalarieWithPhotoModel?>(null);
  String? _pdf;

  set setSalarie(GBSystemSalarieWithPhotoModel salarie) {
    _salarie.value = salarie;
    update();
  }

  set setPDFSalarie(String pdf) {
    _pdf = pdf;
    update();
  }

  String? get getPDFSalarie => _pdf;

  GBSystemSalarieWithPhotoModel? get getSalarie => _salarie.value;
  Rx<GBSystemSalarieWithPhotoModel?> get getSalarieRx => _salarie;
}
