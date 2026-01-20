import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';

import 'GBSystem_Onboarding_Controller.dart';
import 'GBSystem_on_boarding1_widget.dart';
import 'GBSystem_on_boarding2_widget.dart';
import 'GBSystem_on_boarding3_widget.dart';
import 'GBSystem_on_boarding4_widget.dart';

class GBSystem_Onboarding_View extends GetView<GBSystem_Onboarding_Controller> {
  //GBSystem_Onboarding_View({super.key});

  //final controller = Get.put(GBSystemBoardingController());
  static const totalPages = 4;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            PageView(controller: controller.pageController, children: const [GBSystem_OnBoardingWidget1(), GBSystem_OnBoardingWidget2(), GBSystem_OnBoardingWidget3(), GBSystem_OnBoardingWidget4()]),
            Positioned(
              bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
              child: Obx(
                () => DotsIndicator(
                  dotsCount: totalPages,
                  position: controller.currentIndex.roundToDouble(),
                  decorator: DotsDecorator(
                    activeColor: GBSystem_System_Strings.str_primary_color,
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    activeSize: const Size(20, 10),
                  ),
                ),
              ),
            ),
            Positioned(
              right: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.05),
              bottom: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.05),
              child: Obx(() {
                final isLastPage = controller.currentIndex.round() == totalPages - 1;
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: isLastPage ? 1 : 0,
                  child: Visibility(
                    visible: isLastPage,
                    child: InkWell(
                      onTap: controller.completeOnboarding,
                      child: Container(
                        decoration: BoxDecoration(color: GBSystem_System_Strings.str_primary_color, borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(10),
                        child: const Text(GBSystem_Application_Strings.str_boarding_commencer, style: TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
/*

class GBSystem_BoardingScreen extends StatelessWidget {
  GBSystem_BoardingScreen({super.key});

  final m = Get.put<GBSystem_Boarding_Controller>(GBSystem_Boarding_Controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              controller: m.pageController,
              children: const [
                GBSystem_OnBoardingWidget1(),
                GBSystem_OnBoardingWidget2(),
                GBSystem_OnBoardingWidget3(),
                GBSystem_OnBoardingWidget4(),
              ],
            ),
            Positioned(
              bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
              child: Obx(() => DotsIndicator(
                    decorator: DotsDecorator(
                        activeColor: GBSystem_System_Strings.str_primary_color,
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6), // Customize the border radius
                        ),
                        activeSize: const Size(20, 10)),
                    dotsCount: 4,
                    position: m.currentIndex.round().toDouble(),
                  )),
            ),
            Positioned(
              right: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.05),
              bottom: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.05),
              child: Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: m.currentIndex.round().toInt() == 3 ? 1 : 0,
                    child: InkWell(
                      onTap: m.currentIndex.round().toInt() == 3
                          ? () async {
                              await m.updateFirstTime();
                            }
                          : () {},
                      child: Container(
                        decoration: BoxDecoration(color: GBSystem_System_Strings.str_primary_color, borderRadius: BorderRadius.circular(16)),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            GBSystem_Application_Strings.str_boarding_commencer,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

*/