import 'package:flutter/cupertino.dart';
import 'GBSystem_response_model.dart';
//import 'GBSystem_login_screen.dart';
import 'api.dart';
//import 'package:get/get.dart';

class AppManageApi {
  AppManageApi(this.context);
  BuildContext context;
  Future<ResponseModel> post({required String url, required Map<String, String> data, @required String? cookies, @required String? token}) async {
    print('---------------------------------------');
    print(data);
    print('---------------------------------------');
    ResponseModel responseServer = await Api(context).post(url: url, data: data, cookies: cookies, token: token);

    if ((responseServer.data["Data"] as List).isNotEmpty && (responseServer.data["Errors"] as List).isEmpty) {
      return responseServer;
    }
    //Session expire
    else if (responseServer.sessionExpirerCase()
    // responseServer.data["Errors"] != null &&
    //   responseServer.data["Errors"]!.isNotEmpty &&
    //   (responseServer.data["Errors"][0]["DefaultError"][0]["CODE"]) ==
    //       "0538"
    ) {
      // if (Get.isDialogOpen == true ||
      //     Get.isSnackbarOpen == true ||
      //     Get.isBottomSheetOpen == true ||
      //     Get.isOverlaysOpen == true) {
      //   Get.back();
      // }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        //Amar ---Get.offAll(GBSystemLoginScreen());
      });

      return responseServer;
    } else {
      return responseServer;
    }
  }
}
