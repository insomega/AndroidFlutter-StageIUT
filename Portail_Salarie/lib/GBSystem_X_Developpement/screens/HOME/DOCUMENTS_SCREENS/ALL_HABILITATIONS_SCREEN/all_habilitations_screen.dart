import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_agrement_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_diplome_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_officiel_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_habilitation_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DOCUMENTS_SCREENS/ALL_HABILITATIONS_SCREEN/all_habilitations_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/DOCUMENT_WIDGETS/habilitation_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

// ignore: must_be_immutable
class AllHabilitationsScreen extends StatefulWidget {
  AllHabilitationsScreen(
      {super.key,
      this.isCommingFromOut = false,
      required this.currentIndex,
      this.listHabilitations,
      this.listAgrements,
      this.listDiplomes,
      this.listDocumentsOfficiel,
      required this.updateUI});
  final bool isCommingFromOut;
  final RxInt currentIndex;
  List<HabilitationModel>? listHabilitations;
  List<AgrementModel>? listAgrements;
  List<DiplomeModel>? listDiplomes;
  List<DocumentOfficielModel>? listDocumentsOfficiel;
  final Function updateUI;
  @override
  State<AllHabilitationsScreen> createState() => _AllHabilitationsScreenState();
}

class _AllHabilitationsScreenState extends State<AllHabilitationsScreen> {
  void updateUI() {
    setState(() {});
  }

  void updateHabilitations(List<HabilitationModel>? newlistHabilitations) {
    widget.listHabilitations = newlistHabilitations;
  }

  void updateAgrements(List<AgrementModel>? newlistAgrements) {
    widget.listAgrements = newlistAgrements;
  }

  void updateDiplomes(List<DiplomeModel>? newlistDiplomes) {
    widget.listDiplomes = newlistDiplomes;
  }

  void updateDocumentsOfficiel(
      List<DocumentOfficielModel>? newlistDocumentsOfficiel) {
    widget.listDocumentsOfficiel = newlistDocumentsOfficiel;
  }

