import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_agrement_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_diplome_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_document_officiel_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_habiliter_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_agrement_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_diplome_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_officiel_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_habilitation_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/SELECT_ITEM_AGREMENT/GBSystem_select_item_agrement_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/SELECT_ITEM_DIPLOME/GBSystem_select_item_diplome_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/SELECT_ITEM_DOCUMENT_OFFICIEL/GBSystem_select_item_docOfficiel_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/SELECT_ITEM_HABILITER/GBSystem_select_item_habiliter_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/pdf_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/pick_file_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_date_picker.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class DocumentScreenController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();
  RxBool isLoading = RxBool(false);
  RxString? Hab_selected_FOR_LIB = "".obs;
  RxString? Agr_selected_HAB_LIB = "".obs;
  RxString? Dip_selected_DIP_LIB = "".obs;
  RxString? Doc_selected_DOCOFF_LIB = "".obs;

  Future<void> showDialogUpdateHabilitation({
    required BuildContext context,
    required HabilitationModel habilitationModel,
  }) async {
    Rx<DateTime?> selectedDateDebut =
            Rx<DateTime?>(habilitationModel.SFOR_DATD),
        selectedDateFin = Rx<DateTime?>(habilitationModel.SFOR_DATF);
    TextEditingController controllerDesc =
        TextEditingController(text: habilitationModel.SFOR_COMM ?? "");
    TextEditingController controllerHab =
        TextEditingController(text: Hab_selected_FOR_LIB?.value ?? "");
    Rx<TextEditingController> controllerDoc = Rx<TextEditingController>(
        TextEditingController(text: habilitationModel.DOCAN_CODE));
    Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) => Obx(
                      () => Stack(
                        children: [
                          AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Set your desired radius here
                            ),
                            backgroundColor: Colors.white,
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await GBSystem_AuthService(context)
                                            .getHabiliterSelectItem()
                                            .then((value) {
                                          if (value != null) {
                                            final GBSystemHabiliterController
                                                habiliterController = Get.put(
                                                    GBSystemHabiliterController());

                                            habiliterController
                                                .setAllHabiliter = value;
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Get.to(
                                                  GBSystem_SelectItemHabiliterScreen(
                                                controllerTxtField:
                                                    controllerHab,
                                              ));
                                            });
                                          }
                                        });
                                      },
                                      child: CustomTextField(
                                          controller: controllerHab,
                                          enabled: false,
                                          text: GbsSystemStrings
                                              .str_habilitations.tr),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate:
                                                habilitationModel.SFOR_DATD,
                                            labelText: GbsSystemStrings
                                                .str_date_obtention.tr,
                                            initialDate:
                                                habilitationModel.SFOR_DATD,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateDebut.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate: selectedDateFin.value,
                                            labelText: GbsSystemStrings
                                                .str_date_fin.tr,
                                            initialDate: selectedDateFin.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateFin.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      text: GbsSystemStrings.str_description.tr,
                                      controller: controllerDesc,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.02)),
                                      child: InkWell(
                                        onTap: () async {
                                          PlatformFile? filePath =
                                              await PickFileService()
                                                  .pickFile();

                                          file.value = filePath;
                                          controllerDoc.value.text =
                                              file.value?.name ?? "";
                                        },
                                        child: Obx(
                                          () => AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            padding: EdgeInsets.symmetric(
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.02)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: file.value == null
                                                  ? Colors.grey.shade300
                                                  : GbsSystemStrings
                                                      .str_primary_color
                                                      .withOpacity(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: file.value == null
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .doc_fill,
                                                              color:
                                                                  Colors.grey,
                                                              size: 30,
                                                            )
                                                          : Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .doc_fill,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 30,
                                                                ),
                                                                Positioned(
                                                                  bottom: -2,
                                                                  right: 2,
                                                                  child: Icon(
                                                                    CupertinoIcons
                                                                        .check_mark_circled_solid,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 13,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ),
                                                    file.value != null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().normalText(
                                                                    text: file
                                                                        .value!
                                                                        .name,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Flexible(
                                                                    child: GBSystem_TextHelper().smallText(
                                                                        text:
                                                                            "${file.value!.size} bytes",
                                                                        textColor: Colors
                                                                            .grey
                                                                            .shade300,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              GBSystem_TextHelper().smallText(
                                                                  text: GbsSystemStrings
                                                                      .str_choisie_un_fichier
                                                                      .tr,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  maxLines: 2),
                                                              GBSystem_TextHelper().smallText(
                                                                  text: GbsSystemStrings
                                                                      .str_aucune_fichier_choisie
                                                                      .tr,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    file.value = null;
                                                  },
                                                  child: Visibility(
                                                    visible: file.value != null,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: Icon(CupertinoIcons
                                                          .delete),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        text: GbsSystemStrings.str_document.tr,
                                        controller: controllerDoc.value,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GbsSystemStrings.str_primary_color,
                                    textStyle: TextStyle(
                                        color: GbsSystemStrings
                                            .str_primary_color)),
                                onPressed: () async {
                                  final GBSystemHabiliterController
                                      habiliterController =
                                      Get.put(GBSystemHabiliterController());
                                  isLoading.value = true;
                                  //////////
                                  String? base64File;
                                  if (file.value != null) {
                                    base64File = await PickFileService()
                                        .encodeFileToBase64WithoutIntro(
                                            file.value!,
                                            extension: file.value?.extension);
                                  }
                                  ////////////////

                                  await GBSystem_AuthService(context)
                                      .updateHabiliter(
                                          fileBytes: base64File,
                                          habilitationModel: habilitationModel,
                                          comment: controllerDesc.text,
                                          dateDebut: selectedDateDebut.value ??
                                              habilitationModel.SFOR_DATD!,
                                          dateFin: selectedDateFin.value ??
                                              habilitationModel.SFOR_DATF,
                                          fileName: file.value?.name,
                                          habiliterSelectItemModel:
                                              habiliterController
                                                  .getCurrentHabiliter)
                                      .then((value) {
                                    isLoading.value = false;
                                    if (value == true) {
                                      showSuccesDialog(
                                          context,
                                          GbsSystemStrings
                                              .str_operation_effectuer.tr);
                                    }
                                  });
                                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    GbsSystemStrings.str_modifier.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isLoading.value ? Waiting() : Container()
                        ],
                      ),
                    ));
          });
    });
  }

  Future<void> showDialogAddHabilitation({
    required BuildContext context,
  }) async {
    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(null),
        selectedDateFin = Rx<DateTime?>(null);
    TextEditingController controllerDesc = TextEditingController();
    TextEditingController controllerHab = TextEditingController();
    Rx<TextEditingController> controllerDoc =
        Rx<TextEditingController>(TextEditingController());
    Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) => Obx(
                      () => Stack(
                        children: [
                          AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Set your desired radius here
                            ),
                            backgroundColor: Colors.white,
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await GBSystem_AuthService(context)
                                            .getHabiliterSelectItem()
                                            .then((value) {
                                          if (value != null) {
                                            final GBSystemHabiliterController
                                                habiliterController = Get.put(
                                                    GBSystemHabiliterController());

                                            habiliterController
                                                .setAllHabiliter = value;
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Get.to(
                                                  GBSystem_SelectItemHabiliterScreen(
                                                controllerTxtField:
                                                    controllerHab,
                                              ));
                                            });
                                          }
                                        });
                                      },
                                      child: CustomTextField(
                                          controller: controllerHab,
                                          enabled: false,
                                          text: GbsSystemStrings
                                              .str_habilitations.tr),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate:
                                                selectedDateDebut.value,
                                            labelText: GbsSystemStrings
                                                .str_date_obtention.tr,
                                            initialDate:
                                                selectedDateDebut.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateDebut.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate: selectedDateFin.value,
                                            labelText: GbsSystemStrings
                                                .str_date_fin.tr,
                                            initialDate: selectedDateFin.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateFin.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      text: GbsSystemStrings.str_description.tr,
                                      controller: controllerDesc,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.02)),
                                      child: InkWell(
                                        onTap: () async {
                                          PlatformFile? filePath =
                                              await PickFileService()
                                                  .pickFile();

                                          file.value = filePath;
                                          controllerDoc.value.text =
                                              file.value?.name ?? "";
                                        },
                                        child: Obx(
                                          () => AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            padding: EdgeInsets.symmetric(
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.02)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: file.value == null
                                                  ? Colors.grey.shade300
                                                  : GbsSystemStrings
                                                      .str_primary_color
                                                      .withOpacity(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: file.value ==
                                                                null
                                                            ?
                                                            // icon doc grey
                                                            Icon(
                                                                CupertinoIcons
                                                                    .doc_fill,
                                                                color:
                                                                    Colors.grey,
                                                                size: 30,
                                                              )
                                                            : Icon(
                                                                CupertinoIcons
                                                                    .doc_fill,
                                                                color: Colors
                                                                    .white,
                                                                size: 30,
                                                              )),
                                                    file.value != null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: file
                                                                        .value!
                                                                        .name,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text:
                                                                      "${file.value!.size} bytes",
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: GbsSystemStrings
                                                                        .str_choisie_un_fichier
                                                                        .tr,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text: GbsSystemStrings
                                                                      .str_aucune_fichier_choisie
                                                                      .tr,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        String base64File =
                                                            await PickFileService()
                                                                .encodeFileToBase64WithoutIntro(
                                                                    file.value!,
                                                                    extension: file
                                                                        .value
                                                                        ?.extension);
                                                        Uint8List bytes = PDFService()
                                                            .cleanPDFStringAndConvertToUnit8List(
                                                                stringPDF:
                                                                    base64File);
                                                        await PDFService()
                                                            .downloadAndSavePDF(
                                                                controllerDoc
                                                                    .value.text,
                                                                bytes,
                                                                context);
                                                      },
                                                      child: Visibility(
                                                        visible:
                                                            file.value != null,
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .cloud_download,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        file.value = null;
                                                        controllerDoc
                                                            .value.text = "";
                                                      },
                                                      child: Visibility(
                                                        visible:
                                                            file.value != null,
                                                        child: Icon(
                                                            CupertinoIcons
                                                                .delete),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        text: GbsSystemStrings.str_document.tr,
                                        controller: controllerDoc.value,
                                        enabled: false,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GbsSystemStrings.str_primary_color,
                                    textStyle: TextStyle(
                                        color: GbsSystemStrings
                                            .str_primary_color)),
                                onPressed: () async {
                                  final GBSystemHabiliterController
                                      habiliterController =
                                      Get.put(GBSystemHabiliterController());
                                  if (habiliterController.getCurrentHabiliter !=
                                          null &&
                                      selectedDateDebut.value != null) {
                                    final GBSystemSalarieController
                                        salarieController =
                                        Get.put(GBSystemSalarieController());

                                    isLoading.value = true;
                                    //////////
                                    String? base64File;
                                    if (file.value != null) {
                                      base64File = await PickFileService()
                                          .encodeFileToBase64WithoutIntro(
                                              file.value!,
                                              extension: file.value?.extension);
                                    }
                                    ////////////////

                                    await GBSystem_AuthService(context)
                                        .addHabiliter(
                                            fileBytes: base64File,
                                            salarieModel: salarieController
                                                .getSalarie!.salarieModel,
                                            comment: controllerDesc.text,
                                            dateDebut: selectedDateDebut.value!,
                                            dateFin: selectedDateFin.value,
                                            fileName: file.value?.name,
                                            habiliterSelectItemModel:
                                                habiliterController
                                                    .getCurrentHabiliter!)
                                        .then((value) {
                                      isLoading.value = false;
                                      if (value == true) {
                                        showSuccesDialog(
                                            context,
                                            GbsSystemStrings
                                                .str_operation_effectuer.tr);
                                      }
                                    });
                                  } else {
                                    showErrorDialog(context,
                                        GbsSystemStrings.str_remplie_cases.tr);
                                  }

                                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    GbsSystemStrings.str_creer.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isLoading.value ? Waiting() : Container()
                        ],
                      ),
                    ));
          });
    });
  }

  Future<void> showDialogUpdateAgrement({
    required BuildContext context,
    required AgrementModel agrementModel,
  }) async {
    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(agrementModel.SHAB_DATD),
        selectedDateFin = Rx<DateTime?>(agrementModel.SHAB_DATF);
    TextEditingController controllerHab =
        TextEditingController(text: Agr_selected_HAB_LIB?.value ?? "");
    Rx<TextEditingController> controllerDoc = Rx<TextEditingController>(
        TextEditingController(text: agrementModel.DOCAN_CODE ?? ""));
    Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) => Obx(
                      () => Stack(
                        children: [
                          AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Set your desired radius here
                            ),
                            backgroundColor: Colors.white,
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await GBSystem_AuthService(context)
                                            .getAgrementSelectItem()
                                            .then((value) {
                                          if (value != null) {
                                            final GBSystemAgrementController
                                                agrementController = Get.put(
                                                    GBSystemAgrementController());

                                            agrementController.setAllAgrement =
                                                value;
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Get.to(
                                                  GBSystem_SelectItemAgrementScreen(
                                                controllerTxtField:
                                                    controllerHab,
                                              ));
                                            });
                                          }
                                        });
                                      },
                                      child: CustomTextField(
                                          controller: controllerHab,
                                          enabled: false,
                                          text: GbsSystemStrings
                                              .str_agrements.tr),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate:
                                                agrementModel.SHAB_DATD,
                                            labelText: GbsSystemStrings
                                                .str_date_debut.tr,
                                            initialDate:
                                                agrementModel.SHAB_DATD,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateDebut.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate: selectedDateFin.value,
                                            labelText: GbsSystemStrings
                                                .str_date_fin.tr,
                                            initialDate: selectedDateFin.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateFin.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.02)),
                                      child: InkWell(
                                        onTap: () async {
                                          PlatformFile? filePath =
                                              await PickFileService()
                                                  .pickFile();

                                          file.value = filePath;
                                          controllerDoc.value.text =
                                              file.value?.name ?? "";
                                        },
                                        child: Obx(
                                          () => AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            padding: EdgeInsets.symmetric(
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.02)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: file.value == null
                                                  ? Colors.grey.shade300
                                                  : GbsSystemStrings
                                                      .str_primary_color
                                                      .withOpacity(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: file.value == null
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .doc_fill,
                                                              color:
                                                                  Colors.grey,
                                                              size: 30,
                                                            )
                                                          : Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .doc_fill,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 30,
                                                                ),
                                                                Positioned(
                                                                  bottom: -2,
                                                                  right: 2,
                                                                  child: Icon(
                                                                    CupertinoIcons
                                                                        .check_mark_circled_solid,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 13,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ),
                                                    file.value != null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().normalText(
                                                                    text: file
                                                                        .value!
                                                                        .name,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Flexible(
                                                                    child: GBSystem_TextHelper().smallText(
                                                                        text:
                                                                            "${file.value!.size} bytes",
                                                                        textColor: Colors
                                                                            .grey
                                                                            .shade300,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: GbsSystemStrings
                                                                        .str_choisie_un_fichier
                                                                        .tr,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text: GbsSystemStrings
                                                                      .str_aucune_fichier_choisie
                                                                      .tr,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    file.value = null;
                                                  },
                                                  child: Visibility(
                                                    visible: file.value != null,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: Icon(CupertinoIcons
                                                          .delete),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        text: GbsSystemStrings.str_document.tr,
                                        controller: controllerDoc.value,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GbsSystemStrings.str_primary_color,
                                    textStyle: TextStyle(
                                        color: GbsSystemStrings
                                            .str_primary_color)),
                                onPressed: () async {
                                  isLoading.value = true;

                                  String? base64File;

                                  if (file.value != null) {
                                    base64File = await PickFileService()
                                        .encodeFileToBase64WithoutIntro(
                                            file.value!,
                                            extension: file.value?.extension);
                                  }
                                  final GBSystemAgrementController
                                      agrementController =
                                      Get.put(GBSystemAgrementController());

                                  await GBSystem_AuthService(context)
                                      .updateAgrement(
                                          agrementModel: agrementModel,
                                          dateDebut: selectedDateDebut.value ??
                                              agrementModel.SHAB_DATD!,
                                          dateFin: selectedDateFin.value ??
                                              agrementModel.SHAB_DATF,
                                          fileBytes: base64File,
                                          agrementSelectItemModel:
                                              agrementController
                                                  .getCurrentAgrement,
                                          fileName: file.value?.name)
                                      .then((value) {
                                    isLoading.value = false;
                                    if (value == true) {
                                      showSuccesDialog(
                                          context,
                                          GbsSystemStrings
                                              .str_operation_effectuer.tr);
                                    }
                                  });
                                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    GbsSystemStrings.str_modifier.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isLoading.value ? Waiting() : Container()
                        ],
                      ),
                    ));
          });
    });
  }

  Future<void> showDialogAddAgrement({
    required BuildContext context,
  }) async {
    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(null),
        selectedDateFin = Rx<DateTime?>(null);
    TextEditingController controllerHab = TextEditingController();
    Rx<TextEditingController> controllerDoc =
        Rx<TextEditingController>(TextEditingController());
    Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) => Obx(
                      () => Stack(
                        children: [
                          AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Set your desired radius here
                            ),
                            backgroundColor: Colors.white,
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await GBSystem_AuthService(context)
                                            .getAgrementSelectItem()
                                            .then((value) {
                                          if (value != null) {
                                            final GBSystemAgrementController
                                                agrementController = Get.put(
                                                    GBSystemAgrementController());

                                            agrementController.setAllAgrement =
                                                value;
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Get.to(
                                                  GBSystem_SelectItemAgrementScreen(
                                                controllerTxtField:
                                                    controllerHab,
                                              ));
                                            });
                                          }
                                        });
                                      },
                                      child: CustomTextField(
                                          controller: controllerHab,
                                          enabled: false,
                                          text: GbsSystemStrings
                                              .str_agrements.tr),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate:
                                                selectedDateDebut.value,
                                            labelText: GbsSystemStrings
                                                .str_date_debut.tr,
                                            initialDate:
                                                selectedDateDebut.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateDebut.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate: selectedDateFin.value,
                                            labelText: GbsSystemStrings
                                                .str_date_fin.tr,
                                            initialDate: selectedDateFin.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateFin.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.02)),
                                      child: InkWell(
                                        onTap: () async {
                                          PlatformFile? filePath =
                                              await PickFileService()
                                                  .pickFile();

                                          file.value = filePath;
                                          controllerDoc.value.text =
                                              file.value?.name ?? "";
                                        },
                                        child: Obx(
                                          () => AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            padding: EdgeInsets.symmetric(
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.02)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: file.value == null
                                                  ? Colors.grey.shade300
                                                  : GbsSystemStrings
                                                      .str_primary_color
                                                      .withOpacity(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: file.value ==
                                                                null
                                                            ?
                                                            // icon doc grey
                                                            Icon(
                                                                CupertinoIcons
                                                                    .doc_fill,
                                                                color:
                                                                    Colors.grey,
                                                                size: 30,
                                                              )
                                                            : Icon(
                                                                CupertinoIcons
                                                                    .doc_fill,
                                                                color: Colors
                                                                    .white,
                                                                size: 30,
                                                              )),
                                                    file.value != null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: file
                                                                        .value!
                                                                        .name,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text:
                                                                      "${file.value!.size} bytes",
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: GbsSystemStrings
                                                                        .str_choisie_un_fichier
                                                                        .tr,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text: GbsSystemStrings
                                                                      .str_aucune_fichier_choisie
                                                                      .tr,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        String base64File =
                                                            await PickFileService()
                                                                .encodeFileToBase64WithoutIntro(
                                                                    file.value!,
                                                                    extension: file
                                                                        .value
                                                                        ?.extension);
                                                        Uint8List bytes = PDFService()
                                                            .cleanPDFStringAndConvertToUnit8List(
                                                                stringPDF:
                                                                    base64File);
                                                        await PDFService()
                                                            .downloadAndSavePDF(
                                                                controllerDoc
                                                                    .value.text,
                                                                bytes,
                                                                context);
                                                      },
                                                      child: Visibility(
                                                        visible:
                                                            file.value != null,
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .cloud_download,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        file.value = null;
                                                        controllerDoc
                                                            .value.text = "";
                                                      },
                                                      child: Visibility(
                                                        visible:
                                                            file.value != null,
                                                        child: Icon(
                                                            CupertinoIcons
                                                                .delete),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        text: GbsSystemStrings.str_document.tr,
                                        controller: controllerDoc.value,
                                        enabled: false,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GbsSystemStrings.str_primary_color,
                                    textStyle: TextStyle(
                                        color: GbsSystemStrings
                                            .str_primary_color)),
                                onPressed: () async {
                                  final GBSystemAgrementController
                                      agrementController =
                                      Get.put(GBSystemAgrementController());
                                  if (agrementController.getCurrentAgrement !=
                                          null &&
                                      selectedDateDebut.value != null) {
                                    final GBSystemSalarieController
                                        salarieController =
                                        Get.put(GBSystemSalarieController());

                                    String? base64File;

                                    if (file.value != null) {
                                      base64File = await PickFileService()
                                          .encodeFileToBase64WithoutIntro(
                                              file.value!,
                                              extension: file.value?.extension);
                                    }

                                    isLoading.value = true;
                                    await GBSystem_AuthService(context)
                                        .addAgrement(
                                            salarieModel: salarieController
                                                .getSalarie!.salarieModel,
                                            fileBytes: base64File,
                                            dateDebut: selectedDateDebut.value!,
                                            dateFin: selectedDateFin.value,
                                            fileName: file.value?.name,
                                            agrementSelectItemModel:
                                                agrementController
                                                    .getCurrentAgrement!)
                                        .then((value) {
                                      isLoading.value = false;
                                      if (value == true) {
                                        showSuccesDialog(
                                            context,
                                            GbsSystemStrings
                                                .str_operation_effectuer.tr);
                                      }
                                    });
                                  } else {
                                    showErrorDialog(context,
                                        GbsSystemStrings.str_remplie_cases.tr);
                                  }

                                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    GbsSystemStrings.str_creer.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isLoading.value ? Waiting() : Container()
                        ],
                      ),
                    ));
          });
    });
  }

  Future<void> showDialogUpdateDiplome({
    required BuildContext context,
    required DiplomeModel diplomeModel,
  }) async {
    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(diplomeModel.SVRDIP_DATD);

    TextEditingController controllerHab =
        TextEditingController(text: Dip_selected_DIP_LIB?.value ?? "");
    Rx<TextEditingController> controllerDoc = Rx<TextEditingController>(
        TextEditingController(text: diplomeModel.DOCAN_CODE));
    Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) => Obx(
                      () => Stack(
                        children: [
                          AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Set your desired radius here
                            ),
                            backgroundColor: Colors.white,
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await GBSystem_AuthService(context)
                                            .getDiplomeSelectItem()
                                            .then((value) {
                                          if (value != null) {
                                            final GBSystemDiplomeController
                                                diplomeController = Get.put(
                                                    GBSystemDiplomeController());

                                            diplomeController.setAllDiplome =
                                                value;
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Get.to(
                                                  GBSystem_SelectItemDiplomeScreen(
                                                controllerTxtField:
                                                    controllerHab,
                                              ));
                                            });
                                          }
                                        });
                                      },
                                      child: CustomTextField(
                                          controller: controllerHab,
                                          enabled: false,
                                          text:
                                              GbsSystemStrings.str_diplome.tr),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate:
                                                diplomeModel.SVRDIP_DATD,
                                            labelText: GbsSystemStrings
                                                .str_date_obtention.tr,
                                            initialDate:
                                                diplomeModel.SVRDIP_DATD,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateDebut.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.02)),
                                      child: InkWell(
                                        onTap: () async {
                                          PlatformFile? filePath =
                                              await PickFileService()
                                                  .pickFile();

                                          file.value = filePath;
                                          controllerDoc.value.text =
                                              file.value?.name ?? "";
                                        },
                                        child: Obx(
                                          () => AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            padding: EdgeInsets.symmetric(
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.02)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: file.value == null
                                                  ? Colors.grey.shade300
                                                  : GbsSystemStrings
                                                      .str_primary_color
                                                      .withOpacity(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: file.value == null
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .doc_fill,
                                                              color:
                                                                  Colors.grey,
                                                              size: 30,
                                                            )
                                                          : Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .doc_fill,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 30,
                                                                ),
                                                                Positioned(
                                                                  bottom: -2,
                                                                  right: 2,
                                                                  child: Icon(
                                                                    CupertinoIcons
                                                                        .check_mark_circled_solid,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 13,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ),
                                                    file.value != null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().normalText(
                                                                    text: file
                                                                        .value!
                                                                        .name,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Flexible(
                                                                    child: GBSystem_TextHelper().smallText(
                                                                        text:
                                                                            "${file.value!.size} bytes",
                                                                        textColor: Colors
                                                                            .grey
                                                                            .shade300,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: GbsSystemStrings
                                                                        .str_choisie_un_fichier
                                                                        .tr,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text: GbsSystemStrings
                                                                      .str_aucune_fichier_choisie
                                                                      .tr,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    file.value = null;
                                                  },
                                                  child: Visibility(
                                                    visible: file.value != null,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: Icon(CupertinoIcons
                                                          .delete),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        text: GbsSystemStrings.str_document.tr,
                                        controller: controllerDoc.value,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GbsSystemStrings.str_primary_color,
                                    textStyle: TextStyle(
                                        color: GbsSystemStrings
                                            .str_primary_color)),
                                onPressed: () async {
                                  isLoading.value = true;

                                  String? base64File;

                                  if (file.value != null) {
                                    base64File = await PickFileService()
                                        .encodeFileToBase64WithoutIntro(
                                            file.value!,
                                            extension: file.value?.extension);
                                  }

                                  final GBSystemDiplomeController
                                      diplomeController =
                                      Get.put(GBSystemDiplomeController());

                                  await GBSystem_AuthService(context)
                                      .updateDiplome(
                                          diplomeModel: diplomeModel,
                                          dateDebut: selectedDateDebut.value ??
                                              diplomeModel.SVRDIP_DATD!,
                                          fileBytes: base64File,
                                          diplomeSelectItem: diplomeController
                                              .getCurrentDiplome,
                                          fileName: file.value?.name)
                                      .then((value) {
                                    isLoading.value = false;
                                    if (value == true) {
                                      showSuccesDialog(
                                          context,
                                          GbsSystemStrings
                                              .str_operation_effectuer.tr);
                                    }
                                  });
                                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    GbsSystemStrings.str_modifier.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isLoading.value ? Waiting() : Container()
                        ],
                      ),
                    ));
          });
    });
  }

  Future<void> showDialogAddDiplome({
    required BuildContext context,
  }) async {
    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(null);

    TextEditingController controllerHab = TextEditingController();
    Rx<TextEditingController> controllerDoc =
        Rx<TextEditingController>(TextEditingController());
    Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) => Obx(
                      () => Stack(
                        children: [
                          AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Set your desired radius here
                            ),
                            backgroundColor: Colors.white,
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await GBSystem_AuthService(context)
                                            .getDiplomeSelectItem()
                                            .then((value) {
                                          if (value != null) {
                                            final GBSystemDiplomeController
                                                diplomeController = Get.put(
                                                    GBSystemDiplomeController());

                                            diplomeController.setAllDiplome =
                                                value;
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Get.to(
                                                  GBSystem_SelectItemDiplomeScreen(
                                                controllerTxtField:
                                                    controllerHab,
                                              ));
                                            });
                                          }
                                        });
                                      },
                                      child: CustomTextField(
                                          controller: controllerHab,
                                          enabled: false,
                                          text:
                                              GbsSystemStrings.str_diplome.tr),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate:
                                                selectedDateDebut.value,
                                            labelText: GbsSystemStrings
                                                .str_date_obtention.tr,
                                            initialDate:
                                                selectedDateDebut.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateDebut.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.02)),
                                      child: InkWell(
                                        onTap: () async {
                                          PlatformFile? filePath =
                                              await PickFileService()
                                                  .pickFile();

                                          file.value = filePath;
                                          controllerDoc.value.text =
                                              file.value?.name ?? "";
                                        },
                                        child: Obx(
                                          () => AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            padding: EdgeInsets.symmetric(
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.02)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: file.value == null
                                                  ? Colors.grey.shade300
                                                  : GbsSystemStrings
                                                      .str_primary_color
                                                      .withOpacity(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: file.value ==
                                                                null
                                                            ?
                                                            // icon doc grey
                                                            Icon(
                                                                CupertinoIcons
                                                                    .doc_fill,
                                                                color:
                                                                    Colors.grey,
                                                                size: 30,
                                                              )
                                                            : Icon(
                                                                CupertinoIcons
                                                                    .doc_fill,
                                                                color: Colors
                                                                    .white,
                                                                size: 30,
                                                              )),
                                                    file.value != null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: file
                                                                        .value!
                                                                        .name,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text:
                                                                      "${file.value!.size} bytes",
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: GbsSystemStrings
                                                                        .str_choisie_un_fichier
                                                                        .tr,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text: GbsSystemStrings
                                                                      .str_aucune_fichier_choisie
                                                                      .tr,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        String base64File =
                                                            await PickFileService()
                                                                .encodeFileToBase64WithoutIntro(
                                                                    file.value!,
                                                                    extension: file
                                                                        .value
                                                                        ?.extension);
                                                        Uint8List bytes = PDFService()
                                                            .cleanPDFStringAndConvertToUnit8List(
                                                                stringPDF:
                                                                    base64File);
                                                        await PDFService()
                                                            .downloadAndSavePDF(
                                                                controllerDoc
                                                                    .value.text,
                                                                bytes,
                                                                context);
                                                      },
                                                      child: Visibility(
                                                        visible:
                                                            file.value != null,
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .cloud_download,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        file.value = null;
                                                        controllerDoc
                                                            .value.text = "";
                                                      },
                                                      child: Visibility(
                                                        visible:
                                                            file.value != null,
                                                        child: Icon(
                                                            CupertinoIcons
                                                                .delete),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        text: GbsSystemStrings.str_document.tr,
                                        controller: controllerDoc.value,
                                        enabled: false,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GbsSystemStrings.str_primary_color,
                                    textStyle: TextStyle(
                                        color: GbsSystemStrings
                                            .str_primary_color)),
                                onPressed: () async {
                                  final GBSystemDiplomeController
                                      diplomeController =
                                      Get.put(GBSystemDiplomeController());
                                  if (diplomeController.getCurrentDiplome !=
                                          null &&
                                      selectedDateDebut.value != null) {
                                    final GBSystemSalarieController
                                        salarieController =
                                        Get.put(GBSystemSalarieController());

                                    String? base64File;

                                    if (file.value != null) {
                                      base64File = await PickFileService()
                                          .encodeFileToBase64WithoutIntro(
                                              file.value!,
                                              extension: file.value?.extension);
                                    }

                                    isLoading.value = true;
                                    await GBSystem_AuthService(context)
                                        .addDiplome(
                                            salarieModel: salarieController
                                                .getSalarie!.salarieModel,
                                            fileBytes: base64File,
                                            dateDebut: selectedDateDebut.value!,
                                            fileName: file.value?.name,
                                            diplomeSelectItemModel:
                                                diplomeController
                                                    .getCurrentDiplome!)
                                        .then((value) {
                                      isLoading.value = false;
                                      if (value == true) {
                                        showSuccesDialog(
                                            context,
                                            GbsSystemStrings
                                                .str_operation_effectuer.tr);
                                      }
                                    });
                                  } else {
                                    showErrorDialog(context,
                                        GbsSystemStrings.str_remplie_cases.tr);
                                  }

                                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    GbsSystemStrings.str_creer.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isLoading.value ? Waiting() : Container()
                        ],
                      ),
                    ));
          });
    });
  }

  Future<void> showDialogUpdateDocumentOfficiel({
    required BuildContext context,
    required DocumentOfficielModel documentOfficielModel,
  }) async {
    Rx<DateTime?> selectedDateDebut =
            Rx<DateTime?>(documentOfficielModel.SDF_DATD),
        selectedDateFin = Rx<DateTime?>(documentOfficielModel.SDF_DATF);
    // selectedDatePro = Rx<DateTime?>(DateTime(
    //     int.parse(documentOfficielModel.SDF_PRO_YEAR),
    //     int.parse(documentOfficielModel.SDF_PRO_MONTH),
    //     int.parse(documentOfficielModel.SDF_PRO_DAY)));
    TextEditingController controllerNumDoc =
        TextEditingController(text: documentOfficielModel.SDF_NUM);
    TextEditingController controllerType =
        TextEditingController(text: documentOfficielModel.SDF_PRO_TYPE);
    TextEditingController controllerDepartement =
        TextEditingController(text: documentOfficielModel.SDF_PRO_DEPTM);

    TextEditingController controllerHab =
        TextEditingController(text: Doc_selected_DOCOFF_LIB?.value ?? "");
    Rx<TextEditingController> controllerDoc = Rx<TextEditingController>(
        TextEditingController(text: documentOfficielModel.DOCAN_CODE));
    Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) => Obx(
                      () => Stack(
                        children: [
                          AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Set your desired radius here
                            ),
                            backgroundColor: Colors.white,
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await GBSystem_AuthService(context)
                                            .getDocumentOfficielSelectItem()
                                            .then((value) {
                                          if (value != null) {
                                            final GBSystemDocumentOfficielController
                                                docOfficielController = Get.put(
                                                    GBSystemDocumentOfficielController());

                                            docOfficielController
                                                .setAllDocumentOfficiel = value;
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Get.to(
                                                  GBSystem_SelectItemDocumentOfficielScreen(
                                                controllerTxtField:
                                                    controllerHab,
                                              ));
                                            });
                                          }
                                        });
                                      },
                                      child: CustomTextField(
                                          controller: controllerHab,
                                          enabled: false,
                                          text: GbsSystemStrings
                                              .str_documents_officiel.tr),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // CustomDatePicker(
                                    //   selectedDate: selectedDatePro.value,
                                    //   labelText:
                                    //       GbsSystemStrings.str_date_pro.tr,
                                    //   initialDate: selectedDatePro.value,
                                    //   onDateSelected: (DateTime selectedDate) {
                                    //     selectedDatePro.value = selectedDate;
                                    //   },
                                    // ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate:
                                                documentOfficielModel.SDF_DATD,
                                            labelText: GbsSystemStrings
                                                .str_date_debut.tr,
                                            initialDate:
                                                documentOfficielModel.SDF_DATD,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateDebut.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate: selectedDateFin.value,
                                            labelText: GbsSystemStrings
                                                .str_date_fin.tr,
                                            initialDate: selectedDateFin.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateFin.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      text: GbsSystemStrings
                                          .str_numero_document.tr,
                                      controller: controllerNumDoc,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      text: GbsSystemStrings.str_departement.tr,
                                      controller: controllerDepartement,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      text: GbsSystemStrings.str_type.tr,
                                      controller: controllerType,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.02)),
                                      child: InkWell(
                                        onTap: () async {
                                          PlatformFile? filePath =
                                              await PickFileService()
                                                  .pickFile();

                                          file.value = filePath;
                                          controllerDoc.value.text =
                                              file.value?.name ?? "";
                                        },
                                        child: Obx(
                                          () => AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            padding: EdgeInsets.symmetric(
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.02)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: file.value == null
                                                  ? Colors.grey.shade300
                                                  : GbsSystemStrings
                                                      .str_primary_color
                                                      .withOpacity(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: file.value == null
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .doc_fill,
                                                              color:
                                                                  Colors.grey,
                                                              size: 30,
                                                            )
                                                          : Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .doc_fill,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 30,
                                                                ),
                                                                Positioned(
                                                                  bottom: -2,
                                                                  right: 2,
                                                                  child: Icon(
                                                                    CupertinoIcons
                                                                        .check_mark_circled_solid,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 13,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ),
                                                    file.value != null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().normalText(
                                                                    text: file
                                                                        .value!
                                                                        .name,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Flexible(
                                                                    child: GBSystem_TextHelper().smallText(
                                                                        text:
                                                                            "${file.value!.size} bytes",
                                                                        textColor: Colors
                                                                            .grey
                                                                            .shade300,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: GbsSystemStrings
                                                                        .str_choisie_un_fichier
                                                                        .tr,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text: GbsSystemStrings
                                                                      .str_aucune_fichier_choisie
                                                                      .tr,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    file.value = null;
                                                  },
                                                  child: Visibility(
                                                    visible: file.value != null,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: Icon(CupertinoIcons
                                                          .delete),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        text: GbsSystemStrings.str_document.tr,
                                        controller: controllerDoc.value,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GbsSystemStrings.str_primary_color,
                                    textStyle: TextStyle(
                                        color: GbsSystemStrings
                                            .str_primary_color)),
                                onPressed: () async {
                                  final GBSystemDocumentOfficielController
                                      documentOfficielController = Get.put(
                                          GBSystemDocumentOfficielController());
                                  isLoading.value = true;
                                  String? base64File;

                                  if (file.value != null) {
                                    base64File = await PickFileService()
                                        .encodeFileToBase64WithoutIntro(
                                            file.value!,
                                            extension: file.value?.extension);
                                  }

                                  await GBSystem_AuthService(context)
                                      .updateDocumentOfficiel(
                                          documentOfficielModel:
                                              documentOfficielModel,
                                          fileBytes: base64File,
                                          dateDebut: selectedDateDebut.value ??
                                              documentOfficielModel.SDF_DATD,
                                          dateFin: selectedDateFin.value ??
                                              documentOfficielModel.SDF_DATF,
                                          fileName: file.value?.name,
                                          // datePro: selectedDatePro.value,
                                          documentOfficielSelectItemModel:
                                              documentOfficielController
                                                  .getCurrentDocumentOfficiel)
                                      .then((value) {
                                    isLoading.value = false;
                                    if (value == true) {
                                      showSuccesDialog(
                                          context,
                                          GbsSystemStrings
                                              .str_operation_effectuer.tr);
                                    }
                                  });
                                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    GbsSystemStrings.str_modifier.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isLoading.value ? Waiting() : Container()
                        ],
                      ),
                    ));
          });
    });
  }

  Future<void> showDialogAddDocumentOfficiel({
    required BuildContext context,
  }) async {
    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(null),
        selectedDateFin = Rx<DateTime?>(null);
    // selectedDatePro = Rx<DateTime?>(null);
    TextEditingController controllerNumDoc = TextEditingController();
    TextEditingController controllerType = TextEditingController();
    TextEditingController controllerDepartement = TextEditingController();

    TextEditingController controllerHab = TextEditingController();
    Rx<TextEditingController> controllerDoc =
        Rx<TextEditingController>(TextEditingController());
    Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) => Obx(
                      () => Stack(
                        children: [
                          AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Set your desired radius here
                            ),
                            backgroundColor: Colors.white,
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await GBSystem_AuthService(context)
                                            .getDocumentOfficielSelectItem()
                                            .then((value) {
                                          if (value != null) {
                                            final GBSystemDocumentOfficielController
                                                documentOfficielController =
                                                Get.put(
                                                    GBSystemDocumentOfficielController());

                                            documentOfficielController
                                                .setAllDocumentOfficiel = value;
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Get.to(
                                                  GBSystem_SelectItemDocumentOfficielScreen(
                                                controllerTxtField:
                                                    controllerHab,
                                              ));
                                            });
                                          }
                                        });
                                      },
                                      child: CustomTextField(
                                          controller: controllerHab,
                                          enabled: false,
                                          text: GbsSystemStrings
                                              .str_documents_officiel.tr),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // CustomDatePicker(
                                    //   selectedDate: selectedDatePro.value,
                                    //   labelText:
                                    //       GbsSystemStrings.str_date_pro.tr,
                                    //   initialDate: selectedDatePro.value,
                                    //   onDateSelected: (DateTime selectedDate) {
                                    //     selectedDatePro.value = selectedDate;
                                    //   },
                                    // ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate:
                                                selectedDateDebut.value,
                                            labelText: GbsSystemStrings
                                                .str_date_debut.tr,
                                            initialDate:
                                                selectedDateDebut.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateDebut.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate: selectedDateFin.value,
                                            labelText: GbsSystemStrings
                                                .str_date_fin.tr,
                                            initialDate: selectedDateFin.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateFin.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      text: GbsSystemStrings
                                          .str_numero_document.tr,
                                      controller: controllerNumDoc,
                                      keyboardType: TextInputType.number,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      text: GbsSystemStrings.str_departement.tr,
                                      controller: controllerDepartement,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      text: GbsSystemStrings.str_type.tr,
                                      controller: controllerType,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.02)),
                                      child: InkWell(
                                        onTap: () async {
                                          PlatformFile? filePath =
                                              await PickFileService()
                                                  .pickFile();

                                          file.value = filePath;
                                          controllerDoc.value.text =
                                              file.value?.name ?? "";
                                        },
                                        child: Obx(
                                          () => AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            padding: EdgeInsets.symmetric(
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.02)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: file.value == null
                                                  ? Colors.grey.shade300
                                                  : GbsSystemStrings
                                                      .str_primary_color
                                                      .withOpacity(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: file.value ==
                                                                null
                                                            ?
                                                            // icon doc grey
                                                            Icon(
                                                                CupertinoIcons
                                                                    .doc_fill,
                                                                color:
                                                                    Colors.grey,
                                                                size: 30,
                                                              )
                                                            : Icon(
                                                                CupertinoIcons
                                                                    .doc_fill,
                                                                color: Colors
                                                                    .white,
                                                                size: 30,
                                                              )),
                                                    file.value != null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: file
                                                                        .value!
                                                                        .name,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text:
                                                                      "${file.value!.size} bytes",
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.5),
                                                                child: GBSystem_TextHelper().smallText(
                                                                    text: GbsSystemStrings
                                                                        .str_choisie_un_fichier
                                                                        .tr,
                                                                    textColor:
                                                                        Colors
                                                                            .black,
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GBSystem_TextHelper().smallText(
                                                                  text: GbsSystemStrings
                                                                      .str_aucune_fichier_choisie
                                                                      .tr,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        String base64File =
                                                            await PickFileService()
                                                                .encodeFileToBase64WithoutIntro(
                                                                    file.value!,
                                                                    extension: file
                                                                        .value
                                                                        ?.extension);
                                                        Uint8List bytes = PDFService()
                                                            .cleanPDFStringAndConvertToUnit8List(
                                                                stringPDF:
                                                                    base64File);
                                                        await PDFService()
                                                            .downloadAndSavePDF(
                                                                controllerDoc
                                                                    .value.text,
                                                                bytes,
                                                                context);
                                                      },
                                                      child: Visibility(
                                                        visible:
                                                            file.value != null,
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .cloud_download,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        file.value = null;
                                                        controllerDoc
                                                            .value.text = "";
                                                      },
                                                      child: Visibility(
                                                        visible:
                                                            file.value != null,
                                                        child: Icon(
                                                            CupertinoIcons
                                                                .delete),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        text: GbsSystemStrings.str_document.tr,
                                        controller: controllerDoc.value,
                                        enabled: false,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GbsSystemStrings.str_primary_color,
                                    textStyle: TextStyle(
                                        color: GbsSystemStrings
                                            .str_primary_color)),
                                onPressed: () async {
                                  final GBSystemDocumentOfficielController
                                      documentOfficielController = Get.put(
                                          GBSystemDocumentOfficielController());
                                  if (documentOfficielController
                                                  .getCurrentDocumentOfficiel !=
                                              null &&
                                          selectedDateDebut.value != null
                                      // &&
                                      // selectedDatePro.value != null
                                      ) {
                                    final GBSystemSalarieController
                                        salarieController =
                                        Get.put(GBSystemSalarieController());

                                    String? base64File;

                                    if (file.value != null) {
                                      base64File = await PickFileService()
                                          .encodeFileToBase64WithoutIntro(
                                              file.value!,
                                              extension: file.value?.extension);
                                    }

                                    isLoading.value = true;
                                    await GBSystem_AuthService(context)
                                        .addDocumentOfficiel(
                                            dateFin: selectedDateFin.value,
                                            // datePro: selectedDatePro.value!,
                                            departement:
                                                controllerDepartement.text,
                                            numeroDoc: controllerNumDoc.text,
                                            type: controllerType.text,
                                            salarieModel: salarieController
                                                .getSalarie!.salarieModel,
                                            fileBytes: base64File,
                                            dateDebut: selectedDateDebut.value!,
                                            fileName: file.value?.name,
                                            diplomeSelectItemModel:
                                                documentOfficielController
                                                    .getCurrentDocumentOfficiel!)
                                        .then((value) {
                                      isLoading.value = false;
                                      if (value == true) {
                                        showSuccesDialog(
                                            context,
                                            GbsSystemStrings
                                                .str_operation_effectuer.tr);
                                      }
                                    });
                                  } else {
                                    showErrorDialog(context,
                                        GbsSystemStrings.str_remplie_cases.tr);
                                  }

                                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    GbsSystemStrings.str_creer.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isLoading.value ? Waiting() : Container()
                        ],
                      ),
                    ));
          });
    });
  }
}
