import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gbsystem_root/GBSystem_LogEvent.dart';
import 'package:gbsystem_root/GBSystem_NetworkController.dart';
import 'package:gbsystem_translations/GBSystem_translation_strings.dart';
import './GBSystem_Application/Pages/GBSystem_Application_Pages.dart';
import './GBSystem_Application/GBSystem_Application_Initializer.dart';
import 'package:gbsystem_splash_screen/gbsystem_splash_controller.dart';

void main() {
  runZonedGuarded(() async {
    try {
      await GBSystem_PS2_Initializer.initialize();
      runApp(GBSystem_Application());
    } catch (error, stackTrace) {
      _handleStartupError(error, stackTrace);
    }
  }, (error, stackTrace) => _handleStartupError(error, stackTrace));
}

void _handleStartupError(Object error, StackTrace stackTrace) {
  debugPrint('Application startup failed: $error');
}

class GBSystem_Application extends StatelessWidget {
  GBSystem_Application({super.key});

  //final GBSystem_Storage_Service _storage = GBSystem_Storage_Service();

  // final bool isFirstTime = _storage.hasSessionData() ;

  @override
  Widget build(BuildContext context) {
    Get.putAsync(() => ErrorHandlerService().init());
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: GBSystem_Translation_Strings(),

        // initialRoute: _storage.hasSessionData() ? GBSystem_Application_Routes.onboarding : GBSystem_Application_Routes.login,
        initialRoute: GBSystem_SplashController.routeName,
        getPages: GBSystem_Application_Pages.pages,

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          //  SfGlobalLocalizations.delegate,
        ],
        locale: Get.deviceLocale, // GBSystem_Translation_Strings.getLocaleApplication(), //  Get.deviceLocale, // 👈 Définit la langue du téléphone
        fallbackLocale: GBSystem_Translation_Strings.fallbackLocale, // langue par défaut si non supportée
        supportedLocales: GBSystem_Translation_Strings.supportedLocales,
        //locale: Locale("fr"),
        theme: ThemeData(
          fontFamily: 'Mulish',
          // textTheme: const TextTheme(
          //   bodyLarge: TextStyle(decoration: TextDecoration.none),
          //   bodyMedium: TextStyle(decoration: TextDecoration.none),
          //   bodySmall: TextStyle(decoration: TextDecoration.none),
          //   titleLarge: TextStyle(decoration: TextDecoration.none),
          //   titleMedium: TextStyle(decoration: TextDecoration.none),
          //   titleSmall: TextStyle(decoration: TextDecoration.none),
          //   labelLarge: TextStyle(decoration: TextDecoration.none),
          //   labelMedium: TextStyle(decoration: TextDecoration.none),
          //   labelSmall: TextStyle(decoration: TextDecoration.none),
          // ),
        ),
        builder: (context, child) {
          // Initialise le contrôleur pour écouter la connectivité
          Get.put(GBSystem_NetworkController());
          return child ?? const SizedBox();
          // return
          //            Column(
          //   children: [
          //     GBSystem_NetworkBanner(), // bandeau de connexion

          //     Expanded(child: child ?? const SizedBox()),
          //   ],
          // );
        },
        //  home: const GBSystem_SplashView(),
        //home: GBSystemSplashScreen(),
        //  home: GBSystem_PriseService_PS1(),
        //========================  enableLog: true,
        //================logWriterCallback: GBSystem_LogWriter.write,
        // home: TestPage()
        // home: LocalAuthScreen(
        //   destination: Container(),
        //   isBackAvailable: false,
        // ),
      ),
    );
  }
}

/*  tres interessant
   https://medium.com/@syedhasan.cse/getx-ever-method-explained-the-easiest-way-to-handle-state-changes-e6113e52583a

flutter pub global activate flutter_rename
flutter_rename --appname "Nouveau Nom" --bundle-id com.votre.nouveau.id

 */
/**-----------------------------------*/
