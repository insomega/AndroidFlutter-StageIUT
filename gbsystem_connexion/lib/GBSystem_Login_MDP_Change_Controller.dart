import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:gbsystem_root/GBSystem_Storage_Service.dart';

class GBSystem_MDP_Change_Controller extends GBSystem_Root_Controller {
  final GBSystem_Storage_Service _storage = GBSystem_Storage_Service();

  //
  RxBool newPasswordValidate = RxBool(false);
  RxBool passwordValidatorVisibility = RxBool(false);

  final oldPasswordVisibility = false.obs;
  final newPasswordConfirmationVisibility = false.obs;
  final newPasswordVisibility = false.obs;

  void oldPasswordVisibility_Changed() {
    oldPasswordVisibility.value = !oldPasswordVisibility.value;
  }

  void newPasswordConfirmationVisibility_Changed() {
    newPasswordConfirmationVisibility.value = !newPasswordConfirmationVisibility.value;
  }

  void newPasswordVisibility_Changed() {
    newPasswordVisibility.value = !newPasswordVisibility.value;
  }

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<bool> Do_changePassword_To_Server({
    required String email, //
    required String ancientPass, //
    required String newPass,
    required String newPassConf,
  }) async {
    ResponseModel data = await Execute_Server_post(
      data: {
        "OKey": "B0A7449C3A164E1FAFCF68CDF44852E9", //
        "CNX_TYPE": "server",
        "CNX_APPLICATION": "BMSERVER",
        "SVR_CODE": email,
        "SVR_PASSWORD": "",
        "SVR_MAIL": email,
        "SVR_PASS_OLD": ancientPass,
        "SVR_PASS_NEW": newPass,
        "SVR_PASS_CHECK": newPassConf,
      },
    );
    return data.isRequestSucces();
  }

  void Do_changePassword_Valiadation() async {
    if (formKey.currentState!.validate()) {
      await Do_changePassword_To_Server(
        email: emailController.text,
        ancientPass: oldPasswordController.text, //
        newPass: newPasswordController.text,
        newPassConf: confirmPasswordController.text,
      );
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  // final passwordController = TextEditingController();
  final newPasswordFocusNode = FocusNode();

  final showValidator = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.text = _storage.getEmail();
    newPasswordController.addListener(() {
      showValidator.value = newPasswordFocusNode.hasFocus;
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    newPasswordFocusNode.dispose();
    super.onClose();
  }
}
