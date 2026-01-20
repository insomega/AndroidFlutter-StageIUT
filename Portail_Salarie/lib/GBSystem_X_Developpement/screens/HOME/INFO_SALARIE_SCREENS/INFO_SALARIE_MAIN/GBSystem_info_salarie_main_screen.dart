import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/INFO_SALARIE_MAIN/GBSystem_info_salarie_main_screen_controller.dart';

class GBSystemInfoSalarieMainScreen extends StatefulWidget {
  GBSystemInfoSalarieMainScreen(
      {super.key, required this.selectedIndexFromOut});
  final int selectedIndexFromOut;
  @override
  State<GBSystemInfoSalarieMainScreen> createState() =>
      _GBSystemInfoSalarieMainScreenState();
}

class _GBSystemInfoSalarieMainScreenState
    extends State<GBSystemInfoSalarieMainScreen> {
  final m = Get.put<GBSystemInfoSalarieMainScreenController>(
      GBSystemInfoSalarieMainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: m.screens[widget.selectedIndexFromOut]),
        ],
      ),
    );
  }
}
