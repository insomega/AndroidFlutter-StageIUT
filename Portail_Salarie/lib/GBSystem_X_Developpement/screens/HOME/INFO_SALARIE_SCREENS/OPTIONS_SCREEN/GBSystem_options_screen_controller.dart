import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemOptionsScreenController extends GetxController {
   RxBool newPasswordValidate = RxBool(false),
      passwordValidatorVisibility = RxBool(false);

  BuildContext context;

  GBSystemOptionsScreenController(this.context);
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerOldPassword = TextEditingController();
  TextEditingController controllerNewPassword = TextEditingController();
  TextEditingController controllerNewPasswordConfirmation =
      TextEditingController();
  RxBool isLoading = RxBool(false);
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool oldPasswordVisibility = false,
      newPasswordConfirmationVisibility = false,
      newPasswordVisibility = false;
  Future changePassword() async {
    isLoading.value = true;
    await GBSystem_AuthService(context)
        .changePasswordMain(
            ancientPass: controllerOldPassword.text,
            newPass: controllerNewPassword.text,
            newPassConf: controllerNewPasswordConfirmation.text,
            )
        .then((value) {
      isLoading.value = false;
      if (value != false) {
        showSuccesDialog(context, GbsSystemStrings.str_password_changed.tr);
      }
    });
  }
}
