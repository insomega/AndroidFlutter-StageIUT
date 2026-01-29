import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/navigation_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gbsystem_mainview/GBSystem_Root_MainView_Menu_Controller.dart';
import 'package:gbsystem_mainview/GBSystem_MenuService.dart';
import 'package:gbsystem_menu/features/main_navigator.dart';
import 'package:gbsystem_translations/gbsystem_application_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initializeDateFormatting('fr_FR', null);
  
  // 1. Initialiser les dépendances
  // Si MenuService est requis par ton contrôleur, mets-le ici :
  Get.put(MenuService()); 
  
  // Injecte le contrôleur qui charge le JSON
  Get.put(GBSystem_MenuController());
  
  // Injecte le contrôleur de navigation
  Get.put(GBSystem_NavigationController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: GBSystem_Application_Strings.str_app_title,
      theme: ThemeData(
        useMaterial3: true, 
        primaryColor: Colors.blue[900],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[900]!),
      ),
      home: const GBSystem_MainNavigator(),
    );
  }
}