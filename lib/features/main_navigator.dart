import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'navigation_controller.dart';
import 'dynamic_menu.dart';
import '../app_router.dart';

class MainNavigator extends StatelessWidget {
  const MainNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    // On utilise putIfAbsent ou une vérification simple
    final navCtrl = Get.isRegistered<NavigationController>() 
        ? Get.find<NavigationController>() 
        : Get.put(NavigationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("ESPACE SALARIÉ"),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const DynamicMenu(), // Plus besoin de passer jsonPath si c'est géré en interne
      body: Obx(() {
        print("DEBUG: Affichage de l'ID : ${navCtrl.currentViewId.value}"); // Regarde ta console !
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            color: Colors.white, // Force un fond blanc pour voir si ça s'affiche
            key: ValueKey(navCtrl.currentViewId.value),
            child: AppRouter.getPage(navCtrl.currentViewId.value),
          ),
        );
      }),
    );
  }
}