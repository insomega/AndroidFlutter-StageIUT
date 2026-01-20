import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_state_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DEMANDE_VACATION_SCREEN/GBSystem_demande_vacation_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/CHAT_SCREEN/GBSystem_chat_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAIN_SCREEN/GBSystem_Main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PDF_PAGE/GBSystem_pdf_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/home_screen/GBSystem_home_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/local_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/pdf_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/APP_BAR/app_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/GBSystem_user_entrer_sortie.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/user_welcome.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/vacation_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystem_Home_Screen extends StatefulWidget {
  GBSystem_Home_Screen({
    super.key,
  });

  @override
  State<GBSystem_Home_Screen> createState() => _GBSystem_Home_ScreenState();
}

class _GBSystem_Home_ScreenState extends State<GBSystem_Home_Screen> {
  final m = Get.put<GBSystem_Home_Controller>(GBSystem_Home_Controller());
  LatLng? _markerData;
  RxBool isSSO = false.obs;
  Future<bool> checkSSO() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isSSO = preferences.getBool(GbsSystemServerStrings.kSSO);
    return isSSO ?? false;
  }

  @override
  void initState() {
    print(m.myPosition.value);
    if (m.myPosition.value != null) {
      _markerData = m.myPosition.value!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isSSO.value = await checkSSO();
    });

    super.initState();
  }

  void updateMarkerData(LatLng newData) {
    setState(() {
      _markerData = newData;
    });
  }

  void updateUI() {
    setState(() {
      LatLng newData = getListMarkerFromController();
      updateMarkerData(newData);
    });
  }

  double zoomLevel = 10.0;
  MapController controller = MapController();
  GlobalKey formKey = GlobalKey();

  Future<String> getMapToken() async {
    return await m.salarieController.getSalarie!.mapToken!;
  }

  void updateUINoti() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Obx(() => Stack(
              children: [
                SafeArea(
                  child: Stack(
                    children: [
                      Scaffold(
                          appBar: APP_BAR(
                            showDisconnect: isSSO,
                            onChangeTap: () {
                              m.dialogSeasirEntrprise();
                            },
                            onMessageTap: () {
                              Get.to(GBSystemChatScreen(
                                updateUI: updateUINoti,
                                isCommingFromOut: true,
                              ));
                            },
                            onLogoutTap: () async {
                              showWarningSnackBar(context,
                                  GbsSystemStrings.str_deconnexion_question.tr,
                                  () async {
                                try {
                                  await m.deconnexion();
                                } catch (e) {
                                  m.isloading.value = false;
                                  GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "deconnexion",
                                      page: "GBSystem_Home_Screen");
                                }
                              });
                            },
                          ),
                          resizeToAvoidBottomInset: false,
                          body: RefreshIndicator(
                            color: GbsSystemServerStrings.str_primary_color,
                            backgroundColor: Colors.white,
                            onRefresh: () async {
                              await m.fetchDataHome(context);
                            },
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.03)),
                                child: Column(
                                  children: [
                                    m.salarie != null
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: GBSystem_ScreenHelper
                                                  .screenHeightPercentage(
                                                      context, 0.02),
                                            ),
                                            child: UserWelcome(
                                                onAccederTap: () async {
                                                  try {
                                                    m.isloading.value = true;

                                                    await GBSystem_AuthService(
                                                            context)
                                                        .loadPDFSalarie()
                                                        .then((value) {
                                                      if (value != null) {
                                                        m.salarieController
                                                                .setPDFSalarie =
                                                            value;
                                                        Uint8List bytes =
                                                            PDFService()
                                                                .cleanPDFStringAndConvertToUnit8List(
                                                                    stringPDF:
                                                                        value);

                                                        if (bytes.isNotEmpty) {
                                                          m.isloading.value =
                                                              false;
                                                          Get.to(
                                                            GBSystemPDFScreen(
                                                              addExtensionWhenDownload:
                                                                  true,
                                                              pageName:
                                                                  "${GbsSystemStrings.str_carte_proffisionel.tr}",
                                                              fileName:
                                                                  "SalarieInformationsPDF",
                                                              pdfBytes: bytes,
                                                            ),
                                                          );
                                                        } else {
                                                          m.isloading.value =
                                                              false;
                                                        }
                                                      } else {
                                                        m.isloading.value =
                                                            false;
                                                      }
                                                    });
                                                  } catch (e) {
                                                    m.isloading.value = false;
                                                    GBSystem_ManageCatchErrors()
                                                        .catchErrors(context,
                                                            message:
                                                                e.toString(),
                                                            method: "loadPDF",
                                                            page:
                                                                "GBSystem_Home_Screen");
                                                  }
                                                },
                                                salarie: m.salarie!),
                                          )
                                        : Container(),
                                    m.vacationController.getCurrentVacation !=
                                            null
                                        ? UserEnterSortie(
                                            fromPage: GBSystemMainScreen(),
                                            updateUI: updateUI,
                                          )
                                        : Container(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.02)),
                                      child: VacationWidget(
                                        onDemandeVacation: () async {
                                          try {
                                            m.isloading.value = true;

                                            await GBSystem_AuthService(context)
                                                .getListVacationsState()
                                                .then((value) {
                                              m.isloading.value = false;

                                              if (value != null &&
                                                  value.isNotEmpty) {
                                                final vacationStateController =
                                                    Get.put<GBSystemVacationStateController>(
                                                        GBSystemVacationStateController());

                                                vacationStateController
                                                    .setAllVacation = value;
                                                vacationStateController
                                                        .setCurrentVacationVacation =
                                                    value.first;
                                              }
                                            });

                                            Get.to(
                                                GBSystemDemandeVacationScreen(
                                              isCommingFromOut: true,
                                            ));
                                          } catch (e) {
                                            m.isloading.value = false;
                                            GBSystem_ManageCatchErrors()
                                                .catchErrors(context,
                                                    message: e.toString(),
                                                    method: "onDemandeVacation",
                                                    page:
                                                        "GBSystem_Home_Screen");
                                          }
                                        },
                                        numberVacation: m.nombreVacation,
                                      ),
                                    ),
                                    FutureBuilder(
                                        future: getMapToken(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            print(snapshot.data);
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.02),
                                              ),
                                              child: Container(
                                                height: 350,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black54),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 10,
                                                      spreadRadius: 1,
                                                    ),
                                                  ],
                                                  // borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Obx(() => FlutterMap(
                                                      key: formKey,
                                                      mapController: controller,
                                                      options: MapOptions(
                                                        onMapEvent: (event) {
                                                          print(
                                                              "mapEevnt : ${event.source.name}");
                                                        },
                                                        zoom: zoomLevel,
                                                        center: LatLng(
                                                            double.parse(m
                                                                .salarieController
                                                                .getSalarie!
                                                                .salarieModel
                                                                .SVR_LATITUDE
                                                                .replaceAll(
                                                                    ",", ".")),
                                                            double.parse(m
                                                                .salarieController
                                                                .getSalarie!
                                                                .salarieModel
                                                                .SVR_LONGITUDE
                                                                .replaceAll(
                                                                    ",", "."))),
                                                        minZoom: 1,
                                                        maxZoom: 22,
                                                      ),
                                                      children: [
                                                        TileLayer(
                                                          tileProvider:
                                                              NetworkTileProvider(),
                                                          urlTemplate:
                                                              GbsSystemServerStrings
                                                                  .MAPBOX_URL,
                                                          additionalOptions: {
                                                            'accessToken':
                                                                snapshot.data!,
                                                            'id':
                                                                GbsSystemServerStrings
                                                                    .MAPBOX_ID,
                                                          },
                                                        ),
                                                        MarkerClusterLayerWidget(
                                                          options:
                                                              MarkerClusterLayerOptions(
                                                            maxClusterRadius:
                                                                45,
                                                            size: const Size(
                                                                40, 40),
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(50),
                                                            maxZoom: 15,
                                                            markers:
                                                                getListMarker() !=
                                                                        null
                                                                    ? [
                                                                        //marker for current vacation
                                                                        getListMarker()!,
                                                                        //marker for salarie position
                                                                        Marker(
                                                                            point:
                                                                                LatLng(double.parse(m.salarieController.getSalarie!.salarieModel.SVR_LATITUDE.replaceAll(",", ".")), double.parse(m.salarieController.getSalarie!.salarieModel.SVR_LONGITUDE.replaceAll(",", "."))),
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
                                                                                          m.markerUserVisibility.value ? m.markerUserVisibility.value = false : m.markerUserVisibility.value = true;
                                                                                        });
                                                                                      },
                                                                                      child: Container(
                                                                                        clipBehavior: Clip.none,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Icon(
                                                                                          CupertinoIcons.location_solid,
                                                                                          color: Colors.redAccent,
                                                                                          // color: _markerData != LatLng(49.640616, -1.624229)
                                                                                          //     ? Colors.blueAccent
                                                                                          //     : Colors.redAccent,
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
                                                                                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade200), boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey.withOpacity(0.3),
                                                                                              spreadRadius: -40,
                                                                                              blurRadius: 22,
                                                                                              offset: const Offset(10, 40), // changes the shadow position
                                                                                            ),
                                                                                          ]),
                                                                                          child: GBSystem_TextHelper().smallText(text: m.salarieController.getSalarie!.salarieModel.SVR_NOM),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ))
                                                                      ]
                                                                    : [
                                                                        Marker(
                                                                            point:
                                                                                LatLng(double.parse(m.salarieController.getSalarie!.salarieModel.SVR_LATITUDE.replaceAll(",", ".")), double.parse(m.salarieController.getSalarie!.salarieModel.SVR_LONGITUDE.replaceAll(",", "."))),
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
                                                                                          m.markerUserVisibility.value ? m.markerUserVisibility.value = false : m.markerUserVisibility.value = true;
                                                                                        });
                                                                                      },
                                                                                      child: Container(
                                                                                        clipBehavior: Clip.none,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Icon(
                                                                                          CupertinoIcons.location_solid,
                                                                                          color: Colors.redAccent,
                                                                                          // color: _markerData != LatLng(49.640616, -1.624229)
                                                                                          //     ? Colors.blueAccent
                                                                                          //     : Colors.redAccent,
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
                                                                                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade200), boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey.withOpacity(0.3),
                                                                                              spreadRadius: -40,
                                                                                              blurRadius: 22,
                                                                                              offset: const Offset(10, 40), // changes the shadow position
                                                                                            ),
                                                                                          ]),
                                                                                          child: GBSystem_TextHelper().smallText(text: m.salarieController.getSalarie!.salarieModel.SVR_NOM),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ))
                                                                      ],
                                                            builder: (context,
                                                                markers) {
                                                              return Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Colors
                                                                        .blue),
                                                                child: Center(
                                                                  child: Text(
                                                                    markers
                                                                        .length
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            IconButton(
                                                                onPressed: () {
                                                                  try {
                                                                    setState(
                                                                        () {
                                                                      zoomLevel =
                                                                          zoomLevel +
                                                                              1;
                                                                    });

                                                                    controller.move(
                                                                        controller
                                                                            .center,
                                                                        zoomLevel);
                                                                  } catch (e) {
                                                                    GBSystem_ManageCatchErrors().catchErrors(
                                                                        context,
                                                                        message: e
                                                                            .toString(),
                                                                        method:
                                                                            "GBSystem_home_screen",
                                                                        page:
                                                                            "zoomIN (home)");
                                                                  }
                                                                },
                                                                icon: Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8),
                                                                    decoration: BoxDecoration(
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.black12,
                                                                            blurRadius:
                                                                                10,
                                                                            spreadRadius:
                                                                                1,
                                                                          ),
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                200),
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200),
                                                                    child: Icon(
                                                                        Icons
                                                                            .add))),
                                                            IconButton(
                                                                onPressed: () {
                                                                  try {
                                                                    setState(
                                                                        () {
                                                                      zoomLevel =
                                                                          zoomLevel -
                                                                              1;
                                                                    });

                                                                    controller.move(
                                                                        controller
                                                                            .center,
                                                                        zoomLevel);
                                                                  } catch (e) {
                                                                    GBSystem_ManageCatchErrors().catchErrors(
                                                                        context,
                                                                        message: e
                                                                            .toString(),
                                                                        method:
                                                                            "GBSystem_home_screen",
                                                                        page:
                                                                            "zoomOUT (home)");
                                                                  }
                                                                },
                                                                icon: Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8),
                                                                    decoration: BoxDecoration(
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.black12,
                                                                            blurRadius:
                                                                                10,
                                                                            spreadRadius:
                                                                                1,
                                                                          ),
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                200),
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200),
                                                                    child: Icon(
                                                                        Icons
                                                                            .remove))),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child: GBSystem_TextHelper()
                                                  .smallText(
                                                      text:
                                                          "${GbsSystemStrings.str_loading_map.tr} ..."),
                                            );
                                          }
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: CustomButtonWithTrailling(
                                            trailling: Icon(
                                              CupertinoIcons.time,
                                              color: Colors.white,
                                            ),
                                            letterSpacing: 0,
                                            verPadding: 12,
                                            textSize: 14,
                                            textBold: true,
                                            text: GbsSystemStrings
                                                .str_afficher_historique.tr,
                                            onTap: () async {
                                              try {
                                                await m.getHistorique(context);
                                              } catch (e) {
                                                m.isloading.value = false;
                                                GBSystem_ManageCatchErrors()
                                                    .catchErrors(context,
                                                        message: e.toString(),
                                                        method: "getHistorique",
                                                        page:
                                                            "GBSystem_Home_Screen");
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                      m.isloading.value ? Waiting() : Container()
                    ],
                  ),
                ),
                m.isloading.value ? Waiting() : Container()
              ],
            )));
  }

  // "pk.eyJ1IjoiYm1zb2Z0LW1hcCIsImEiOiJja2V2N3I0ZG8zcXYwMnJwaWNocnpoOTU2In0.iViaptlZtPPk6tDa8Woa9Q",
  // m
  //     .salarieController
  //     .getSalarie!
  //     .mapToken!
  //     ??
  // GbsSystemServerStrings
  //     .MAPBOX_ACCESS_TOKEN
  // ,
  LatLng getListMarkerFromController() {
    LatLng marks = LatLng(
        double.parse(m
            .vacationController.getCurrentVacationRx.value!.LIE_LATITUDE
            .replaceAll(",", ".")),
        double.parse(m
            .vacationController.getCurrentVacationRx.value!.LIE_LONGITUDE
            .replaceAll(",", ".")));

    print("new mark : ${marks.latitude} / ${marks.longitude}");
    return marks;
  }

  Marker? getListMarker() {
    return m.vacationController.getCurrentVacationRx.value != null &&
            _markerData != null
        ? Marker(
            point: _markerData!,
            child: InkWell(
              onTap: () {
                setState(() {
                  m.markerLocationVisibility.value
                      ? m.markerLocationVisibility.value = false
                      : m.markerLocationVisibility.value = true;
                });
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    child: Icon(
                      CupertinoIcons.location_solid,
                      color: Colors.blueAccent,
                      // color: _markerData != LatLng(49.640616, -1.624229)
                      //     ? Colors.blueAccent
                      //     : Colors.redAccent,
                      size: 40,
                    ),
                  ),
                  Visibility(
                    visible: m.markerLocationVisibility.value,
                    child: Positioned(
                      top: -25,
                      left: -25,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: Colors.grey.shade200),
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
                            text: m.vacationController.getCurrentVacationRx
                                    .value?.LIE_LIB ??
                                ""),
                      ),
                    ),
                  )
                ],
              ),
            ))
        : null;
  }
}
