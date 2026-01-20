import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DETAILS_EVENT_AGENDA_SCREEN/GBSystem_details_event_agenda_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/PRISE_SERVICE_MAP/GBSystem_user_entrer_sortie_map.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class DetailsEventsAgendaScreen extends StatefulWidget {
  DetailsEventsAgendaScreen({super.key, this.isCommingFromOut = false});
  final bool isCommingFromOut;
  @override
  State<DetailsEventsAgendaScreen> createState() =>
      _DetailsEventsAgendaScreenState();
}

class _DetailsEventsAgendaScreenState extends State<DetailsEventsAgendaScreen> {
  final m = Get.put<DetailsEventsAgendaScreenController>(
      DetailsEventsAgendaScreenController());

  double zoomLevel = 10.0;
  MapController controller = MapController();
  updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 4.0,
        shadowColor: GbsSystemStrings.str_primary_color,
        toolbarHeight: 80,
        backgroundColor: GbsSystemStrings.str_primary_color,
        title: Text(
          GbsSystemStrings.str_details_vacation.tr,
          style: TextStyle(color: Colors.white),
        ),
        leading: widget.isCommingFromOut != true
            ? InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                ),
              )
            : Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical:
                  GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
          child: Column(
            children: [
              m.vacationController.getCurrentVacation != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GBSystem_ScreenHelper.screenWidthPercentage(
                                  context, 0.02)),
                      child: UserEnterSortieMap(
                        updateUI: updateUI,
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                        context, 0.02),
                    horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.04)),
                child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FlutterMap(
                      nonRotatedChildren: [
                        MarkerClusterLayerWidget(
                          options: MarkerClusterLayerOptions(
                            maxClusterRadius: 45,
                            size: const Size(40, 40),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(50),
                            maxZoom: 15,
                            markers: m.myPosition != null
                                ? [
                                    //agenda details position
                                    Marker(
                                        point: m.myPosition!,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  m.markerLocationVisibility
                                                          .value
                                                      ? m.markerLocationVisibility
                                                          .value = false
                                                      : m.markerLocationVisibility
                                                          .value = true;
                                                });
                                              },
                                              child: Container(
                                                child: const Icon(
                                                  CupertinoIcons.location_solid,
                                                  color: Colors.blueAccent,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: m
                                                  .markerLocationVisibility
                                                  .value,
                                              child: Positioned(
                                                top: -25,
                                                left: -25,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors
                                                              .grey.shade200),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          spreadRadius: -40,
                                                          blurRadius: 22,
                                                          offset: const Offset(
                                                              10,
                                                              40), // changes the shadow position
                                                        ),
                                                      ]),
                                                  child: GBSystem_TextHelper()
                                                      .smallText(
                                                          text: m
                                                              .vacationController
                                                              .getCurrentVacationRx
                                                              .value!
                                                              .LIE_LIB),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    // salarie position
                                    Marker(
                                        point: LatLng(
                                            double.parse(m
                                                .salarieController
                                                .getSalarie!
                                                .salarieModel
                                                .SVR_LATITUDE
                                                .replaceAll(",", ".")),
                                            double.parse(m
                                                .salarieController
                                                .getSalarie!
                                                .salarieModel
                                                .SVR_LONGITUDE
                                                .replaceAll(",", "."))),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  m.markerUserVisibility.value
                                                      ? m.markerUserVisibility
                                                          .value = false
                                                      : m.markerUserVisibility
                                                          .value = true;
                                                });
                                              },
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Positioned(
                                                    left: 2,
                                                    bottom: -20,
                                                    child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      200),
                                                          border: Border.all(
                                                            color: Colors.blue,
                                                            width: 3,
                                                          )),
                                                    ),
                                                  ),
                                                  Container(
                                                    clipBehavior: Clip.none,
                                                    decoration: BoxDecoration(),
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .location_solid,
                                                      color: Colors.redAccent,
                                                      // color: _markerData != LatLng(49.640616, -1.624229)
                                                      //     ? Colors.blueAccent
                                                      //     : Colors.redAccent,
                                                      size: 40,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible:
                                                  m.markerUserVisibility.value,
                                              child: Positioned(
                                                top: -25,
                                                left: -25,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors
                                                              .grey.shade200),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          spreadRadius: -40,
                                                          blurRadius: 22,
                                                          offset: const Offset(
                                                              10,
                                                              40), // changes the shadow position
                                                        ),
                                                      ]),
                                                  child: GBSystem_TextHelper()
                                                      .smallText(
                                                          text: m
                                                              .salarieController
                                                              .getSalarie!
                                                              .salarieModel
                                                              .SVR_NOM),
                                                ),
                                              ),
                                            )
                                          ],
                                        ))
                                  ]
                                : [
                                    Marker(
                                        point: LatLng(
                                            double.parse(m
                                                .salarieController
                                                .getSalarie!
                                                .salarieModel
                                                .SVR_LATITUDE
                                                .replaceAll(",", ".")),
                                            double.parse(m
                                                .salarieController
                                                .getSalarie!
                                                .salarieModel
                                                .SVR_LONGITUDE
                                                .replaceAll(",", "."))),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  m.markerUserVisibility.value
                                                      ? m.markerUserVisibility
                                                          .value = false
                                                      : m.markerUserVisibility
                                                          .value = true;
                                                });
                                              },
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Positioned(
                                                    left: 2,
                                                    bottom: -20,
                                                    child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      200),
                                                          border: Border.all(
                                                            color: Colors.blue,
                                                            width: 3,
                                                          )),
                                                    ),
                                                  ),
                                                  Container(
                                                    clipBehavior: Clip.none,
                                                    decoration: BoxDecoration(),
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .location_solid,
                                                      color: Colors.redAccent,
                                                      // color: _markerData != LatLng(49.640616, -1.624229)
                                                      //     ? Colors.blueAccent
                                                      //     : Colors.redAccent,
                                                      size: 40,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible:
                                                  m.markerUserVisibility.value,
                                              child: Positioned(
                                                top: -25,
                                                left: -25,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors
                                                              .grey.shade200),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          spreadRadius: -40,
                                                          blurRadius: 22,
                                                          offset: const Offset(
                                                              10,
                                                              40), // changes the shadow position
                                                        ),
                                                      ]),
                                                  child: GBSystem_TextHelper()
                                                      .smallText(
                                                          text: m
                                                              .salarieController
                                                              .getSalarie!
                                                              .salarieModel
                                                              .SVR_NOM),
                                                ),
                                              ),
                                            )
                                          ],
                                        ))
                                  ],
                            builder: (context, markers) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text(
                                    markers.length.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // MarkerLayer(
                        //   markers: m.myPosition != null
                        //       ? [
                        //           //agenda details position
                        //           Marker(
                        //               point: m.myPosition!,
                        //               child: Stack(
                        //                 clipBehavior: Clip.none,
                        //                 children: [
                        //                   InkWell(
                        //                     onTap: () {
                        //                       setState(() {
                        //                         m.markerLocationVisibility.value
                        //                             ? m.markerLocationVisibility
                        //                                 .value = false
                        //                             : m.markerLocationVisibility
                        //                                 .value = true;
                        //                       });
                        //                     },
                        //                     child: Container(
                        //                       child: const Icon(
                        //                         CupertinoIcons.location_solid,
                        //                         color: Colors.blueAccent,
                        //                         size: 40,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Visibility(
                        //                     visible: m
                        //                         .markerLocationVisibility.value,
                        //                     child: Positioned(
                        //                       top: -25,
                        //                       left: -25,
                        //                       child: Container(
                        //                         padding: EdgeInsets.symmetric(
                        //                             vertical: 5,
                        //                             horizontal: 10),
                        //                         decoration: BoxDecoration(
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     8),
                        //                             color: Colors.white,
                        //                             border: Border.all(
                        //                                 width: 1,
                        //                                 color: Colors
                        //                                     .grey.shade200),
                        //                             boxShadow: [
                        //                               BoxShadow(
                        //                                 color: Colors.grey
                        //                                     .withOpacity(0.3),
                        //                                 spreadRadius: -40,
                        //                                 blurRadius: 22,
                        //                                 offset: const Offset(10,
                        //                                     40), // changes the shadow position
                        //                               ),
                        //                             ]),
                        //                         child: GBSystem_TextHelper()
                        //                             .smallText(
                        //                                 text: m
                        //                                     .vacationController
                        //                                     .getCurrentVacationRx
                        //                                     .value!
                        //                                     .LIE_LIB),
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               )),
                        //           // salarie position
                        //           Marker(
                        //               point: LatLng(
                        //                   double.parse(m
                        //                       .salarieController
                        //                       .getSalarie!
                        //                       .salarieModel
                        //                       .SVR_LATITUDE
                        //                       .replaceAll(",", ".")),
                        //                   double.parse(m
                        //                       .salarieController
                        //                       .getSalarie!
                        //                       .salarieModel
                        //                       .SVR_LONGITUDE
                        //                       .replaceAll(",", "."))),
                        //               child: Stack(
                        //                 clipBehavior: Clip.none,
                        //                 children: [
                        //                   InkWell(
                        //                     onTap: () {
                        //                       setState(() {
                        //                         m.markerUserVisibility.value
                        //                             ? m.markerUserVisibility
                        //                                 .value = false
                        //                             : m.markerUserVisibility
                        //                                 .value = true;
                        //                       });
                        //                     },
                        //                     child: Stack(
                        //                       clipBehavior: Clip.none,
                        //                       children: [
                        //                         Positioned(
                        //                           left: 2,
                        //                           bottom: -20,
                        //                           child: Container(
                        //                             height: 25,
                        //                             width: 25,
                        //                             decoration: BoxDecoration(
                        //                                 color: Colors.blue
                        //                                     .withOpacity(0.2),
                        //                                 borderRadius:
                        //                                     BorderRadius
                        //                                         .circular(200),
                        //                                 border: Border.all(
                        //                                   color: Colors.blue,
                        //                                   width: 3,
                        //                                 )),
                        //                           ),
                        //                         ),
                        //                         Container(
                        //                           clipBehavior: Clip.none,
                        //                           decoration: BoxDecoration(),
                        //                           child: Icon(
                        //                             CupertinoIcons
                        //                                 .location_solid,
                        //                             color: Colors.redAccent,
                        //                             // color: _markerData != LatLng(49.640616, -1.624229)
                        //                             //     ? Colors.blueAccent
                        //                             //     : Colors.redAccent,
                        //                             size: 40,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   Visibility(
                        //                     visible:
                        //                         m.markerUserVisibility.value,
                        //                     child: Positioned(
                        //                       top: -25,
                        //                       left: -25,
                        //                       child: Container(
                        //                         padding: EdgeInsets.symmetric(
                        //                             vertical: 5,
                        //                             horizontal: 10),
                        //                         decoration: BoxDecoration(
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     8),
                        //                             color: Colors.white,
                        //                             border: Border.all(
                        //                                 width: 1,
                        //                                 color: Colors
                        //                                     .grey.shade200),
                        //                             boxShadow: [
                        //                               BoxShadow(
                        //                                 color: Colors.grey
                        //                                     .withOpacity(0.3),
                        //                                 spreadRadius: -40,
                        //                                 blurRadius: 22,
                        //                                 offset: const Offset(10,
                        //                                     40), // changes the shadow position
                        //                               ),
                        //                             ]),
                        //                         child: GBSystem_TextHelper()
                        //                             .smallText(
                        //                                 text: m
                        //                                     .salarieController
                        //                                     .getSalarie!
                        //                                     .salarieModel
                        //                                     .SVR_NOM),
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               ))
                        //         ]
                        //       : [
                        //           Marker(
                        //               point: LatLng(
                        //                   double.parse(m
                        //                       .salarieController
                        //                       .getSalarie!
                        //                       .salarieModel
                        //                       .SVR_LATITUDE
                        //                       .replaceAll(",", ".")),
                        //                   double.parse(m
                        //                       .salarieController
                        //                       .getSalarie!
                        //                       .salarieModel
                        //                       .SVR_LONGITUDE
                        //                       .replaceAll(",", "."))),
                        //               child: Stack(
                        //                 clipBehavior: Clip.none,
                        //                 children: [
                        //                   InkWell(
                        //                     onTap: () {
                        //                       setState(() {
                        //                         m.markerUserVisibility.value
                        //                             ? m.markerUserVisibility
                        //                                 .value = false
                        //                             : m.markerUserVisibility
                        //                                 .value = true;
                        //                       });
                        //                     },
                        //                     child: Stack(
                        //                       clipBehavior: Clip.none,
                        //                       children: [
                        //                         Positioned(
                        //                           left: 2,
                        //                           bottom: -20,
                        //                           child: Container(
                        //                             height: 25,
                        //                             width: 25,
                        //                             decoration: BoxDecoration(
                        //                                 color: Colors.blue
                        //                                     .withOpacity(0.2),
                        //                                 borderRadius:
                        //                                     BorderRadius
                        //                                         .circular(200),
                        //                                 border: Border.all(
                        //                                   color: Colors.blue,
                        //                                   width: 3,
                        //                                 )),
                        //                           ),
                        //                         ),
                        //                         Container(
                        //                           clipBehavior: Clip.none,
                        //                           decoration: BoxDecoration(),
                        //                           child: Icon(
                        //                             CupertinoIcons
                        //                                 .location_solid,
                        //                             color: Colors.redAccent,
                        //                             // color: _markerData != LatLng(49.640616, -1.624229)
                        //                             //     ? Colors.blueAccent
                        //                             //     : Colors.redAccent,
                        //                             size: 40,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   Visibility(
                        //                     visible:
                        //                         m.markerUserVisibility.value,
                        //                     child: Positioned(
                        //                       top: -25,
                        //                       left: -25,
                        //                       child: Container(
                        //                         padding: EdgeInsets.symmetric(
                        //                             vertical: 5,
                        //                             horizontal: 10),
                        //                         decoration: BoxDecoration(
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     8),
                        //                             color: Colors.white,
                        //                             border: Border.all(
                        //                                 width: 1,
                        //                                 color: Colors
                        //                                     .grey.shade200),
                        //                             boxShadow: [
                        //                               BoxShadow(
                        //                                 color: Colors.grey
                        //                                     .withOpacity(0.3),
                        //                                 spreadRadius: -40,
                        //                                 blurRadius: 22,
                        //                                 offset: const Offset(10,
                        //                                     40), // changes the shadow position
                        //                               ),
                        //                             ]),
                        //                         child: GBSystem_TextHelper()
                        //                             .smallText(
                        //                                 text: m
                        //                                     .salarieController
                        //                                     .getSalarie!
                        //                                     .salarieModel
                        //                                     .SVR_NOM),
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               ))
                        //         ],
                        // ),
                      ],
                      mapController: controller,
                      options: MapOptions(
                        center: LatLng(
                            double.parse(m.salarieController.getSalarie!
                                .salarieModel.SVR_LATITUDE
                                .replaceAll(",", ".")),
                            double.parse(m.salarieController.getSalarie!
                                .salarieModel.SVR_LONGITUDE
                                .replaceAll(",", "."))),
                        zoom: zoomLevel,
                        minZoom: 1,
                        maxZoom: 22,
                      ),
                      children: [
                        TileLayer(
                          tileProvider: NetworkTileProvider(),
                          urlTemplate: GbsSystemServerStrings.MAPBOX_URL,
                          additionalOptions: {
                            'accessToken':
                                m.salarieController.getSalarie?.mapToken ??
                                    GbsSystemServerStrings.MAPBOX_ACCESS_TOKEN,
                            'id': GbsSystemServerStrings.MAPBOX_ID,
                          },
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  try {
                                    setState(() {
                                      zoomLevel = zoomLevel + 1;
                                    });

                                    controller.move(
                                        controller.center, zoomLevel);
                                  } catch (e) {
                                    GBSystem_ManageCatchErrors().catchErrors(
                                        context,
                                        message: e.toString(),
                                        method:
                                            "GBSystem_details_event_agenda_screen",
                                        page: "zoomIN (home)");
                                  }
                                },
                                icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: -40,
                                            blurRadius: 22,
                                            offset: const Offset(10,
                                                10), // changes the shadow position
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        color: Colors.grey.shade200),
                                    child: Icon(Icons.add))),
                            IconButton(
                                onPressed: () {
                                  try {
                                    setState(() {
                                      zoomLevel = zoomLevel - 1;
                                    });

                                    controller.move(
                                        controller.center, zoomLevel);
                                  } catch (e) {
                                    GBSystem_ManageCatchErrors().catchErrors(
                                        context,
                                        message: e.toString(),
                                        method:
                                            "GBSystem_details_event_agenda_screen",
                                        page: "zoomOUT (home)");
                                  }
                                },
                                icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: -40,
                                            blurRadius: 22,
                                            offset: const Offset(10,
                                                10), // changes the shadow position
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        color: Colors.grey.shade200),
                                    child: Icon(Icons.remove))),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
