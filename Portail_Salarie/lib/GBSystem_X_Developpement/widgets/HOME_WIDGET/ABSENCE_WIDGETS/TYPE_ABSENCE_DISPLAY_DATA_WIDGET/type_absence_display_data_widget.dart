import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_compteur_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_cet_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_compteur_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_date_picker.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_drop_down_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class TypeAbsenceDisplayDataWidget extends StatefulWidget {
  const TypeAbsenceDisplayDataWidget(
      {super.key,
      required this.atr1,
      required this.name,
      required this.atr2,
      required this.atr3,
      required this.atr4,
      required this.atr5,
      required this.atr22});

  final String name, atr1, atr2, atr22, atr3, atr4, atr5;

  @override
  State<TypeAbsenceDisplayDataWidget> createState() =>
      _TypeAbsenceDisplayDataWidgetState();
}

class _TypeAbsenceDisplayDataWidgetState
    extends State<TypeAbsenceDisplayDataWidget> {
  TextEditingController controllerAtr1 = TextEditingController();
  TextEditingController controllerAtr2 = TextEditingController();
  TextEditingController controllerAtr22 = TextEditingController();

  TextEditingController controllerAtr3 = TextEditingController();
  TextEditingController controllerAtr4 = TextEditingController();
  TextEditingController controllerAtr5 = TextEditingController();

  @override
  void initState() {
    controllerAtr1.text = widget.atr1;
    controllerAtr2.text = widget.atr2;
    controllerAtr22.text = widget.atr22;

    controllerAtr3.text = widget.atr3;
    controllerAtr4.text = widget.atr4;
    controllerAtr5.text = widget.atr5;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 200,
          margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: Colors.black54)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextField(
                  textStyle: TextStyle(color: Colors.black),
                  controller: controllerAtr1,
                  enabled: false,
                  text: GbsSystemStrings.demander_acquis.tr),
              CustomTextField(
                textStyle: TextStyle(color: Colors.black),
                controller: controllerAtr2,
                text: GbsSystemStrings.demander_pris.tr,
                enabled: false,
              ),
              CustomTextField(
                textStyle: TextStyle(color: Colors.black),
                controller: controllerAtr22,
                text: GbsSystemStrings.mise_au_cet_en_cours.tr,
                enabled: false,
              ),
              CustomTextField(
                  textStyle: TextStyle(color: Colors.black),
                  controller: controllerAtr3,
                  enabled: false,
                  text: GbsSystemStrings.demander_a_venir.tr),
              CustomTextField(
                  textStyle: TextStyle(color: Colors.black),
                  controller: controllerAtr4,
                  enabled: false,
                  text: GbsSystemStrings.demander_demande_en_cours.tr),
              CustomTextField(
                textStyle: TextStyle(color: Colors.black),
                controller: controllerAtr5,
                enabled: false,
                text: GbsSystemStrings.demander_solde_restant_a_prendre.tr,
              ),
            ],
          ),
        ),
        Positioned(
            top: 0,
            right: 20,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: GBSystem_TextHelper()
                    .smallText(text: widget.name, textColor: Colors.white))),
      ],
    );
  }
}

class CETDisplayDataWidget extends StatefulWidget {
  const CETDisplayDataWidget({
    super.key,
    // required this.Acquis,
    // required this.MiseAuCETEnCours,
    // required this.MiseAuCETAnneeEnCours,
    // required this.RachatCETEnCours,
    // required this.RachatDeCET,
    // required this.PriseDeCETEnCours,
    // required this.PriseDeCET,
    // required this.SoldeDeCET,
    required this.compteurModel,
  });

  // final String Acquis,
  //     MiseAuCETEnCours,
  //     MiseAuCETAnneeEnCours,
  //     RachatCETEnCours,
  //     RachatDeCET,
  //     PriseDeCETEnCours,
  //     PriseDeCET,
  //     SoldeDeCET;
  final CompteurModel? compteurModel;

  @override
  State<CETDisplayDataWidget> createState() => _CETDisplayDataWidgetState();
}

class _CETDisplayDataWidgetState extends State<CETDisplayDataWidget> {
  TextEditingController controllerAcquis = TextEditingController();
  TextEditingController controllerMiseAuCETEnCours = TextEditingController();
  TextEditingController controllerMiseAuCETAnneeEnCours =
      TextEditingController();
  TextEditingController controllerRachatCETEnCours = TextEditingController();
  TextEditingController controllerRachatDeCET = TextEditingController();
  TextEditingController controllerPriseDeCETEnCours = TextEditingController();
  TextEditingController controllerPriseDeCET = TextEditingController();
  TextEditingController controllerSoldeDeCET = TextEditingController();

