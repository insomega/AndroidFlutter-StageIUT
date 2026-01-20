import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_nombre_notifications_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_publication_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAIN_SCREEN/GBSystem_Main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/VALIDER_DOCUMENTS_SCREEN/GBSystem_valider_documents_screen__controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/USER_ENTRER_SORTIE/PRISE_SERVICE_VALIDER_DOCS/GBSystem_user_entrer_sortie_valider.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/VALIDER_DOCUMENTS_WIDGETS/GBSystem_document_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/VALIDER_DOCUMENTS_WIDGETS/GBSystem_publication_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemValiderDocumentsScreen extends StatefulWidget {
  GBSystemValiderDocumentsScreen({super.key, this.valideAuth = false});
  final bool valideAuth;
  @override
  State<GBSystemValiderDocumentsScreen> createState() =>
      _GBSystemValiderDocumentsScreenState();
}

class _GBSystemValiderDocumentsScreenState
    extends State<GBSystemValiderDocumentsScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  String _authStatus = GbsSystemStrings.str_auth_please_authentificate.tr;
  bool authSuccess = false;

  // Check if device supports biometrics
  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    return canCheckBiometrics;
  }

  // Authenticate using biometrics
  Future<bool> _authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason:
            GbsSystemStrings.str_auth_please_authentificate_to_proceed.tr,
        options: AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _authStatus = authenticated
            ? GbsSystemStrings.str_auth_auth_success.tr
            : GbsSystemStrings.str_auth_auth_failed.tr;
      });
      authSuccess = authenticated;
      return authenticated;
    } catch (e) {
      setState(() {
        _authStatus =
            "${GbsSystemStrings.str_dialog_erreur.tr}: ${e.toString()}";
      });
      authSuccess = true;

      return false;
    }
  }

  Future<void> resultAuth() async {
    bool canAuthenticate = await _checkBiometrics();

    if (canAuthenticate) {
      // Loop until authentication succeeds
      if (!authSuccess) {
        await _authenticate();
        if (authSuccess) {
          // Authentication succeeded, print success message
          print("auth success -----");
        } else {
          exit(0);
        }
      }
    } else {
      setState(() {
        _authStatus = GbsSystemStrings.str_auth_biometrics_not_available.tr;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(GbsSystemStrings.str_auth_biometrics_not_available.tr),
            content:
                Text(GbsSystemStrings.str_device_dont_support_biometrics.tr),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  authSuccess = true;
                },
                child: Text(GbsSystemStrings.str_fermer.tr),
              ),
            ],
          );
        },
      );
    }
  }

  final m = Get.put<GBSystemValiderDocumentsScreenController>(
      GBSystemValiderDocumentsScreenController());

  void updateUIValiderDocuments() {
    setState(() {});
  }

  @override
  void initState() {
    print("debuuuuuuuuuuuuuut");
    if (widget.valideAuth) {
      resultAuth();
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                centerTitle: true,
                elevation: 4.0,
                leading: Container(),
                shadowColor: GbsSystemStrings.str_primary_color,
                toolbarHeight: 80,
                backgroundColor: GbsSystemStrings.str_primary_color,
                title: Text(
                  GbsSystemStrings.str_valider_vos_documents.tr,
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomIconButton(
                      icon: Icon(
                        CupertinoIcons.home,
                        color: GbsSystemStrings.str_primary_color,
                      ),
                      height: 40,
                      width: 40,
                      raduis: 100,
                      color: Colors.white,
                      onTap: () async {
                        if ((m
                                        .validerDocumentsController
                                        .getCurrentValiderDocument
                                        .value
                                        ?.listDocuments ==
                                    null ||
                                m
                                    .validerDocumentsController
                                    .getCurrentValiderDocument
                                    .value!
                                    .listDocuments!
                                    .isEmpty) &&
                            (m
                                        .validerDocumentsController
                                        .getCurrentValiderDocument
                                        .value
                                        ?.listPublications ==
                                    null ||
                                m
                                    .validerDocumentsController
                                    .getCurrentValiderDocument
                                    .value!
                                    .listPublications!
                                    .isEmpty)) {
                          await GBSystem_AuthService(context)
                              .getInfoSalarie()
                              .then((infoSalarie) async {
                            if (infoSalarie != null) {
                              final GBSystemSalarieController
                                  salarieController =
                                  Get.put(GBSystemSalarieController());
                              final GBSystemVacationController
                                  vacationController =
                                  Get.put(GBSystemVacationController());
                              final notificationController =
                                  Get.put<GBSystemNotificationController>(
                                      GBSystemNotificationController());
                              salarieController.setSalarie = infoSalarie;
                              await GBSystem_AuthService(context)
                                  .getVacationsHome()
                                  .then((vacationsHome) async {
                                print("vacation : $vacationsHome");
                                if (vacationsHome != null &&
                                    vacationsHome.isNotEmpty) {
                                  vacationController.setAllVacation =
                                      vacationsHome;
                                  vacationController
                                          .setCurrentVacationVacation =
                                      vacationsHome.first;
                                }
                              });
                              await GBSystem_AuthService(context)
                                  .getNombreNotiChat()
                                  .then((nbrNoti) async {
                                if (nbrNoti != null) {
                                  notificationController.setNbrNoti = nbrNoti;
                                }
                              });
                              await GBSystem_AuthService(context)
                                  .getNombreVacationProposer()
                                  .then((nbrVac) async {
                                if (nbrVac != null) {
                                  vacationController
                                      .setNumberVacationsProposer = nbrVac;
                                }
                              });

                              Get.to(GBSystemMainScreen());
                            } else {}
                          });
                        } else {
                          showErrorDialog(
                              context,
                              GbsSystemStrings
                                  .str_att_vos_devez_valider_docs.tr);
                        }
                      },
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.01)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() => m
                                      .validerDocumentsController
                                      .getCurrentValiderDocument
                                      .value
                                      ?.listPublications !=
                                  null &&
                              m
                                  .validerDocumentsController
                                  .getCurrentValiderDocument
                                  .value!
                                  .listPublications!
                                  .isNotEmpty
                          ? Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: GBSystem_ScreenHelper
                                          .screenHeightPercentage(
                                              context, 0.01)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GBSystem_TextHelper().normalText(
                                          fontWeight: FontWeight.bold,
                                          text: GbsSystemStrings
                                              .str_planning_non_consulter.tr,
                                          textColor: GbsSystemStrings
                                              .str_primary_color),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        int previousPageIndex =
                                            m.pageController.page!.round() - 1;
                                        m.pageController.animateToPage(
                                            previousPageIndex,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.linear);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          CupertinoIcons.arrow_left_circle_fill,
                                          color: GbsSystemStrings
                                              .str_primary_color,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 250,
                                      width: 300,
                                      child: PageView.builder(
                                        controller: m.pageController,
                                        // shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: m
                                                .validerDocumentsController
                                                .getCurrentValiderDocument
                                                .value
                                                ?.listPublications
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            child: PublicationWidget(
                                                btnDisplayText: GbsSystemStrings
                                                        .str_afficher.tr +
                                                    " / " +
                                                    GbsSystemStrings
                                                        .str_partager.tr,
                                                showDownloadBtn: false,
                                                onTelechargerTap: () async {
                                                  m.pubFunction(
                                                      m
                                                              .validerDocumentsController
                                                              .getCurrentValiderDocument
                                                              .value
                                                              ?.listPublications?[
                                                                  index]
                                                              .SVR_LIB ??
                                                          "publicationPDF",
                                                      index,
                                                      context);
                                                },
                                                onAfficherTap: () async {
                                                  m.pubFunctionWithDisplay(
                                                      // m
                                                      //         .validerDocumentsController
                                                      //         .getCurrentValiderDocument
                                                      //         .value
                                                      //         ?.listPublications?[
                                                      //             index]
                                                      //         .SVR_LIB ??
                                                      //     "publicationPDF"
                                                      m
                                                                  .validerDocumentsController
                                                                  .getCurrentValiderDocument
                                                                  .value
                                                                  ?.listPublications?[
                                                                      index]
                                                                  .SVRPPH_START_DATE !=
                                                              null
                                                          ? "${PublicationModel.convertDate(m.validerDocumentsController.getCurrentValiderDocument.value!.listPublications![index].SVRPPH_START_DATE!, separateur: "_")}.pdf"
                                                          : "publicationPDF.pdf",
                                                      index,
                                                      context);
                                                },
                                                publicationModel: m
                                                    .validerDocumentsController
                                                    .getCurrentValiderDocument
                                                    .value!
                                                    .listPublications![index]),
                                          );
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        int nextPageIndex =
                                            m.pageController.page!.round() + 1;
                                        m.pageController.animateToPage(
                                            nextPageIndex,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.linear);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          CupertinoIcons
                                              .arrow_right_circle_fill,
                                          color: GbsSystemStrings
                                              .str_primary_color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container()),
                      Obx(() => m
                                      .validerDocumentsController
                                      .getCurrentValiderDocument
                                      .value
                                      ?.listDocuments !=
                                  null &&
                              m
                                  .validerDocumentsController
                                  .getCurrentValiderDocument
                                  .value!
                                  .listDocuments!
                                  .isNotEmpty
                          ? Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: GBSystem_ScreenHelper
                                          .screenHeightPercentage(
                                              context, 0.01)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GBSystem_TextHelper().normalText(
                                          fontWeight: FontWeight.bold,
                                          text: GbsSystemStrings
                                              .str_documents_de_lentreprise.tr,
                                          textColor: GbsSystemStrings
                                              .str_primary_color),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        int previousPageIndex =
                                            m.pageController2.page!.round() - 1;
                                        m.pageController2.animateToPage(
                                            previousPageIndex,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.linear);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          CupertinoIcons.arrow_left_circle_fill,
                                          color: GbsSystemStrings
                                              .str_primary_color,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 250,
                                      width: 300,
                                      child: PageView.builder(
                                        // shrinkWrap: true,
                                        controller: m.pageController2,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: m
                                                .validerDocumentsController
                                                .getCurrentValiderDocument
                                                .value
                                                ?.listDocuments
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            child: DocumentWidget(
                                                btnDisplayText: GbsSystemStrings
                                                        .str_afficher.tr +
                                                    " / " +
                                                    GbsSystemStrings
                                                        .str_partager.tr,
                                                showDownloadBtn: false,
                                                onTelechargerTap: () async {
                                                  m.docFunction(
                                                      m
                                                              .validerDocumentsController
                                                              .getCurrentValiderDocument
                                                              .value
                                                              ?.listDocuments?[
                                                                  index]
                                                              .DOCAN_CODE ??
                                                          "documentPDF",
                                                      index,
                                                      context);
                                                },
                                                onAfficherTap: () async {
                                                  m.docFunctionWithDisplay(
                                                      m
                                                              .validerDocumentsController
                                                              .getCurrentValiderDocument
                                                              .value
                                                              ?.listDocuments?[
                                                                  index]
                                                              .DOCAN_CODE ??
                                                          "documentPDF",
                                                      index,
                                                      context);
                                                },
                                                documentModel: m
                                                    .validerDocumentsController
                                                    .getCurrentValiderDocument
                                                    .value!
                                                    .listDocuments![index]),
                                          );
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        int nextPageIndex =
                                            m.pageController2.page!.round() + 1;
                                        m.pageController2.animateToPage(
                                            nextPageIndex,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.linear);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          CupertinoIcons
                                              .arrow_right_circle_fill,
                                          color: GbsSystemStrings
                                              .str_primary_color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container()),
                      Obx(
                        () => m.validerDocumentsController
                                .getCurrentVacationBool.value
                            ? Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: GBSystem_ScreenHelper
                                            .screenHeightPercentage(
                                                context, 0.01)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GBSystem_TextHelper().normalText(
                                            fontWeight: FontWeight.bold,
                                            text: GbsSystemStrings
                                                .str_prise_de_vacation.tr,
                                            textColor: GbsSystemStrings
                                                .str_primary_color),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.01)),
                                    child: PriseDeServiceValiderDocuments(
                                      updateUI: updateUIValiderDocuments,
                                      onPointageTap: () async {
                                        m.validerDocumentsController
                                            .setCurrentVacationVacation = null;
                                        await m.verifierNoPDFtoGoHome(context);
                                        updateUIValiderDocuments();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
