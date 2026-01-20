import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_planning_model.dart';

class GBSystemSalariePlanningWidget extends StatelessWidget {
  const GBSystemSalariePlanningWidget(
      {super.key, required this.salariePlanning});

  final SalariePlanningModel salariePlanning;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.amber),
        child: Text(salariePlanning.SVR_NOM));
  }
}
