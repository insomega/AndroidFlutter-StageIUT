import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/DEMANDE_INDISPONIBILITER_SCREEN/GBSystem_demande_indisponibiliter_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/INDISPONIBILITER_SCREEN/GBSystem_indisponibiliter_screen.dart';

class GBSystemIndisponibiliterMainScreenController extends GetxController {
  RxInt currentIndex = 0.obs, pageIndex = 0.obs;

  // Define your screens in a list
  final screens = [
    GBSystemDemandeIndisponibiliterScreen(),
    GBSystemIndisponibiliterScreen(),
  ];
}
