// lib/main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/navigation_controller.dart';
import 'features/dynamic_menu.dart';
import 'app_router.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initializeDateFormatting('fr_FR', null);
  
  // Injection globale du contrôleur
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Requis pour GetX
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, primaryColor: Colors.blue[900]),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatelessWidget {
  const MainNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Espace Salarié", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const DynamicMenu(jsonPath: 'assets/menu_config.json'),
      // Obx écoute les changements de currentViewId et reconstruit uniquement cette partie
      body: Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Container(
          key: ValueKey(navCtrl.currentViewId.value),
          child: AppRouter.getPage(navCtrl.currentViewId.value),
        ),
      )),
    );
  }
}