import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_vacation_model.dart';

class GBSystemVacationPlanningWidget extends StatelessWidget {
  const GBSystemVacationPlanningWidget(
      {super.key, required this.vacationModel});

  final VacationModel vacationModel;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Text(vacationModel.TITLE));
  }
}
