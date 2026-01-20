import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_place_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_ville_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_location_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/ADRESSE_WIDGET/adresse_wdget_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class AdresseWidget extends StatefulWidget {
  const AdresseWidget({
    super.key,
    required this.salarie,
    this.onSuivantTap,
    this.onPrecedentTap,
    required this.updateLoading,
  });

  final GBSystemSalarieWithPhotoModel? salarie;
  final void Function()? onSuivantTap, onPrecedentTap;
  final Function(bool) updateLoading;

  @override
  State<AdresseWidget> createState() => _AdresseWidgetState();
}

class _AdresseWidgetState extends State<AdresseWidget> {
  @override
  Widget build(BuildContext context) {
    final AdresseWidgetController m =
        Get.put(AdresseWidgetController(salarie: widget.salarie));
    final GBSystemVilleController villeController =
        Get.put(GBSystemVilleController());
    final GBSystemPlaceController placeController =
        Get.put(GBSystemPlaceController());
    return Form(
      key: m.formKey,
      autovalidateMode: m.autovalidateMode,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal:
                  GBSystem_ScreenHelper.screenWidthPercentage(context, 0.025),
            ),
            padding: EdgeInsets.symmetric(
              horizontal:
                  GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          m.isSearchVisible.value = true;
                        },
                        child: CustomTextField(
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return GbsSystemStrings.str_field_required;
                            } else {
                              return null;
                            }
                          },
                          controller: m.controllerAd1.value,
                          text: GbsSystemStrings.str_adresse.tr + " 1",
                          // textStyle: TextStyle(color: Colors.black),
                          enabled: false,
                          suffixIcon: Icon(
                            CupertinoIcons.location_solid,
                            color: GbsSystemStrings.str_primary_color,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    Obx(
                      () => Visibility(
                        visible: m.isSearchVisible.value,
                        child: CustomTextField(
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return GbsSystemStrings.str_field_required;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (p0) async {
                            if (p0.isNotEmpty) {
                              m.isLoading.value = true;
                            } else {
                              m.isLoading.value = false;
                            }
                            try {
                              m.textInput.value = p0;
                              m.filteredSuggestions.value = [];

                              await LocationService()
                                  .getSuggestionsPosition(context,
                                      search: m.textInput.value)
                                  .then(
                                (value) {
                                  m.isLoading.value = false;
                                  m.filteredSuggestions.value = value;
                                },
                              );
                            } catch (e) {
                              m.isLoading.value = false;
                            }
                          },
                          controller: m.controllerSearchAd1.value,
                          text: GbsSystemStrings.str_rechercher.tr,
                          textStyle: TextStyle(color: Colors.black),
                          enabled: true,
                        ),
                      ),
                    ),
                    Obx(() => m.isLoading.value
                        ? Container(height: 100, child: WaitingWidgets())
                        : (m.filteredSuggestions.value.isNotEmpty &&
                                m.textInput.value.isNotEmpty
                            ? Container(
                                height: 200,
                                margin: EdgeInsets.only(bottom: 5),
                                child: ListView.builder(
                                  itemCount: m.filteredSuggestions.value.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5,
                                              color: Colors.black54)),
                                      child: ListTile(
                                        title: Text(
                                            "${m.filteredSuggestions.value[index].label}"),
                                        // subtitle: Text(
                                        //     "${m.filteredSuggestions.value[index].city}"),
                                        onTap: () async {
                                          placeController.setCurrentPlace = m
                                              .filteredSuggestions.value[index];

                                          m.controllerLat.value.text = m
                                              .filteredSuggestions
                                              .value[index]
                                              .longitude
                                              .toString();

                                          m.controllerLong.value.text = m
                                              .filteredSuggestions
                                              .value[index]
                                              .latitude
                                              .toString();

                                          m.controllerAd1.value.text =
                                              "${m.filteredSuggestions.value[index].label}";

                                          setState(() {
                                            m.filteredSuggestions.value.clear();
                                          });

                                          widget.updateLoading(true);

                                          await GBSystem_AuthService(context)
                                              .getSelectedVille(
                                                  selectedPlace: placeController
                                                      .getCurrentPlace!)
                                              .then(
                                            (value) {
                                              widget.updateLoading(false);

                                              if (value != null) {
                                                villeController
                                                    .setCurrentVille = value;
                                                m.controllerVille.value.text =
                                                    "${value.VIL_CODE} | ${value.VIL_LIB}";
                                              }
                                            },
                                          );

                                          m.isSearchVisible.value = false;
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container())),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    Obx(
                      () => CustomTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return GbsSystemStrings.str_field_required;
                          } else {
                            return null;
                          }
                        },
                        controller: m.controllerAd2.value,
                        text: GbsSystemStrings.str_adresse.tr + " 2",
                        enabled: true,
                      ),
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    Obx(
                      () => CustomTextField(
                        controller: m.controllerLat.value,
                        text: GbsSystemStrings.str_latitude.tr,
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    Obx(
                      () => CustomTextField(
                        controller: m.controllerLong.value,
                        text: GbsSystemStrings.str_longitude.tr,
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    Obx(
                      () => InkWell(
                        // onTap: () async {
                        //   print("object tap");
                        //   widget.updateLoading(true);
                        //   await GBSystem_AuthService(context)
                        //       .getAllVille()
                        //       .then(
                        //     (value) {
                        //       widget.updateLoading(false);

                        //       villeController.setAllVille = value;

                        //       Get.to(GBSystem_SelectItemVilleScreen(
                        //           controllerTxtField: m.controllerVille.value));
                        //     },
                        //   );
                        // },
                        child: CustomTextField(
                          controller: m.controllerVille.value,
                          text: GbsSystemStrings.str_ville.tr,
                          enabled: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: false,
                          child: CustomButtonWithTrailling(
                              trailling: Icon(
                                CupertinoIcons.arrow_left,
                                color: Colors.white,
                                size: 12,
                              ),
                              onTap: widget.onPrecedentTap,
                              textSize: 12,
                              horPadding: 10,
                              verPadding: 10,
                              text: GbsSystemStrings.str_precedent.tr),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomButton(
                            enabled: (m.salarieController.getSalarie
                                    ?.salarieModel.CLIENT_ID ==
                                "1"),
                            color: Colors.green,
                            onTap: () async {
                              try {
                                if (m.formKey.currentState!.validate()) {
                                  widget.updateLoading(true);
                                  await GBSystem_AuthService(context)
                                      .updateAdresseNew(
                                          place:
                                              placeController.getCurrentPlace,
                                          ville:
                                              villeController.getCurrentVille,
                                          adresse1: m.controllerAd1.value.text,
                                          adresse2: m.controllerAd2.value.text)
                                      .then((value) async {
                                    if (value != null) {
                                      final GBSystemSalarieController
                                          salarieController =
                                          Get.put(GBSystemSalarieController());

                                      await GBSystem_AuthService(context)
                                          .getInfoSalarie()
                                          .then((infoSalarie) async {
                                        widget.updateLoading(false);
                                        if (infoSalarie != null) {
                                          salarieController.setSalarie =
                                              infoSalarie;
                                        }
                                      });

                                      showSuccesDialog(
                                          context,
                                          GbsSystemStrings
                                              .str_operation_effectuer.tr);
                                    } else {
                                      widget.updateLoading(false);
                                    }
                                  });
                                } else {
                                  m.autovalidateMode = AutovalidateMode.always;
                                }
                              } catch (e) {
                                GBSystem_ManageCatchErrors().catchErrors(
                                    context,
                                    message: e.toString(),
                                    method: "updateAdresse",
                                    page: "adresse_widget");
                              }

                              // try {
                              //   if (m.formKey.currentState!.validate()) {
                              //     updateLoading(true);
                              //     await GBSystem_AuthService(context)
                              //         .updateAdresse(
                              //             salarie: salarie!,
                              //             adresse1: m.controllerAd1.value.text,
                              //             adresse2: m.controllerAd2.value.text)
                              //         .then((value) async {
                              //       if (value != null) {
                              //         final GBSystemSalarieController
                              //             salarieController =
                              //             Get.put(GBSystemSalarieController());

                              //         print(value.SVR_ADR1);
                              //         print(value.SVR_ADR2);
                              //         print(value.LAST_UPDT);
                              //         print(value.SVR_LATITUDE);
                              //         print(value.SVR_LONGITUDE);
                              //         print(value.VIL_LIB);

                              //         await GBSystem_AuthService(context)
                              //             .getInfoSalarie()
                              //             .then((infoSalarie) async {
                              //           updateLoading(false);
                              //           if (infoSalarie != null) {
                              //             print(infoSalarie
                              //                 .salarieModel.SVR_ADR1);
                              //             print(infoSalarie
                              //                 .salarieModel.SVR_ADR2);

                              //             print(infoSalarie
                              //                 .salarieModel.SVR_LATITUDE);
                              //             print(infoSalarie
                              //                 .salarieModel.SVR_LONGITUDE);
                              //             print(
                              //                 infoSalarie.salarieModel.VIL_LIB);
                              //             salarieController.setSalarie =
                              //                 infoSalarie;
                              //           }
                              //         });

                              //         showSuccesDialog(context,
                              //             GbsSystemStrings.str_dialog_succes);
                              //       } else {
                              //         updateLoading(false);
                              //       }
                              //     });
                              //   } else {
                              //     m.autovalidateMode = AutovalidateMode.always;
                              //   }
                              // } catch (e) {
                              //   GBSystem_ManageCatchErrors().catchErrors(
                              //       context,
                              //       message: e.toString(),
                              //       method: "updateAdresse",
                              //       page: "adresse_widget");
                              // }
                            },
                            horPadding: 20,
                            verPadding: 10,
                            textSize: 12,
                            text: GbsSystemStrings.str_valider.tr),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButtonWithLeading(
                              trailling: Icon(
                                CupertinoIcons.arrow_right,
                                color: Colors.white,
                                size: 12,
                              ),
                              onTap: widget.onSuivantTap,
                              horPadding: 10,
                              verPadding: 10,
                              textSize: 12,
                              text: GbsSystemStrings.str_suivant.tr),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 3,
            right: 13,
            child: CustomIconButton(
              onTap: widget.onSuivantTap,
              horPadding: 10,
              verPadding: 10,
              icon: Icon(
                CupertinoIcons.arrow_right,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
          Positioned(
            top: 3,
            left: 13,
            child: CustomIconButton(
              onTap: widget.onPrecedentTap,
              horPadding: 10,
              verPadding: 10,
              icon: Icon(
                CupertinoIcons.arrow_left,
                color: Colors.white,
                size: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
