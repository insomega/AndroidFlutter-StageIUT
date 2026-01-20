import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_compteur_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_nombre_jour_max_model.dart';

class GBSystemCETModel {
  final CompteurModel compteurModel;
  final List<NombreJourMaxModel> listNombreDesJours;

  
  GBSystemCETModel(
      {required this.compteurModel, required this.listNombreDesJours});
}
