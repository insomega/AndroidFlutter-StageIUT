import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_compteur_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_compteur_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/TYPE_ABSENCE_DISPLAY_DATA_WIDGET/type_absence_display_data_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class CETWidgetController extends GetxController {
  CETWidgetController(this.context);

  BuildContext context;
  CompteurModel? compteurModel;
  final compteurController =
      Get.put<GBSystemCompteurController>(GBSystemCompteurController());

  PageController pageController = PageController(initialPage: 0);
  RxInt currentPageIndex = 0.obs;
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    compteurModel = compteurController.getCompteur;
    super.onInit();
  }

  Future<void> dialogCompteur(
      {required BuildContext context,
      required CompteurModel compteurModel}) async {
    // Capture the context before it's disposed
    BuildContext dialogContext = context;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: dialogContext,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),

                    // backgroundColor: GbsSystemStrings.str_primary_color.withOpacity(0.85),
                    backgroundColor: Colors.white,
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: 250,
                          height: GBSystem_ScreenHelper.screenHeightPercentage(
                              context, 0.65),
                          child: PageView.builder(
                            onPageChanged: (index) {
                              currentPageIndex.value = index;
                            },
                            // controller: pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,

                            itemBuilder: (context, index) {
                              return TypeAbsenceDisplayDataWidget(
                                atr1: (index == 0
                                        ? compteurModel.SABSD_CP_ACQUIS
                                        : index == 1
                                            ? compteurModel.SABSD_RC_ACQUIS
                                            : compteurModel.SABSD_RTT_ACQUIS) ??
                                    "",
                                name: (index == 0
                                        ? compteurModel.TPH_CODE_CP
                                        : index == 1
                                            ? compteurModel.TPH_CODE_RC
                                            : compteurModel.TPH_CODE_RTT) ??
                                    "",
                                atr2: (index == 0
                                        ? compteurModel.SABSD_CP_PRIS
                                        : index == 1
                                            ? compteurModel.SABSD_RC_PRIS
                                            : compteurModel.SABSD_RTT_PRIS) ??
                                    "",
                                atr22: (index == 0
                                        ? compteurModel.CET_EN_COURS_CP
                                        : index == 1
                                            ? compteurModel.CET_EN_COURS_RC
                                            : compteurModel.CET_EN_COURS_RTT) ??
                                    "",
                                atr3: (index == 0
                                        ? compteurModel.CPJOUR
                                        : index == 1
                                            ? compteurModel.RCJOUR
                                            : compteurModel.RTTJOUR) ??
                                    "",
                                atr4: (index == 0
                                        ? compteurModel.CP_DEM
                                        : index == 1
                                            ? compteurModel.RC_DEM
                                            : "") ??
                                    "",
                                atr5: (index == 0
                                        ? compteurModel.CP_REST
                                        : index == 1
                                            ? compteurModel.RC_REST
                                            : compteurModel.RTT_REST) ??
                                    "",
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(CupertinoIcons.multiply,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: GbsSystemStrings.str_primary_color,
                            textStyle: TextStyle(
                                color: GbsSystemStrings.str_primary_color)),
                        onPressed: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            GbsSystemStrings.str_fermer.tr,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
        },
      );
    });
  }

  // void dialogCompteur({required CompteurModel compteurModel}) async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Get.dialog(
  //       AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //         backgroundColor: Colors.white,
  //         content: Padding(
  //           padding: EdgeInsets.symmetric(vertical: 10),
  //           child: Stack(
  //             clipBehavior: Clip.none,
  //             children: [
  //               SizedBox(
  //                 height: GBSystem_ScreenHelper.screenHeightPercentage(
  //                     context, 0.65),
  //                 width: 250,
  //                 child: PageView.builder(
  //                   onPageChanged: (index) {
  //                     currentPageIndex.value = index;
  //                   },
  //                   // controller: pageController,
  //                   scrollDirection: Axis.horizontal,
  //                   itemCount: 3,
  //                   itemBuilder: (context, index) {
  //                     return TypeAbsenceDisplayDataWidget(
  //                       atr1: (index == 0
  //                               ? compteurModel.SABSD_CP_ACQUIS
  //                               : index == 1
  //                                   ? compteurModel.SABSD_RC_ACQUIS
  //                                   : compteurModel.SABSD_RTT_ACQUIS) ??
  //                           "",
  //                       name: (index == 0
  //                               ? compteurModel.TPH_CODE_CP
  //                               : index == 1
  //                                   ? compteurModel.TPH_CODE_RC
  //                                   : compteurModel.TPH_CODE_RTT) ??
  //                           "",
  //                       atr2: (index == 0
  //                               ? compteurModel.SABSD_CP_PRIS
  //                               : index == 1
  //                                   ? compteurModel.SABSD_RC_PRIS
  //                                   : compteurModel.SABSD_RTT_PRIS) ??
  //                           "",
  //                       atr22: (index == 0
  //                               ? compteurModel.CET_EN_COURS_CP
  //                               : index == 1
  //                                   ? compteurModel.CET_EN_COURS_RC
  //                                   : compteurModel.CET_EN_COURS_RTT) ??
  //                           "",
  //                       atr3: (index == 0
  //                               ? compteurModel.CPJOUR
  //                               : index == 1
  //                                   ? compteurModel.RCJOUR
  //                                   : compteurModel.RTTJOUR) ??
  //                           "",
  //                       atr4: (index == 0
  //                               ? compteurModel.CP_DEM
  //                               : index == 1
  //                                   ? compteurModel.RC_DEM
  //                                   : "") ??
  //                           "",
  //                       atr5: (index == 0
  //                               ? compteurModel.CP_REST
  //                               : index == 1
  //                                   ? compteurModel.RC_REST
  //                                   : compteurModel.RTT_REST) ??
  //                           "",
  //                     );
  //                   },
  //                 ),
  //               ),
  //               Positioned(
  //                 top: 0,
  //                 left: 0,
  //                 child: InkWell(
  //                   onTap: () {
  //                     Get.back();
  //                   },
  //                   child: Icon(CupertinoIcons.multiply, color: Colors.white),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: GbsSystemStrings.str_primary_color,
  //               textStyle: TextStyle(color: Colors.white),
  //             ),
  //             onPressed: () {
  //               Get.back();
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.all(4.0),
  //               child: Expanded(
  //                 // width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.15),
  //                 child: Text(
  //                   GbsSystemStrings.str_fermer.tr,
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

