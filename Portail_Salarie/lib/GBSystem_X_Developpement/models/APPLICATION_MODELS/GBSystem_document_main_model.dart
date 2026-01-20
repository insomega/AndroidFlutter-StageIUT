import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_agrement_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_diplome_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_officiel_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_habilitation_model.dart';

class GBSystemDocumentsMainModel {
  final List<AgrementModel>? listAgrements;
  final List<HabilitationModel>? listHabilitations;
  final List<DiplomeModel>? listDiplomes;
  final List<DocumentOfficielModel>? listDocumentsOfficiel;
  
  
  GBSystemDocumentsMainModel(
      {required this.listAgrements, required this.listDiplomes,required this.listDocumentsOfficiel,required this.listHabilitations});
}
