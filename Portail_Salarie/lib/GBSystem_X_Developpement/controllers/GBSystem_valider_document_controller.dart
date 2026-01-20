import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_valider_document_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_publication_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_model.dart';

class GBSystemValiderDocumentController extends GetxController {
  Rx<GBSystemValiderDocumentsModel?> _validerDocuments = Rx<GBSystemValiderDocumentsModel?>(null);
VacationModel? _currentVacation;
 DateTime? _entrer, _sortie;
  
  set setCurrentValiderDocument(GBSystemValiderDocumentsModel? ValiderDocument) {
    _validerDocuments.value = ValiderDocument;
    update();
  }
   set setCurrentVacationVacation(VacationModel? vacation) {
    _currentVacation = vacation;
    update();
  }

  set AddVacationToLeft(VacationModel vacationModel) {
    _validerDocuments.value!.listVacations!.insert(0, vacationModel);
    update();
  }

 set AddVacationToRight(VacationModel vacation) {
    _validerDocuments.value!.listVacations!.insert(_validerDocuments.value!.listVacations!.length, vacation);
    update();
  }

  void removeDocument(DocumentModel documentModel) {
    int index = _validerDocuments.value!.listDocuments!.indexOf(documentModel);
    _validerDocuments.value!.listDocuments!.removeAt(index);
    update();
  }

void removeVacation(VacationModel vacationModel) {
    int index = _validerDocuments.value!.listVacations!.indexOf(vacationModel);
    _validerDocuments.value!.listDocuments!.removeAt(index);
    update();
  }

 void removePublication(PublicationModel publicationModel) {
    int index = _validerDocuments.value!.listPublications!.indexOf(publicationModel);
    _validerDocuments.value!.listPublications!.removeAt(index);
    update();
  }

set setVacationEntrer(DateTime entrer) {
    _entrer = entrer;
    update();
  }

  set setVacationSortie(DateTime sortie) {
    _sortie = sortie;
    update();
  }

  
  Rx<GBSystemValiderDocumentsModel?> get getCurrentValiderDocument => _validerDocuments;
 VacationModel? get getCurrentVacation => _currentVacation;
 RxBool get getCurrentVacationBool => _currentVacation != null ? RxBool(true):RxBool(false);
 DateTime? get getEntrer => _entrer;
  DateTime? get getSortie => _sortie;
  
}
