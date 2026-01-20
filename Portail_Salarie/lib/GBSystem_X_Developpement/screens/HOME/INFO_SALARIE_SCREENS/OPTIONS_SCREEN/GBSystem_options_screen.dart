import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_de.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_en.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_es.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_fr.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_gr.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_pt.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_ro.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_tr.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/OPTIONS_SCREEN/GBSystem_options_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemOptionsScreen extends StatefulWidget {
  const GBSystemOptionsScreen({super.key, this.isCommingFromOut = false});

  final bool isCommingFromOut;

  @override
  State<GBSystemOptionsScreen> createState() => _GBSystemOptionsScreenState();
}

class _GBSystemOptionsScreenState extends State<GBSystemOptionsScreen> {
  @override
  Widget build(BuildContext context) {
    final m = Get.put<GBSystemOptionsScreenController>(
        GBSystemOptionsScreenController(context));
    return Obx(() => SafeArea(
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
                    GbsSystemStrings.str_changment_mot_de_passe.tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: widget.isCommingFromOut
                      ? InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.white,
                          ),
                        )
                      : Container(),
                ),
                body: Form(
                  key: m.formKey,
                  autovalidateMode: m.autovalidateMode,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.1),
                              vertical:
                                  GBSystem_ScreenHelper.screenHeightPercentage(
                                      context, 0.05)), //////),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: GBSystem_ScreenHelper
                                            .screenHeightPercentage(
                                                context, 0.02)),
                                    child: CustomTextField(
                                      controller: m.controllerOldPassword,
                                      text:
                                          GbsSystemStrings.str_old_password.tr,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            m.oldPasswordVisibility
                                                ? m.oldPasswordVisibility =
                                                    false
                                                : m.oldPasswordVisibility =
                                                    true;
                                          });
                                        },
                                        child: m.oldPasswordVisibility
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                      ),
                                      obscureText: !m.oldPasswordVisibility,
                                      validator: (data) {
                                        if (data == null || data.isEmpty) {
                                          return GbsSystemStrings
                                              .str_validat_svp_enter_password
                                              .tr;
                                        } else if (data.length < 6) {
                                          return GbsSystemStrings
                                              .str_validat_password_length.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: GBSystem_ScreenHelper
                                            .screenHeightPercentage(
                                                context, 0.02)),
                                    child: CustomTextField(
                                      controller: m.controllerNewPassword,
                                      text:
                                          GbsSystemStrings.str_new_password.tr,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            m.newPasswordVisibility
                                                ? m.newPasswordVisibility =
                                                    false
                                                : m.newPasswordVisibility =
                                                    true;
                                          });
                                        },
                                        child: m.newPasswordVisibility
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                      ),
                                      obscureText: !m.newPasswordVisibility,
                                      validator: (data) {
                                        if (m.newPasswordValidate == false) {
                                          return "";
                                        } else {
                                          return null;
                                        }

                                        // if (data == null || data.isEmpty) {
                                        //   return GbsSystemStrings
                                        //       .str_validat_svp_enter_password
                                        //       .tr;
                                        // } else if (data.length < 6) {
                                        //   return GbsSystemStrings
                                        //       .str_validat_password_length.tr;
                                        // } else {
                                        //   return null;
                                        // }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: GBSystem_ScreenHelper
                                            .screenHeightPercentage(
                                                context, 0.02)),
                                    child: FlutterPwValidator(
                                        strings:
                                            getTranslatValidator(Get.locale),
                                        successColor: Colors.green,
                                        failureColor: Colors.red,
                                        defaultColor:
                                            GbsSystemStrings.str_primary_color,
                                        controller: m.controllerNewPassword,
                                        minLength: 8,
                                        uppercaseCharCount: 1,
                                        lowercaseCharCount: 1,
                                        numericCharCount: 1,
                                        specialCharCount: 1,
                                        width:
                                            GBSystem_ScreenHelper.screenWidth(
                                                context),
                                        height: 190,
                                        onSuccess: () {
                                          m.newPasswordValidate.value = true;
                                        },
                                        onFail: () {
                                          m.newPasswordValidate.value = false;
                                        }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: GBSystem_ScreenHelper
                                            .screenHeightPercentage(
                                                context, 0.02)),
                                    child: CustomTextField(
                                      controller:
                                          m.controllerNewPasswordConfirmation,
                                      text: GbsSystemStrings
                                          .str_new_password_confirmation.tr,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            m.newPasswordConfirmationVisibility
                                                ? m.newPasswordConfirmationVisibility =
                                                    false
                                                : m.newPasswordConfirmationVisibility =
                                                    true;
                                          });
                                        },
                                        child:
                                            m.newPasswordConfirmationVisibility
                                                ? const Icon(Icons.visibility)
                                                : const Icon(
                                                    Icons.visibility_off),
                                      ),
                                      obscureText:
                                          !m.newPasswordConfirmationVisibility,
                                      validator: (data) {
                                        if (data == null || data.isEmpty) {
                                          return GbsSystemStrings
                                              .str_validat_svp_enter_password
                                              .tr;
                                        } else if (data.length < 6) {
                                          return GbsSystemStrings
                                              .str_validat_password_length.tr;
                                        } else if (data !=
                                            m.controllerNewPassword.text) {
                                          return GbsSystemStrings
                                              .str_validat_password_must_be_the_same
                                              .tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: GBSystem_ScreenHelper
                                        .screenHeightPercentage(context, 0.05)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomButton(
                                      horPadding: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.1),
                                      verPadding: GBSystem_ScreenHelper
                                          .screenHeightPercentage(
                                              context, 0.02),
                                      textSize: 18,
                                      textBold: true,
                                      text: GbsSystemStrings.str_valider.tr,
                                      onTap: () async {
                                        try {
                                          if (m.formKey.currentState!
                                              .validate()) {
                                            await m.changePassword();
                                          } else {
                                            m.autovalidateMode =
                                                AutovalidateMode.always;
                                          }
                                        } catch (e) {
                                          m.isLoading.value = false;
                                          GBSystem_ManageCatchErrors()
                                              .catchErrors(
                                                  context,
                                                  message: e.toString(),
                                                  method: "changePassword",
                                                  page:
                                                      "GBSystem_options_screen");
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              m.isLoading.value ? Waiting() : Container()
            ],
          ),
        ));
  }

  FlutterPwValidatorStrings? getTranslatValidator(Locale? myLocal) {
    if (myLocal?.languageCode == 'de') {
      return DutshStrings();
    } else if (myLocal?.languageCode == 'en') {
      return EnglishStrings();
    } else if (myLocal?.languageCode == 'es') {
      return EspagnolStrings();
    } else if (myLocal?.languageCode == 'fr') {
      return FrenchStrings();
    } else if (myLocal?.languageCode == 'gr') {
      return GrecStrings();
    } else if (myLocal?.languageCode == 'pt') {
      return PortugalStrings();
    } else if (myLocal?.languageCode == 'ro') {
      return RomanieStrings();
    } else if (myLocal?.languageCode == 'tr') {
      return TurkieStrings();
    } else {
      return FrenchStrings();
    }
  }
}
