import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_error_server_model.dart';

class GBSystemErrorController extends GetxController {
  GbsystemErrorServerModel? _currentError;

  set setCurrentError(GbsystemErrorServerModel? error) {
    _currentError = error;
    update();
  }

  GbsystemErrorServerModel? get getCurrentError => _currentError;
}
