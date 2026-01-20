import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemResetPasswordController extends GetxController {
  BuildContext context;
  RxBool isLoading = RxBool(false);
  GBSystemResetPasswordController(this.context);
  TextEditingController controllerEmail = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  Future resetPassword() async {
    isLoading.value = true;

    bool verifier = await GBSystem_AuthService(context).verifierExistUrlS19();
    if (verifier) {
      await GBSystem_AuthService(context)
          .moteDePasseOublier(mail: controllerEmail.text)
          .then((value) {
        isLoading.value = false;
        if (value != null) {
          showSuccesDialog(context, GbsSystemStrings.str_mail_sended.tr);
        }
      });
    } else {
      isLoading.value = false;
      showErrorDialog(context, GbsSystemStrings.str_saisie_code_client.tr);
    }
  }
}
