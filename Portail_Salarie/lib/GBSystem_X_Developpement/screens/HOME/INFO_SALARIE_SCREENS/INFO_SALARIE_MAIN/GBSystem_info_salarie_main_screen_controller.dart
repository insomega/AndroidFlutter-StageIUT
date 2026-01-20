import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/CARTE_PROFFISIONEL_SCREEN/GBSystem_carte_proffisionel_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/CHAT_SCREEN/GBSystem_chat_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/OPTIONS_SCREEN/GBSystem_options_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/TENUE_SCREEN/GBSystem_tenue_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/modifier_informations_screen/GBSystem_modifier_informations_screen.dart';

class GBSystemInfoSalarieMainScreenController extends GetxController {
  RxInt currentIndex = 0.obs, pageIndex = 0.obs;

  // Define your screens in a list
  final screens = [
    GBSystemModifierInformationsScreen(
      isCommingFromOut: true,
    ),
    GBSystemCarteProffisionelScreen(),
    GbsystemTenueScreen(),
    GBSystemChatScreen(),
    GBSystemOptionsScreen(),
  ];
}
