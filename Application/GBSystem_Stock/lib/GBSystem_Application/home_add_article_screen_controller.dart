import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_root/custom_date_picker.dart';
import 'package:gbsystem_root/GBSystem_custom_text_field.dart';
import 'package:gbsystem_root/api.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_ref_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_catalogue_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_taille_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/articles_add_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/catalogue_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/color_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/enterpot_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/fournisseur_controller.dart';
//import 'package:gbsystem_stock/GBSystem_Application/GBSystem_Auth/GBSystem_auth_service.dart';
import 'package:gbsystem_stock/GBSystem_Application/taille_controller.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class HomeAddArticleScreenController extends GBSystem_Root_Controller {
  HomeAddArticleScreenController(this.context, {required this.updateUI});

  final Function updateUI;
  final ArticlesAddController articlesController = Get.put(ArticlesAddController());
  final CatalogueController catalogueController = Get.put(CatalogueController());
  final ColorController colorsController = Get.put(ColorController());
  final FournisseurController fournisseurController = Get.put(FournisseurController());
  final TailleController tailleController = Get.put(TailleController());
  final EnterpotController enterpotController = Get.put(EnterpotController());
  // final ColorController colorController = Get.put(ColorController());

  BuildContext context;

  RxBool isLoading = RxBool(false), isLoadingMain = RxBool(false);
  Future<void> showDialogAddCatalogue({required BuildContext context, required GbsystemArticleRefModel artiecleRef}) async {
    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(null), selectedDateFin = Rx<DateTime?>(null), selectedDateUpdate = Rx<DateTime?>(null);

    TextEditingController controllerReferential = TextEditingController();
    TextEditingController controllerCategorie = TextEditingController();
    TextEditingController controllerPrix = TextEditingController();
    // TextEditingController controllerModifierLe = TextEditingController();
    TextEditingController controllerParResponsable = TextEditingController();

    Rx<TextEditingController> controllerFournisseur = Rx<TextEditingController>(TextEditingController());
    Rx<TextEditingController> controllerCouleur = Rx<TextEditingController>(TextEditingController());
    //Color? colorField;

    List<GbsystemTailleModel> tailleSelected = [];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controllerReferential.text = artiecleRef.ARTREF_LIB;
      controllerCategorie.text = "${artiecleRef.ARTCAT_CODE} | ${artiecleRef.ARTCAT_LIB}";
      controllerPrix.text = "0";
      controllerParResponsable.text = artiecleRef.USR_LIB ?? "";

      selectedDateUpdate.value = artiecleRef.LAST_UPDT != null ? artiecleRef.LAST_UPDT! : null;
      controllerFournisseur.value.text = fournisseurController.getSelectedFournisseur != null ? fournisseurController.getSelectedFournisseur!.FOU_LIB : "";
      controllerCouleur.value.text = colorsController.getSelectedColor != null ? colorsController.getSelectedColor!.CLR_LIB : "";
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Obx(
              () => Stack(
                children: [
                  AlertDialog(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0), // Set your desired radius here
                    ),
                    backgroundColor: Colors.white,
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              // () async {
                              //   await GBSystem_AuthService(context).getAllFournisseur().then((value) {
                              //     if (value != null) {
                              //       fournisseurController.setAllFournisseur = value;
                              //       WidgetsBinding.instance.addPostFrameCallback((_) {
                              //         Get.to(GBSystem_SelectItemFournisseurScreen(controllerTxtField: controllerFournisseur.value));
                              //       });
                              //     }
                              //   });
                              // },
                              child: Stack(
                                children: [
                                  Obx(
                                    () => CustomTextField(
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(CupertinoIcons.clear, color: Colors.transparent),
                                      ),
                                      colorLabel: true,
                                      labelColor: fournisseurController.getSelectedFournisseurObx.value != null ? Colors.green : Colors.red,
                                      borderColor: fournisseurController.getSelectedFournisseurObx.value != null ? Colors.green : Colors.red,
                                      controller: controllerFournisseur.value,
                                      enabled: false,
                                      text: GBSystem_Application_Strings.str_select_fournisseur,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 3,
                                    child: InkWell(
                                      onTap: () {
                                        fournisseurController.setSelectedFournisseur = null;
                                        controllerFournisseur.value.text = "";
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(CupertinoIcons.clear, color: Colors.grey.shade500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_referential, controller: controllerReferential),
                            SizedBox(height: 15),
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_categorie, controller: controllerCategorie),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDatePickerFrench(
                                    selectedDate: selectedDateDebut.value,
                                    labelText: GBSystem_Application_Strings.str_date_debut,
                                    initialDate: selectedDateDebut.value,
                                    onDateSelected: (DateTime selectedDate) {
                                      selectedDateDebut.value = selectedDate;
                                    },
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: CustomDatePickerFrench(
                                    selectedDate: selectedDateFin.value,
                                    labelText: GBSystem_Application_Strings.str_date_fin.tr,
                                    initialDate: selectedDateFin.value,
                                    onDateSelected: (DateTime selectedDate) {
                                      selectedDateFin.value = selectedDate;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            CustomTextField(keyboardType: TextInputType.number, text: GBSystem_Application_Strings.str_prix, controller: controllerPrix),
                            SizedBox(height: 15),
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  // () async {
                                  //   await GBSystem_AuthService(context).getAllColors().then((value) {
                                  //     if (value != null) {
                                  //       colorsController.setAllColors = value;

                                  //       WidgetsBinding.instance.addPostFrameCallback((_) {
                                  //         Get.to(
                                  //           GBSystem_SelectItemColorScreen(
                                  //             updateUI: () {
                                  //               setState(() {});
                                  //             },
                                  //             colorField: colorField,
                                  //             controllerTxtField: controllerCouleur.value,
                                  //           ),
                                  //         );
                                  //       });
                                  //     }
                                  //   });
                                  // },
                                  child: Obx(
                                    () => CustomTextField(
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(CupertinoIcons.clear, color: Colors.transparent),
                                      ),
                                      colorLabel: true,
                                      labelColor: colorsController.getSelectedColorObx.value != null ? Colors.black : Colors.black,
                                      borderColor: colorsController.getSelectedColorObx.value != null ? Colors.black : Colors.black,
                                      color: colorsController.getSelectedColorObx.value != null ? Color(int.parse('0xFF${colorsController.getSelectedColorObx.value!.CLR_CODE_colorweb.replaceAll(r"#", "").replaceAll(r"$", "")}')) : null,
                                      controller: controllerCouleur.value,
                                      enabled: false,
                                      text: GBSystem_Application_Strings.str_select_couleurs,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 3,
                                  child: InkWell(
                                    onTap: () {
                                      colorsController.setSelectedColor = null;
                                      controllerCouleur.value.text = "";
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(CupertinoIcons.clear, color: Colors.grey.shade500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Material(
                              child: MultiSelectChipField<GbsystemTailleModel?>(
                                items: tailleController.getAllTailles != null ? tailleController.getAllTailles!.map((taille) => MultiSelectItem<GbsystemTailleModel?>(taille, "${taille.TPOI_CODE} | ${taille.TPOI_LIB}")).toList() : [],
                                initialValue: [],
                                title: Text(GBSystem_Application_Strings.str_tailles),
                                headerColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.5),
                                decoration: BoxDecoration(border: Border.all(color: GBSystem_Application_Strings.str_primary_color, width: 1.8)),
                                selectedChipColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.5),
                                selectedTextStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                                onTap: (List<GbsystemTailleModel?>? values) {
                                  // Handle the selected values here, ensuring null safety
                                  if (values != null) {
                                    tailleSelected = [];
                                    values.forEach((element) => tailleSelected.add(element!));
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            // CustomDatePickerFrench(
                            //   enabled: true,
                            //   selectedDate: selectedDateUpdate.value,
                            //   labelText:
                            //       GBSystem_Application_Strings.str_modifier_le,
                            //   initialDate: selectedDateUpdate.value,
                            //   onDateSelected: (DateTime selectedDate) {
                            //     selectedDateUpdate.value = selectedDate;
                            //   },
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            // CustomTextField(
                            //   enabled: false,
                            //   text: GBSystem_Application_Strings.str_par,
                            //   controller: controllerParResponsable,
                            // ),
                          ],
                        );
                      },
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GBSystem_Application_Strings.str_primary_color,
                          textStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                        ),
                        onPressed: () async {
                          if (fournisseurController.getSelectedFournisseur != null &&
                              selectedDateDebut.value != null &&
                              // selectedDateFin.value != null &&
                              controllerPrix.text.isNotEmpty &&
                              // colorsController.getSelectedColor !=
                              //     null &&
                              tailleSelected.isNotEmpty) {
                            isLoading.value = true;
                            // await GBSystem_AuthService(context)
                            //     .AddArticleRefToCatalogue(
                            //       article: artiecleRef, //
                            //       fournisseur: fournisseurController.getSelectedFournisseur!,
                            //       dateDebut: selectedDateDebut.value,
                            //       dateFin: selectedDateFin.value,
                            //       prix: controllerPrix.text,
                            //       color: colorsController.getSelectedColor,
                            //       listTailles: tailleSelected,
                            //     )
                            //     .then((value) {
                            //       isLoading.value = false;

                            //       if (value != null) {
                            //         value.forEach((element) => catalogueController.addNewCatalogue(element));
                            //         // catalogueController.setAllCatalogues =
                            //         //     value;
                            //         updateUI();
                            //         if (Get.isDialogOpen == true) {
                            //           Get.back();
                            //         }

                            //         showSuccesDialog(GBSystem_Application_Strings.str_operation_effectuer);
                            //       } else {
                            //         showErrorDialog(GBSystem_Application_Strings.str_error_send_data);
                            //       }
                            //     });
                          } else {
                            showErrorDialog(GBSystem_Application_Strings.str_remplie_cases);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(GBSystem_Application_Strings.str_ok, style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GBSystem_Application_Strings.str_primary_color,
                          textStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                        ),
                        onPressed: () async {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(GBSystem_Application_Strings.str_annuler, style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  isLoading.value ? Waiting() : Container(),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Future<void> showDialogAddToStock({required BuildContext context, required GbsystemCatalogueModel catalogue}) async {
    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(null), selectedDateFin = Rx<DateTime?>(null);

    TextEditingController controllerFournisseur = TextEditingController();
    TextEditingController controllerReferential = TextEditingController();
    TextEditingController controllerCategorie = TextEditingController();
    TextEditingController controllerPrix = TextEditingController();
    TextEditingController controllerQteStock = TextEditingController();
    TextEditingController controllerCouleur = TextEditingController();

    Rx<TextEditingController> controllerEnterpot = Rx<TextEditingController>(TextEditingController());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (enterpotController.getSelectedEnterpot != null) {
        controllerEnterpot.value.text = "${enterpotController.getSelectedEnterpot!.ENTR_CODE} | ${enterpotController.getSelectedEnterpot!.ENTR_LIB}";
      }
      controllerFournisseur.text = "${catalogue.FOU_CODE} | ${catalogue.FOU_LIB}";

      controllerReferential.text = "${catalogue.ARTREF_CODE} | ${catalogue.ARTREF_LIB}";
      controllerCategorie.text = "${catalogue.ARTCAT_CODE} | ${catalogue.ARTCAT_LIB}";
      controllerPrix.text = catalogue.ARTFOUREF_PRIX;
      controllerCouleur.text = catalogue.CLR_LIB;
      selectedDateDebut.value = catalogue.ARTFOUREF_START_DATE != null ? catalogue.ARTFOUREF_START_DATE! : null;
      selectedDateFin.value = catalogue.ARTFOUREF_END_DATE != null ? catalogue.ARTFOUREF_END_DATE! : null;

      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Obx(
              () => Stack(
                children: [
                  AlertDialog(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0), // Set your desired radius here
                    ),
                    backgroundColor: Colors.white,
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              // () async {
                              //   await GBSystem_AuthService(context).getAllEnterpot().then((value) {
                              //     if (value != null) {
                              //       enterpotController.setAllEnterpot = value;
                              //       WidgetsBinding.instance.addPostFrameCallback((_) {
                              //         Get.to(GBSystem_SelectItemEnterpotScreen(controllerTxtField: controllerEnterpot.value));
                              //       });
                              //     }
                              //   });
                              // },
                              child: Stack(
                                children: [
                                  Obx(
                                    () => CustomTextField(
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(CupertinoIcons.clear, color: Colors.transparent),
                                      ),
                                      colorLabel: true,
                                      labelColor: enterpotController.getSelectedEnterpotObx.value != null ? Colors.green : Colors.red,
                                      borderColor: enterpotController.getSelectedEnterpotObx.value != null ? Colors.green : Colors.red,
                                      controller: controllerEnterpot.value,
                                      enabled: false,
                                      text: GBSystem_Application_Strings.str_select_enterpot,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 3,
                                    child: InkWell(
                                      onTap: () {
                                        enterpotController.setSelectedEnterpot = null;
                                        controllerEnterpot.value.text = "";
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(CupertinoIcons.clear, color: Colors.grey.shade500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_fournisseur, controller: controllerFournisseur),
                            SizedBox(height: 15),
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_referential, controller: controllerReferential),
                            SizedBox(height: 15),
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_categorie, controller: controllerCategorie),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDatePickerFrench(
                                    selectedDate: selectedDateDebut.value,
                                    labelText: GBSystem_Application_Strings.str_date_debut,
                                    initialDate: selectedDateDebut.value,
                                    onDateSelected: (DateTime selectedDate) {
                                      selectedDateDebut.value = selectedDate;
                                    },
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: CustomDatePickerFrench(
                                    selectedDate: selectedDateFin.value,
                                    labelText: GBSystem_Application_Strings.str_date_fin.tr,
                                    initialDate: selectedDateFin.value,
                                    onDateSelected: (DateTime selectedDate) {
                                      selectedDateFin.value = selectedDate;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_prix, controller: controllerPrix),
                            SizedBox(height: 15),
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_couleurs, controller: controllerCouleur),
                            SizedBox(height: 15),
                            CustomTextField(keyboardType: TextInputType.number, text: GBSystem_Application_Strings.str_qte_stock, controller: controllerQteStock),
                          ],
                        );
                      },
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GBSystem_Application_Strings.str_primary_color,
                          textStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                        ),
                        onPressed: () async {
                          if (enterpotController.getSelectedEnterpot != null &&
                              selectedDateDebut.value != null &&
                              // selectedDateFin.value != null &&
                              controllerQteStock.text.isNotEmpty) {
                            isLoading.value = true;
                            // await GBSystem_AuthService(context)
                            //     .AddCatalogueAuStock(
                            //       enterpot: enterpotController.getSelectedEnterpot!, //
                            //       catalogue: catalogue,
                            //       dateDebut: selectedDateDebut.value,
                            //       dateFin: selectedDateFin.value,
                            //       qte: controllerQteStock.text,
                            //     )
                            //     .then((value) {
                            //       isLoading.value = false;

                            //       if (value) {
                            //         updateUI();
                            //         if (Get.isDialogOpen == true) {
                            //           Get.back();
                            //         }

                            //         showSuccesDialog(GBSystem_Application_Strings.str_operation_effectuer);
                            //       } else {
                            //         // showErrorDialog(
                            //         //     context,
                            //         //     GBSystem_Application_Strings
                            //         //         .str_error_send_data);
                            //       }
                            //     });
                          } else {
                            showErrorDialog(GBSystem_Application_Strings.str_remplie_cases);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(GBSystem_Application_Strings.str_ok, style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GBSystem_Application_Strings.str_primary_color,
                          textStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                        ),
                        onPressed: () async {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(GBSystem_Application_Strings.str_annuler, style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  isLoading.value ? Waiting() : Container(),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Future<void> showDialogUpdateCatalogue({required BuildContext context, required GbsystemCatalogueModel catalogue}) async {
    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(null), selectedDateFin = Rx<DateTime?>(null), selectedDateUpdate = Rx<DateTime?>(null);

    TextEditingController controllerReferential = TextEditingController();
    TextEditingController controllerCategorie = TextEditingController();
    TextEditingController controllerPrix = TextEditingController();
    TextEditingController controllerFournisseur = TextEditingController();
    TextEditingController controllerParResponsable = TextEditingController();

    Rx<TextEditingController> controllerCouleur = Rx<TextEditingController>(TextEditingController());
    //Color? colorField;

    List<String> tailleSelected = [catalogue.TPOI_LIB];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controllerFournisseur.text = "${catalogue.FOU_CODE} | ${catalogue.FOU_LIB}";
      controllerReferential.text = "${catalogue.ARTREF_CODE} | ${catalogue.ARTREF_LIB}";
      controllerCategorie.text = "${catalogue.ARTCAT_CODE} | ${catalogue.ARTCAT_LIB}";
      controllerPrix.text = catalogue.ARTFOUREF_PRIX;

      controllerParResponsable.text = catalogue.USR_LIB;

      selectedDateUpdate.value = catalogue.LAST_UPDT != null ? catalogue.LAST_UPDT! : null;

      selectedDateDebut.value = catalogue.ARTFOUREF_START_DATE != null ? catalogue.ARTFOUREF_START_DATE! : null;
      selectedDateFin.value = catalogue.ARTFOUREF_END_DATE != null ? catalogue.ARTFOUREF_END_DATE! : null;

      controllerCouleur.value.text = catalogue.CLR_LIB;

      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Obx(
              () => Stack(
                children: [
                  AlertDialog(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0), // Set your desired radius here
                    ),
                    backgroundColor: Colors.white,
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_fournisseur, controller: controllerFournisseur),
                            SizedBox(height: 15),
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_referential, controller: controllerReferential),
                            SizedBox(height: 15),
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_categorie, controller: controllerCategorie),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDatePickerFrench(
                                    selectedDate: selectedDateDebut.value,
                                    labelText: GBSystem_Application_Strings.str_date_debut,
                                    initialDate: selectedDateDebut.value,
                                    onDateSelected: (DateTime selectedDate) {
                                      selectedDateDebut.value = selectedDate;
                                    },
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: CustomDatePickerFrench(
                                    selectedDate: selectedDateFin.value,
                                    labelText: GBSystem_Application_Strings.str_date_fin.tr,
                                    initialDate: selectedDateFin.value,
                                    onDateSelected: (DateTime selectedDate) {
                                      selectedDateFin.value = selectedDate;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            CustomTextField(keyboardType: TextInputType.number, text: GBSystem_Application_Strings.str_prix, controller: controllerPrix),
                            SizedBox(height: 15),
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    /*voir ci-dessous */
                                  },
                                  //  () async {
                                  //   await GBSystem_AuthService(context).getAllColors().then((value) {
                                  //     if (value != null) {
                                  //       colorsController.setAllColors = value;

                                  //       WidgetsBinding.instance.addPostFrameCallback((_) {
                                  //         Get.to(
                                  //           GBSystem_SelectItemColorScreen(
                                  //             updateUI: () {
                                  //               setState(() {});
                                  //             },
                                  //             colorField: colorField,
                                  //             controllerTxtField: controllerCouleur.value,
                                  //           ),
                                  //         );
                                  //       });
                                  //     }
                                  //   });
                                  //},
                                  child: Obx(
                                    () => CustomTextField(
                                      borderColor: Colors.black, //
                                      labelColor: Colors.black,
                                      color: Colors.black,
                                      colorLabel: true,
                                      controller: controllerCouleur.value,
                                      enabled: false,
                                      text: GBSystem_Application_Strings.str_select_couleurs,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 3,
                                  child: InkWell(
                                    onTap: () {
                                      colorsController.setSelectedColor = null;
                                      controllerCouleur.value.text = "";
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(CupertinoIcons.clear, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            AbsorbPointer(
                              absorbing: true,
                              child: Material(
                                color: Colors.grey,
                                child: MultiSelectChipField<String?>(
                                  items: tailleSelected.map((taille) => MultiSelectItem<String>(taille, taille)).toList(),
                                  initialValue: [],
                                  title: Text(GBSystem_Application_Strings.str_tailles),
                                  headerColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.5),
                                  decoration: BoxDecoration(border: Border.all(color: GBSystem_Application_Strings.str_primary_color, width: 1.8)),
                                  selectedChipColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.5),
                                  selectedTextStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                                  onTap: (p0) {},
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            CustomDatePickerFrench(
                              enabled: true,
                              selectedDate: selectedDateUpdate.value,
                              labelText: GBSystem_Application_Strings.str_modifier_le,
                              initialDate: selectedDateUpdate.value,
                              onDateSelected: (DateTime selectedDate) {
                                selectedDateUpdate.value = selectedDate;
                              },
                            ),
                            SizedBox(height: 15),
                            CustomTextField(enabled: false, text: GBSystem_Application_Strings.str_par, controller: controllerParResponsable),
                          ],
                        );
                      },
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GBSystem_Application_Strings.str_primary_color,
                          textStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                        ),
                        onPressed: () async {
                          if (selectedDateDebut.value != null &&
                              // selectedDateFin.value != null &&
                              controllerPrix.text.isNotEmpty
                          // &&
                          // (colorsController.getSelectedColor !=
                          //         null ||
                          //     controllerCouleur
                          //         .value.text.isNotEmpty)
                          ) {
                            isLoading.value = true;
                            // await GBSystem_AuthService(context)
                            //     .updateCatalogue(
                            //       catalogue: catalogue, //
                            //       dateDebut: selectedDateDebut.value!,
                            //       dateFin: selectedDateFin.value,
                            //       prix: controllerPrix.text,
                            //       color: colorsController.getSelectedColor,
                            //     )
                            //     .then((value) {
                            //       isLoading.value = false;

                            //       if (value != null) {
                            //         catalogueController.updateCatalogue(catalogue, value);
                            //         updateUI();
                            //         if (Get.isDialogOpen == true) {
                            //           Get.back();
                            //         }

                            //         showSuccesDialog(GBSystem_Application_Strings.str_operation_effectuer);
                            //       } else {
                            //         showErrorDialog(GBSystem_Application_Strings.str_error_send_data);
                            //       }
                            //     });
                          } else {
                            showErrorDialog(GBSystem_Application_Strings.str_remplie_cases);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(GBSystem_Application_Strings.str_ok, style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GBSystem_Application_Strings.str_primary_color,
                          textStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                        ),
                        onPressed: () async {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(GBSystem_Application_Strings.str_annuler, style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  isLoading.value ? Waiting() : Container(),
                ],
              ),
            ),
          );
        },
      );
    });
  }


Future<List<GbsystemCatalogueModel>?> getAllCatalogueArticle({
    required GbsystemArticleRefModel articleRef,
  }) async {
     ResponseModel Sever_Response =  await Execute_Server_post(data: {
          "OKey":              "ArticleRef_Manager,charge_Catalog_Fouri,charge_Catalog_Fouri",
          "ITEM_LIB": "0",
          "ARTREF_IDF": articleRef.ARTREF_IDF,
          
        });

    // Note: AppManageApi call has been commented out as _ActiveUrl, _Wid, and _Cookies are not defined in this controller
    // ResponseModel data = await AppManageApi(context).post(
    //     url: _ActiveUrl,
    //     data: {
    //       "OKey":
    //           "ArticleRef_Manager,charge_Catalog_Fouri,charge_Catalog_Fouri",
    //       "ITEM_LIB": "0",
    //       "ARTREF_IDF": articleRef.ARTREF_IDF,
    //       "Wid": _Wid!
    //     },
    //     cookies: _Cookies);
    ResponseModel data = Sever_Response;

    if ((data.data["Data"] as List).isNotEmpty &&
        (data.data["Errors"] as List).isEmpty) {
      List<GbsystemCatalogueModel> listCatalogues = [];

      print(data.data);
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null &&
            data.data["Data"][i] is Map &&
            data.data["Data"][i]["ARTCAT"] != null) {
          listCatalogues = GbsystemCatalogueModel.convertDynamictoListCatalogue(
              data.data["Data"][i]["ARTCAT"]);
        }
      }

      return listCatalogues;
    } else {
      return null;
    }
  }

  Future<void> getArticleByTag({required String? tagType, required String tag}) async {
    ResponseModel Sever_Response = await Execute_Server_post(data: {"OKey": "mobile_application,READ_ARTREF_INFO_TAG,READ_ARTREF_INFO_TAG", "TAG_CODE": tag});

    if (Sever_Response.isRequestSucces()) {
      GbsystemArticleRefModel? articleRefModel = GbsystemArticleRefModel.fromResponse(Sever_Response);
      articlesController.setSelectedArticle = articleRefModel;
      if (articleRefModel != null) {
          await getAllCatalogueArticle(articleRef:articleRefModel);
      };
      return ;
    } else {
      showErrorDialog(GBSystem_Application_Strings.str_no_article_associer_a_cette_code.tr);
      return ;
    }
  }
}
