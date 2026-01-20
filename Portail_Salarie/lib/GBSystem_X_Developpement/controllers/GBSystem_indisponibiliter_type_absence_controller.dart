import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_absence_model.dart';

class GBSystemIndisponibiliterTypeAbsenceController extends GetxController {
  TypeAbsenceModel? _indisponibiliter;

  set setIndisponibiliter(TypeAbsenceModel Indisponibiliter) {
    _indisponibiliter = Indisponibiliter;
    update();
  }

  TypeAbsenceModel? get getIndisponibiliter => _indisponibiliter;
}
