import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/connection_checker_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_http_overide.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/SPLASH_SCREENS/splash_screen/GBSystem_Splash_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/test_page.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = GBSystem_MyHttpOverrides();
  await initializeDateFormatting('fr');
  // init local database hive

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox(GbsSystemServerStrings.kHiveBox_Requests);
  await Hive.openBox(GbsSystemServerStrings.kHiveBox_Evaluation);

  runApp(GBSystemNewApplication());
}

class GBSystemNewApplication extends StatelessWidget {
  GBSystemNewApplication({super.key});
  final m = Get.put<ConnectionCheckerController>(ConnectionCheckerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          SfGlobalLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fr"),
        ],
        locale: Locale("fr"),
        theme: ThemeData(fontFamily: 'Mulish'),
        debugShowCheckedModeBanner: false,
        home: GBSystemSplashScreen(),
        // home: TestPage()
        // home: LocalAuthScreen(
        //   destination: Container(),
        //   isBackAvailable: false,
        // ),
      ),
    );
  }
}
