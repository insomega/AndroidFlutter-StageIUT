//import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_AppInitializer.dart';
import 'package:gbsystem_root/GBSystem_Root_Params.dart';
import '../GBSystem_Application/GBSystem_Application_Params.dart';
//import '../GBSystem_Application/Routes/GBSystem_Application_Routes.dart';
//import 'package:gbsystem_splash_screen/gbsystem_splash_controller.dart';

class GBSystem_BMEvents_Initializer extends GBSystem_AppInitializer {
  GBSystem_BMEvents_Initializer() {
    // TODO: implement
  }

  static Future<bool> initialize() async {
    final bool result = await GBSystem_AppInitializer.initialize();

    // Initialisation selon l’app courante
    GBSystem_Application_Params_Manager.initialize(GBSystem_BMEvents_Application_Params());

    return result;
  }
}
