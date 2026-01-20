import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_Root_Params.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_de.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_en.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_es.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_fr.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_gr.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_pt.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_ro.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/validator_languages/validator_tr.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/AUTH/change_password_screen/GBSystem_change_password_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/APP_BAR/custom_app_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class GBSystemChangePasswordScreen extends StatefulWidget {
  const GBSystemChangePasswordScreen({super.key, required this.email});
  final String? email;
  @override
  State<GBSystemChangePasswordScreen> createState() =>
      _GBSystemChangePasswordScreenState();
}

class _GBSystemChangePasswordScreenState
    extends State<GBSystemChangePasswordScreen> {
  @override
  void initState() {
    controllerEmail.text = widget.email ?? "";
    super.initState();
  }

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerOldPassword = TextEditingController();
  TextEditingController controllerNewPassword = TextEditingController();
  TextEditingController controllerNewPasswordConfirmation =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final m = Get.put<GBSystemChangePasswordController>(
        GBSystemChangePasswordController(context));

    return Obx(() => SafeArea(
          child: Stack(
            children: [
              Scaffold(
                extendBodyBehindAppBar: true,
                appBar: CustomAppBar(
                  leadingIcon: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.black,
                  ),
                  onLeadingTap: () {
                    Get.back();
                  },
                ),
                resizeToAvoidBottomInset: false,
                body: Form(
                  key: m.formKey,
                  autovalidateMode: m.autovalidateMode,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: GBSystem_ScreenHelper.screenWidth(context),
                          height: GBSystem_ScreenHelper.screenHeightPercentage(
                              context, 0.3),
                          decoration: const BoxDecoration(
                            color: GbsSystemStrings.str_primary_color,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.2)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.translate(
                                  offset: const Offset(-5, 0),
                                  child: Image.asset(
                                    GbsSystemServerStrings.str_logo_image_path,
                                    color: Colors.white,
                                    width: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.4),
                                    height: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.3),
                                  ),
                                ),
                                GBSystem_TextHelper().largeText(
                                  text: ActiveApplication_Params.Title,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ),
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: GBSystem_ScreenHelper
                                        .screenHeightPercentage(
                                            context, 0.01)), ////
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          GbsSystemStrings
                                              .str_change_password.tr,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: GbsSystemStrings
                                                  .str_primary_color),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 2,
                                      color: GbsSystemStrings.str_primary_color,
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: GBSystem_ScreenHelper
                                            .screenHeightPercentage(
                                                context, 0.02)),
                                    child: CustomTextField(
                                        controller: controllerEmail,
                                        validator: (data) {
                                          if (data == null || data.isEmpty) {
                                            return GbsSystemStrings
                                                .str_validat_svp_enter_mail.tr;
                                          } else if (!RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(data)) {
                                            return GbsSystemStrings
                                                .str_validat_svp_enter_site_valide
                                                .tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        text: GbsSystemStrings.str_mail.tr),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: GBSystem_ScreenHelper
                                            .screenHeightPercentage(
                                                context, 0.02)),
                                    child: CustomTextField(
                                      controller: controllerOldPassword,
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
                                      controller: controllerNewPassword,
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
                                        controller: controllerNewPassword,
                                        minLength: 8,
                                        uppercaseCharCount: 1,
                                        lowercaseCharCount: 1,
                                        numericCharCount: 1,
                                        specialCharCount: 1,
                                        width:
                                            GBSystem_ScreenHelper.screenWidth(
                                                context),
                                        height: 170,
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
                                          controllerNewPasswordConfirmation,
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
                                            controllerNewPassword.text) {
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
                                      text: GbsSystemStrings.str_ok.tr,
                                      onTap: () async {
                                        if (m.formKey.currentState!
                                            .validate()) {
                                          await m.changePassword(
                                              ancientPass:
                                                  controllerOldPassword.text,
                                              mail: controllerEmail.text,
                                              newPass:
                                                  controllerNewPassword.text,
                                              newPassConf:
                                                  controllerNewPasswordConfirmation
                                                      .text);
                                        } else {
                                          m.autovalidateMode =
                                              AutovalidateMode.always;
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
