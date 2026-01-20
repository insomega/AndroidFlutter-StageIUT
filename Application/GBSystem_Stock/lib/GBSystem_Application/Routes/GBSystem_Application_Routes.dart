import 'package:gbsystem_onboarding/GBSystem_Onboarding_Controller.dart';

import 'package:gbsystem_connexion/GBSystem_Login_Controller.dart';

class GBSystem_Application_Routes {
  static const login = GBSystem_Login_Controller.routeName;
  static const onboarding = GBSystem_Onboarding_Controller.routeName;
  static const mdp_oublier = '/login/mdp_oublier';
  static const mdp_change = '/login/mdp_change';
  static const dashboard = '/dashboard';
  static const mainAppView = '/mainAppView';
  static const homeGestionStock = '/homeGestionStock';

  //static const splashScreen = '/splashScreen';
  // Ajoutez les vues manquantes utilisées dans votre MenuService
  static const View1 = '/view1';
  static const View2 = '/view2';
  static const View3 = '/view3';
  static const View4 = '/view4';
}
