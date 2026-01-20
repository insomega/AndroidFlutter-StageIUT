import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DOCUMENTS_SCREENS/ALL_HABILITATIONS_SCREEN/all_habilitations_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DOCUMENTS_SCREENS/DOCUMENT_SCREEN/GBSystem_document_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/DOCUMENT_WIDGETS/habilitation_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/DOCUMENT_WIDGETS/type_document_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemDocumentScreen extends StatefulWidget {
  const GBSystemDocumentScreen({super.key, this.isCommingFromOut = false});

  final bool isCommingFromOut;

  @override
  State<GBSystemDocumentScreen> createState() => _GBSystemDocumentScreenState();
}

class _GBSystemDocumentScreenState extends State<GBSystemDocumentScreen> {
  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final m = Get.put<DocumentScreenController>(DocumentScreenController());
    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                centerTitle: true,
                elevation: 4.0,
                shadowColor: GbsSystemStrings.str_primary_color,
                toolbarHeight: 80,
                backgroundColor: GbsSystemStrings.str_primary_color,
                title: Text(
                  GbsSystemStrings.str_documents.tr,
                  style: TextStyle(color: Colors.white),
                ),
                leading: widget.isCommingFromOut
                    ? InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          CupertinoIcons.arrow_branch,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
              ),
              body: FutureBuilder(
                future: GBSystem_AuthService(context).getDocumentsMain(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              GBSystem_ScreenHelper.screenHeightPercentage(
                                  context, 0.02),
                          horizontal:
                              GBSystem_ScreenHelper.screenWidthPercentage(
                                  context, 0.02)),
                      child: SingleChildScrollView(
                        child: Column(
                          //  Wrap(
                          //     spacing: 20,
                          //     runSpacing: 15,

                          children: [
                            TypeDocumentWidget(
                              onAddTap: () async {
                                try {
                                  await m.showDialogAddHabilitation(
                                      context: context);
                                } catch (e) {
                                  m.isLoading.value = false;
                                  GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "showDialogAddHabilitation",
                                      page: "GBSystem_document_screen");
                                }
                              },
                              onTap: () {
                                m.currentIndex.value = 0;
                                Get.to(AllHabilitationsScreen(
                                  updateUI: updateUI,
                                  currentIndex: m.currentIndex,
                                  isCommingFromOut: true,
                                  listAgrements: snapshot.data?.listAgrements,
                                  listDiplomes: snapshot.data?.listDiplomes,
                                  listDocumentsOfficiel:
                                      snapshot.data?.listDocumentsOfficiel,
                                  listHabilitations:
                                      snapshot.data?.listHabilitations,
                                ));
                              },
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.8),
                              number:
                                  snapshot.data?.listHabilitations?.length ?? 0,
                              text: GbsSystemStrings.str_habilitations.tr,
                              color: Colors.pink,
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            TypeDocumentWidget(
                              onAddTap: () async {
                                try {
                                  await m.showDialogAddAgrement(
                                      context: context);
                                } catch (e) {
                                  GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "showDialogAddAgrement",
                                      page: "GBSystem_document_screen");
                                }
                              },
                              onTap: () {
                                m.currentIndex.value = 1;
                                Get.to(AllHabilitationsScreen(
                                  updateUI: updateUI,
                                  currentIndex: m.currentIndex,
                                  isCommingFromOut: true,
                                  listAgrements: snapshot.data?.listAgrements,
                                  listDiplomes: snapshot.data?.listDiplomes,
                                  listDocumentsOfficiel:
                                      snapshot.data?.listDocumentsOfficiel,
                                  listHabilitations:
                                      snapshot.data?.listHabilitations,
                                ));
                              },
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.8),
                              number: snapshot.data?.listAgrements?.length ?? 0,
                              text: GbsSystemStrings.str_agrements.tr,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            TypeDocumentWidget(
                              onAddTap: () async {
                                try {
                                  await m.showDialogAddDiplome(
                                      context: context);
                                } catch (e) {
                                  GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "showDialogAddDiplome",
                                      page: "GBSystem_document_screen");
                                }
                              },
                              onTap: () {
                                m.currentIndex.value = 2;
                                Get.to(AllHabilitationsScreen(
                                  updateUI: updateUI,
                                  currentIndex: m.currentIndex,
                                  isCommingFromOut: true,
                                  listAgrements: snapshot.data?.listAgrements,
                                  listDiplomes: snapshot.data?.listDiplomes,
                                  listDocumentsOfficiel:
                                      snapshot.data?.listDocumentsOfficiel,
                                  listHabilitations:
                                      snapshot.data?.listHabilitations,
                                ));
                              },
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.8),
                              number: snapshot.data?.listDiplomes?.length ?? 0,
                              text: GbsSystemStrings.str_diplomes.tr,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            TypeDocumentWidget(
                              onTap: () {
                                m.currentIndex.value = 3;
                                Get.to(AllHabilitationsScreen(
                                  updateUI: updateUI,
                                  currentIndex: m.currentIndex,
                                  isCommingFromOut: true,
                                  listAgrements: snapshot.data?.listAgrements,
                                  listDiplomes: snapshot.data?.listDiplomes,
                                  listDocumentsOfficiel:
                                      snapshot.data?.listDocumentsOfficiel,
                                  listHabilitations:
                                      snapshot.data?.listHabilitations,
                                ));
                              },
                              onAddTap: () async {
                                try {
                                  await m.showDialogAddDocumentOfficiel(
                                      context: context);
                                } catch (e) {
                                  GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "showDialogAddDocumentOfficiel",
                                      page: "GBSystem_document_screen");
                                }
                              },
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.8),
                              number: snapshot
                                      .data?.listDocumentsOfficiel?.length ??
                                  0,
                              text: GbsSystemStrings.str_documents_officiels.tr,
                              color: Colors.lightBlue,
                            ),
                            Visibility(
                              visible: false,
                              child: SizedBox(
                                  height: 200,
                                  // width: 200,
                                  child: Obx(
                                    () => PageView.builder(
                                      itemCount: m.currentIndex.value == 0
                                          ? snapshot
                                              .data!.listHabilitations?.length
                                          : m.currentIndex.value == 1
                                              ? snapshot
                                                  .data!.listAgrements?.length
                                              : m.currentIndex.value == 2
                                                  ? snapshot.data!.listDiplomes
                                                      ?.length
                                                  : snapshot
                                                      .data!
                                                      .listDocumentsOfficiel
                                                      ?.length,
                                      itemBuilder: (context, index) {
                                        return m.currentIndex.value == 0
                                            ? ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: snapshot.data!
                                                    .listHabilitations?.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                    child: HabilitationWidget(
                                                        onDeleteTap: () async {
                                                          try {
                                                            m.isLoading.value =
                                                                true;

                                                            await GBSystem_AuthService(
                                                                    context)
                                                                .deleteHabilitation(
                                                                    habilitationModel:
                                                                        snapshot
                                                                            .data!
                                                                            .listHabilitations![index])
                                                                .then((value) {
                                                              m.isLoading
                                                                      .value =
                                                                  false;

                                                              if (value ==
                                                                  true) {
                                                                showSuccesDialog(
                                                                    context,
                                                                    GbsSystemStrings
                                                                        .str_deleted_with_success
                                                                        .tr);
                                                              }
                                                            });
                                                          } catch (e) {
                                                            m.isLoading.value =
                                                                false;
                                                            GBSystem_ManageCatchErrors()
                                                                .catchErrors(
                                                                    context,
                                                                    message: e
                                                                        .toString(),
                                                                    method:
                                                                        "deleteHabilitation",
                                                                    page:
                                                                        "GBSystem_document_screen");
                                                          }
                                                        },
                                                        onUpdateTap: () {
                                                          try {
                                                            m.Hab_selected_FOR_LIB
                                                                    ?.value =
                                                                snapshot
                                                                    .data!
                                                                    .listHabilitations![
                                                                        index]
                                                                    .FOR_LIB;
                                                            m.showDialogUpdateHabilitation(
                                                                context:
                                                                    context,
                                                                habilitationModel:
                                                                    snapshot.data!
                                                                            .listHabilitations![
                                                                        index]);
                                                          } catch (e) {
                                                            GBSystem_ManageCatchErrors()
                                                                .catchErrors(
                                                                    context,
                                                                    message: e
                                                                        .toString(),
                                                                    method:
                                                                        "showDialogUpdateHabilitation",
                                                                    page:
                                                                        "GBSystem_document_screen");
                                                          }
                                                        },
                                                        habilitationModel: snapshot
                                                                .data!
                                                                .listHabilitations![
                                                            index]),
                                                  );
                                                },
                                              )
                                            : m.currentIndex.value == 1
                                                ? ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data!
                                                        .listAgrements?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 5,
                                                                vertical: 10),
                                                        child: AgrementWidget(
                                                            onDeleteTap:
                                                                () async {
                                                              try {
                                                                m.isLoading
                                                                        .value =
                                                                    true;

                                                                await GBSystem_AuthService(
                                                                        context)
                                                                    .deleteAgrement(
                                                                        agrementModel: snapshot
                                                                            .data!
                                                                            .listAgrements![index])
                                                                    .then((value) {
                                                                  m.isLoading
                                                                          .value =
                                                                      false;

                                                                  if (value ==
                                                                      true) {
                                                                    showSuccesDialog(
                                                                        context,
                                                                        GbsSystemStrings
                                                                            .str_deleted_with_success
                                                                            .tr);
                                                                  }
                                                                });
                                                              } catch (e) {
                                                                m.isLoading
                                                                        .value =
                                                                    false;
                                                                GBSystem_ManageCatchErrors().catchErrors(
                                                                    context,
                                                                    message: e
                                                                        .toString(),
                                                                    method:
                                                                        "deleteAgrement",
                                                                    page:
                                                                        "GBSystem_document_screen");
                                                              }
                                                            },
                                                            onUpdateTap: () {
                                                              try {
                                                                m.Agr_selected_HAB_LIB
                                                                        ?.value =
                                                                    snapshot
                                                                        .data!
                                                                        .listAgrements![
                                                                            index]
                                                                        .HAB_LIB;
                                                                m.showDialogUpdateAgrement(
                                                                    context:
                                                                        context,
                                                                    agrementModel:
                                                                        snapshot
                                                                            .data!
                                                                            .listAgrements![index]);
                                                              } catch (e) {
                                                                GBSystem_ManageCatchErrors().catchErrors(
                                                                    context,
                                                                    message: e
                                                                        .toString(),
                                                                    method:
                                                                        "showDialogUpdateAgrement",
                                                                    page:
                                                                        "GBSystem_document_screen");
                                                              }
                                                            },
                                                            agrementModel: snapshot
                                                                    .data!
                                                                    .listAgrements![
                                                                index]),
                                                      );
                                                    },
                                                  )
                                                : m.currentIndex.value == 2
                                                    ? ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemCount: snapshot
                                                            .data!
                                                            .listDiplomes
                                                            ?.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        10),
                                                            child:
                                                                DiplomeWidget(
                                                                    onDeleteTap:
                                                                        () async {
                                                                      try {
                                                                        m.isLoading.value =
                                                                            true;

                                                                        await GBSystem_AuthService(context)
                                                                            .deleteDiplome(diplomeModel: snapshot.data!.listDiplomes![index])
                                                                            .then((value) {
                                                                          m.isLoading.value =
                                                                              false;

                                                                          if (value ==
                                                                              true) {
                                                                            showSuccesDialog(context,
                                                                                GbsSystemStrings.str_deleted_with_success.tr);
                                                                          }
                                                                        });
                                                                      } catch (e) {
                                                                        m.isLoading.value =
                                                                            false;
                                                                        GBSystem_ManageCatchErrors().catchErrors(
                                                                            context,
                                                                            message: e
                                                                                .toString(),
                                                                            method:
                                                                                "deleteDiplome",
                                                                            page:
                                                                                "GBSystem_document_screen");
                                                                      }
                                                                    },
                                                                    onUpdateTap:
                                                                        () {
                                                                      try {
                                                                        m.Dip_selected_DIP_LIB?.value = snapshot
                                                                            .data!
                                                                            .listDiplomes![index]
                                                                            .DIP_LIB;
                                                                        m.showDialogUpdateDiplome(
                                                                            context:
                                                                                context,
                                                                            diplomeModel:
                                                                                snapshot.data!.listDiplomes![index]);
                                                                      } catch (e) {
                                                                        GBSystem_ManageCatchErrors().catchErrors(
                                                                            context,
                                                                            message: e
                                                                                .toString(),
                                                                            method:
                                                                                "showDialogUpdateDiplome",
                                                                            page:
                                                                                "GBSystem_document_screen");
                                                                      }
                                                                    },
                                                                    diplomeModel:
                                                                        snapshot
                                                                            .data!
                                                                            .listDiplomes![index]),
                                                          );
                                                        },
                                                      )
                                                    : ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemCount: snapshot
                                                            .data!
                                                            .listDocumentsOfficiel
                                                            ?.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        10),
                                                            child:
                                                                DocumentOfficielWidget(
                                                                    onDeleteTap:
                                                                        () async {
                                                                      try {
                                                                        m.isLoading.value =
                                                                            true;

                                                                        await GBSystem_AuthService(context)
                                                                            .deleteDocumentOfficiel(documentOfficielModel: snapshot.data!.listDocumentsOfficiel![index])
                                                                            .then((value) {
                                                                          m.isLoading.value =
                                                                              false;

                                                                          if (value ==
                                                                              true) {
                                                                            showSuccesDialog(context,
                                                                                GbsSystemStrings.str_deleted_with_success.tr);
                                                                          }
                                                                        });
                                                                      } catch (e) {
                                                                        m.isLoading.value =
                                                                            false;
                                                                        GBSystem_ManageCatchErrors().catchErrors(
                                                                            context,
                                                                            message: e
                                                                                .toString(),
                                                                            method:
                                                                                "deleteDocumentOfficiel",
                                                                            page:
                                                                                "GBSystem_document_screen");
                                                                      }
                                                                    },
                                                                    onUpdateTap:
                                                                        () {
                                                                      try {
                                                                        m.Doc_selected_DOCOFF_LIB?.value = snapshot
                                                                            .data!
                                                                            .listDocumentsOfficiel![index]
                                                                            .DOCOFF_LIB;
                                                                        m.showDialogUpdateDocumentOfficiel(
                                                                            context:
                                                                                context,
                                                                            documentOfficielModel:
                                                                                snapshot.data!.listDocumentsOfficiel![index]);
                                                                      } catch (e) {
                                                                        GBSystem_ManageCatchErrors().catchErrors(
                                                                            context,
                                                                            message: e
                                                                                .toString(),
                                                                            method:
                                                                                "showDialogUpdateDocumentOfficiel",
                                                                            page:
                                                                                "GBSystem_document_screen");
                                                                      }
                                                                    },
                                                                    documentOfficielModel:
                                                                        snapshot
                                                                            .data!
                                                                            .listDocumentsOfficiel![index]),
                                                          );
                                                        },
                                                      );
                                      },
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Waiting();
                  }
                },
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