  @override
  void initState() {
    controllerAcquis.text = widget.compteurModel!.SABSD_CET_ACQUIS ?? "0.00";
    controllerMiseAuCETEnCours.text =
        widget.compteurModel!.MISE_CET_EN_COURS ?? "0.00";
    controllerMiseAuCETAnneeEnCours.text =
        widget.compteurModel!.MISE_CET_ANNEE_EN_COURS ?? "0.00";
    controllerRachatCETEnCours.text =
        widget.compteurModel!.CET_RACHAT_EN_COURS ?? "0.00";
    controllerRachatDeCET.text = widget.compteurModel!.CET_RACHAT ?? "0.00";
    controllerPriseDeCETEnCours.text =
        widget.compteurModel!.PRISE_CET_EN_COURS ?? "0.00";
    controllerPriseDeCET.text = widget.compteurModel!.PRISE_CET ?? "0.00";
    controllerSoldeDeCET.text = widget.compteurModel!.SABSD_CET_SOLDE ?? "0.00";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          // clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: Colors.grey.shade400)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextField(
                  textStyle: TextStyle(color: Colors.black),
                  controller: controllerAcquis,
                  enabled: true,
                  text: GbsSystemStrings.demander_acquis.tr),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                textStyle: TextStyle(color: Colors.black),
                controller: controllerMiseAuCETEnCours,
                text: GbsSystemStrings.mise_au_cet_en_cours.tr,
                enabled: false,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  textStyle: TextStyle(color: Colors.black),
                  controller: controllerMiseAuCETAnneeEnCours,
                  enabled: false,
                  text: GbsSystemStrings.mise_au_cet_annee_en_cours.tr),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  textStyle: TextStyle(color: Colors.black),
                  controller: controllerRachatCETEnCours,
                  enabled: false,
                  text: GbsSystemStrings.rachat_cet_en_cours.tr),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                textStyle: TextStyle(color: Colors.black),
                controller: controllerRachatDeCET,
                enabled: false,
                text: GbsSystemStrings.rachat_de_cet.tr,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                textStyle: TextStyle(color: Colors.black),
                controller: controllerPriseDeCETEnCours,
                enabled: false,
                text: GbsSystemStrings.prise_de_cet_en_cours.tr,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                textStyle: TextStyle(color: Colors.black),
                controller: controllerPriseDeCET,
                enabled: false,
                text: GbsSystemStrings.prise_de_cet.tr,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                textStyle: TextStyle(color: Colors.black),
                controller: controllerSoldeDeCET,
                enabled: false,
                text: GbsSystemStrings.solde_de_cet.tr,
              ),
            ],
          ),
        ),
        Positioned(
            top: 0,
            right: 20,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: GBSystem_TextHelper().smallText(
                    text: GbsSystemStrings.solde_des_jours_de_cet.tr))),
      ],
    );
  }
}

class CalculeCETWidget extends StatefulWidget {
  const CalculeCETWidget({
    super.key,
    required this.CETModel,
    required this.updateLoading,
    required this.updateUI,
    this.isTypeThree = false,
  });

  final GBSystemCETModel CETModel;
  final Function updateLoading, updateUI;
  final bool isTypeThree;

  @override
  State<CalculeCETWidget> createState() => _CalculeCETWidgetState();
}

class _CalculeCETWidgetState extends State<CalculeCETWidget> {
  String? selectedNombreJour;

