import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_state_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAP_SCREEN/Gbsystem_map_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAP_SCREEN/marker_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class GbsystemMapScreen extends StatefulWidget {
  const GbsystemMapScreen({super.key, required this.listCordonner});

  final List<LatLng> listCordonner;

  @override
  State<GbsystemMapScreen> createState() => _GbsystemMapScreenState();
}

class _GbsystemMapScreenState extends State<GbsystemMapScreen> {
  double zoomLevel = 5.0;
  MapController controller = MapController();

  final GbsystemMapScreenController m = Get.put(GbsystemMapScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 4.0,
        shadowColor: GbsSystemStrings.str_primary_color,
        toolbarHeight: 80,
        backgroundColor: GbsSystemStrings.str_primary_color,
        title: Text(
          GbsSystemStrings.str_map.tr,
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical:
                GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
            horizontal: 10),
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Obx(() => FlutterMap(
                mapController: controller,
                options: MapOptions(
                  zoom: zoomLevel,
                  center: LatLng(
                      double.parse(m.salarieController.getSalarie!.salarieModel
                          .SVR_LATITUDE
                          .replaceAll(",", ".")),
                      double.parse(m.salarieController.getSalarie!.salarieModel
                          .SVR_LONGITUDE
                          .replaceAll(",", "."))),
                  minZoom: 1,
                  maxZoom: 22,
                ),
                children: [
                  TileLayer(
                    tileProvider: NetworkTileProvider(),
                    urlTemplate: GbsSystemServerStrings.MAPBOX_URL,
                    additionalOptions: {
                      'accessToken': m.salarieController.getSalarie?.mapToken ??
                          GbsSystemServerStrings.MAPBOX_ACCESS_TOKEN,
                      'id': GbsSystemServerStrings.MAPBOX_ID
                    },
                  ),
                  MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                      maxClusterRadius: 45,
                      size: const Size(40, 40),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(50),
                      maxZoom: 15,
                      markers:
                          getAllMarker(listCordonner: widget.listCordonner),
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
                  //   markers: getAllMarker(listCordonner: widget.listCordonner),
                  // ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            try {
                              setState(() {
                                zoomLevel = zoomLevel + 1;
                              });

                              controller.move(controller.center, zoomLevel);
                            } catch (e) {
                              GBSystem_ManageCatchErrors().catchErrors(context,
                                  message: e.toString(),
                                  method: "GBSystem_home_screen",
                                  page: "zoomIN (home)");
                            }
                          },
                          icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(200),
                                  color: Colors.grey.shade200),
                              child: Icon(Icons.add))),
                      IconButton(
                          onPressed: () {
                            try {
                              setState(() {
                                zoomLevel = zoomLevel - 1;
                              });

                              controller.move(controller.center, zoomLevel);
                            } catch (e) {
                              GBSystem_ManageCatchErrors().catchErrors(context,
                                  message: e.toString(),
                                  method: "GBSystem_home_screen",
                                  page: "zoomOUT (home)");
                            }
                          },
                          icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(200),
                                  color: Colors.grey.shade200),
                              child: Icon(Icons.remove))),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Marker getMarkerSalarie() {
    return Marker(
        point: LatLng(
            double.parse(m
                .salarieController.getSalarie!.salarieModel.SVR_LATITUDE
                .replaceAll(",", ".")),
            double.parse(m
                .salarieController.getSalarie!.salarieModel.SVR_LONGITUDE
                .replaceAll(",", "."))),
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
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    )),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      m.markerUserVisibility.value
                          ? m.markerUserVisibility.value = false
                          : m.markerUserVisibility.value = true;
                    });
                  },
                  child: Container(
                    clipBehavior: Clip.none,
                    decoration: BoxDecoration(),
                    child: Icon(
                      CupertinoIcons.location_solid,
                      color: Colors.redAccent,
                      size: 40,
                    ),
                  ),
                ),
                Visibility(
                  visible: m.markerUserVisibility.value,
                  child: Positioned(
                    top: -25,
                    left: -25,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border:
                              Border.all(width: 1, color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: -40,
                              blurRadius: 22,
                              offset: const Offset(
                                  10, 40), // changes the shadow position
                            ),
                          ]),
                      child: GBSystem_TextHelper().smallText(
                          text: m.salarieController.getSalarie!.salarieModel
                              .SVR_NOM),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  List<Marker> getAllMarkerVacations() {
    List<VacationStateModel> listVacs =
        m.vacationStateController.getAllVacations.value ?? [];
    return listVacs.map(
      (e) {
        return Marker(
            point: LatLng(double.parse(e.LIE_LATITUDE.replaceAll(",", ".")),
                double.parse(e.LIE_LONGITUDE.replaceAll(",", "."))),
            child: MarkerWidget(message: e.TITLE));
      },
    ).toList();
  }

  List<Marker> getAllMarker({required List<LatLng> listCordonner}) {
    List<Marker> markerVacationState = getAllMarkerVacations();
    markerVacationState.add(getMarkerSalarie());
    return markerVacationState;
  }
}
