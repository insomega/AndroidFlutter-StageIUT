import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/navigation_controller.dart';
import 'features/dynamic_menu.dart';
import 'app_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gbsystem_mainview/GBSystem_Root_MainView_Menu_Controller.dart';
import 'package:gbsystem_mainview/GBSystem_MenuService.dart';
import 'core/bmsoft_icons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initializeDateFormatting('fr_FR', null);
  
  // 1. Initialiser les dépendances
  // Si MenuService est requis par ton contrôleur, mets-le ici :
  Get.put(MenuService()); 
  
  // Injecte le contrôleur qui charge le JSON
  Get.put(GBSystem_MenuController());
  
  // Injecte le contrôleur de navigation
  Get.put(NavigationController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Espace Salarié',
      theme: ThemeData(
        useMaterial3: true, 
        primaryColor: Colors.blue[900],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[900]!),
      ),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatelessWidget {
  const MainNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère l'instance déjà injectée dans le main
    final navCtrl = Get.find<NavigationController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(BMSoftIcons.logo, color: Colors.white, size: 28), 
            const SizedBox(width: 12),
            const Text(
              "ESPACE SALARIÉ", 
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.1
              )
            ),
          ],
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const DynamicMenu(),
      // L'Obx réagit au changement de navCtrl.currentViewId.value
      body: Obx(() {
        final currentId = navCtrl.currentViewId.value;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          // La transition se déclenche car la ValueKey change
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Container(
            key: ValueKey(currentId),
            color: Colors.white,
            // AppRouter.getPage retourne le bon Widget (ex: GBSystem_Vacation_List_PS2_Wigget)
            child: AppRouter.getPage(currentId),
          ),
        );
      }),
    );
  }
}