  int? selectedIndex;

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  @override
  Widget build(BuildContext context) {
    return Container(
      // clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.grey.shade400)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 30,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    setState(() {
                      selectedIndex = index;
                      selectedNombreJour = null;
                      selectedDate.value = null;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    margin: EdgeInsets.symmetric(
                        horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.01)),
                    padding: EdgeInsets.symmetric(
                        horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.04)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: selectedIndex == index
                          ? GbsSystemStrings.str_primary_color
                          : Colors.grey.shade300,
                    ),
                    child: Center(
                      child: GBSystem_TextHelper().smallText(
                          textColor: selectedIndex == index
                              ? Colors.white
                              : GbsSystemStrings.str_primary_color,
                          text: index == 0
                              ? "CP"
                              : index == 1
                                  ? "RC"
                                  : "RTT"),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomDropDownButtonString(
              onChanged: (p0) {
                setState(() {
                  selectedNombreJour = p0;
                });
              },
              selectedItem: selectedNombreJour,
              listItems: (selectedIndex == 0
                  ? listItemsNombreDesJours(
                      "CP",
                      widget.CETModel.listNombreDesJours.isNotEmpty
                          ? int.parse(widget.CETModel.listNombreDesJours.first
                                  .NBJ_MAX_CP ??
                              "0")
                          : 0)
                  : selectedIndex == 1
                      ? listItemsNombreDesJours(
                          "RC",
                          widget.CETModel.listNombreDesJours.isNotEmpty
                              ? int.parse(widget.CETModel.listNombreDesJours
                                      .first.NBJ_MAX_RC ??
                                  "0")
                              : 0)
                      : selectedIndex == 2
                          ? listItemsNombreDesJours(
                              "RTT",
                              widget.CETModel.listNombreDesJours.isNotEmpty
                                  ? int.parse(widget.CETModel.listNombreDesJours
                                          .first.NBJ_MAX_RTT ??
                                      "0")
                                  : 0)
                          : ["0"]),
              hint: GbsSystemStrings.str_nombre_des_jours.tr),
          SizedBox(
            height: 10,
          ),
          AbsorbPointer(
            absorbing: true,
            child: Obx(
              () => CustomDatePickerWithTime(
                  labelText: GbsSystemStrings.str_date_demande.tr,
                  initialDate: selectedDate.value,
                  enabled: false,
                  onDateSelected: (p0) {},
                  selectedDate: selectedDate.value),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                  onTap: widget.isTypeThree == false
                      ? () async {
                          try {
                            if (selectedNombreJour != null &&
                                selectedIndex != null) {
                              widget.updateLoading(true);

                              await GBSystem_AuthService(context)
                                  .validerCompteurCET(
                                      nombreJourValue: selectedNombreJour!,
                                      type: selectedIndex == 0
                                          ? "CP"
                                          : selectedIndex == 1
                                              ? "RC"
                                              : "RTT")
                                  .then((value) async {
                                widget.updateLoading(false);

                                if (value != null) {
                                  widget.updateLoading(true);

                                  selectedDate.value = value.DEMANDE_DATE;

                                  //// manage nombre
                                  await GBSystem_AuthService(context)
                                      .getCompteurCET()
                                      .then((value) {
                                    widget.updateLoading(false);
                                    if (value != null) {
                                      selectedNombreJour = null;
                                      // setState(() {});
                                      final compteurController =
                                          Get.put<GBSystemCompteurController>(
                                              GBSystemCompteurController());
                                      compteurController.setCompteur =
                                          value.compteurModel;
                                      compteurController.setListNombreDesJours =
                                          value.listNombreDesJours;

                                      showSuccesDialog(
                                          context,
                                          GbsSystemStrings
                                              .str_operation_effectuer.tr);

                                      widget.updateUI();
                                    }
                                  });
                                }
                              });
                            } else {
                              showErrorDialog(context,
                                  GbsSystemStrings.str_remplie_cases.tr);
                            }
                          } catch (e) {
                            widget.updateLoading(false);
                            print(e.toString());

                            GBSystem_ManageCatchErrors().catchErrors(context,
                                message: e.toString(),
                                method: "validerCompteurCET 1",
                                page: "type_absence_display_data_widget");
                          }
                        }
                      : () async {
                          try {
                            if (selectedNombreJour != null &&
                                selectedIndex != null) {
                              widget.updateLoading(true);

                              await GBSystem_AuthService(context)
                                  .validerCompteurCETPriseDeJour(
                                nombreJourValue: selectedNombreJour!,
                              )
                                  .then((value) async {
                                // print("data valider :  $value");
                                widget.updateLoading(false);
                                if (value != null) {
                                  widget.updateLoading(true);
                                  selectedDate.value = value.DEMANDE_DATE;
                                  //// manage nombre
                                  await GBSystem_AuthService(context)
                                      .getCompteurCET()
                                      .then((value) {
                                    widget.updateLoading(false);
                                    if (value != null) {
                                      selectedNombreJour = null;
                                      // setState(() {});

                                      final compteurController =
                                          Get.put<GBSystemCompteurController>(
                                              GBSystemCompteurController());
                                      compteurController.setCompteur =
                                          value.compteurModel;
                                      compteurController.setListNombreDesJours =
                                          value.listNombreDesJours;
                                      widget.updateUI();

                                      showSuccesDialog(
                                          context,
                                          GbsSystemStrings
                                              .str_operation_effectuer.tr);
                                    }
                                  });
                                }
                              });
                            } else {
                              showErrorDialog(context,
                                  GbsSystemStrings.str_remplie_cases.tr);
                            }
                          } catch (e) {
                            widget.updateLoading(false);
                            print(e.toString());
                            GBSystem_ManageCatchErrors().catchErrors(context,
                                message: e.toString(),
                                method: "validerCompteurCETPriseDeJour 2",
                                page: "type_absence_display_data_widget");
                          }
                        },
                  horPadding: 15,
                  verPadding: 8,
                  text: GbsSystemStrings.str_valider.tr),
            ],
          )
        ],
      ),
    );
  }

  List<String> listItemsNombreDesJours(String typeOperation, int max) {
    List<String> result = [];
    if (max == 0) {
      result.add(0.toString());
    } else {
      if (typeOperation == "CP" || typeOperation == "RTT") {
        for (var i = 1; i <= max; i++) {
          result.add(i.toString());
        }
      } else {
        int length = max ~/ 7;

        if (length == 0) {
          result.add(0.toString());
        } else {
          for (var i = 1; i <= length; i++) {
            result.add((7 * i).toString());
          }
        }
      }
    }

    return result;
  }
}

