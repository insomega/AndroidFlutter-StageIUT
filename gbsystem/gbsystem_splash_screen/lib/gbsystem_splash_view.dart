import 'package:flutter/material.dart';
//import 'package:gbsystem_root/GBSystem_NetworkController.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'package:get/get.dart';
import 'gbsystem_splash_controller.dart';

class GBSystem_SplashView extends GetView<GBSystem_SplashController> {
  const GBSystem_SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(GBSystem_System_Strings.str_logo_image_path, width: 120),
              const SizedBox(height: 30),
              Obx(
                () => Text(
                  controller.currentStep.value, //
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => LinearProgressIndicator(
                  value: controller.progress.value, //
                  backgroundColor: Colors.white24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
