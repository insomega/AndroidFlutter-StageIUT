import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_map_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/packages/calendar_package/src/calendar_controller_provider.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/packages/calendar_package/src/calendar_event_data.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/packages/calendar_package/src/enumerations.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/packages/calendar_package/src/event_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/packages/calendar_package/src/month_view/month_view.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DETAILS_EVENT_AGENDA_SCREEN/GBSystem_details_event_agenda_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_events_controller.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    super.key,
  });
  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  RxBool isLoading = RxBool(false);
  final eventsController =
      Get.put<GBSystemEventsController>(GBSystemEventsController());

  List<EventModel>? listEvents = [];
  List<EventAbsenceModel>? listEventsAbsence = [];
  List<CalendarEventData> events = [];

  void initEventsAgenda() {
    events = [];
    listEvents?.forEach(
      (element) {
        events.add(
          CalendarEventData(
            date: element.VAC_START_HOUR ?? DateTime.now(),
            // endDate: element.VAC_END_HOUR,
            title:
                "${AbsenceModel.convertTime(element.VAC_START_HOUR!)}\n${AbsenceModel.convertTime(element.VAC_END_HOUR!)}", //\n
            startTime: element.VAC_START_HOUR,
            endTime: element.VAC_END_HOUR,

            event: element,
            color: Color(int.parse(
              "0xFF${element.backgroundColor!.replaceAll(r"#", "")}",
            )),
          ),
        );
      },
    );
    listEventsAbsence?.forEach(
      (element) {
        events.add(
          CalendarEventData(
            date: element.PLATPH_START_HOUR ?? DateTime.now(),
            endDate: element.PLATPH_END_HOUR,
            title: testAbsencesSameDayAndHasHours(
                    debut: element.PLATPH_START_HOUR,
                    fin: element.PLATPH_END_HOUR)
                ? (checkEventAbsenceIfSameDay(
                        dateDebut: element.PLATPH_START_HOUR!,
                        dateFin: element.PLATPH_END_HOUR!)
                    ? "${element.TPH_CODE}\n${AbsenceModel.convertTime(element.PLATPH_START_HOUR!)}\n${AbsenceModel.convertTime(element.PLATPH_END_HOUR!)}"
                    : "${AbsenceModel.convertTime(element.PLATPH_START_HOUR!)}\n${AbsenceModel.convertTime(element.PLATPH_END_HOUR!)}\n${GbsSystemStrings.str_au.tr}\n${element.PLATPH_END_HOUR!.day} ${DateFormat.MMMM(getLocaleApplication()).format(element.PLATPH_END_HOUR!)} ")
                : "${element.TPH_CODE}",
            description: "abs",
            startTime: element.PLATPH_START_HOUR,
            endTime: element.PLATPH_END_HOUR,
            event: element,
            color: Color(int.parse(
              "0xFF${element.backgroundColor!.replaceAll(r"#", "")}",
            )),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    listEvents = eventsController.getAllEvents;
    listEventsAbsence = eventsController.getAllEventsAbsence;
    initEventsAgenda();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            listEvents != null && listEvents!.isNotEmpty
                ? CalendarControllerProvider(
                    controller: EventController()..addAll(events),
                    child: MonthView(
                      minMonth:
                          getFirstDate(dateDebut: listEvents!.first.start),
                      maxMonth: getLastDate(dateDebut: listEvents!.first.start),
                      weekDayStringBuilder: (p0) {
                        print(p0);
                        return getWeekDaysName()[p0]
                            .substring(0, 2)
                            .toUpperCase();
                      },
                      onEventTap: (event, date) async {
                        if (event.description != 'abs') {
                          isLoading.value = true;

                          await GBSystem_AuthService(context)
                              .getInfoVacationAgenda(
                                  VAC_IDF: (event.event as EventModel).VAC_IDF)
                              .then((value) {
                            isLoading.value = false;

                            final vacationController =
                                Get.put<GBSystemVacationMapController>(
                                    GBSystemVacationMapController());
                            vacationController.setCurrentVacationVacation =
                                value;
                            Get.to(DetailsEventsAgendaScreen());
                          });
                        } else {
                          SnackBar snackBar = SnackBar(
                              content: Text(
                                  "${GbsSystemStrings.str_absence.tr} : ${checkEventAbsenceIfSameDay(dateDebut: (event.event as EventAbsenceModel).PLATPH_START_HOUR!, dateFin: (event.event as EventAbsenceModel).PLATPH_END_HOUR!) ? "${(event.event as EventAbsenceModel).TPH_CODE} ${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_START_HOUR!)} - ${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_END_HOUR!)}" : "${(event.event as EventAbsenceModel).PLATPH_START_HOUR!.day} ${DateFormat.MMMM(getLocaleApplication()).format((event.event as EventAbsenceModel).PLATPH_START_HOUR!)} ${GbsSystemStrings.str_au.tr} ${(event.event as EventAbsenceModel).PLATPH_END_HOUR!.day} ${DateFormat.MMMM(getLocaleApplication()).format((event.event as EventAbsenceModel).PLATPH_END_HOUR!)}"}"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      onEventLongTap: (event, date) {
                        SnackBar snackBar = SnackBar(
                            content: Text(event.description == "abs"
                                ? "${GbsSystemStrings.str_absence.tr} : ${checkEventAbsenceIfSameDay(dateDebut: (event.event as EventAbsenceModel).PLATPH_START_HOUR!, dateFin: (event.event as EventAbsenceModel).PLATPH_END_HOUR!) ? "${(event.event as EventAbsenceModel).TPH_CODE} ${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_START_HOUR!)} - ${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_END_HOUR!)}" : "${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_START_HOUR!)} - ${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_END_HOUR!)} ${GbsSystemStrings.str_au.tr} ${(event.event as EventAbsenceModel).PLATPH_END_HOUR!.day} ${DateFormat.MMMM(getLocaleApplication()).format((event.event as EventAbsenceModel).PLATPH_END_HOUR!)} "}"
                                : "${GbsSystemStrings.str_vacation.tr} : ${AbsenceModel.convertTime((event.event as EventModel).VAC_START_HOUR!)} ${AbsenceModel.convertTime((event.event as EventModel).VAC_END_HOUR!)}"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      startDay: WeekDays.monday,
                      useAvailableVerticalSpace: true,
                    ),
                  )
                : FutureBuilder(
                    future: GBSystem_AuthService(context).getListEvents(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null &&
                            snapshot.data!.listEventModel.isNotEmpty) {
                          listEvents = snapshot.data!.listEventModel;
                          listEventsAbsence =
                              snapshot.data!.listEventAbsenceModel;
                          initEventsAgenda();
                        } else {
                          return EmptyDataWidget();
                        }

                        return CalendarControllerProvider(
                          controller: EventController()..addAll(events),
                          child: MonthView(
                            minMonth: getFirstDate(
                                dateDebut: listEvents!.first.start),
                            maxMonth:
                                getLastDate(dateDebut: listEvents!.first.start),
                            weekDayStringBuilder: (p0) {
                              return getWeekDaysName()[p0]
                                  .substring(0, 2)
                                  .toUpperCase();
                            },
                            onEventTap: (event, date) async {
                              if (event.description != 'abs') {
                                isLoading.value = true;

                                await GBSystem_AuthService(context)
                                    .getInfoVacationAgenda(
                                        VAC_IDF:
                                            (event.event as EventModel).VAC_IDF)
                                    .then((value) {
                                  isLoading.value = false;

                                  final vacationController =
                                      Get.put<GBSystemVacationMapController>(
                                          GBSystemVacationMapController());
                                  vacationController
                                      .setCurrentVacationVacation = value;
                                  Get.to(DetailsEventsAgendaScreen());
                                });
                              } else {
                                SnackBar snackBar = SnackBar(
                                    content: Text(
                                        "${GbsSystemStrings.str_absence.tr} : ${checkEventAbsenceIfSameDay(dateDebut: (event.event as EventAbsenceModel).PLATPH_START_HOUR!, dateFin: (event.event as EventAbsenceModel).PLATPH_END_HOUR!) ? "${(event.event as EventAbsenceModel).TPH_CODE} ${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_START_HOUR!)} - ${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_END_HOUR!)}" : "${(event.event as EventAbsenceModel).PLATPH_START_HOUR!.day} ${DateFormat.MMMM(getLocaleApplication()).format((event.event as EventAbsenceModel).PLATPH_START_HOUR!)} ${GbsSystemStrings.str_au.tr} ${(event.event as EventAbsenceModel).PLATPH_END_HOUR!.day} ${DateFormat.MMMM(getLocaleApplication()).format((event.event as EventAbsenceModel).PLATPH_END_HOUR!)}"}"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            onEventLongTap: (event, date) {
                              SnackBar snackBar = SnackBar(
                                  content: Text(event.description == "abs"
                                      ? "${GbsSystemStrings.str_absence.tr} : ${checkEventAbsenceIfSameDay(dateDebut: (event.event as EventAbsenceModel).PLATPH_START_HOUR!, dateFin: (event.event as EventAbsenceModel).PLATPH_END_HOUR!) ? "${(event.event as EventAbsenceModel).TPH_CODE} ${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_START_HOUR!)} - ${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_END_HOUR!)}" : "${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_START_HOUR!)} - ${AbsenceModel.convertTime((event.event as EventAbsenceModel).PLATPH_END_HOUR!)} ${GbsSystemStrings.str_au.tr} ${(event.event as EventAbsenceModel).PLATPH_END_HOUR!.day} ${DateFormat.MMMM(getLocaleApplication()).format((event.event as EventAbsenceModel).PLATPH_END_HOUR!)} "}"
                                      : "${GbsSystemStrings.str_vacation.tr} : ${AbsenceModel.convertTime((event.event as EventModel).VAC_START_HOUR!)} ${AbsenceModel.convertTime((event.event as EventModel).VAC_END_HOUR!)}"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            startDay: WeekDays.monday,
                            useAvailableVerticalSpace: true,
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Container(
                            height: 250,
                            child: WaitingWidgets(),
                          ),
                        );
                      } else {
                        return EmptyDataWidget();
                      }
                    },
                  ),
            isLoading.value ? Waiting() : Container()
          ],
        ));
  }

  String getLocaleApplication() {
    return Get.locale != null ? Get.locale.toString() : "fr";
  }

  bool checkEventAbsenceIfSameDay(
      {required DateTime dateDebut, required DateTime dateFin}) {
    bool check = false;
    if (dateDebut.year == dateFin.year &&
        dateDebut.month == dateFin.month &&
        dateDebut.day == dateFin.day) {
      check = true;
    }

    return check;
  }

  List<String> getWeekDaysName() {
    return List.generate(
      7,
      (index) {
        DateTime date = DateTime(2024, 1, 1).add(Duration(days: index));
        return DateFormat.EEEE(getLocaleApplication()).format(date);
      },
    );
  }

  DateTime getFirstDate({required DateTime? dateDebut}) {
    return DateTime((dateDebut?.year ?? DateTime.now().year),
        (dateDebut?.month ?? DateTime.now().month), 1);
  }

  DateTime getLastDate({required DateTime? dateDebut}) {
    DateTime nextMonthFirstDay = DateTime(
        (dateDebut?.year ?? DateTime.now().year),
        (dateDebut?.month ?? DateTime.now().month) + 1,
        1);
    int lastDay = nextMonthFirstDay.subtract(Duration(days: 1)).day;
    print("last day $lastDay");
    return DateTime((dateDebut?.year ?? DateTime.now().year),
        (dateDebut?.month ?? DateTime.now().month), lastDay);
  }

  bool testAbsencesSameDayAndHasHours({DateTime? debut, DateTime? fin}) {
    bool test = false;
    //test if the same day
    if (debut?.year == fin?.year &&
        debut?.month == fin?.month &&
        debut?.day == fin?.day) {
      // test if at least on date has hours
      if (!((debut?.hour == 0 && debut?.minute == 0) &&
          (fin?.hour == 0 && fin?.minute == 0))) {
        test = true;
      }
    }
    return test;
  }
}
