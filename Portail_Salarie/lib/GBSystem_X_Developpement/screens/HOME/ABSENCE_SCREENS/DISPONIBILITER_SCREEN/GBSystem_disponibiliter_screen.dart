import 'package:animated_toggle/animated_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/DISPONIBILITER_SCREEN/GBSystem_disponibiliter_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/CET_WIDGETS/cet_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/CET_WIDGETS_RACHAT/cet_rachat_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemDisponibiliterScreen extends StatefulWidget {
  const GBSystemDisponibiliterScreen(
      {super.key, this.isCommingFromOut = false});
  final bool isCommingFromOut;

  @override
  State<GBSystemDisponibiliterScreen> createState() =>
      _GBSystemDisponibiliterScreenState();
}

class _GBSystemDisponibiliterScreenState
    extends State<GBSystemDisponibiliterScreen> {
  final m =
      Get.put<DisponibiliterScreenController>(DisponibiliterScreenController());

  updateLoading(bool myBool) {
    m.isLoading.value = myBool;
  }

  updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
                extendBodyBehindAppBar: false,
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 4.0,
                  shadowColor: GbsSystemStrings.str_primary_color,
                  toolbarHeight: 80,
                  backgroundColor: GbsSystemStrings.str_primary_color,
                  title: Text(
                    GbsSystemStrings.str_cet,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: widget.isCommingFromOut
                      ? InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.white,
                          ),
                        )
                      : Container(),
                ),
                body: Column(
                  children: [
                    AnimatedHorizontalToggle(
                      taps: [
                        GbsSystemStrings.str_placement_cet.tr,
                        GbsSystemStrings.str_rachat_cet.tr,
                        GbsSystemStrings.str_prise_de_jours_cet.tr,
                      ],
                      activeBoxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                      width: MediaQuery.of(context).size.width - 10,
                      height: 45,
                      duration: const Duration(milliseconds: 200),
                      initialIndex: 0,
                      background: Colors.grey.shade200.withOpacity(0.6),
                      activeColor: GbsSystemStrings.str_primary_color,
                      activeTextStyle: const TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      inActiveTextStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: GbsSystemStrings.str_primary_color),
                      horizontalPadding: 0,
                      verticalPadding: 4,
                      activeHorizontalPadding: 0,
                      activeVerticalPadding: 4,
                      radius: 14,
                      activeButtonRadius: 14,
                      onChange: (int currentIndex, int targetIndex) {
                        m.currentPageIndex.value = targetIndex;
                        m.pageController.animateToPage(targetIndex,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      showActiveButtonColor: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: m.pageController,
                        scrollDirection: Axis.horizontal,
                        children: [
                          CETWidget(
                            updateLoading: updateLoading,
                            updateUI: updateUI,
                          ),
                          CETRachatWidget(
                            updateLoading: updateLoading,
                            updateUI: updateUI,
                          ),
                          CETWidget(
                            updateLoading: updateLoading,
                            updateUI: updateUI,
                            isTypeThree: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
