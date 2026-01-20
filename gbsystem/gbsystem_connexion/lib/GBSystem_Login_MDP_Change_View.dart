import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'GBSystem_Login_MDP_Change_Controller.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
//import 'package:gbsystem_root/GBSystem_custom_text_field.dart';
import 'package:gbsystem_root/custom_app_bar.dart';
import 'package:gbsystem_root/custom_button.dart';
import 'package:gbsystem_root/GBSystem_TextField_Email.dart';
import 'package:gbsystem_root/GBSystem_TextField_Password.dart';
import 'package:gbsystem_root/GBSystem_Root_Params.dart';

import 'validator_de.dart';
import 'validator_en.dart';
import 'validator_es.dart';
import 'validator_fr.dart';
import 'validator_gr.dart';
import 'validator_pt.dart';
import 'validator_ro.dart';
import 'validator_tr.dart';

class GBSystem_MDP_Change_View extends GetView<GBSystem_MDP_Change_Controller> {
  const GBSystem_MDP_Change_View({super.key});

  Widget _buildHeader(BuildContext context) {
    final AppParams = GBSystem_Application_Params_Manager.instance;
    return Container(
      width: GBSystem_ScreenHelper.screenWidth(context),
      height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.3),
      decoration: const BoxDecoration(color: GBSystem_Application_Strings.str_primary_color),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(-5, 0),
              child: Image.asset(
                GBSystem_System_Strings.str_logo_image_path, //
                color: Colors.white,
                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.4),
                height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.3),
              ),
            ),
            GBSystem_TextHelper().largeText(
              text: AppParams.Title, //
              textColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordFields(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          context, //
          controller: controller.emailController,
          label: GBSystem_Application_Strings.str_mail.tr,
        ),
        _buildPasswordField(
          context,
          controller: controller.oldPasswordController,
          //  focusNode: null,
          label: GBSystem_Application_Strings.str_old_password.tr,
          //visibility: controller.oldPasswordVisibility,

          //onVisibilityChanged: controller.oldPasswordVisibility_Changed,
          //  () => () {
          //   controller.oldPasswordVisibility.value = !controller.oldPasswordVisibility.value;
          // },
          //validator: _validatePassword,
        ),
        _buildPasswordField(
          context,
          controller: controller.newPasswordController,
          //focusNode: controller.newPasswordFocusNode,
          label: GBSystem_Application_Strings.str_new_password.tr,
          //visibility: controller.newPasswordVisibility,

          //onVisibilityChanged: controller.newPasswordVisibility_Changed,
          // () => () {
          //   controller.newPasswordVisibility.value = !controller.newPasswordVisibility.value;
          // },
          // validator: (value) => controller.newPasswordValidate.value ? null : "",
        ),

        Obx(
          () => controller.showValidator.value
              ? FlutterPwValidator(
                  strings: getTranslatValidator(Get.locale),
                  successColor: Colors.green,
                  failureColor: Colors.red,
                  defaultColor: GBSystem_Application_Strings.str_primary_color,
                  controller: controller.newPasswordController,
                  minLength: 8,
                  uppercaseCharCount: 1,
                  lowercaseCharCount: 1,
                  numericCharCount: 1,
                  specialCharCount: 1,
                  width: GBSystem_ScreenHelper.screenWidth(context),
                  height: 170,
                  onSuccess: () => controller.newPasswordValidate.value = true,
                  onFail: () => controller.newPasswordValidate.value = false,
                )
              : const SizedBox.shrink(),
        ),
        _buildPasswordField(
          context,
          controller: controller.confirmPasswordController,
          //   focusNode: null,
          label: GBSystem_Application_Strings.str_new_password_confirmation.tr,
          // visibility: controller.newPasswordConfirmationVisibility,

          //onVisibilityChanged: controller.newPasswordConfirmationVisibility_Changed,

          //validator: (value) => _validateConfirmPassword(value, controller.newPasswordController.text),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, {required TextEditingController controller, required String label}) {
    return GBSystem_TextField_Email(
      controller: controller, //
      labelText: label,
    );
    // return Padding(
    //   padding: EdgeInsets.only(bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
    //   child: GBSystem_TextField_Email(
    //     controller: controller, //
    //     labelText: label,
    //   ),
    // );

    // return Padding(
    //   padding: EdgeInsets.only(bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
    //   child: CustomTextField(
    //     controller: controller, //
    //     validator: validator,
    //     keyboardType: keyboardType,
    //     text: label,
    //   ),
    // );
  }

  Widget _buildPasswordField(
    BuildContext context, {
    required TextEditingController controller, //
    //required FocusNode? focusNode, //
    required String label,
    //required RxBool visibility,
    //required VoidCallback onVisibilityChanged,
    //required String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
      child: GBSystem_TextField_Password(text: label, controller: controller),
    );

    // return Obx(() {
    //   return Padding(
    //     padding: EdgeInsets.only(bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
    //     child: CustomTextField(
    //       controller: controller,
    //       focusNode: focusNode,
    //       text: label,
    //       suffixIcon: GestureDetector(
    //         onTap: onVisibilityChanged, //
    //         child: visibility.value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
    //       ),

    //       // IconButton(icon: Icon(visibility.value ? Icons.visibility : Icons.visibility_off), onPressed: onVisibilityChanged),
    //       obscureText: !visibility.value,
    //       validator: validator,
    //     ),
    //   );
    // });
  }

  // String? _validateEmail(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return GBSystem_Application_Strings.str_validat_svp_enter_mail.tr;
  //   }
  //   if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
  //     return GBSystem_Application_Strings.str_validat_svp_enter_site_valide.tr;
  //   }
  //   return null;
  // }

  // String? _validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return GBSystem_Application_Strings.str_validat_svp_enter_password.tr;
  //   }
  //   if (value.length < 6) {
  //     return GBSystem_Application_Strings.str_validat_password_length.tr;
  //   }
  //   return null;
  // }

  // String? _validateConfirmPassword(String? value, String newPassword) {
  //   if (value == null || value.isEmpty) {
  //     return GBSystem_Application_Strings.str_validat_svp_enter_password.tr;
  //   }
  //   if (value.length < 6) {
  //     return GBSystem_Application_Strings.str_validat_password_length.tr;
  //   }
  //   if (value != newPassword) {
  //     return GBSystem_Application_Strings.str_validat_password_must_be_the_same.tr;
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              leadingIcon: const Icon(CupertinoIcons.arrow_left, color: Colors.black),
              onLeadingTap: Get.back,
            ),
            resizeToAvoidBottomInset: true,
            body: Form(
              key: controller.formKey,
              autovalidateMode: controller.autovalidateMode,
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    _buildHeader(context),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        //
                        horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.1),
                        vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.05),
                      ),
                      child: Column(
                        children: [
                          _buildTitleSection(context), //
                          _buildPasswordFields(context),
                          _buildSubmitButton(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Obx(() => controller.isLoading.value ? Waiting() : Container()),
        ],
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                GBSystem_Application_Strings.str_change_password.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: GBSystem_Application_Strings.str_primary_color),
              ),
            ],
          ),
          const Divider(thickness: 2, color: GBSystem_Application_Strings.str_primary_color),
        ],
      ),
    );
  }

  // void _handleSubmit() async {
  //   if (controller.formKey.currentState!.validate()) {
  //     //await controller.changePassword(ancientPass: _oldPasswordController.text, mail: _emailController.text, newPass: _newPasswordController.text, newPassConf: _confirmPasswordController.text);
  //   } else {
  //     controller.autovalidateMode = AutovalidateMode.always;
  //   }
  // }

  Widget _buildSubmitButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, //
      children: [GBSystem_SubmitButton(context, controller.Do_changePassword_Valiadation, GBSystem_Application_Strings.str_ok.tr)],
    );
  }

  FlutterPwValidatorStrings? getTranslatValidator(Locale? myLocal) {
    if (myLocal?.languageCode == 'de') {
      return DutshStrings();
    } else if (myLocal?.languageCode == 'en') {
      return EnglishStrings();
    } else if (myLocal?.languageCode == 'es') {
      return EspagnolStrings();
    } else if (myLocal?.languageCode == 'fr') {
      return FrenchStrings();
    } else if (myLocal?.languageCode == 'gr') {
      return GrecStrings();
    } else if (myLocal?.languageCode == 'pt') {
      return PortugalStrings();
    } else if (myLocal?.languageCode == 'ro') {
      return RomanieStrings();
    } else if (myLocal?.languageCode == 'tr') {
      return TurkieStrings();
    } else {
      return FrenchStrings();
    }
  }
}
