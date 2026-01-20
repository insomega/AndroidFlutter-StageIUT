import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_Root_Params.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/SELECT_ITEM_AGENCE/GBSystem_select_item_agence_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/entreprise_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/GBSystem_custom_button.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/GBSystem_custom_text_field.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GBSystemLoginScreen extends StatefulWidget {
  GBSystemLoginScreen({super.key});

  @override
  State<GBSystemLoginScreen> createState() => _GBSystemLoginScreenState();
}

class _GBSystemLoginScreenState extends State<GBSystemLoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    final m = Get.put<GBSystem_Login_controller>(
        GBSystem_Login_controller(formKey: formKey));
    m.verifierExistUrlS19InitState();
    super.initState();
  }

  RxBool loadingBtn = RxBool(false);
  @override
  Widget build(BuildContext context) {
    final m = Get.put<GBSystem_Login_controller>(
        GBSystem_Login_controller(formKey: formKey));

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
                                    color: GbsSystemServerStrings
                                        .str_primary_color,
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
                                                    context, 0.4),
                                            height: GBSystem_ScreenHelper
                                                .screenWidthPercentage(
                                                    context, 0.3),
                                          ),
                                        ),
                                        Flexible(
                                          child:
                                              GBSystem_TextHelper().largeText(
                                            text:
                                                ActiveApplication_Params.Title,
                                            textColor: Colors.white,
                                            maxLines: 2,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                                                : GbsSystemStrings
                                                                    .str_mode_identification,
                                                            textColor:
                                                                GbsSystemServerStrings
                                                                    .str_primary_color,
                                                            fontWeight:
                                                                FontWeight.w500)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                m.codeClientFieldVisibility
                                                        .value
                                                    ? CupertinoButton(
                                                        onPressed: () async {
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
                                                            EdgeInsets.zero,
                                                        child: Stack(
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            const Icon(Icons
                                                                .replay_rounded),
                                                            Positioned(
                                                              top: 0,
                                                              left: -10,
                                                              child: Icon(
                                                                Icons
                                                                    .visibility,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : CupertinoButton(
                                                        onPressed: () async {
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
                                                            EdgeInsets.zero,
                                                        child: Stack(
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            const Icon(Icons
                                                                .replay_rounded),
                                                            Positioned(
                                                              top: 0,
                                                              left: -10,
                                                              child: Icon(
                                                                Icons
                                                                    .visibility_off,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 2,
                                              color: GbsSystemServerStrings
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
                                                SizedBox(
                                                  width: 120,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
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
                                                              loadingBtn.value =
                                                                  true;
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
                                                                  }
                                                                },
                                                              );
                                                              loadingBtn.value =
                                                                  false;
                                                            } else {}
                                                          },
                                                        );
                                                      } else {
                                                        if (m.validateCodeClient(
                                                            context,
                                                            m.controllerCodeClient
                                                                .text)) {
                                                          loadingBtn.value =
                                                              true;
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
                                                              }
                                                            },
                                                          );
                                                          loadingBtn.value =
                                                              false;
                                                        } else {}
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize:
                                                          const Size(100, 50),
                                                      backgroundColor:
                                                          GbsSystemServerStrings
                                                              .str_primary_color,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: Obx(
                                                      () => loadingBtn.value
                                                          ? SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          : const Text(
                                                              GbsSystemStrings
                                                                  .str_valider,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  letterSpacing:
                                                                      1,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                // CustomButton(
                                                //     isLoading: m.loading.value,
                                                //     onTap: () async {
                                                //       bool alreadyHasUrl = await m
                                                //           .verifierExistUrlS19();
                                                //       if (alreadyHasUrl) {
                                                //         showWarningSnackBar(
                                                //           context,
                                                //           GbsSystemStrings
                                                //               .str_are_you_sure_want_change_entreprise,
                                                //           () {
                                                //             if (m.validateCodeClient(
                                                //                 context,
                                                //                 m.controllerCodeClient
                                                //                     .text)) {
                                                //               m.loading.value =
                                                //                   true;
                                                //               EntrepriseService()
                                                //                   .AccessUrlAndS19(
                                                //                       context,
                                                //                       agenceCode: m
                                                //                           .controllerCodeClient
                                                //                           .text)
                                                //                   .then(
                                                //                 (value) {
                                                //                   //boubaker 13/01/2025 6146_2025_01_08_APK_Portail_salarie_affichage_ecran_code_entreprise_si_code_incorrect.mp4
                                                //                   if (value) {
                                                //                     m.codeClientFieldVisibility
                                                //                             .value =
                                                //                         false;
                                                //                   }
                                                //                 },
                                                //               );
                                                //               m.loading.value =
                                                //                   false;
                                                //             } else {}
                                                //           },
                                                //         );
                                                //       } else {
                                                //         if (m.validateCodeClient(
                                                //             context,
                                                //             m.controllerCodeClient
                                                //                 .text)) {
                                                //           m.loading.value =
                                                //               true;
                                                //           EntrepriseService()
                                                //               .AccessUrlAndS19(
                                                //                   context,
                                                //                   agenceCode: m
                                                //                       .controllerCodeClient
                                                //                       .text)
                                                //               .then(
                                                //             (value) {
                                                //               //boubaker 13/01/2025 6146_2025_01_08_APK_Portail_salarie_affichage_ecran_code_entreprise_si_code_incorrect.mp4
                                                //               if (value) {
                                                //                 m.codeClientFieldVisibility
                                                //                         .value =
                                                //                     false;
                                                //               }
                                                //             },
                                                //           );
                                                //           m.loading.value =
                                                //               false;
                                                //         } else {}
                                                //       }
                                                //     },
                                                //     horPadding: 10,
                                                //     verPadding: 10,
                                                //     text: GbsSystemStrings
                                                //         .str_valider.tr),
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
                                                                  .str_validat_svp_enter_site;
                                                            } else if (!match) {
                                                              return GbsSystemStrings
                                                                  .str_validat_svp_enter_site_valide;
                                                            } else {
                                                              return null;
                                                            }
                                                          }
                                                        : (data) {
                                                            if (data == null ||
                                                                data.isEmpty) {
                                                              return GbsSystemStrings
                                                                  .str_validat_svp_enter_mail;
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    text: m.addSiteWebBool.value
                                                        ? GbsSystemStrings
                                                            .str_site
                                                        : GbsSystemStrings
                                                            .str_mail),
                                              ),
                                            ),
                                            Obx(
                                              () => CustomTextField(
                                                focusNode: m
                                                    .textFieldFocusNodePassword,
                                                controller:
                                                    m.controllerPassword,
                                                text: m.addSiteWebBool.value
                                                    ? GbsSystemStrings.str_s19
                                                    : GbsSystemStrings
                                                        .str_password,
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
                                                              .str_validat_svp_enter_password;
                                                        } else if (data.length <
                                                            8) {
                                                          return GbsSystemStrings
                                                              .str_validat_password_length;
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                              ),
                                            ),
                                            Visibility(
                                              visible: ActiveApplication_Params
                                                      .appNumber !=
                                                  1,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: GBSystem_ScreenHelper
                                                            .screenHeightPercentage(
                                                                context, 0.05),
                                                        bottom: GBSystem_ScreenHelper
                                                            .screenHeightPercentage(
                                                                context, 0.01)),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            GBSystem_TextHelper().normalText(
                                                                text: GbsSystemStrings
                                                                    .str_type_connexion_agence,
                                                                textColor:
                                                                    GbsSystemServerStrings
                                                                        .str_primary_color,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)
                                                          ],
                                                        ),
                                                        const Divider(
                                                          thickness: 2,
                                                          color: GbsSystemServerStrings
                                                              .str_primary_color,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      if (m
                                                          .formKey.currentState!
                                                          .validate()) {
                                                        m.loading.value = true;
                                                        await GBSystem_AuthService(
                                                                context)
                                                            .getAllAgences(
                                                          email: m
                                                              .controllerEmail
                                                              .text,
                                                          password: m
                                                              .controllerPassword
                                                              .text,
                                                        )
                                                            .then((value) {
                                                          m.loading.value =
                                                              false;

                                                          if (value != null) {
                                                            final GBSystemAgenceQuickAccessController
                                                                agenceQuickAccessController =
                                                                Get.put(
                                                                    GBSystemAgenceQuickAccessController());

                                                            agenceQuickAccessController
                                                                    .setAllAgence =
                                                                value;
                                                            WidgetsBinding
                                                                .instance
                                                                .addPostFrameCallback(
                                                                    (_) {
                                                              Get.to(
                                                                  GBSystem_SelectItemAgenceScreen(
                                                                controllerTxtField:
                                                                    m.controllerAgence,
                                                              ));
                                                            });
                                                          }
                                                        });
                                                      } else {
                                                        setState(() {
                                                          m.autovalidateMode =
                                                              AutovalidateMode
                                                                  .always;
                                                        });
                                                      }
                                                    },
                                                    child: CustomTextField(
                                                        controller:
                                                            m.controllerAgence,
                                                        enabled: false,
                                                        text: GbsSystemStrings
                                                            .str_acces_direct),
                                                  ),
                                                ],
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
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.1)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButton(
                                          horPadding: GBSystem_ScreenHelper
                                              .screenWidthPercentage(
                                                  context, 0.1),
                                          verPadding: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.02),
                                          textSize: 18,
                                          textBold: true,
                                          text: GbsSystemStrings.str_ok,
                                          onTap: m.addSiteWebBool.value
                                              ? () async {
                                                  await m
                                                      .enregistrerServerFunction(
                                                          context);
                                                }
                                              : () async {
                                                  ActiveApplication_Params
                                                              .appNumber ==
                                                          1
                                                      ? await m.loginFunction(
                                                          context)
                                                      : ActiveApplication_Params
                                                                  .appNumber ==
                                                              2
                                                          ? await m
                                                              .loginFunctionPlanning(
                                                                  context)
                                                          : ActiveApplication_Params
                                                                      .appNumber ==
                                                                  3
                                                              ? await m
                                                                  .loginFunctionQuickAccess(
                                                                      context)
                                                              : await m
                                                                  .loginFunctionGestionDeStock(
                                                                      context);
                                                },
                                        )
                                      ],
                                    ),
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
                                    text: GbsSystemStrings.str_droits_reserved,
                                    textColor: GbsSystemServerStrings
                                        .str_primary_color)),
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
