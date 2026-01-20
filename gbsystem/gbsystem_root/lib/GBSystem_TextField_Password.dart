// ignore: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gbsystem_root/GBSystem_custom_text_field.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

class GBSystem_TextField_Password extends StatefulWidget {
  const GBSystem_TextField_Password({super.key, required this.text, required this.controller, this.focusNode, this.isVisible});

  final String text;
  final RxBool? isVisible;
  final TextEditingController controller;
  final FocusNode? focusNode;
  @override
  State<GBSystem_TextField_Password> createState() => _GBSystem_TextField_PasswordState();
}

class _GBSystem_TextField_PasswordState extends State<GBSystem_TextField_Password> {
  late final RxBool _isVisible;
  final RxBool _passwordVisibility = false.obs;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.isVisible ?? false.obs;
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? _validatePassword(String? data) {
    if (data == null || data.isEmpty) {
      return GBSystem_Application_Strings.str_validat_svp_enter_password.tr;
    }

    final password = data.trim();

    if (password.length < 8) return GBSystem_Application_Strings.str_validat_password_length.tr;
    if (!RegExp(r'[A-Z]').hasMatch(password)) return GBSystem_Application_Strings.str_validat_password_MAJ.tr;
    if (!RegExp(r'[a-z]').hasMatch(password)) return GBSystem_Application_Strings.str_validat_password_Min.tr;
    if (!RegExp(r'[0-9]').hasMatch(password)) return GBSystem_Application_Strings.str_validat_password_Chiffre.tr;
    if (!RegExp(r'[!@#\$&*~%^().?_+=<>:;,-]').hasMatch(password)) {
      return GBSystem_Application_Strings.str_validat_password_Speciale.tr;
    }

    return null;
  }

  void _togglePasswordVisibility() => _passwordVisibility.toggle();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextField(
        enabled: !_isVisible.value,
        focusNode: widget.focusNode,
        controller: widget.controller,
        text: widget.text,
        suffixIcon: GestureDetector(onTap: _togglePasswordVisibility, child: _passwordVisibility.value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
        obscureText: !_passwordVisibility.value,
        validator: _validatePassword,
      ),
    );
  }
}
