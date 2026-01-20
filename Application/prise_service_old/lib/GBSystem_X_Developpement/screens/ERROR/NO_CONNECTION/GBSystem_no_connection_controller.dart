import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class GBSystem_no_connection_controller extends GetxController {
  
  RxBool _isConnected = RxBool(false);

  GBSystem_no_connection_controller() {
    initConnectivity();
  }

  RxBool get isConnected => _isConnected;

  Future<void> initConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _isConnected = RxBool(true);
    } else {
      _isConnected = RxBool(false);
    }

  }

}