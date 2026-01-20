import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/TELEPHONE_WIDGET/telephone_widget_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class TelephoneWidget extends StatelessWidget {
  const TelephoneWidget(
      {super.key,
      required this.salarie,
      this.onSuivantTap,
      this.onValideTap,
      this.onPrecedentTap,
      this.onValideServerTap,
      required this.updateLoading});

  final GBSystemSalarieWithPhotoModel? salarie;
  final void Function()? onSuivantTap,
      onValideTap,
      onPrecedentTap,
      onValideServerTap;
  final Function(bool) updateLoading;

  @override
  Widget build(BuildContext context) {
    final TelephoneWidgetController m =
        Get.put(TelephoneWidgetController(salarie: salarie));

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
                      () => CustomTextField(
                        keyboardType: TextInputType.phone,
                        controller: m.controllerTel1.value,
                        text: GbsSystemStrings.str_telephone.tr + " 1",
                        enabled: true,
                      ),
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    Obx(
                      () => CustomTextField(
                        keyboardType: TextInputType.phone,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return GbsSystemStrings.str_field_required;
                          } else {
                            return null;
                          }
                        },
                        controller: m.controllerPortabl.value,
                        text: GbsSystemStrings.str_portable.tr,
                        enabled: true,
                      ),
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                            enabled: (m.salarieController.getSalarie
                                    ?.salarieModel.CLIENT_ID ==
                                "1"),
                            color: Colors.green,
                            onTap: () async {
                              try {
                                if (m.formKey.currentState!.validate()) {
                                  updateLoading(true);
                                  await GBSystem_AuthService(context)
                                      .updateTelephoneNew(
                                          newPortable:
                                              m.controllerPortabl.value.text,
                                          newTelephone:
                                              m.controllerTel1.value.text)
                                      .then((value) async {
                                    updateLoading(false);
                                    if (value) {
                                      final GBSystemSalarieController
                                          salarieController =
                                          Get.put(GBSystemSalarieController());

                                      await GBSystem_AuthService(context)
                                          .getInfoSalarie()
                                          .then((infoSalarie) async {
                                        updateLoading(false);
                                        if (infoSalarie != null) {
                                          salarieController.setSalarie =
                                              infoSalarie;
                                        }
                                      });

                                      m.showSecondPart.value = true;

                                      showSuccesDialog(
                                          context,
                                          GbsSystemStrings
                                              .str_operation_effectuer.tr);
                                    } else {
                                      updateLoading(false);
                                    }
                                  });
                                } else {
                                  m.autovalidateMode = AutovalidateMode.always;
                                }
                              } catch (e) {
                                GBSystem_ManageCatchErrors().catchErrors(
                                    context,
                                    message: e.toString(),
                                    method: "updateTelephone",
                                    page: "telephone_widget");
                              }
                            },
                            horPadding: 10,
                            verPadding: 10,
                            textSize: 12,
                            text: GbsSystemStrings.str_valider.tr),
                      ],
                    ),
                    Obx(
                      () => Visibility(
                        visible: m.showSecondPart.value,
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  GBSystem_ScreenHelper.screenHeightPercentage(
                                      context, 0.02),
                            ),
                            Obx(
                              () => CustomTextField(
                                onChanged: (p0) {
                                  if (p0.length >= 6) {
                                    m.enabledBtn.value = true;
                                  } else {
                                    m.enabledBtn.value = false;
                                  }
                                },
                                controller: m.controllerSMS.value,
                                text: GbsSystemStrings.str_code_sms.tr,
                                enabled: true,
                              ),
                            ),
                            SizedBox(
                              height:
                                  GBSystem_ScreenHelper.screenHeightPercentage(
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
                                      onTap: onPrecedentTap,
                                      textSize: 12,
                                      horPadding: 10,
                                      verPadding: 10,
                                      text: GbsSystemStrings.str_precedent.tr),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Obx(
                                  () => CustomButton(
                                      enabled: !(m.enabledBtn.value) ||
                                          (m.salarieController.getSalarie
                                                  ?.salarieModel.CLIENT_ID ==
                                              "1"),
                                      onTap: () async {
                                        try {
                                          if (m.formKey.currentState!
                                              .validate()) {
                                            updateLoading(true);
                                            await GBSystem_AuthService(context)
                                                .valideSMSTelephoneNew(
                                              SMSCode:
                                                  m.controllerSMS.value.text,
                                            )
                                                .then((value) {
                                              updateLoading(false);
                                              if (value) {
                                                showSuccesDialog(
                                                    context,
                                                    GbsSystemStrings
                                                        .str_operation_effectuer
                                                        .tr);
                                              }
                                            });
                                          } else {
                                            m.autovalidateMode =
                                                AutovalidateMode.always;
                                          }
                                        } catch (e) {
                                          GBSystem_ManageCatchErrors()
                                              .catchErrors(context,
                                                  message: e.toString(),
                                                  method: "validSMSTelephone",
                                                  page: "telephone_widget");
                                        }
                                      },
                                      color: Colors.green,
                                      horPadding: 20,
                                      verPadding: 10,
                                      textSize: 12,
                                      text: GbsSystemStrings.str_valider.tr),
                                ),
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
                                      onTap: onSuivantTap,
                                      horPadding: 10,
                                      verPadding: 10,
                                      textSize: 12,
                                      text: GbsSystemStrings.str_suivant.tr),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 3,
            right: 13,
            child: CustomIconButton(
              onTap: onSuivantTap,
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
              onTap: onPrecedentTap,
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
