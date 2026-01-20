import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_model.dart';

class GBSystemEventAgendaModel {
  final List<EventModel> listEventModel;
  final List<EventAbsenceModel> listEventAbsenceModel;

  GBSystemEventAgendaModel({
    required this.listEventAbsenceModel,
    required this.listEventModel,
  });
}
