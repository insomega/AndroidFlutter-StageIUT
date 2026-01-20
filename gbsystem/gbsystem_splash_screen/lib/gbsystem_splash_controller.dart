import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_Root_SplashStep.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';

class GBSystem_SplashController extends GBSystem_Root_Controller {
  static const String routeName = '/splashScreen';

  final List<GBSystem_Root_SplashStep> steps;
  final String fallbackRoute;

  GBSystem_SplashController({required this.steps, required this.fallbackRoute});

  final RxString currentStep = ''.obs;
  final RxDouble progress = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    _runSteps();
  }

  Future<void> _runSteps() async {
    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      currentStep.value = step.SplashStep_label;

      final shouldStop = await step.execute();
      if (shouldStop) return;

      progress.value = (i + 1) / steps.length;
    }

    // Navigation vers la route par défaut si toutes les étapes sont passées
    // Toutes les étapes terminées → on va vers la route finale

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.offAllNamed(fallbackRoute);
    });
  }
}
