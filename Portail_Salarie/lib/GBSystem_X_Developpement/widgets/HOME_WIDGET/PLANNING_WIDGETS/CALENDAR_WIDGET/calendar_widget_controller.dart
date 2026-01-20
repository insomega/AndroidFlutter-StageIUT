import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_events_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_model.dart';

class CalendarWidgetController extends GetxController {
  final eventsController =
      Get.put<GBSystemEventsController>(GBSystemEventsController());

  List<EventModel>? listEvents = [];
  List<EventAbsenceModel>? listEventsAbsence = [];

  @override
  void onInit() {
    listEvents = eventsController.getAllEvents;
    listEventsAbsence = eventsController.getAllEventsAbsence;

    super.onInit();
  }
}
