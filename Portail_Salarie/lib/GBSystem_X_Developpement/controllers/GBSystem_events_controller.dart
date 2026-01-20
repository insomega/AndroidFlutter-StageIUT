import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_model.dart';

class GBSystemEventsController extends GetxController {
  List<EventModel>? _allEvents;
  List<EventAbsenceModel>? _allEventsAbsence;
  EventModel? _currentEvent;

  VacationModel? _currentVacationEvent;

  set setEvent(EventModel Event) {
    _allEvents?.add(Event);
    update();
  }

  set setCurrentEventEvent(EventModel? Event) {
    _currentEvent = Event;
    update();
  }

  set setCurrentVacationEvent(VacationModel? vacationModel) {
    _currentVacationEvent = vacationModel;
    update();
  }

  set setEventToLeft(EventModel Event) {
    _allEvents?.insert(0, Event);
    update();
  }

  set setEventToRight(EventModel Event) {
    _allEvents?.insert(_allEvents!.length, Event);
    update();
  }

  set setAllEvent(List<EventModel>? Events) {
    _allEvents = Events;
    update();
  }

  set setAllEventAbsence(List<EventAbsenceModel>? EventsAbsence) {
    _allEventsAbsence = EventsAbsence;
    update();
  }

  List<EventModel>? get getAllEvents => _allEvents;
  List<EventAbsenceModel>? get getAllEventsAbsence => _allEventsAbsence;

  EventModel? get getCurrentEvent => _currentEvent;
  VacationModel? get getCurrentVacationEvent => _currentVacationEvent;
}
