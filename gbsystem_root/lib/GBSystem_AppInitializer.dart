import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'GBSystem_http_overide.dart';
//import 'GBSystem_firebase_options.dart';
import 'GBSystem_System_Strings.dart';
import 'GBSystem_NetworkController.dart';
import 'package:get_storage/get_storage.dart';

class GBSystem_AppInitializer {
  /// Initialise tous les services nécessaires avant le lancement de l'application.
  /// Retourne `true` si tout s'est bien passé, sinon `false`.
  static Future<bool> initialize() async {
    try {
      await _initFlutterBindings();
      await _initHttpOverrides();
      await _initDateFormatting();
      //await _initFirebase();
      await _initHive();
      await _initGetStorage();
      //await _initSplashController();

      // Enregistrement permanent du contrôleur
      Get.put(GBSystem_NetworkController(), permanent: true);
      return true;
    } catch (e, stackTrace) {
      debugPrint("❌ Erreur lors de l'initialisation: $e");
      debugPrint("📜 Stack trace: $stackTrace");
      return false;
    }
  }

  /// Initialise les bindings Flutter (nécessaire avant toute opération Flutter).
  static Future<void> _initFlutterBindings() async {
    WidgetsFlutterBinding.ensureInitialized();
    debugPrint("✅ Bindings Flutter initialisés");
  }

  /// Configure les overrides HTTP (pour contourner les problèmes de certificat SSL en développement).
  static Future<void> _initHttpOverrides() async {
    HttpOverrides.global = GBSystem_HttpOverrides();
    debugPrint("✅ HTTP Overrides configurés");
  }

  /// Initialise le formatage des dates localisées.
  static Future<void> _initDateFormatting() async {
    await initializeDateFormatting(Intl.defaultLocale);
    debugPrint("✅ Formatage des dates initialisé");
  }

  // /// Initialise Firebase avec les options par défaut.
  // static Future<void> _initFirebase() async {
  //   await Firebase.initializeApp(options: GBSystem_DefaultFirebaseOptions.currentPlatform);
  //   debugPrint("✅ Firebase initialisé");
  // }

  /// Initialise Hive (base de données locale) et ouvre la boîte de stockage.
  static Future<void> _initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox(GBSystem_System_Strings.kHiveBox_Requests);
    debugPrint("✅ Hive initialisé avec la boîte: ${GBSystem_System_Strings.kHiveBox_Requests}");
  }

  static Future<void> _initGetStorage() async {
    await GetStorage.init();

    debugPrint("✅ GetStorage initialisés");
  }
}
