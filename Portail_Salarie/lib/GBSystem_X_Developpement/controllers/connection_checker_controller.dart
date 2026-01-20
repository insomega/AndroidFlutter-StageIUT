import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_connection_snack_bar.dart';

class ConnectionCheckerController extends GetxController {
  var subscription;

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
          if(result.isNotEmpty){
 GBSystemConnectionSnackBar().afficherSnackBarConnection(result.first);
          }
     
    });
  }
}
