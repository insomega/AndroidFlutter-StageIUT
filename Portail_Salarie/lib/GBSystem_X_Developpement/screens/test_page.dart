import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/INDISPONIBILITER_MAIN_SCREEN/GBSystem_indisponibiliter_main_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/auth_link_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/pdf_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  late final AuthLinkService _authLinkService;
  @override
  void initState() {
    super.initState();

    _authLinkService = AuthLinkService();
    _authLinkService.init();

    _authLinkService.onAuthLink.listen((authData) {
      print(
          'Auth link received: token=${authData.token}, userId=${authData.userId}');
      // TODO: Navigate or authenticate the user
    });
  }

  @override
  void dispose() {
    _authLinkService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("data"),
          onPressed: () async {
            DateTime date = DateTime.now();
            print(ConvertDateService().formatDateTimeVacation(date));
          },
        ),
      ),
    );
  }
}
