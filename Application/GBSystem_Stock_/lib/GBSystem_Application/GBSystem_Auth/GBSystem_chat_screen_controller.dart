import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';
import 'GBSystem_messages_controller.dart';
import 'GBSystem_nombre_notifications_controller.dart';
import 'GBSystem_salarie_controller.dart';
import 'GBSystem_salarie_photo_model.dart';

class GBSystemChatScreenController extends GetxController {
  GBSystemSalarieWithPhotoModel? salarie;

  RxBool isLoading = RxBool(false);
  bool isPageOpened = false;
  final salarieController = Get.put<GBSystemSalarieController>(GBSystemSalarieController());

  final notificationController = Get.put<GBSystemNotificationController>(GBSystemNotificationController());
  final messagesController = Get.put<GBSystemMessagesController>(GBSystemMessagesController());

  RxString? selectedItem = "".obs;
  List<String> listItems = [GBSystem_Application_Strings.str_prise_de_service, GBSystem_Application_Strings.str_vacation, GBSystem_Application_Strings.str_cloturer, GBSystem_Application_Strings.str_absence, GBSystem_Application_Strings.str_info];
  @override
  void onInit() {
    isPageOpened = true;
    salarie = salarieController.getSalarie;

    super.onInit();
  }
}
