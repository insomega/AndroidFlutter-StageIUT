import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

class GBSystem_MDP_Oublier_Controller extends GBSystem_Root_Controller {
  @override
  void onInit() {
    super.onInit();
    controllerEmail.text = _storage.getEmail();
  }

  final GBSystem_Storage_Service _storage = GBSystem_Storage_Service();
  // RxBool isLoading = RxBool(false);
  TextEditingController controllerEmail = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final RxnString resetResultMessage = RxnString();

  // Future resetPassword() async {
  //   bool verifier = infoConnexion_URL_S19_Exists();
  //   if (verifier) {
  //     await moteDePasseOublier().then((value) {
  //       if (value != null) {
  //         showSuccesDialog(GBSystem_Application_Strings.str_mail_sended.tr);
  //       }
  //     });
  //   }
  // }

  Future resetPassword(String email) async {
    if (infoConnexion_URL_S19_Exists()) {
      String? result = await moteDePasseOublier(email);
      if (result != null && result != '0') {
        resetResultMessage.value = GBSystem_Application_Strings.str_mail_sended.tr;
      }
    }
  }

  Future<String?> moteDePasseOublier(String email) async {
    ResponseModel data = await Execute_Server_post(
      data: {
        "OKey": GBSystem_System_Strings.okey_ChangePassword,
        // "OKey": "Server,system_user,NEW_PASSWORD",
        "ITEM_CODE": email, //controllerEmail.text,
      },
    );
    if (data.isRequestSucces()) {
      //print(data.data);

      return data.get_Response_ClientData()["ITEM_IDF"];
    } else {
      return '0';
    }
  }

  bool infoConnexion_URL_S19_Exists() {
    bool verifier = false;
    String? str_siteweb = _storage.getsiteWeb();
    if (str_siteweb != null && str_siteweb.isNotEmpty) {
      verifier = true;
    }
    return verifier;
  }
}
