import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_publication_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_model.dart';

class GBSystemValiderDocumentsModel {
  final List<DocumentModel>? listDocuments;
  final List<PublicationModel>? listPublications;
   List<VacationModel>? listVacations;
  
  GBSystemValiderDocumentsModel(
      {required this.listDocuments, required this.listPublications,required this.listVacations});
}
