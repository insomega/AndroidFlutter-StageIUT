import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_entreprise_model.dart';

class GBSystemDocumentEntrepriseController extends GetxController {
  // List<DocumentEntrepriseModel>? _allDocumentEntreprise;
  // DocumentEntrepriseModel? _currentDocumentEntreprise;
 Rx<DocumentEntrepriseModel?> _currentDocumentEntreprise = Rx<DocumentEntrepriseModel?>(null);
   Rx<List<DocumentEntrepriseModel>?> _allDocumentEntreprise = Rx<List<DocumentEntrepriseModel>?>(null);
   

  set setDocumentEntreprise(DocumentEntrepriseModel DocumentEntreprise) {
    _allDocumentEntreprise.value?.add(DocumentEntreprise);
    update();
  }

  set setCurrentDocumentEntreprise(DocumentEntrepriseModel? DocumentEntreprise) {
    _currentDocumentEntreprise.value = DocumentEntreprise;
    update();
  }

  set setDocumentEntrepriseToLeft(DocumentEntrepriseModel DocumentEntreprise) {
    _allDocumentEntreprise.value?.insert(0, DocumentEntreprise);
    update();
  }

  set setDocumentEntrepriseToRight(DocumentEntrepriseModel DocumentEntreprise) {
    _allDocumentEntreprise.value?.insert(_allDocumentEntreprise.value!.length, DocumentEntreprise);
    update();
  }

  set setAllDocumentEntreprise(List<DocumentEntrepriseModel>? DocumentEntreprises) {
    _allDocumentEntreprise.value = DocumentEntreprises;
    update();
  }

  List<DocumentEntrepriseModel>? get getAllDocumentEntreprises => _allDocumentEntreprise.value;
   Rx<List<DocumentEntrepriseModel>?> get getAllDocumentEntreprisesRx => _allDocumentEntreprise;
  
  DocumentEntrepriseModel? get getCurrentDocumentEntreprise => _currentDocumentEntreprise.value;

}
