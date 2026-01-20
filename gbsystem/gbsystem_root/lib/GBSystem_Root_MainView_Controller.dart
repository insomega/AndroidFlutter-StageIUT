import 'dart:io';
//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

class GBSystem_Root_MainForm_Controller extends GBSystem_Root_Controller with GBSystem_HomeScreen_PS1Mixin {}

mixin GBSystem_HomeScreen_PS1Mixin on GetxController {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final RxBool authSuccess = false.obs;

  Future<void> handleAuthentication() async {
    if (!authSuccess.value) {
      final success = await _authenticate();
      if (!success) exit(0);
    }
  }

  Future<bool> _authenticate() async {
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: GBSystem_Application_Strings.str_auth_please_authentificate_to_proceed.tr, //
        options: const AuthenticationOptions(useErrorDialogs: true, stickyAuth: true),
      );
      authSuccess.value = authenticated;
      return authenticated;
    } catch (e) {
      authSuccess.value = true;
      return true;
    }
  }
}
