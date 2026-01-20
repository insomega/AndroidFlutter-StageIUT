import 'package:get/get.dart';

import 'package:gbsystem_root/GBSystem_Root_SplashStep.dart';
import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
//import 'package:gbsystem_splash_screen/gbsystem_splash_controller.dart';

import 'GBSystem_Onboarding_Controller.dart';

class GBSystem_OnboardingStep implements GBSystem_Root_SplashStep {
  @override
  String get SplashStep_label => 'Chargement de l\'onboarding...';

  // @override
  // Future<void> execute() async {
  //   final seen = _storage.getIsFirstTime();
  //   if (!seen) {
  //     // Redirection et fin de l'exécution
  //     Future.microtask(() => Get.offAllNamed(GBSystem_Onboarding_Controller.onboardingRoute));
  //     return; // Très important !
  //   }
  // }

  // @override
  // Future<bool> execute() async {
  //   final seen = _storage.getIsFirstTime();

  //   if (!seen) {
  //     //  _storage.saveOnboarding();
  //     Future.microtask(() => Get.offAllNamed(GBSystem_Onboarding_Controller.onboardingRoute));
  //     return true; // On arrête les étapes ici
  //   }

  //   return false; // On continue vers l'étape suivante
  // }

  @override
  Future<bool> execute() async {
    final seen = GBSystem_Storage_Service().getIsFirstTime();

    if (!seen) {
      // 👉 Redirige SANS supprimer la stack (et attend la fin)
      await Get.toNamed(GBSystem_Onboarding_Controller.routeName);
      // Marquer comme vu si besoin
      //_storage.saveIsFirstTime();
    }

    return false; // ✅ Continue les étapes ensuite
  }
}
