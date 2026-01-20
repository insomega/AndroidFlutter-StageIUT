import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DEMANDE_VACATION_SCREEN/GBSystem_demande_vacation_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/DISPONIBILITER_PROPOSITION_DE_VACATION_SCREEN/GBSystem_diponibiliter_proposition_vacation_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/EXCLUSION_PROPOSITIONS_DE_VACATION/GBSystem_exclusion_propositions_de_vacation.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/PLANNING_SCREEN/GBSystem_planning_screen.dart';

class GBSystemPlanningMainScreenController extends GetxController {
  GBSystemPlanningMainScreenController({required this.selectedIndex});

  // RxInt currentIndex = 0.obs,
  int selectedIndex;
  RxInt pageIndex = 0.obs;
  RxInt currentIndex = 0.obs;
  @override
  void onInit() {
    currentIndex.value = selectedIndex;
    super.onInit();
  }

  @override
  void onClose() {
    currentIndex.value = 0;
    super.onClose();
  }

  // Define your screens in a list
  final screens = [
    GBSystemPlanningScreen(),
    GBSystemDemandeVacationScreen(
      isPriseDeVacation: true,
    ),
    DisponibiliterPropositionVacationScreen(),
    ExclusionPropositionsDeVacation()
  ];
}
