import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class GBSystemInternatController extends GetxController {
  bool _isConnected = false;

  GBSystemInternatController() {
    initConnectivity();
  }

  bool get isConnected => _isConnected;

  Future<void> initConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      _isConnected = true;
    } else {
      _isConnected = false;
    }

    update();
  }
}
