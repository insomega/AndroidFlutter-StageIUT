import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'navigation_controller.dart';
import 'dynamic_menu.dart';
import '../app_router.dart';
import '../core/bmsoft_icons.dart';
import 'package:gbsystem_translations/gbsystem_application_strings.dart';

class GBSystem_MainNavigator extends StatelessWidget {
  const GBSystem_MainNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère l'instance déjà injectée dans le main
    final navCtrl = Get.find<GBSystem_NavigationController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Utilisation du logo avec une taille explicite et une couleur contrastée
            Icon(
              GBSystem_BMSoftIcons.logo, 
              color: Colors.white, 
              size: 50, // Augmentez un peu la taille pour mieux le voir
            ), 
            const SizedBox(width: 12),
            const Text(
              GBSystem_Application_Strings.str_app_title, 
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      drawer: const GBSystem_DynamicMenu(),
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
            child: GBSystem_AppRouter.getPage(currentId),
          ),
        );
      }),
    );
  }
}