import 'GBSystem_error_server_model.dart';
import 'package:get/get.dart';

class GBSystemErrorController extends GetxController {
  GbsystemErrorServerModel? _currentError;

  set setCurrentError(GbsystemErrorServerModel? error) {
    _currentError = error;
    update();
  }

  GbsystemErrorServerModel? get getCurrentError => _currentError;
}