  Future<bool> _whenBack() async {
    widget.updateUI();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final m = Get.put<AllHabilitationsScreenController>(
        AllHabilitationsScreenController());

    print(
        "cooon ${widget.listDocumentsOfficiel != null && widget.listDocumentsOfficiel!.isNotEmpty}");
    return WillPopScope(
      onWillPop: _whenBack,
      child: Stack(
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
                widget.currentIndex.value == 0
                    ? GbsSystemStrings.str_habilitations.tr
                    : widget.currentIndex.value == 1
                        ? GbsSystemStrings.str_agrements.tr
                        : widget.currentIndex.value == 2
                            ? GbsSystemStrings.str_diplomes.tr
                            : GbsSystemStrings.str_documents_officiels.tr,
                style: TextStyle(color: Colors.white),
              ),
              leading: widget.isCommingFromOut
                  ? InkWell(
                      onTap: () {
                        Get.back();
                        widget.updateUI();
                      },
                      child: const Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
            ),
            body: SizedBox(
                // height:ScreenHel,
                // width: 200,
                child: Obx(
              () => PageView.builder(
                // scrollDirection: Axis.vertical,

                itemCount: widget.currentIndex.value == 0
                    ? widget.listHabilitations?.length
                    : widget.currentIndex.value == 1
                        ? widget.listAgrements?.length
                        : widget.currentIndex.value == 2
                            ? widget.listDiplomes?.length
                            : widget.listDocumentsOfficiel?.length,
                itemBuilder: (context, index) {
                  return widget.currentIndex.value == 0
                      ? widget.listHabilitations != null &&
                              widget.listHabilitations!.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.listHabilitations?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: HabilitationWidget(
                                      onDeleteTap: () async {
                                        showWarningSnackBar(
                                          context,
                                          GbsSystemStrings
                                              .str_are_you_sure_want_delete.tr,
                                          () async {
                                            try {
                                              m.isLoading.value = true;

                                              await GBSystem_AuthService(
                                                      context)
                                                  .deleteHabilitation(
                                                      habilitationModel: widget
                                                              .listHabilitations![
                                                          index])
                                                  .then((value) {
                                                m.isLoading.value = false;

                                                if (value == true) {
                                                  ///added
                                                  try {
                                                    setState(() {
                                                      widget.listHabilitations
                                                          ?.remove(widget
                                                                  .listHabilitations![
                                                              index]);
                                                    });
                                                    widget.updateUI();
                                                  } catch (e) {
                                                    print("error : $e");
                                                  }

                                                  ////
                                                  showSuccesDialog(
                                                      context,
                                                      GbsSystemStrings
                                                          .str_deleted_with_success
                                                          .tr);
                                                }
                                              });
                                            } catch (e) {
                                              m.isLoading.value = false;
                                              GBSystem_ManageCatchErrors()
                                                  .catchErrors(
                                                      context,
                                                      message: e.toString(),
                                                      method:
                                                          "deleteHabilitation",
                                                      page:
                                                          "GBSystem_document_screen");
                                            }
                                          },
                                        );
                                      },
                                      onUpdateTap: () {
                                        try {
                                          m.Hab_selected_FOR_LIB?.value = widget
                                              .listHabilitations![index]
                                              .FOR_LIB;
                                          m.showDialogUpdateHabilitation(
                                              context: context,
                                              updateHabilitations:
                                                  updateHabilitations,
                                              updateUI: updateUI,
                                              habilitationModel: widget
                                                  .listHabilitations![index]);
                                        } catch (e) {
                                          GBSystem_ManageCatchErrors().catchErrors(
                                              context,
                                              message: e.toString(),
                                              method:
                                                  "showDialogUpdateHabilitation",
                                              page: "GBSystem_document_screen");
                                        }
                                      },
                                      habilitationModel:
                                          widget.listHabilitations![index]),
                                );
                              },
                            )
                          : EmptyDataWidget()
                      : widget.currentIndex.value == 1
                          ? (widget.listAgrements != null &&
                                  widget.listAgrements!.isNotEmpty)
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: widget.listAgrements?.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: AgrementWidget(
                                          onDeleteTap: () async {
                                            showWarningSnackBar(
                                              context,
                                              GbsSystemStrings
                                                  .str_are_you_sure_want_delete
                                                  .tr,
                                              () async {
                                                try {
                                                  m.isLoading.value = true;

                                                  await GBSystem_AuthService(
                                                          context)
                                                      .deleteAgrement(
                                                          agrementModel: widget
                                                                  .listAgrements![
                                                              index])
                                                      .then((value) {
                                                    m.isLoading.value = false;

                                                    if (value == true) {
                                                      ///added
                                                      try {
                                                        setState(() {
                                                          widget.listAgrements
                                                              ?.remove(widget
                                                                      .listAgrements![
                                                                  index]);
                                                        });
                                                        widget.updateUI();
                                                      } catch (e) {
                                                        print("error : $e");
                                                      }

                                                      ////
                                                      showSuccesDialog(
                                                          context,
                                                          GbsSystemStrings
                                                              .str_deleted_with_success
                                                              .tr);
                                                    }
                                                  });
                                                } catch (e) {
                                                  m.isLoading.value = false;
                                                  GBSystem_ManageCatchErrors()
                                                      .catchErrors(context,
                                                          message: e.toString(),
                                                          method:
                                                              "deleteAgrement",
                                                          page:
                                                              "GBSystem_document_screen");
                                                }
                                              },
                                            );
                                          },
                                          onUpdateTap: () {
                                            try {
                                              m.Agr_selected_HAB_LIB?.value =
                                                  widget.listAgrements![index]
                                                      .HAB_LIB;
                                              m.showDialogUpdateAgrement(
                                                  context: context,
                                                  updateAgrements:
                                                      updateAgrements,
                                                  updateUI: updateUI,
                                                  agrementModel: widget
                                                      .listAgrements![index]);
                                            } catch (e) {
                                              GBSystem_ManageCatchErrors().catchErrors(
                                                  context,
                                                  message: e.toString(),
                                                  method:
                                                      "showDialogUpdateAgrement",
                                                  page:
                                                      "GBSystem_document_screen");
                                            }
                                          },
                                          agrementModel:
                                              widget.listAgrements![index]),
                                    );
                                  },
                                )
                              : EmptyDataWidget()
                          : widget.currentIndex.value == 2
                              ? widget.listDiplomes != null &&
                                      widget.listDiplomes!.isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: widget.listDiplomes?.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          child: DiplomeWidget(
                                              onDeleteTap: () async {
                                                showWarningSnackBar(
                                                  context,
                                                  GbsSystemStrings
                                                      .str_are_you_sure_want_delete
                                                      .tr,
                                                  () async {
                                                    try {
                                                      m.isLoading.value = true;

                                                      await GBSystem_AuthService(
                                                              context)
                                                          .deleteDiplome(
                                                              diplomeModel:
                                                                  widget.listDiplomes![
                                                                      index])
                                                          .then((value) {
                                                        m.isLoading.value =
                                                            false;

                                                        if (value == true) {
                                                          ///added
                                                          try {
                                                            setState(() {
                                                              widget
                                                                  .listDiplomes
                                                                  ?.remove(widget
                                                                          .listDiplomes![
                                                                      index]);
                                                            });
                                                            widget.updateUI();
                                                          } catch (e) {
                                                            print("error : $e");
                                                          }

                                                          ////
                                                          showSuccesDialog(
                                                              context,
                                                              GbsSystemStrings
                                                                  .str_deleted_with_success
                                                                  .tr);
                                                        }
                                                      });
                                                    } catch (e) {
                                                      m.isLoading.value = false;
                                                      GBSystem_ManageCatchErrors()
                                                          .catchErrors(context,
                                                              message:
                                                                  e.toString(),
                                                              method:
                                                                  "deleteDiplome",
                                                              page:
                                                                  "GBSystem_document_screen");
                                                    }
                                                  },
                                                );
                                              },
                                              onUpdateTap: () {
                                                try {
                                                  m.Dip_selected_DIP_LIB
                                                          ?.value =
                                                      widget
                                                          .listDiplomes![index]
                                                          .DIP_LIB;
                                                  m.showDialogUpdateDiplome(
                                                      context: context,
                                                      updateDiplomes:
                                                          updateDiplomes,
                                                      updateUI: updateUI,
                                                      diplomeModel:
                                                          widget.listDiplomes![
                                                              index]);
                                                } catch (e) {
                                                  GBSystem_ManageCatchErrors()
                                                      .catchErrors(context,
                                                          message: e.toString(),
                                                          method:
                                                              "showDialogUpdateDiplome",
                                                          page:
                                                              "GBSystem_document_screen");
                                                }
                                              },
                                              diplomeModel:
                                                  widget.listDiplomes![index]),
                                        );
                                      },
                                    )
                                  : EmptyDataWidget()
                              : widget.listDocumentsOfficiel != null &&
                                      widget.listDocumentsOfficiel!.isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:
                                          widget.listDocumentsOfficiel?.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          child: DocumentOfficielWidget(
                                              onDeleteTap: () async {
                                                showWarningSnackBar(
                                                  context,
                                                  GbsSystemStrings
                                                      .str_are_you_sure_want_delete
                                                      .tr,
                                                  () async {
                                                    try {
                                                      m.isLoading.value = true;

                                                      await GBSystem_AuthService(
                                                              context)
                                                          .deleteDocumentOfficiel(
                                                              documentOfficielModel:
                                                                  widget.listDocumentsOfficiel![
                                                                      index])
                                                          .then((value) {
                                                        m.isLoading.value =
                                                            false;

                                                        if (value == true) {
                                                          ///added
                                                          try {
                                                            setState(() {
                                                              widget
                                                                  .listDocumentsOfficiel
                                                                  ?.remove(widget
                                                                          .listDocumentsOfficiel![
                                                                      index]);
                                                            });
                                                            widget.updateUI();
                                                          } catch (e) {
                                                            print("error : $e");
                                                          }

                                                          ////

                                                          showSuccesDialog(
                                                              context,
                                                              GbsSystemStrings
                                                                  .str_deleted_with_success
                                                                  .tr);
                                                        }
                                                      });
                                                    } catch (e) {
                                                      m.isLoading.value = false;
                                                      GBSystem_ManageCatchErrors()
                                                          .catchErrors(context,
                                                              message:
                                                                  e.toString(),
                                                              method:
                                                                  "deleteDocumentOfficiel",
                                                              page:
                                                                  "GBSystem_document_screen");
                                                    }
                                                  },
                                                );
                                              },
                                              onUpdateTap: () {
                                                try {
                                                  m.Doc_selected_DOCOFF_LIB
                                                          ?.value =
                                                      widget
                                                          .listDocumentsOfficiel![
                                                              index]
                                                          .DOCOFF_LIB;
                                                  m.showDialogUpdateDocumentOfficiel(
                                                      context: context,
                                                      updateDocumentsOfficiel:
                                                          updateDocumentsOfficiel,
                                                      updateUI: updateUI,
                                                      documentOfficielModel:
                                                          widget.listDocumentsOfficiel![
                                                              index]);
                                                } catch (e) {
                                                  GBSystem_ManageCatchErrors()
                                                      .catchErrors(context,
                                                          message: e.toString(),
                                                          method:
                                                              "showDialogUpdateDocumentOfficiel",
                                                          page:
                                                              "GBSystem_document_screen");
                                                }
                                              },
                                              documentOfficielModel:
                                                  widget.listDocumentsOfficiel![
                                                      index]),
                                        );
                                      },
                                    )
                                  : EmptyDataWidget();
                },
              ),
            )),
          ),
          m.isLoading.value ? Waiting() : Container()
        ],
      ),
    );
  }
}
