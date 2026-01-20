import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_state_controller.dart';

class GbsystemMapScreenController extends GetxController {
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
  final vacationStateController = Get.put<GBSystemVacationStateController>(
      GBSystemVacationStateController());
  RxBool markerUserVisibility = RxBool(false);
  RxBool markerLocationVisibility = RxBool(false);
}
