import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_planning_dispo_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_planning_download_model.dart';

class PlanningModel {
  List<PlanningDownloadModel> planningDownloadModel;
  List<PlanningDisponibleModel> planningDisponibleModel;
  PlanningModel(
      {required this.planningDisponibleModel,
      required this.planningDownloadModel});
}