class CalculeCETRachatWidget extends StatefulWidget {
  const CalculeCETRachatWidget({
    super.key,
    required this.CETModel,
    required this.updateLoading,
    required this.updateUI,
  });

  final GBSystemCETModel CETModel;
  final Function updateLoading, updateUI;

  @override
  State<CalculeCETRachatWidget> createState() => _CalculeCETRachatWidgetState();
}

class _CalculeCETRachatWidgetState extends State<CalculeCETRachatWidget> {
  String? selectedNombreJour;

  int? selectedIndex;

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  @override
  Widget build(BuildContext context) {
    return Container(
      // clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.grey.shade400)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDropDownButtonString(
              onChanged: (p0) {
                setState(() {
                  selectedNombreJour = p0;
                });
              },
              selectedItem: selectedNombreJour,
              listItems: listItemsNombreDesJours(
                  "RTT",
                  widget.CETModel.listNombreDesJours.isNotEmpty
                      ? int.parse(widget
                              .CETModel.listNombreDesJours.first.NBJ_MAX_RTT ??
                          "0")
                      : 0),
              hint: GbsSystemStrings.str_nombre_des_jours.tr),
          SizedBox(
            height: 10,
          ),
          AbsorbPointer(
            absorbing: true,
            child: Obx(
              () => CustomDatePicker(
                  labelText: GbsSystemStrings.str_date_demande.tr,
                  initialDate: selectedDate.value,
                  enabled: false,
                  onDateSelected: (p0) {},
                  selectedDate: selectedDate.value),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                  onTap: () async {
                    try {
                      if (selectedNombreJour != null) {
                        widget.updateLoading(true);

                        await GBSystem_AuthService(context)
                            .validerCompteurCETRachat(
                          nombreJourValue: selectedNombreJour!,
                        )
                            .then((value) async {
                          widget.updateLoading(false);
                          if (value != null) {
                            widget.updateLoading(true);
                            selectedDate.value = value.DEMANDE_DATE;
                            //// manage nombre
                            await GBSystem_AuthService(context)
                                .getCompteurCET()
                                .then((value) {
                              widget.updateLoading(false);
                              if (value != null) {
                                final compteurController =
                                    Get.put<GBSystemCompteurController>(
                                        GBSystemCompteurController());
                                compteurController.setCompteur =
                                    value.compteurModel;
                                compteurController.setListNombreDesJours =
                                    value.listNombreDesJours;
                                selectedNombreJour = null;
                                widget.updateUI();

                                showSuccesDialog(
                                    context,
                                    GbsSystemStrings
                                        .str_operation_effectuer.tr);
                              }
                            });
                          }
                        });
                      } else {
                        showErrorDialog(
                            context, GbsSystemStrings.str_remplie_cases.tr);
                      }
                    } catch (e) {
                      widget.updateLoading(false);
                      GBSystem_ManageCatchErrors().catchErrors(context,
                          message: e.toString(),
                          method: "validerCompteurCETRachat",
                          page: "type_absence_display_data_widget");
                    }
                  },
                  horPadding: 15,
                  verPadding: 8,
                  text: GbsSystemStrings.str_valider.tr),
            ],
          )
        ],
      ),
    );
  }

  List<String> listItemsNombreDesJours(String typeOperation, int max) {
    List<String> result = [];
    if (max == 0) {
      result.add(0.toString());
    } else {
      if (typeOperation == "CP" || typeOperation == "RTT") {
        for (var i = 1; i <= max; i++) {
          result.add(i.toString());
        }
      } else {
        int length = max ~/ 7;

        if (length == 0) {
          result.add(0.toString());
        } else {
          for (var i = 1; i <= length; i++) {
            result.add((7 * i).toString());
          }
        }
      }
    }

    return result;
  }
}
