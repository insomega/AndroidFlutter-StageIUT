import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_messages_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_nombre_notifications_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemChatScreenController extends GetxController {
  GBSystemSalarieWithPhotoModel? salarie;

  RxBool isLoading = RxBool(false);
  bool isPageOpened = false;
  final salarieController =
      Get.put<GBSystemSalarieController>(GBSystemSalarieController());

  final notificationController =
      Get.put<GBSystemNotificationController>(GBSystemNotificationController());
  final messagesController =
      Get.put<GBSystemMessagesController>(GBSystemMessagesController());

  RxString? selectedItem = "".obs;
  List<String> listItems = [
    GbsSystemStrings.str_prise_de_service,
    GbsSystemStrings.str_vacation,
    GbsSystemStrings.str_cloturer,
    GbsSystemStrings.str_absence,
    GbsSystemStrings.str_info
  ];
  @override
  void onInit() {
    isPageOpened = true;
    salarie = salarieController.getSalarie;

    super.onInit();
  }
}
