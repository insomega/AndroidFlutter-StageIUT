import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/DEMANDE_ABSENCE_SCREEN/GBSystem_demande_absence_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/DEMANDE_INDISPONIBILITER_SCREEN/GBSystem_demande_indisponibiliter_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/DISPONIBILITER_SCREEN/GBSystem_disponibiliter_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/INDISPONIBILITER_MAIN_SCREEN/GBSystem_indisponibiliter_main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/INDISPONIBILITER_SCREEN/GBSystem_indisponibiliter_screen.dart';

class GBSystemAbsenceMainScreenController extends GetxController {
  RxInt currentIndex = 0.obs, pageIndex = 0.obs;

  // Define your screens in a list
  final screens = [
    GBSystemDemandeAbsenceScreen(),
    GBSystemIndisponibiliterMainScreen(
      selectedIndexFromOut: 0,
    ),
    // GBSystemDemandeIndisponibiliterScreen(),
    // GBSystemIndisponibiliterScreen(),
    GBSystemDisponibiliterScreen()
  ];
}
