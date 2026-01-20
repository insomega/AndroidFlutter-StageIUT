import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gbsystem_root/GBSystem_custom_text_field.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';

class GBSystem_TextField_Email extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusnode;
  final String labelText;

  const GBSystem_TextField_Email({
    //
    Key? key,
    required this.controller,
    required this.labelText,
    this.focusnode,
  }) : super(key: key);

  String? _validateEmail(String? data) {
    if (data == null || data.isEmpty) {
      return GBSystem_Application_Strings.str_validat_svp_enter_mail.tr;
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+").hasMatch(data)) {
      return GBSystem_Application_Strings.str_email_invalide_msg.tr;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015)),
      child: CustomTextField(
        controller: controller, //
        focusNode: focusnode,
        keyboardType: TextInputType.emailAddress,
        validator: _validateEmail,
        text: labelText,
        prefixIcon: const Icon(Icons.email_outlined),
      ),
    );

    // return CustomTextField(
    //   controller: controller, //
    //   keyboardType: TextInputType.emailAddress,
    //   validator: _validateEmail,
    //   text: labelText,
    //   //prefixIcon: const Icon(Icons.email_outlined),
    // );
  }
}

/*
Padding(
         padding: EdgeInsets.only(bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
         child: CustomTextField(enabled: !controller.CodeEntreprise_Visibility.value, focusNode: controller.textFieldFocusNodeEmail, controller: controller.controllerEmail, validator: _validateEmail, keyboardType: TextInputType.emailAddress, text: GBSystem_Application_Strings.str_mail.tr),
       )
class GBSystem_TextField_Email extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String emptyError;
  final String invalidError;
  final bool isRequired;

  const GBSystem_TextField_Email({
    super.key, //
    required this.controller,
    required this.labelText,
    this.emptyError = 'Veuillez saisir votre email',
    this.invalidError = 'Veuillez saisir un email valide',
    this.isRequired = true,
  });

  String? _validateEmail(String? data) {
    if (isRequired && (data == null || data.trim().isEmpty)) {
      return emptyError;
    } else if (data != null && !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$").hasMatch(data)) {
      return invalidError;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: _validateEmail,
      decoration: InputDecoration(labelText: labelText, border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.email_outlined)),
    );
  }
}

*/
