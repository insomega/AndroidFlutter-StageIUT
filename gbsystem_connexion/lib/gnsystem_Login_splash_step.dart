import 'package:get/get.dart';
//import 'package:get_storage/get_storage.dart';
import 'package:gbsystem_root/GBSystem_Root_SplashStep.dart';
import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
import 'GBSystem_Login_Controller.dart';

class GBSystem_Login_SplashStep implements GBSystem_Root_SplashStep {
  final GBSystem_Storage_Service _storage = GBSystem_Storage_Service();

  @override
  String get SplashStep_label => 'Vérification de la connexion...';

  // @override
  // Future<void> execute() async {
  //   final seen = _storage.hasSessionData();
  //   if (!seen) {
  //     // Redirection et fin de l'exécution
  //     Future.microtask(() => Get.offAllNamed(GBSystem_Login_Controller.loginRoute));
  //     return; // Très important !
  //   }
  // }

  // @override
  // Future<bool> execute() async {
  //   final seen = _storage.hasSessionData();

  //   if (!seen) {
  //     //  _storage.saveOnboarding();
  //     Future.microtask(() => Get.offAllNamed(GBSystem_Login_Controller.loginRoute));
  //     return true; // On arrête les étapes ici
  //   }

  //   return false; // On continue vers l'étape suivante
  // }

  @override
  Future<bool> execute() async {
    final seen = _storage.hasSessionData();

    if (!seen) {
      // Marquer comme vu si besoin
      //  _storage.saveOnboarding();

      // 👉 Redirige SANS supprimer la stack (et attend la fin)
      await Get.toNamed(GBSystem_Login_Controller.routeName);
      return true; // On arrête le slashscree et le controlleur du mot de passe appel mainview
    }
    return false; // ✅ Continue les étapes ensuite
  }
}





/*
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../splash_step.dart';

class DocumentStep implements SplashStep {
  final box = GetStorage();

  @override
  String get label => 'Chargement des documents...';

  @override
  Future<void> execute() async {
    final required = box.read('documents_required') ?? false;
    if (required) {
      Get.offAllNamed('/documents');
      throw Exception('Redirection vers documents');
    }
  }
}

*/

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'src/splash_controller.dart';
import 'src/splash_view.dart';
import 'src/steps/onboarding_step.dart';
import 'src/steps/auth_step.dart';
import 'src/steps/document_step.dart';

void main() async {
  await GetStorage.init();

  Get.put(SplashController(
    steps: [
      OnboardingStep(),
      AuthStep(),
      DocumentStep(),
    ],
    fallbackRoute: '/main',
  ));

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: const SplashView(),
    getPages: [
      GetPage(name: '/onboarding', page: () => const DummyPage('Onboarding')),
      GetPage(name: '/login', page: () => const DummyPage('Login')),
      GetPage(name: '/documents', page: () => const DummyPage('Documents')),
      GetPage(name: '/main', page: () => const DummyPage('Main')),
    ],
  ));
}

class DummyPage extends StatelessWidget {
  final String label;
  const DummyPage(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(label)));
  }
}
*/