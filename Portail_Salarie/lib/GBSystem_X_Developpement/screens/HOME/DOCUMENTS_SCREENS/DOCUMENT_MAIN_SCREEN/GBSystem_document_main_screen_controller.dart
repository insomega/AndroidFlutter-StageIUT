import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DOCUMENTS_SCREENS/DOCUMENT_DE_ENTREPRISE_SCREEN/GBSystem_document_de_entreprise_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DOCUMENTS_SCREENS/DOCUMENT_SCREEN/GBSystem_document_screen.dart';

class GBSystemDocumentMainScreenController extends GetxController {
  RxInt currentIndex = 0.obs, pageIndex = 0.obs;

  // Define your screens in a list
  final screens = [
    GBSystemDocumentScreen(),
    GBSystemDocumentDeEntrepriseScreen(),
    // GBSystemNotesDeFraisScreen()
  ];
}
