import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemChangePasswordController extends GetxController {
  RxBool newPasswordValidate = RxBool(false),
      passwordValidatorVisibility = RxBool(false);

  BuildContext context;

  GBSystemChangePasswordController(this.context);
  RxBool isLoading = RxBool(false);
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool oldPasswordVisibility = false,
      newPasswordConfirmationVisibility = false,
      newPasswordVisibility = false;
  Future changePassword(
      {required String ancientPass,
      required String newPass,
      required String newPassConf,
      required String mail}) async {
    isLoading.value = true;
    bool verifier = await GBSystem_AuthService(context).verifierExistUrlS19();

    if (verifier) {
      await GBSystem_AuthService(context)
          .changeMotDePasse(
              ancientPass: ancientPass,
              newPass: newPass,
              newPassConf: newPassConf,
              mail: mail)
          .then((value) {
        isLoading.value = false;
        if (value != null) {
          showSuccesDialog(context, GbsSystemStrings.str_password_changed.tr);
        }
      });
    } else {
      isLoading.value = false;
      showErrorDialog(context, GbsSystemStrings.str_saisie_code_client.tr);
    }
  }
}