// Future<void> showDialogCompteurInfo(
//       {required BuildContext context,
//       required CompteurModel compteurModel}) async {
//     // Capture the context before it's disposed
//     // BuildContext dialogContext = context;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//             builder: (context, setState) => AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//               backgroundColor:
//                   GbsSystemStrings.str_primary_color.withOpacity(0.85),
//               content: Padding(
//                 padding: EdgeInsets.only(
//                   top: GBSystem_ScreenHelper.screenHeightPercentage(
//                       context, 0.02),
//                 ),
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     PageView.builder(
//                       onPageChanged: (index) {
//                         currentPageIndex.value = index;
//                       },
//                       // controller: pageController,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 3,
//                       itemBuilder: (context, index) {
//                         return TypeAbsenceDisplayDataWidget(
//                           atr1: (index == 0
//                                   ? compteurModel.SABSD_CP_ACQUIS
//                                   : index == 1
//                                       ? compteurModel.SABSD_RC_ACQUIS
//                                       : compteurModel.SABSD_RTT_ACQUIS) ??
//                               "",
//                           name: (index == 0
//                                   ? compteurModel.TPH_CODE_CP
//                                   : index == 1
//                                       ? compteurModel.TPH_CODE_RC
//                                       : compteurModel.TPH_CODE_RTT) ??
//                               "",
//                           atr2: (index == 0
//                                   ? compteurModel.SABSD_CP_PRIS
//                                   : index == 1
//                                       ? compteurModel.SABSD_RC_PRIS
//                                       : compteurModel.SABSD_RTT_PRIS) ??
//                               "",
//                           atr22: (index == 0
//                                   ? compteurModel.CET_EN_COURS_CP
//                                   : index == 1
//                                       ? compteurModel.CET_EN_COURS_RC
//                                       : compteurModel.CET_EN_COURS_RTT) ??
//                               "",
//                           atr3: (index == 0
//                                   ? compteurModel.CPJOUR
//                                   : index == 1
//                                       ? compteurModel.RCJOUR
//                                       : compteurModel.RTTJOUR) ??
//                               "",
//                           atr4: (index == 0
//                                   ? compteurModel.CP_DEM
//                                   : index == 1
//                                       ? compteurModel.RC_DEM
//                                       : "") ??
//                               "",
//                           atr5: (index == 0
//                                   ? compteurModel.CP_REST
//                                   : index == 1
//                                       ? compteurModel.RC_REST
//                                       : compteurModel.RTT_REST) ??
//                               "",
//                         );
//                       },
//                     ),
//                     Positioned(
//                       top: 0,
//                       left: 0,
//                       child: InkWell(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child:
//                             Icon(CupertinoIcons.multiply, color: Colors.white),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //   children: [
//                 //     ElevatedButton(

//                 //       style: ElevatedButton.styleFrom(
//                 //         backgroundColor: Colors.white,
//                 //         textStyle: TextStyle(color: GbsSystemStrings.str_primary_color),
//                 //       ),
//                 //       onPressed: () {
//                 //         pageController.animateToPage(currentPageIndex.value - 1,
//                 //             duration: Duration(milliseconds: 300), curve: Curves.bounceInOut);
//                 //       },
//                 //       child: Padding(
//                 //         padding: const EdgeInsets.all(4.0),
//                 //         child: Expanded(
//                 //           // width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.15),
//                 //           child: Text(
//                 //             GbsSystemStrings.str_precedent.tr,
//                 //             style: TextStyle(color: GbsSystemStrings.str_primary_color),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //     ElevatedButton(
//                 //       style: ElevatedButton.styleFrom(
//                 //         backgroundColor: Colors.white,
//                 //         textStyle: TextStyle(color: GbsSystemStrings.str_primary_color),
//                 //       ),
//                 //       onPressed: () {
//                 //         pageController.animateToPage(currentPageIndex.value + 1,
//                 //             duration: Duration(milliseconds: 300), curve: Curves.bounceInOut);
//                 //       },
//                 //       child: Padding(
//                 //         padding: const EdgeInsets.all(4.0),
//                 //         child: Expanded(
//                 //                 // width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.15),

//                 //           child: Text(
//                 //             GbsSystemStrings.str_suivant.tr,
//                 //             style: TextStyle(color: GbsSystemStrings.str_primary_color),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//               ],
//             ),
//           );
//         },
//       );
//     });

// }
}
