import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_officiel_select_item_model.dart';

class GBSystemDocumentOfficielController extends GetxController {
  List<getDocumentOfficielSelectItemModel>? _allDocumentOfficiel;
  getDocumentOfficielSelectItemModel? _currentDocumentOfficiel;

  set setDocumentOfficiel(getDocumentOfficielSelectItemModel DocumentOfficiel) {
    _allDocumentOfficiel?.add(DocumentOfficiel);
    update();
  }

  set setCurrentDocumentOfficiel(getDocumentOfficielSelectItemModel? DocumentOfficiel) {
    _currentDocumentOfficiel = DocumentOfficiel;
    update();
  }

  set setDocumentOfficielToLeft(getDocumentOfficielSelectItemModel DocumentOfficiel) {
    _allDocumentOfficiel?.insert(0, DocumentOfficiel);
    update();
  }

  set setDocumentOfficielToRight(getDocumentOfficielSelectItemModel DocumentOfficiel) {
    _allDocumentOfficiel?.insert(_allDocumentOfficiel!.length, DocumentOfficiel);
    update();
  }

  set setAllDocumentOfficiel(List<getDocumentOfficielSelectItemModel>? DocumentOfficiels) {
    _allDocumentOfficiel = DocumentOfficiels;
    update();
  }

  List<getDocumentOfficielSelectItemModel>? get getAllDocumentOfficiels => _allDocumentOfficiel;
  getDocumentOfficielSelectItemModel? get getCurrentDocumentOfficiel => _currentDocumentOfficiel;
}
