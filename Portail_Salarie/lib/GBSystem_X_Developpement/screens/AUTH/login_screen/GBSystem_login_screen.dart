import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_Root_Params.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/AUTH/change_password_screen/GBSystem_change_password_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/AUTH/reset_password_screen/GBSystem_reset_password_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/entreprise_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_drop_down_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class GBSystemLoginScreen extends StatefulWidget {
  GBSystemLoginScreen({super.key});

  @override
  State<GBSystemLoginScreen> createState() => _GBSystemLoginScreenState();
}

class _GBSystemLoginScreenState extends State<GBSystemLoginScreen> {
  final m = Get.put<GBSystem_Login_controller>(GBSystem_Login_controller());
  @override
  void initState() {
    m.verifierExistUrlS19InitState();
    m.getCurrentLocale().then(
      (value) {
        m.selectedLanguage = RxString(value);
        m.selectedLanguage.value = value;
        Get.updateLocale(Locale(value));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Obx(
          () => SafeArea(
            child: Stack(
              children: [
                Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: Form(
                    key: m.formKey,
                    autovalidateMode: m.autovalidateMode,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: GBSystem_ScreenHelper.screenWidth(
                                      context),
                                  height: GBSystem_ScreenHelper
                                      .screenHeightPercentage(context, 0.3),
                                  decoration: const BoxDecoration(
                                    color: GbsSystemStrings.str_primary_color,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.2)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Transform.translate(
                                          offset: const Offset(-5, 0),
                                          child: Image.asset(
                                            GbsSystemServerStrings
                                                .str_logo_image_path,
                                            color: Colors.white,
                                            width: GBSystem_ScreenHelper
                                                .screenWidthPercentage(
                                                    context, 0.38),
                                            height: GBSystem_ScreenHelper
                                                .screenWidthPercentage(
                                                    context, 0.3),
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
                                      horizontal: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.1),
                                      vertical: GBSystem_ScreenHelper
                                          .screenHeightPercentage(
                                              context, 0.02)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: GBSystem_ScreenHelper
                                                .screenHeightPercentage(
                                                    context, 0.02)),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Obx(
                                                  () => InkWell(
                                                    onTap: () {
                                                      m.changeModeFunction(
                                                          context);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        GBSystem_TextHelper().normalText(
                                                            text: m.addSiteWebBool
                                                                    .value
                                                                ? GbsSystemStrings
                                                                    .str_mode_enregistrer_server
                                                                    .tr
                                                                : GbsSystemStrings
                                                                    .str_mode_identification
                                                                    .tr,
                                                            textColor:
                                                                GbsSystemStrings
                                                                    .str_primary_color,
                                                            fontWeight:
                                                                FontWeight.w500)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: m.canAuth.value,
                                                    child:
                                                        m.codeClientFieldVisibility
                                                                .value
                                                            ? CupertinoButton(
                                                                onPressed:
                                                                    () async {
                                                                  m.codeClientFieldVisibility
                                                                          .value =
                                                                      !m.codeClientFieldVisibility
                                                                          .value;
                                                                  String?
                                                                      currentClient =
                                                                      await EntrepriseService()
                                                                          .getCurrentClientName();
                                                                  if (currentClient !=
                                                                          null &&
                                                                      currentClient
                                                                          .isNotEmpty) {
                                                                    m.controllerCodeClient
                                                                            .text =
                                                                        currentClient;
                                                                  }
                                                                },
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                child: Stack(
                                                                  clipBehavior:
                                                                      Clip.none,
                                                                  children: [
                                                                    const Icon(Icons
                                                                        .replay_rounded),
                                                                    Positioned(
                                                                      top: 0,
                                                                      left: -10,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .visibility,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : CupertinoButton(
                                                                onPressed:
                                                                    () async {
                                                                  m.codeClientFieldVisibility
                                                                          .value =
                                                                      !m.codeClientFieldVisibility
                                                                          .value;

                                                                  String?
                                                                      currentClient =
                                                                      await EntrepriseService()
                                                                          .getCurrentClientName();
                                                                  if (currentClient !=
                                                                          null &&
                                                                      currentClient
                                                                          .isNotEmpty) {
                                                                    m.controllerCodeClient
                                                                            .text =
                                                                        currentClient;
                                                                  }
                                                                },
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                child: Stack(
                                                                  clipBehavior:
                                                                      Clip.none,
                                                                  children: [
                                                                    const Icon(Icons
                                                                        .replay_rounded),
                                                                    Positioned(
                                                                      top: 0,
                                                                      left: -10,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .visibility_off,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 2,
                                              color: GbsSystemStrings
                                                  .str_primary_color,
                                            )
                                          ],
                                        ),
                                      ),
                                      Obx(
                                        () => Visibility(
                                          visible:
                                              m.codeClientFieldVisibility.value,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.02)),
                                            child: CustomTextField(
                                                // // suffixIcon: TextButton(
                                                // //     onPressed: () {
                                                // //       if (m.validateCodeClient(
                                                // //           context,
                                                // //           m.controllerCodeClient
                                                // //               .text)) {
                                                // //         EntrepriseService()
                                                // //             .AccessUrlAndS19(
                                                // //                 context,
                                                // //                 agenceCode: m
                                                // //                     .controllerCodeClient
                                                // //                     .text)
                                                // //             .then(
                                                // //           (value) {
                                                // //             m.codeClientFieldVisibility
                                                // //                 .value = false;
                                                // //           },
                                                // //         );
                                                // //       } else {}
                                                // //     },
                                                //     child: GBSystem_TextHelper()
                                                //         .smallText(
                                                //             text:
                                                //                 GbsSystemStrings
                                                //                     .str_ok.tr,
                                                //             textColor:
                                                //                 GbsSystemServerStrings
                                                //                     .str_primary_color)),
                                                controller:
                                                    m.controllerCodeClient,
                                                keyboardType:
                                                    TextInputType.text,
                                                text: GbsSystemStrings
                                                    .str_code_entreprise.tr),
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Visibility(
                                            visible: m.codeClientFieldVisibility
                                                .value,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                CustomButton(
                                                    onTap: () async {
                                                      bool alreadyHasUrl = await m
                                                          .verifierExistUrlS19();
                                                      if (alreadyHasUrl) {
                                                        showWarningSnackBar(
                                                          context,
                                                          GbsSystemStrings
                                                              .str_are_you_sure_want_change_entreprise,
                                                          () {
                                                            if (m.validateCodeClient(
                                                                context,
                                                                m.controllerCodeClient
                                                                    .text)) {
                                                              EntrepriseService()
                                                                  .AccessUrlAndS19(
                                                                      context,
                                                                      agenceCode: m
                                                                          .controllerCodeClient
                                                                          .text)
                                                                  .then(
                                                                (value) {
                                                                  //boubaker 13/01/2025 6146_2025_01_08_APK_Portail_salarie_affichage_ecran_code_entreprise_si_code_incorrect.mp4
                                                                  if (value) {
                                                                    m.codeClientFieldVisibility
                                                                            .value =
                                                                        false;
                                                                    m.canAuth
                                                                            .value =
                                                                        true;
                                                                  }
                                                                },
                                                              );
                                                            } else {}
                                                          },
                                                        );
                                                      } else {
                                                        if (m.validateCodeClient(
                                                            context,
                                                            m.controllerCodeClient
                                                                .text)) {
                                                          EntrepriseService()
                                                              .AccessUrlAndS19(
                                                                  context,
                                                                  agenceCode: m
                                                                      .controllerCodeClient
                                                                      .text)
                                                              .then(
                                                            (value) {
                                                              //boubaker 13/01/2025 6146_2025_01_08_APK_Portail_salarie_affichage_ecran_code_entreprise_si_code_incorrect.mp4
                                                              if (value) {
                                                                m.codeClientFieldVisibility
                                                                        .value =
                                                                    false;
                                                                m.canAuth
                                                                        .value =
                                                                    true;
                                                              }
                                                            },
                                                          );
                                                        } else {}
                                                      }
                                                    },
                                                    horPadding: 10,
                                                    verPadding: 10,
                                                    text: GbsSystemStrings
                                                        .str_valider.tr),
                                              ],
                                            )),
                                      ),
                                      Visibility(
                                        visible:
                                            !m.codeClientFieldVisibility.value,
                                        child: Column(
                                          children: [
                                            Obx(
                                              () => Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: GBSystem_ScreenHelper
                                                        .screenHeightPercentage(
                                                            context, 0.02)),
                                                child: CustomTextField(
                                                    enabled: !m
                                                        .codeClientFieldVisibility
                                                        .value,
                                                    focusNode: m
                                                        .textFieldFocusNodeEmail,
                                                    controller:
                                                        m.controllerEmail,
                                                    validator: m.addSiteWebBool
                                                            .value
                                                        ? (data) {
                                                            String urlPattern =
                                                                GbsSystemStrings
                                                                    .str_validator_site_web;
                                                            bool match = RegExp(
                                                                    urlPattern,
                                                                    caseSensitive:
                                                                        false)
                                                                .hasMatch(
                                                                    data ?? "");

                                                            if (data == null ||
                                                                data.isEmpty) {
                                                              return GbsSystemStrings
                                                                  .str_validat_svp_enter_site
                                                                  .tr;
                                                            } else if (!match) {
                                                              return GbsSystemStrings
                                                                  .str_validat_svp_enter_site_valide
                                                                  .tr;
                                                            } else {
                                                              return null;
                                                            }
                                                          }
                                                        : (data) {
                                                            if (data == null ||
                                                                data.isEmpty) {
                                                              return GbsSystemStrings
                                                                  .str_validat_svp_enter_mail
                                                                  .tr;
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    text: m.addSiteWebBool.value
                                                        ? GbsSystemStrings
                                                            .str_site.tr
                                                        : GbsSystemStrings
                                                            .str_mail.tr),
                                              ),
                                            ),
                                            Obx(
                                              () => CustomTextField(
                                                enabled: !m
                                                    .codeClientFieldVisibility
                                                    .value,
                                                focusNode: m
                                                    .textFieldFocusNodePassword,
                                                controller:
                                                    m.controllerPassword,
                                                text: m.addSiteWebBool.value
                                                    ? GbsSystemStrings.str_s19
                                                    : GbsSystemStrings
                                                        .str_password.tr,
                                                suffixIcon: m
                                                        .addSiteWebBool.value
                                                    ? null
                                                    : GestureDetector(
                                                        onTap: () {
                                                          m.passwordVisibility
                                                                  .value
                                                              ? m.passwordVisibility
                                                                  .value = false
                                                              : m.passwordVisibility
                                                                  .value = true;
                                                        },
                                                        child: m.passwordVisibility
                                                                .value
                                                            ? const Icon(Icons
                                                                .visibility)
                                                            : const Icon(Icons
                                                                .visibility_off),
                                                      ),
                                                obscureText:
                                                    m.addSiteWebBool.value
                                                        ? false
                                                        : !m.passwordVisibility
                                                            .value,
                                                validator: m
                                                        .addSiteWebBool.value
                                                    ? (data) {
                                                        return null;
                                                      }
                                                    : (data) {
                                                        if (data == null ||
                                                            data.isEmpty) {
                                                          return GbsSystemStrings
                                                              .str_validat_svp_enter_password
                                                              .tr;
                                                        } else if (data.length <
                                                            8) {
                                                          return GbsSystemStrings
                                                              .str_validat_password_length
                                                              .tr;
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: !m.codeClientFieldVisibility.value,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: GBSystem_ScreenHelper
                                                .screenWidthPercentage(
                                                    context, 0.1)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                    GBSystemResetPasswordScreen());
                                              },
                                              child: SizedBox(
                                                width: GBSystem_ScreenHelper
                                                    .screenWidthPercentage(
                                                        context, 0.4),
                                                child: Text(
                                                  GbsSystemStrings
                                                      .str_mot_de_passe_oublier
                                                      .tr,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: GbsSystemStrings
                                                          .str_primary_color),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                    GBSystemChangePasswordScreen(
                                                  email: m.controllerEmail.text,
                                                ));
                                              },
                                              child: SizedBox(
                                                width: GBSystem_ScreenHelper
                                                    .screenWidthPercentage(
                                                        context, 0.4),
                                                child: Text(
                                                  GbsSystemStrings
                                                      .str_change_password.tr,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: GbsSystemStrings
                                                          .str_primary_color),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: GBSystem_ScreenHelper
                                            .screenHeightPercentage(
                                                context, 0.02),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: GBSystem_ScreenHelper
                                                .screenWidthPercentage(
                                                    context, 0.1)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(
                                              () =>
                                                  CustomDropDownSelectLanguage(
                                                selectedItem:
                                                    m.selectedLanguage.value,
                                                onChanged: (p0) {
                                                  m.selectedLanguage.value =
                                                      p0!;
                                                  Get.updateLocale(Locale(p0));
                                                  m.changeSharedPerfermenceLocal(
                                                      p0);
                                                },
                                              ),
                                            ),
                                            CustomButton(
                                              horPadding: GBSystem_ScreenHelper
                                                  .screenWidthPercentage(
                                                      context, 0.1),
                                              verPadding: GBSystem_ScreenHelper
                                                  .screenHeightPercentage(
                                                      context, 0.02),
                                              textSize: 18,
                                              textBold: true,
                                              text: GbsSystemStrings
                                                  .str_connexion.tr,
                                              onTap: m.addSiteWebBool.value
                                                  ? () async {
                                                      await m
                                                          .enregistrerServerFunction(
                                                              context);
                                                    }
                                                  : () async {
                                                      await m.loginFunction(
                                                          context);
                                                    },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !m.textFieldFocusNodeEmail.hasFocus &&
                              !m.textFieldFocusNodePassword.hasFocus,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: GBSystem_ScreenHelper
                                        .screenHeightPercentage(context, 0.02)),
                                child: GBSystem_TextHelper().smallText(
                                    text:
                                        "${GbsSystemStrings.str_droits_reserved_part_1} ${DateTime.now().year} ${GbsSystemStrings.str_droits_reserved_part_2.tr}",
                                    textColor:
                                        GbsSystemStrings.str_primary_color)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                m.loading.value ? Waiting() : Container()
              ],
            ),
          ),
        ));
  }
}
