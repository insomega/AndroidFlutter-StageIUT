import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_map_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_event_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DETAILS_EVENT_AGENDA_SCREEN/GBSystem_details_event_agenda_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_events_controller.dart';

// ignore: must_be_immutable
class CalendarWidget extends StatefulWidget {
  CalendarWidget({
    super.key,
    required this.calendarFormat,
  });
  final CalendarFormat calendarFormat;
  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

// GBSystemEventAgendaModel
class _CalendarWidgetState extends State<CalendarWidget> {
  RxBool isLoading = RxBool(false);
  final eventsController =
      Get.put<GBSystemEventsController>(GBSystemEventsController());

  List<EventModel>? listEvents = [];
  List<EventAbsenceModel>? listEventsAbsence = [];

  @override
  void initState() {
    initializeDateFormatting(getCurrentLocaleCode().value);
    listEvents = eventsController.getAllEvents;
    listEventsAbsence = eventsController.getAllEventsAbsence;

    super.initState();
  }

  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    updateUI();

    // print(listEvents);
    // print(listEventsAbsence);
    // listEvents!.forEach((element) {
    //   print(
    //       "event  ---> ${element.START_HOUR?.day} : ${element.END_HOUR?.day}");
    // });
    return Obx(() => Stack(
          children: [
            listEvents != null && listEvents!.isNotEmpty
                ? Obx(() => FutureBuilder(
                      future: initializeDateFormatting(
                          getCurrentLocaleCode().value),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return SingleChildScrollView(
                            child: TableCalendar(
                              pageJumpingEnabled: false,
                              availableGestures: AvailableGestures.none,

                              headerStyle: HeaderStyle(
                                  leftChevronVisible: false,
                                  rightChevronVisible: false,
                                  formatButtonVisible: false,
                                  titleCentered: true),
                              // headerVisible: false,
                              onFormatChanged: (format) {
                                // print(format);
                              },

                              locale: getCurrentLocaleCode().value,

                              currentDay: DateTime(2050),
                              firstDay: DateTime.utc(2020, 10, 16),
                              lastDay: DateTime.utc(2050, 3, 14),
                              focusedDay: listEvents?.first.VAC_START_HOUR! ??
                                  DateTime.now(),
                              calendarFormat: widget.calendarFormat,

                              calendarBuilders: CalendarBuilders(
                                  // defaultBuilder:
                                  outsideBuilder: (context, day, focusedDay) {
                                {
                                  if (listEvents != null &&
                                      listEvents!.isNotEmpty &&
                                      checkDateExistInListEvents(
                                          day: day, lisDates: listEvents!)) {
                                    List<EventModel>? eventModel = verifierDate(
                                        day: day, lisDates: listEvents!);
                                    if (eventModel != null) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: eventModel.length,
                                        itemBuilder:
                                            (context, index) =>
                                                verifierDateBool(
                                                        eventModel:
                                                            eventModel[index])
                                                    ? InkWell(
                                                        onTap: () async {
                                                          isLoading.value =
                                                              true;

                                                          await GBSystem_AuthService(
                                                                  context)
                                                              .getInfoVacationAgenda(
                                                                  VAC_IDF: eventModel[
                                                                          index]
                                                                      .VAC_IDF)
                                                              .then((value) {
                                                            isLoading.value =
                                                                false;

                                                            final vacationController =
                                                                Get.put<GBSystemVacationMapController>(
                                                                    GBSystemVacationMapController());
                                                            vacationController
                                                                    .setCurrentVacationVacation =
                                                                value;
                                                            Get.to(
                                                                DetailsEventsAgendaScreen());
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  // this line to show current day with the first event only (for current day events)
                                                                  color: index == 0
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                // this line to show current day with the first event only (for current day events)

                                                                Visibility(
                                                                  visible:
                                                                      index ==
                                                                          0,
                                                                  child: Container(
                                                                      child: Center(
                                                                          child: GBSystem_TextHelper().superSmallText(
                                                                              maxLines: 2,
                                                                              text: day.day.toString()))),
                                                                ),
                                                                SizedBox(
                                                                  height: 2,
                                                                ),
                                                                //                 final hexColor = eventModel.backgroundColor!
                                                                //     .replaceAll(r"#", "");
                                                                // final color = Color(int.parse(
                                                                //   '0xFF$hexColor',
                                                                // ));
                                                                Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          int.parse(
                                                                        "0xFF${eventModel[index].backgroundColor!.replaceAll(r"#", "")}",
                                                                      )),
                                                                    ),
                                                                    child: Center(
                                                                        child: GBSystem_TextHelper().superSmallText(maxLines: 2, text: "${AbsenceModel.convertTime(eventModel[index].VAC_START_HOUR!)} ${AbsenceModel.convertTime(eventModel[index].VAC_END_HOUR!)}"
                                                                            // "${eventModel.VAC_START_HOUR!.hour}:${eventModel.VAC_START_HOUR!.minute} ${eventModel.VAC_END_HOUR!.hour}:${eventModel.VAC_END_HOUR!.minute}")),
                                                                            ))),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () async {
                                                          isLoading.value =
                                                              true;

                                                          await GBSystem_AuthService(
                                                                  context)
                                                              .getInfoVacationAgenda(
                                                                  VAC_IDF: eventModel[
                                                                          index]
                                                                      .VAC_IDF)
                                                              .then((value) {
                                                            isLoading.value =
                                                                false;

                                                            final vacationController =
                                                                Get.put<GBSystemVacationMapController>(
                                                                    GBSystemVacationMapController());
                                                            vacationController
                                                                    .setCurrentVacationVacation =
                                                                value;
                                                            Get.to(
                                                                DetailsEventsAgendaScreen());
                                                          });
                                                        },
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Visibility(
                                                              visible:
                                                                  index == 0,
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  child: Center(
                                                                      child: GBSystem_TextHelper().superSmallText(
                                                                          maxLines:
                                                                              2,
                                                                          text: day
                                                                              .day
                                                                              .toString()))),
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Color(int
                                                                          .parse(
                                                                        "0xFF${eventModel[index].backgroundColor!.replaceAll(r"#", "")}",
                                                                      )),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                              child: Center(
                                                                  child: GBSystem_TextHelper()
                                                                      .superSmallText(
                                                                          maxLines:
                                                                              2,
                                                                          text:
                                                                              "${AbsenceModel.convertTime(eventModel[index].VAC_START_HOUR!)} ${AbsenceModel.convertTime(eventModel[index].VAC_END_HOUR!)}")),
                                                              // "${eventModel.VAC_START_HOUR!.hour}:${eventModel.VAC_START_HOUR!.minute} ${eventModel.VAC_END_HOUR!.hour}:${eventModel.VAC_END_HOUR!.minute}")),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                              child: Text(day.day.toString())),
                                        ),
                                      );
                                    }
                                  } else if (listEventsAbsence != null) {
                                    List<int> allDaysAbsence =
                                        getListDaysOfListEventAbsence(
                                            listEventAbsenceModel:
                                                listEventsAbsence!);

                                    if (allDaysAbsence.contains(day.day)) {
                                      EventAbsenceModel? currentAbsence =
                                          getEventAbsenceByDay(
                                              day: day,
                                              lisDates: listEventsAbsence!);

                                      return Column(
                                        children: [
                                          GBSystem_TextHelper().superSmallText(
                                            text: day.day.toString(),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 50,
                                            margin: currentAbsence != null &&
                                                    checkEventIfOnly(
                                                        event: currentAbsence,
                                                        listEventsAbsence:
                                                            listEventsAbsence!)
                                                ? EdgeInsets.symmetric(
                                                    horizontal: 5)
                                                : null,
                                            decoration:
                                                BoxDecoration(boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Colors.red.withOpacity(0.3),
                                                spreadRadius: -30,
                                                blurRadius: 12,
                                                offset: const Offset(3,
                                                    3), // changes the shadow position
                                              ),
                                            ], color: Colors.red),
                                            child: Row(
                                              children: [
                                                SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      currentAbsence != null &&
                                                              checkEventIfOnly(
                                                                  event:
                                                                      currentAbsence,
                                                                  listEventsAbsence:
                                                                      listEventsAbsence!)
                                                          ? GBSystem_TextHelper()
                                                              .superSmallText(
                                                                  text:
                                                                      "${currentAbsence.TPH_CODE!}")
                                                          : Container(),
                                                      GBSystem_TextHelper()
                                                          .superSmallText(
                                                              text: currentAbsence !=
                                                                      null
                                                                  ? "${AbsenceModel.convertTime(currentAbsence.PLATPH_START_HOUR!)} "
                                                                  : ""),
                                                      GBSystem_TextHelper()
                                                          .superSmallText(
                                                              text: currentAbsence !=
                                                                      null
                                                                  ? "${AbsenceModel.convertTime(currentAbsence.PLATPH_END_HOUR!)} "
                                                                  : ""),
                                                      currentAbsence != null &&
                                                              checkEventIfLastAndNotOnly(
                                                                  event:
                                                                      currentAbsence,
                                                                  listEventsAbsence:
                                                                      listEventsAbsence!)
                                                          ? Column(
                                                              children: [
                                                                GBSystem_TextHelper()
                                                                    .superSmallText(
                                                                        text:
                                                                            "au ${currentAbsence.PLATPH_END_HOUR!.day}"),
                                                                GBSystem_TextHelper()
                                                                    .superSmallText(
                                                                        text:
                                                                            "${DateFormat.MMMM(getLocaleApplication()).format(currentAbsence.PLATPH_END_HOUR!)} "),
                                                              ],
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                            child: Text(day.day.toString())),
                                      ),
                                    );
                                  }
                                }
                              }, defaultBuilder: (context, day, focusedDay) {
                                if (listEventsAbsence != null) {
                                  List<int> allDaysAbsence =
                                      getListDaysOfListEventAbsence(
                                          listEventAbsenceModel:
                                              listEventsAbsence!);

                                  if (allDaysAbsence.contains(day.day)) {
                                    EventAbsenceModel? currentAbsence =
                                        getEventAbsenceByDay(
                                            day: day,
                                            lisDates: listEventsAbsence!);

                                    return Column(
                                      children: [
                                        GBSystem_TextHelper().superSmallText(
                                          text: day.day.toString(),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 50,
                                          margin: currentAbsence != null &&
                                                  checkEventIfOnly(
                                                      event: currentAbsence,
                                                      listEventsAbsence:
                                                          listEventsAbsence!)
                                              ? EdgeInsets.symmetric(
                                                  horizontal: 5)
                                              : null,
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.3),
                                              spreadRadius: -30,
                                              blurRadius: 12,
                                              offset: const Offset(3,
                                                  3), // changes the shadow position
                                            ),
                                          ], color: Colors.red),
                                          child: Row(
                                            children: [
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    currentAbsence != null &&
                                                            checkEventIfOnly(
                                                                event:
                                                                    currentAbsence,
                                                                listEventsAbsence:
                                                                    listEventsAbsence!)
                                                        ? GBSystem_TextHelper()
                                                            .superSmallText(
                                                                text:
                                                                    "${currentAbsence.TPH_CODE!}")
                                                        : Container(),
                                                    GBSystem_TextHelper()
                                                        .superSmallText(
                                                            text: currentAbsence !=
                                                                    null
                                                                ? "${AbsenceModel.convertTime(currentAbsence.PLATPH_START_HOUR!)} "
                                                                : ""),
                                                    GBSystem_TextHelper()
                                                        .superSmallText(
                                                            text: currentAbsence !=
                                                                    null
                                                                ? "${AbsenceModel.convertTime(currentAbsence.PLATPH_END_HOUR!)} "
                                                                : ""),
                                                    currentAbsence != null &&
                                                            checkEventIfLastAndNotOnly(
                                                                event:
                                                                    currentAbsence,
                                                                listEventsAbsence:
                                                                    listEventsAbsence!)
                                                        ? Column(
                                                            children: [
                                                              GBSystem_TextHelper()
                                                                  .superSmallText(
                                                                      text:
                                                                          "au ${currentAbsence.PLATPH_END_HOUR!.day}"),
                                                              GBSystem_TextHelper()
                                                                  .superSmallText(
                                                                      text:
                                                                          "${DateFormat.MMMM(getLocaleApplication()).format(currentAbsence.PLATPH_END_HOUR!)} "),
                                                            ],
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }

                                if (listEvents != null &&
                                    listEvents!.isNotEmpty &&
                                    checkDateExistInListEvents(
                                        day: day, lisDates: listEvents!)) {
                                  List<EventModel>? eventModel = verifierDate(
                                      day: day, lisDates: listEvents!);
                                  if (eventModel != null) {
                                    // final hexColor = eventModel.backgroundColor!
                                    //     .replaceAll(r"#", "");
                                    // final color = Color(int.parse(
                                    //   '0xFF$hexColor',
                                    // ));

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: eventModel.length,
                                      itemBuilder: (context, index) =>
                                          verifierDateBool(
                                                  eventModel: eventModel[index])
                                              ? InkWell(
                                                  onTap: () async {
                                                    isLoading.value = true;

                                                    await GBSystem_AuthService(
                                                            context)
                                                        .getInfoVacationAgenda(
                                                            VAC_IDF: eventModel[
                                                                    index]
                                                                .VAC_IDF)
                                                        .then((value) {
                                                      isLoading.value = false;

                                                      final vacationController =
                                                          Get.put<GBSystemVacationMapController>(
                                                              GBSystemVacationMapController());
                                                      vacationController
                                                              .setCurrentVacationVacation =
                                                          value;
                                                      Get.to(
                                                          DetailsEventsAgendaScreen());
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        // this line to show current day with the first event only (for current day events)
                                                        color: index == 0
                                                            ? Colors.red
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          // this line to show current day with the first event only (for current day events)

                                                          Visibility(
                                                            visible: index == 0,
                                                            child: Container(
                                                                child: Center(
                                                                    child: GBSystem_TextHelper().superSmallText(
                                                                        maxLines:
                                                                            2,
                                                                        text: day
                                                                            .day
                                                                            .toString()))),
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          //                 final hexColor = eventModel.backgroundColor!
                                                          //     .replaceAll(r"#", "");
                                                          // final color = Color(int.parse(
                                                          //   '0xFF$hexColor',
                                                          // ));
                                                          Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    int.parse(
                                                                  "0xFF${eventModel[index].backgroundColor!.replaceAll(r"#", "")}",
                                                                )),
                                                              ),
                                                              child: Center(
                                                                  child: GBSystem_TextHelper().superSmallText(
                                                                      maxLines:
                                                                          2,
                                                                      text:
                                                                          "${AbsenceModel.convertTime(eventModel[index].VAC_START_HOUR!)} ${AbsenceModel.convertTime(eventModel[index].VAC_END_HOUR!)}"
                                                                      // "${eventModel.VAC_START_HOUR!.hour}:${eventModel.VAC_START_HOUR!.minute} ${eventModel.VAC_END_HOUR!.hour}:${eventModel.VAC_END_HOUR!.minute}")),
                                                                      ))),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    isLoading.value = true;

                                                    await GBSystem_AuthService(
                                                            context)
                                                        .getInfoVacationAgenda(
                                                            VAC_IDF: eventModel[
                                                                    index]
                                                                .VAC_IDF)
                                                        .then((value) {
                                                      isLoading.value = false;

                                                      final vacationController =
                                                          Get.put<GBSystemVacationMapController>(
                                                              GBSystemVacationMapController());
                                                      vacationController
                                                              .setCurrentVacationVacation =
                                                          value;
                                                      Get.to(
                                                          DetailsEventsAgendaScreen());
                                                    });
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Visibility(
                                                        visible: index == 0,
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child: Center(
                                                                child: GBSystem_TextHelper()
                                                                    .superSmallText(
                                                                        maxLines:
                                                                            2,
                                                                        text: day
                                                                            .day
                                                                            .toString()))),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    int.parse(
                                                                  "0xFF${eventModel[index].backgroundColor!.replaceAll(r"#", "")}",
                                                                )),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        child: Center(
                                                            child: GBSystem_TextHelper()
                                                                .superSmallText(
                                                                    maxLines: 2,
                                                                    text:
                                                                        "${AbsenceModel.convertTime(eventModel[index].VAC_START_HOUR!)} ${AbsenceModel.convertTime(eventModel[index].VAC_END_HOUR!)}")),
                                                        // "${eventModel.VAC_START_HOUR!.hour}:${eventModel.VAC_START_HOUR!.minute} ${eventModel.VAC_END_HOUR!.hour}:${eventModel.VAC_END_HOUR!.minute}")),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                            child: Text(day.day.toString())),
                                      ),
                                    );
                                  }
                                } else if (listEventsAbsence != null) {
                                  List<int> allDaysAbsence =
                                      getListDaysOfListEventAbsence(
                                          listEventAbsenceModel:
                                              listEventsAbsence!);

                                  if (allDaysAbsence.contains(day.day)) {
                                    EventAbsenceModel? currentAbsence =
                                        getEventAbsenceByDay(
                                            day: day,
                                            lisDates: listEventsAbsence!);

                                    return Column(
                                      children: [
                                        GBSystem_TextHelper().superSmallText(
                                          text: day.day.toString(),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 50,
                                          margin: currentAbsence != null &&
                                                  checkEventIfOnly(
                                                      event: currentAbsence,
                                                      listEventsAbsence:
                                                          listEventsAbsence!)
                                              ? EdgeInsets.symmetric(
                                                  horizontal: 5)
                                              : null,
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.3),
                                              spreadRadius: -30,
                                              blurRadius: 12,
                                              offset: const Offset(3,
                                                  3), // changes the shadow position
                                            ),
                                          ], color: Colors.red),
                                          child: Row(
                                            children: [
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    currentAbsence != null &&
                                                            checkEventIfOnly(
                                                                event:
                                                                    currentAbsence,
                                                                listEventsAbsence:
                                                                    listEventsAbsence!)
                                                        ? GBSystem_TextHelper()
                                                            .superSmallText(
                                                                text:
                                                                    "${currentAbsence.TPH_CODE!}")
                                                        : Container(),
                                                    GBSystem_TextHelper()
                                                        .superSmallText(
                                                            text: currentAbsence !=
                                                                    null
                                                                ? "${AbsenceModel.convertTime(currentAbsence.PLATPH_START_HOUR!)} "
                                                                : ""),
                                                    GBSystem_TextHelper()
                                                        .superSmallText(
                                                            text: currentAbsence !=
                                                                    null
                                                                ? "${AbsenceModel.convertTime(currentAbsence.PLATPH_END_HOUR!)} "
                                                                : ""),
                                                    currentAbsence != null &&
                                                            checkEventIfLastAndNotOnly(
                                                                event:
                                                                    currentAbsence,
                                                                listEventsAbsence:
                                                                    listEventsAbsence!)
                                                        ? Column(
                                                            children: [
                                                              GBSystem_TextHelper()
                                                                  .superSmallText(
                                                                      text:
                                                                          "au ${currentAbsence.PLATPH_END_HOUR!.day}"),
                                                              GBSystem_TextHelper()
                                                                  .superSmallText(
                                                                      text:
                                                                          "${DateFormat.MMMM(getLocaleApplication()).format(currentAbsence.PLATPH_END_HOUR!)} "),
                                                            ],
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                          child: Text(day.day.toString())),
                                    ),
                                  );
                                }
                              }),
                            ),
                          );
                        } else {
                          return WaitingWidgets();
                        }
                      },
                    ))
                : FutureBuilder(
                    future: GBSystem_AuthService(context).getListEvents(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null &&
                            snapshot.data!.listEventModel.isNotEmpty) {
                          listEvents = snapshot.data!.listEventModel;
                          listEventsAbsence =
                              snapshot.data!.listEventAbsenceModel;
                        } else {
                          return EmptyDataWidget();
                        }

                        return Obx(() => FutureBuilder(
                              future: initializeDateFormatting(
                                  getCurrentLocaleCode().value),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return SingleChildScrollView(
                                    child: TableCalendar(
                                      pageJumpingEnabled: false,
                                      availableGestures: AvailableGestures.none,

                                      currentDay: DateTime(2050),
                                      firstDay: DateTime.utc(2020, 10, 16),
                                      lastDay: DateTime.utc(2050, 3, 14),
                                      // focusedDay: widget.focusedDay,
                                      focusedDay:
                                          listEvents?.first.VAC_START_HOUR! ??
                                              DateTime.now(),
                                      locale: getCurrentLocaleCode().value,
                                      headerStyle: HeaderStyle(
                                          formatButtonVisible: false,
                                          leftChevronVisible: false,
                                          rightChevronVisible: false,
                                          titleCentered: true),

                                      calendarFormat: widget.calendarFormat,
                                      calendarBuilders: CalendarBuilders(
                                          // defaultBuilder:
                                          outsideBuilder:
                                              (context, day, focusedDay) {
                                        {
                                          if (listEventsAbsence != null) {
                                            List<int> allDaysAbsence =
                                                getListDaysOfListEventAbsence(
                                                    listEventAbsenceModel:
                                                        listEventsAbsence!);

                                            if (allDaysAbsence
                                                .contains(day.day)) {
                                              EventAbsenceModel?
                                                  currentAbsence =
                                                  getEventAbsenceByDay(
                                                      day: day,
                                                      lisDates:
                                                          listEventsAbsence!);

                                              return Column(
                                                children: [
                                                  GBSystem_TextHelper()
                                                      .superSmallText(
                                                    text: day.day.toString(),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 30,
                                                    width: 50,
                                                    margin: currentAbsence !=
                                                                null &&
                                                            checkEventIfOnly(
                                                                event:
                                                                    currentAbsence,
                                                                listEventsAbsence:
                                                                    listEventsAbsence!)
                                                        ? EdgeInsets.symmetric(
                                                            horizontal: 5)
                                                        : null,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: -30,
                                                            blurRadius: 12,
                                                            offset: const Offset(
                                                                3,
                                                                3), // changes the shadow position
                                                          ),
                                                        ],
                                                        color: Colors.red),
                                                    child: Row(
                                                      children: [
                                                        SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              currentAbsence !=
                                                                          null &&
                                                                      checkEventIfOnly(
                                                                          event:
                                                                              currentAbsence,
                                                                          listEventsAbsence:
                                                                              listEventsAbsence!)
                                                                  ? GBSystem_TextHelper()
                                                                      .superSmallText(
                                                                          text:
                                                                              "${currentAbsence.TPH_CODE!}")
                                                                  : Container(),
                                                              GBSystem_TextHelper()
                                                                  .superSmallText(
                                                                      text: currentAbsence !=
                                                                              null
                                                                          ? "${AbsenceModel.convertTime(currentAbsence.PLATPH_START_HOUR!)} "
                                                                          : ""),
                                                              GBSystem_TextHelper()
                                                                  .superSmallText(
                                                                      text: currentAbsence !=
                                                                              null
                                                                          ? "${AbsenceModel.convertTime(currentAbsence.PLATPH_END_HOUR!)} "
                                                                          : ""),
                                                              currentAbsence !=
                                                                          null &&
                                                                      checkEventIfLastAndNotOnly(
                                                                          event:
                                                                              currentAbsence,
                                                                          listEventsAbsence:
                                                                              listEventsAbsence!)
                                                                  ? Column(
                                                                      children: [
                                                                        GBSystem_TextHelper().superSmallText(
                                                                            text:
                                                                                "au ${currentAbsence.PLATPH_END_HOUR!.day}"),
                                                                        GBSystem_TextHelper().superSmallText(
                                                                            text:
                                                                                "${DateFormat.MMMM(getLocaleApplication()).format(currentAbsence.PLATPH_END_HOUR!)} "),
                                                                      ],
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          }

                                          // if (listEventsAbsence != null &&
                                          //     checkDateExistInListEventsAbsence(
                                          //         day: day,
                                          //         lisDates: listEventsAbsence!)) {
                                          //   List<int> listDaysOfEvent =
                                          //       getListDaysOfEventAbsence(
                                          //           eventAbsenceModel:
                                          //               getEventAbsenceByDay(
                                          //                   day: day,
                                          //                   lisDates:
                                          //                       listEventsAbsence!)!);
                                          //   print("day : ${day.day}");
                                          //   print("list $listDaysOfEvent");
                                          //   print(
                                          //       "condition ${listDaysOfEvent.contains(day.day)}");

                                          //   if (listDaysOfEvent.contains(day.day)) {
                                          //     return Container(
                                          //       alignment: Alignment.center,
                                          //       height: 30,
                                          //       width: 30,
                                          //       decoration:
                                          //           BoxDecoration(color: Colors.red),
                                          //     );
                                          //   }
                                          // }

                                          if (listEvents != null &&
                                              listEvents!.isNotEmpty &&
                                              checkDateExistInListEvents(
                                                  day: day,
                                                  lisDates: listEvents!)) {
                                            List<EventModel>? eventModel =
                                                verifierDate(
                                                    day: day,
                                                    lisDates: listEvents!);
                                            if (eventModel != null) {
                                              // final hexColor = eventModel.backgroundColor!
                                              //     .replaceAll(r"#", "");
                                              // final color = Color(int.parse(
                                              //   '0xFF$hexColor',
                                              // ));

                                              return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: eventModel.length,
                                                itemBuilder:
                                                    (context, index) =>
                                                        verifierDateBool(
                                                                eventModel:
                                                                    eventModel[
                                                                        index])
                                                            ? InkWell(
                                                                onTap:
                                                                    () async {
                                                                  isLoading
                                                                          .value =
                                                                      true;

                                                                  await GBSystem_AuthService(
                                                                          context)
                                                                      .getInfoVacationAgenda(
                                                                          VAC_IDF: eventModel[index]
                                                                              .VAC_IDF)
                                                                      .then(
                                                                          (value) {
                                                                    isLoading
                                                                            .value =
                                                                        false;

                                                                    final vacationController =
                                                                        Get.put<GBSystemVacationMapController>(
                                                                            GBSystemVacationMapController());
                                                                    vacationController
                                                                            .setCurrentVacationVacation =
                                                                        value;
                                                                    Get.to(
                                                                        DetailsEventsAgendaScreen());
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          // this line to show current day with the first event only (for current day events)
                                                                          color: index == 0
                                                                              ? Colors.red
                                                                              : Colors.transparent,
                                                                          borderRadius: BorderRadius.circular(8)),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        // this line to show current day with the first event only (for current day events)

                                                                        Visibility(
                                                                          visible:
                                                                              index == 0,
                                                                          child:
                                                                              Container(child: Center(child: GBSystem_TextHelper().superSmallText(maxLines: 2, text: day.day.toString()))),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        //                 final hexColor = eventModel.backgroundColor!
                                                                        //     .replaceAll(r"#", "");
                                                                        // final color = Color(int.parse(
                                                                        //   '0xFF$hexColor',
                                                                        // ));
                                                                        Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(int.parse(
                                                                                "0xFF${eventModel[index].backgroundColor!.replaceAll(r"#", "")}",
                                                                              )),
                                                                            ),
                                                                            child: Center(
                                                                                child: GBSystem_TextHelper().superSmallText(maxLines: 2, text: "${AbsenceModel.convertTime(eventModel[index].VAC_START_HOUR!)} ${AbsenceModel.convertTime(eventModel[index].VAC_END_HOUR!)}"
                                                                                    // "${eventModel.VAC_START_HOUR!.hour}:${eventModel.VAC_START_HOUR!.minute} ${eventModel.VAC_END_HOUR!.hour}:${eventModel.VAC_END_HOUR!.minute}")),
                                                                                    ))),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : InkWell(
                                                                onTap:
                                                                    () async {
                                                                  isLoading
                                                                          .value =
                                                                      true;

                                                                  await GBSystem_AuthService(
                                                                          context)
                                                                      .getInfoVacationAgenda(
                                                                          VAC_IDF: eventModel[index]
                                                                              .VAC_IDF)
                                                                      .then(
                                                                          (value) {
                                                                    isLoading
                                                                            .value =
                                                                        false;

                                                                    final vacationController =
                                                                        Get.put<GBSystemVacationMapController>(
                                                                            GBSystemVacationMapController());
                                                                    vacationController
                                                                            .setCurrentVacationVacation =
                                                                        value;
                                                                    Get.to(
                                                                        DetailsEventsAgendaScreen());
                                                                  });
                                                                },
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Visibility(
                                                                      visible:
                                                                          index ==
                                                                              0,
                                                                      child: Container(
                                                                          decoration:
                                                                              BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                                          child: Center(child: GBSystem_TextHelper().superSmallText(maxLines: 2, text: day.day.toString()))),
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Color(int.parse(
                                                                            "0xFF${eventModel[index].backgroundColor!.replaceAll(r"#", "")}",
                                                                          )),
                                                                          borderRadius: BorderRadius.circular(8)),
                                                                      child: Center(
                                                                          child: GBSystem_TextHelper().superSmallText(
                                                                              maxLines: 2,
                                                                              text: "${AbsenceModel.convertTime(eventModel[index].VAC_START_HOUR!)} ${AbsenceModel.convertTime(eventModel[index].VAC_END_HOUR!)}")),
                                                                      // "${eventModel.VAC_START_HOUR!.hour}:${eventModel.VAC_START_HOUR!.minute} ${eventModel.VAC_END_HOUR!.hour}:${eventModel.VAC_END_HOUR!.minute}")),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                              );
                                            } else {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                      child: Text(
                                                          day.day.toString())),
                                                ),
                                              );
                                            }
                                          } else {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Center(
                                                    child: Text(
                                                        day.day.toString())),
                                              ),
                                            );
                                          }
                                        }
                                      }, defaultBuilder:
                                              (context, day, focusedDay) {
                                        if (listEventsAbsence != null) {
                                          List<int> allDaysAbsence =
                                              getListDaysOfListEventAbsence(
                                                  listEventAbsenceModel:
                                                      listEventsAbsence!);

                                          if (allDaysAbsence
                                              .contains(day.day)) {
                                            EventAbsenceModel? currentAbsence =
                                                getEventAbsenceByDay(
                                                    day: day,
                                                    lisDates:
                                                        listEventsAbsence!);

                                            return Column(
                                              children: [
                                                GBSystem_TextHelper()
                                                    .superSmallText(
                                                  text: day.day.toString(),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 30,
                                                  width: 50,
                                                  margin: currentAbsence != null &&
                                                          checkEventIfOnly(
                                                              event:
                                                                  currentAbsence,
                                                              listEventsAbsence:
                                                                  listEventsAbsence!)
                                                      ? EdgeInsets.symmetric(
                                                          horizontal: 5)
                                                      : null,
                                                  decoration:
                                                      BoxDecoration(boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.red
                                                          .withOpacity(0.3),
                                                      spreadRadius: -30,
                                                      blurRadius: 12,
                                                      offset: const Offset(3,
                                                          3), // changes the shadow position
                                                    ),
                                                  ], color: Colors.red),
                                                  child: Row(
                                                    children: [
                                                      SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            currentAbsence !=
                                                                        null &&
                                                                    checkEventIfOnly(
                                                                        event:
                                                                            currentAbsence,
                                                                        listEventsAbsence:
                                                                            listEventsAbsence!)
                                                                ? GBSystem_TextHelper()
                                                                    .superSmallText(
                                                                        text:
                                                                            "${currentAbsence.TPH_CODE!}")
                                                                : Container(),
                                                            GBSystem_TextHelper()
                                                                .superSmallText(
                                                                    text: currentAbsence !=
                                                                            null
                                                                        ? "${AbsenceModel.convertTime(currentAbsence.PLATPH_START_HOUR!)} "
                                                                        : ""),
                                                            GBSystem_TextHelper()
                                                                .superSmallText(
                                                                    text: currentAbsence !=
                                                                            null
                                                                        ? "${AbsenceModel.convertTime(currentAbsence.PLATPH_END_HOUR!)} "
                                                                        : ""),
                                                            currentAbsence !=
                                                                        null &&
                                                                    checkEventIfLastAndNotOnly(
                                                                        event:
                                                                            currentAbsence,
                                                                        listEventsAbsence:
                                                                            listEventsAbsence!)
                                                                ? Column(
                                                                    children: [
                                                                      GBSystem_TextHelper()
                                                                          .superSmallText(
                                                                              text: "au ${currentAbsence.PLATPH_END_HOUR!.day}"),
                                                                      GBSystem_TextHelper()
                                                                          .superSmallText(
                                                                              text: "${DateFormat.MMMM(getLocaleApplication()).format(currentAbsence.PLATPH_END_HOUR!)} "),
                                                                    ],
                                                                  )
                                                                : Container()
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        }

                                        // if (listEventsAbsence != null &&
                                        //     checkDateExistInListEventsAbsence(
                                        //         day: day,
                                        //         lisDates: listEventsAbsence!)) {
                                        //   List<int> listDaysOfEvent =
                                        //       getListDaysOfEventAbsence(
                                        //           eventAbsenceModel:
                                        //               getEventAbsenceByDay(
                                        //                   day: day,
                                        //                   lisDates:
                                        //                       listEventsAbsence!)!);
                                        //   print("day : ${day.day}");
                                        //   print("list $listDaysOfEvent");
                                        //   print(
                                        //       "condition ${listDaysOfEvent.contains(day.day)}");

                                        //   if (listDaysOfEvent.contains(day.day)) {
                                        //     return Container(
                                        //       alignment: Alignment.center,
                                        //       height: 30,
                                        //       width: 30,
                                        //       decoration:
                                        //           BoxDecoration(color: Colors.red),
                                        //     );
                                        //   }
                                        // }

                                        if (listEvents != null &&
                                            listEvents!.isNotEmpty &&
                                            checkDateExistInListEvents(
                                                day: day,
                                                lisDates: listEvents!)) {
                                          List<EventModel>? eventModel =
                                              verifierDate(
                                                  day: day,
                                                  lisDates: listEvents!);
                                          if (eventModel != null) {
                                            // final hexColor = eventModel.backgroundColor!
                                            //     .replaceAll(r"#", "");
                                            // final color = Color(int.parse(
                                            //   '0xFF$hexColor',
                                            // ));

                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: eventModel.length,
                                              itemBuilder:
                                                  (context, index) =>
                                                      verifierDateBool(
                                                              eventModel:
                                                                  eventModel[
                                                                      index])
                                                          ? InkWell(
                                                              onTap: () async {
                                                                isLoading
                                                                        .value =
                                                                    true;

                                                                await GBSystem_AuthService(
                                                                        context)
                                                                    .getInfoVacationAgenda(
                                                                        VAC_IDF:
                                                                            eventModel[index]
                                                                                .VAC_IDF)
                                                                    .then(
                                                                        (value) {
                                                                  isLoading
                                                                          .value =
                                                                      false;

                                                                  final vacationController =
                                                                      Get.put<GBSystemVacationMapController>(
                                                                          GBSystemVacationMapController());
                                                                  vacationController
                                                                          .setCurrentVacationVacation =
                                                                      value;
                                                                  Get.to(
                                                                      DetailsEventsAgendaScreen());
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        // this line to show current day with the first event only (for current day events)
                                                                        color: index ==
                                                                                0
                                                                            ? Colors
                                                                                .red
                                                                            : Colors
                                                                                .transparent,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8)),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      // this line to show current day with the first event only (for current day events)

                                                                      Visibility(
                                                                        visible:
                                                                            index ==
                                                                                0,
                                                                        child: Container(
                                                                            child:
                                                                                Center(child: GBSystem_TextHelper().superSmallText(maxLines: 2, text: day.day.toString()))),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      //                 final hexColor = eventModel.backgroundColor!
                                                                      //     .replaceAll(r"#", "");
                                                                      // final color = Color(int.parse(
                                                                      //   '0xFF$hexColor',
                                                                      // ));
                                                                      Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(int.parse(
                                                                              "0xFF${eventModel[index].backgroundColor!.replaceAll(r"#", "")}",
                                                                            )),
                                                                          ),
                                                                          child: Center(
                                                                              child: GBSystem_TextHelper().superSmallText(maxLines: 2, text: "${AbsenceModel.convertTime(eventModel[index].VAC_START_HOUR!)} ${AbsenceModel.convertTime(eventModel[index].VAC_END_HOUR!)}"
                                                                                  // "${eventModel.VAC_START_HOUR!.hour}:${eventModel.VAC_START_HOUR!.minute} ${eventModel.VAC_END_HOUR!.hour}:${eventModel.VAC_END_HOUR!.minute}")),
                                                                                  ))),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap: () async {
                                                                isLoading
                                                                        .value =
                                                                    true;

                                                                await GBSystem_AuthService(
                                                                        context)
                                                                    .getInfoVacationAgenda(
                                                                        VAC_IDF:
                                                                            eventModel[index]
                                                                                .VAC_IDF)
                                                                    .then(
                                                                        (value) {
                                                                  isLoading
                                                                          .value =
                                                                      false;

                                                                  final vacationController =
                                                                      Get.put<GBSystemVacationMapController>(
                                                                          GBSystemVacationMapController());
                                                                  vacationController
                                                                          .setCurrentVacationVacation =
                                                                      value;
                                                                  Get.to(
                                                                      DetailsEventsAgendaScreen());
                                                                });
                                                              },
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Visibility(
                                                                    visible:
                                                                        index ==
                                                                            0,
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                8)),
                                                                        child: Center(
                                                                            child:
                                                                                GBSystem_TextHelper().superSmallText(maxLines: 2, text: day.day.toString()))),
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            color:
                                                                                Color(int.parse(
                                                                              "0xFF${eventModel[index].backgroundColor!.replaceAll(r"#", "")}",
                                                                            )),
                                                                            borderRadius: BorderRadius.circular(8)),
                                                                    child: Center(
                                                                        child: GBSystem_TextHelper().superSmallText(
                                                                            maxLines:
                                                                                2,
                                                                            text:
                                                                                "${AbsenceModel.convertTime(eventModel[index].VAC_START_HOUR!)} ${AbsenceModel.convertTime(eventModel[index].VAC_END_HOUR!)}")),
                                                                    // "${eventModel.VAC_START_HOUR!.hour}:${eventModel.VAC_START_HOUR!.minute} ${eventModel.VAC_END_HOUR!.hour}:${eventModel.VAC_END_HOUR!.minute}")),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                            );
                                          } else {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Center(
                                                    child: Text(
                                                        day.day.toString())),
                                              ),
                                            );
                                          }
                                        } else {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Center(
                                                  child:
                                                      Text(day.day.toString())),
                                            ),
                                          );
                                        }
                                      }),
                                    ),
                                  );
                                } else {
                                  return WaitingWidgets();
                                }
                              },
                            ));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          height: 250,
                          child: WaitingWidgets(),
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

  RxString getCurrentLocaleCode() {
    if (Get.locale?.languageCode != null && Get.locale?.languageCode != "gr") {
      return RxString(Get.locale!.languageCode);
    } else {
      return RxString("fr");
    }
  }

  List<EventModel>? verifierDate(
      {required DateTime day, required List<EventModel?> lisDates}) {
    List<EventModel>? listEvent = [];

    for (var element in lisDates) {
      if (element != null && element.START_HOUR != null) {
        if (element.START_HOUR!.day == day.day &&
            element.START_HOUR!.month == day.month &&
            element.START_HOUR!.year == day.year) {
          listEvent.add(element);
        }
      }
    }
    return listEvent;
  }

  bool checkDateExistInListEvents(
      {required DateTime day, required List<EventModel?> lisDates}) {
    bool exist = false;

    for (var element in lisDates) {
      if (element != null && element.START_HOUR != null) {
        if (element.START_HOUR!.day == day.day &&
            element.START_HOUR!.month == day.month &&
            element.START_HOUR!.year == day.year) {
          exist = true;
        }
      }
    }
    return exist;
  }

  bool checkEventIfLastAndNotOnly(
      {required EventAbsenceModel event,
      required List<EventAbsenceModel> listEventsAbsence}) {
    bool check = false;
    List<List<int>> listListDay = [];
    for (var i = 0; i < listEventsAbsence.length; i++) {
      listListDay.add(
          getListDaysOfEventAbsence(eventAbsenceModel: listEventsAbsence[i]));
    }
    print(listListDay);

    for (var i = 0; i < listListDay.length; i++) {
      print("list $i ${listListDay[i]}");
      print(
          "condition ${(listListDay[i].length > 1 && listListDay[i].last == event.PLATPH_END_HOUR!.day)}");
      print("condition 1 ${(listListDay[i].length > 1)}");
      print(
          "condition 2 ${(listListDay[i].last == event.PLATPH_END_HOUR!.day)}");
      print("date end day: ${event.PLATPH_END_HOUR!.day}");
      if (listListDay[i].length > 1 &&
          listListDay[i].last == event.PLATPH_END_HOUR!.day) {
        print("-------------------");
        print("event true : ${event.PLATPH_END_HOUR}");

        print("-------------------");
        check = true;
      }
    }
    return check;
  }

  bool checkEventIfOnly(
      {required EventAbsenceModel event,
      required List<EventAbsenceModel> listEventsAbsence}) {
    bool check = false;
    List<List<int>> listListDay = [];
    for (var i = 0; i < listEventsAbsence.length; i++) {
      listListDay.add(
          getListDaysOfEventAbsence(eventAbsenceModel: listEventsAbsence[i]));
    }
    print(listListDay);

    for (var i = 0; i < listListDay.length; i++) {
      if (listListDay[i].length <= 1 &&
          listListDay[i].contains(event.PLATPH_START_HOUR!.day)) {
        check = true;
      }
    }
    return check;
  }

  EventAbsenceModel? getEventAbsenceByDay(
      {required DateTime day, required List<EventAbsenceModel?> lisDates}) {
    EventAbsenceModel? eventAbsenceModel;

    for (var element in lisDates) {
      if (element != null && element.PLATPH_START_HOUR != null) {
        if (element.PLATPH_START_HOUR!.day == day.day &&
            element.PLATPH_START_HOUR!.month == day.month &&
            element.PLATPH_START_HOUR!.year == day.year) {
          eventAbsenceModel = element;
        }
      }
    }
    return eventAbsenceModel;
  }

  bool checkDateExistInListEventsAbsence(
      {required DateTime day, required List<EventAbsenceModel?> lisDates}) {
    bool exist = false;

    for (var element in lisDates) {
      if (element != null && element.PLATPH_START_HOUR != null) {
        if (element.PLATPH_START_HOUR!.day == day.day &&
            element.PLATPH_START_HOUR!.month == day.month &&
            element.PLATPH_START_HOUR!.year == day.year) {
          exist = true;
        }
      }
    }
    return exist;
  }

  List<int> getListDaysOfListEventAbsence(
      {required List<EventAbsenceModel> listEventAbsenceModel}) {
    List<int> listDays = [];

    for (var i = 0; i < listEventAbsenceModel.length; i++) {
      DateTime dateNow = listEventAbsenceModel[i].PLATPH_START_HOUR!;
      DateTime future = listEventAbsenceModel[i].PLATPH_END_HOUR!;

      Duration defference = future.difference(dateNow);
      if (defference.inDays != 0) {
        for (var i = 0; i <= defference.inDays; i++) {
          listDays.add(dateNow.add(Duration(days: i)).day);
        }
      } else {
        listDays.add(dateNow.day);
      }
    }
    return listDays;
  }

  List<int> getListDaysOfEventAbsence(
      {required EventAbsenceModel eventAbsenceModel}) {
    List<int> listDays = [];

    DateTime dateNow = eventAbsenceModel.PLATPH_START_HOUR!;
    DateTime future = eventAbsenceModel.PLATPH_END_HOUR!;

    Duration defference = future.difference(dateNow);
    if (defference.inDays != 0) {
      for (var i = 0; i <= defference.inDays; i++) {
        listDays.add(dateNow.add(Duration(days: i)).day);
      }
    } else {
      listDays.add(dateNow.day);
    }

    return listDays;
  }

  bool verifierDateBool({required EventModel eventModel}) {
    bool check = false;
    if (eventModel.START_HOUR!.day == DateTime.now().day &&
        eventModel.START_HOUR!.month == DateTime.now().month &&
        eventModel.START_HOUR!.year == DateTime.now().year) {
      check = true;
    }
    return check;
  }

  String getLocaleApplication() {
    return Get.locale.toString() != 'gr' ? Get.locale.toString() : 'en';
    // List<String> myLocales = ["fr", "en", "de", "es", "gr", "pt", "ro", "tr"];
    // if (myLocales.contains(ui.window.locale.toString().substring(0, 2))) {
    //   return ui.window.locale.toString().substring(0, 2);
    // } else {
    //   return "fr-FR";
    // }
  }
}
