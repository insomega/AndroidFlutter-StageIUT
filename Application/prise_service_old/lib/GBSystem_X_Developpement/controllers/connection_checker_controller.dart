import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_connection_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/ERROR/ACTION_OFFLINE/action_offline_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_local_database_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class ConnectionCheckerController extends GetxController {
  var subscription;

  ConnectionCheckerController();

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
      if (result.isNotEmpty) {
        print(result.first.name);
        GBSystemConnectionSnackBar().afficherSnackBarConnection(
            connectivityResult: result.first,
            whenConnextionReturn: () async {
              bool isActionOfflineExists =
                  (await LocalDatabaseService().getAllStoredRequests() as List)
                      .isNotEmpty;
              print(
                  (await LocalDatabaseService().getAllStoredRequests() as List)
                      .length);
              if (isActionOfflineExists) {
                Get.defaultDialog(
                  title: GbsSystemStrings.str_actions_offline,
                  middleText: GbsSystemStrings.str_question_actions_offline,
                  textCancel: GbsSystemStrings.str_non,
                  textConfirm: GbsSystemStrings.str_oui,
                  onConfirm: () async {
                    print("conf");
                    Get.off(ActionOfflineScreen());
                    // await LocalDatabaseService().retryStoredRequests();
                  },
                  onCancel: () async {
                    print("cancel");
                    // Get.back();
                  },
                );
              }
            });
      }
    });
  }
}
