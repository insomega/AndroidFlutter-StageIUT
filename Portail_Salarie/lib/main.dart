import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:Portail_Salarie/GBSystem_X_Developpement/controllers/connection_checker_controller.dart';
import 'package:Portail_Salarie/GBSystem_X_Developpement/helper/GBSystem_http_overide.dart';
import 'package:Portail_Salarie/GBSystem_X_Developpement/screens/ERROR/SSO_ERROR/GBSystem_error_sso_screen.dart';
import 'package:Portail_Salarie/GBSystem_X_Developpement/screens/SPLASH_SCREENS/SPLASH_SCREEN/GBSystem_splash_screen.dart';
import 'package:Portail_Salarie/GBSystem_X_Developpement/screens/test_page.dart';
import 'package:Portail_Salarie/GBSystem_X_Developpement/services/auth_link_service.dart';
import 'package:Portail_Salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:Portail_Salarie/_RessourceStrings/GBSystem_translation_strings.dart';
import 'dart:ui' as ui;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //http request
  HttpOverrides.global = GBSystem_MyHttpOverrides();
  //date format
  await initializeDateFormatting(Intl.defaultLocale);
  //firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // init local database hive
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox(GbsSystemServerStrings.kHiveBox_Requests);

  runApp(PortailSalarieApp());
}

class PortailSalarieApp extends StatefulWidget {
  PortailSalarieApp({super.key});

  @override
  State<PortailSalarieApp> createState() => _PortailSalarieAppState();
}

class _PortailSalarieAppState extends State<PortailSalarieApp> {
  final m = Get.put<ConnectionCheckerController>(ConnectionCheckerController());

  final navigatorKey = GlobalKey<NavigatorState>();
  Future<Locale?> getSharedPerfermenceLocal() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    String? localeString =
        await prefs2.getString(GbsSystemServerStrings.kLocale);
    if (localeString != null) {
      return Locale(localeString);
    } else {
      return null;
    }
  }

  Future<void> updateSharedPerfermenceLocal() async {
    Locale? usedLocale = await getSharedPerfermenceLocal();
    if (usedLocale != null) {
      Get.updateLocale(usedLocale);
    }
  }

  late final AuthLinkService _authLinkService;

  @override
  void dispose() {
    _authLinkService.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    updateSharedPerfermenceLocal();
    //
    _authLinkService = AuthLinkService();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _authLinkService.init();
    });

    _authLinkService.onAuthLink.listen((authData) {
      print(
          'Auth link received: token=${authData.token}, userId=${authData.userId}');
      // TODO: Navigate or authenticate the user
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        translations: GBSystemTranslationStrings(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          SfGlobalLocalizations.delegate,
        ],

        supportedLocales: [
          Locale("fr"),
          Locale("en"),
          Locale("de"),
          Locale("es"),
          Locale("el"),
          Locale("pt"),
          Locale("ro"),
          Locale("tr"),
        ],
        locale: getLocaleApplication(),
        theme: ThemeData(fontFamily: 'Mulish'),
        debugShowCheckedModeBanner: false,
        home: GBSystemSplashScreen(),
        // home: TestPage(),
        // home: ErrorSSOPage(),
        // home: LocalAuthScreen(
        //   destination: Container(),
        //   isBackAvailable: false,
        // ),
        navigatorKey: navigatorKey,
      ),
    );
  }

  Locale getLocaleApplication() {
    List<String> myLocales = ["fr", "en", "de", "es", "el", "pt", "ro", "tr"];

    if (myLocales.contains(ui.window.locale.toString().substring(0, 2))) {
      return Locale(ui.window.locale.toString().substring(0, 2));
    } else {
      return Locale("fr");
    }
  }
}
