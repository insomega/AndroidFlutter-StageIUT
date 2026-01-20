import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/PLANNING_MAIN/GBSystem_planning_main_screen_controller.dart';

class GBSystemPlanningMainScreen extends StatefulWidget {
  GBSystemPlanningMainScreen({super.key, required this.selectedIndexFromOut});

  final int selectedIndexFromOut;
  @override
  State<GBSystemPlanningMainScreen> createState() =>
      _GBSystemPlanningMainScreenState();
}

class _GBSystemPlanningMainScreenState
    extends State<GBSystemPlanningMainScreen> {
  @override
  Widget build(BuildContext context) {
    final m = Get.put<GBSystemPlanningMainScreenController>(
        GBSystemPlanningMainScreenController(
            selectedIndex: widget.selectedIndexFromOut));

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: m.screens[widget.selectedIndexFromOut]),
        ],
      ),
    );
  }
}
