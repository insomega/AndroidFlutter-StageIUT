import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_error_server_model.dart';

class GBSystemErrorController extends GetxController {
  GbsystemErrorServerModel? _currentError;

  set setCurrentError(GbsystemErrorServerModel? error) {
    _currentError = error;
    update();
  }

  GbsystemErrorServerModel? get getCurrentError => _currentError;
}
