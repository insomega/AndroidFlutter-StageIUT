import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:gbsystem_root/GBSystem_Root_Params.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
//import 'package:gbsystem_root/GBSystem_waiting.dart';
//import 'package:gbsystem_root/GBSystem_change_password_screen.dart';
//import 'package:gbsystem_root/GBSystem_login_controller.dart';
//import 'package:gbsystem_root/GBSystem_reset_password_screen.dart';
//import 'package:gbsystem_root/entreprise_service.dart';
import 'package:gbsystem_root/custom_button.dart';
import 'package:gbsystem_root/GBSystem_Root_Params.dart';
import 'package:gbsystem_root/custom_drop_down_button.dart';
import 'package:gbsystem_root/GBSystem_custom_text_field.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import './GBSystem_Login_Controller.dart';
//import '../GBSystem_Application/Routes/GBSystem_Application_Routes.dart';
import 'package:gbsystem_root/GBSystem_TextField_Email.dart';
import 'package:gbsystem_root/GBSystem_TextField_Password.dart';
import 'package:gbsystem_lookup/GBSystem_Dossier_Lookup.dart';

class GBSystem_Login_View extends GetView<GBSystem_Login_Controller> {
  const GBSystem_Login_View({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: true,
                body: Form(
                  key: controller.formKey,
                  autovalidateMode: controller.autovalidateMode.value,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, //
                            children: [
                              _buildHeaderSection(context), //
                              _buildLoginForm(context),
                              _buildFooterSection(context),
                            ],
                          ),
                        ),
                      ),
                      _buildCopyrightFooter(context),
                    ],
                  ),
                ),
              ),

              // ✅ Observer et afficher un succès si applicable
              Obx(() {
                final msg = controller.Succes_Message.value;
                if (msg != null) {
                  Future.delayed(Duration.zero, () {
                    showSuccesDialog(msg);
                    controller.Succes_Message.value = null; // reset après affichage
                  });
                }
                return const SizedBox.shrink();
              }),
              //  Observer et afficher un succès si applicable
              Obx(() {
                final msg = controller.Error_Message.value;
                if (msg != null) {
                  Future.delayed(Duration.zero, () {
                    showErrorDialog(msg);
                    controller.Error_Message.value = null; // reset après affichage
                  });
                }
                return const SizedBox.shrink();
              }),

              //avoir  if (controller.loading.value) Waiting(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    final AppParams = GBSystem_Application_Params_Manager.instance;
    return Container(
      width: GBSystem_ScreenHelper.screenWidth(context),
      height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.3),
      decoration: const BoxDecoration(color: GBSystem_Application_Strings.str_primary_color),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(-5, 0),
              child: Image.asset(
                GBSystem_System_Strings.str_logo_image_path, //
                color: Colors.white,
                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.38),
                height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.3),
              ),
            ),
            GBSystem_TextHelper().largeText(text: AppParams.Title, textColor: Colors.white, fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.1), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //
        children: [
          _buildModeSwitchRow(context), //
          _build_CodeEntreprise_Field(),
          _buildAuthFields(context),
        ],
      ),
    );
  }

  Widget _buildModeSwitchRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.00000000000002)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //
            children: [
              _buildModeSwitchButton(), //
              _build_CodeEntreprise_VisibilityToggle(),
            ],
          ),
          const Divider(thickness: 2, color: GBSystem_Application_Strings.str_primary_color),
        ],
      ),
    );
  }

  // Widget _buildModeSwitchButton() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       GBSystem_TextHelper().normalText(
  //         text: GBSystem_Application_Strings.str_mode_identification.tr, //
  //         textColor: GBSystem_Application_Strings.str_primary_color,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ],
  //   );
  // }
  Widget _buildModeSwitchButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: controller.incrementIdentificationTap,
          child: GBSystem_TextHelper().normalText(
            text: GBSystem_Application_Strings.str_mode_identification.tr, //
            textColor: GBSystem_Application_Strings.str_primary_color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _build_CodeEntreprise_VisibilityToggle() {
    return Obx(() {
      bool aVisibility = controller.CodeEntreprise_Visibility.value;

      return CupertinoButton(
        onPressed: controller.Change_CodeEntreprise_Visibility,
        padding: EdgeInsets.zero,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.replay_rounded),
            Positioned(top: 0, left: -10, child: Icon(aVisibility ? Icons.visibility : Icons.visibility_off, size: 15)),
          ],
        ),
      );
    });
  }

  Widget _build_CodeEntreprise_Field() {
    return Obx(() {
      if (!controller.CodeEntreprise_Visibility.value) return const SizedBox.shrink();

      return Padding(
        padding: EdgeInsets.only(bottom: GBSystem_ScreenHelper.screenHeightPercentage(Get.context!, 0.02)),
        child: Column(
          children: [
            CustomTextField(
              controller: controller.CodeEntreprise_Controller, //
              keyboardType: TextInputType.text,
              text: GBSystem_Application_Strings.str_code_entreprise.tr,
            ),
            const SizedBox(height: 12), // <- Espace ajouté
            _buildValidate_CodeEntreprise_Button(),
          ],
        ),
      );
    });
  }

  Widget _buildValidate_CodeEntreprise_Button() {
    return GBSystem_SubmitButton(Get.context!, controller.CodeEntreprise_DoValidation, GBSystem_Application_Strings.str_valider.tr);
  }

  // void _validate_CodeEntreprise_() {
  //   bool alreadyHasUrl = controller.verifierExistUrlS19();
  //   bool url_updated = controller.CodeEntreprise_Exists_and_Updated();

  //   if (alreadyHasUrl) {
  //     if (url_updated) {
  //       showWarningSnackBar(
  //         GBSystem_Application_Strings.str_are_you_sure_want_change_entreprise, //
  //         btnOkOnPress: () => _CodeEntreprise_DoValidation(),
  //         btnCancelOnPress: () => controller.Change_CodeEntreprise_Visibility(),
  //       );
  //     } else {
  //       controller.Change_CodeEntreprise_Visibility();
  //     }
  //   } else {
  //     _CodeEntreprise_DoValidation();
  //   }
  // }

  // Future<void> _CodeEntreprise_DoValidation() async {
  //   await controller.CodeEntreprise_DoValidation();
  // }

  Widget _buildAuthFields(BuildContext context) {
    return Obx(() {
      if (controller.CodeEntreprise_Visibility.value) return const SizedBox.shrink();

      return Column(
        children: [
          _buildEmailField(), //
          _buildPasswordField(),

          _buildPasswordActions(context),
          _buildDossierField(),
          _buildLoginActions(context),
          _buildNfcLoginButton(context), // Nouveau bouton NFC
        ],
      );
    });
  }

  Widget _buildNfcLoginButton(BuildContext context) {
    if (GBSystem_Application_Params_Manager.instance.ReadingNfc_Identifacation) {
      return Obx(() {
        return IconButton(
          icon: Icon(Icons.nfc, color: controller.isReadingNfc.value ? Colors.grey : GBSystem_Application_Strings.str_primary_color, size: 32),
          onPressed: controller.isReadingNfc.value ? null : controller.startNfcAuthentication,
          tooltip: GBSystem_Application_Strings.str_waiting_for_tag.tr,
        );
      });
    }
    return SizedBox(height: 0);
  }

  Widget _buildDossierField() {
    if (GBSystem_Application_Params_Manager.instance.SelectUserDossier) {
      return GBSystem_Dossier_Lookup_TextField(
        controllerLookup: controller.dossierLookupController,
        //
        // controllerEmail: controller.controllerEmail,
        // controllerPassword: controller.controllerPassword,
      );
    }
    return SizedBox(height: 0);
  }

  Widget _buildEmailField() {
    return GBSystem_TextField_Email(
      controller: controller.controllerEmail, //
      focusnode: controller.textFieldFocusNodeEmail,
      labelText: GBSystem_Application_Strings.str_mail.tr,
    );
  }

  Widget _buildPasswordField() {
    return GBSystem_TextField_Password(
      text: GBSystem_Application_Strings.str_password.tr, //
      controller: controller.controllerPassword, //
      isVisible: controller.CodeEntreprise_Visibility,
    );
  }

  Widget _buildPasswordActions(BuildContext context) {
    if (GBSystem_Application_Params_Manager.instance.CanChangePassword) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start, //
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildForgotPasswordButton(context), _buildChangePasswordButton(context)],
      );
    }
    return SizedBox(height: 10);
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(GBSystem_Application_Params_Manager.instance.mdp_oublier), //GBSystem_Application_Routes.mdp_oublier),
      child: SizedBox(
        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.4),
        child: Text(
          GBSystem_Application_Strings.str_mot_de_passe_oublier.tr,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 14, color: GBSystem_Application_Strings.str_primary_color),
        ),
      ),
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(GBSystem_Application_Params_Manager.instance.mdp_change), //GBSystem_Application_Routes.mdp_change),
      child: SizedBox(
        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.4),
        child: Text(
          GBSystem_Application_Strings.str_change_password.tr,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 14, color: GBSystem_Application_Strings.str_primary_color),
        ),
      ),
    );
  }

  Widget _buildLoginActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLanguageDropdown(), //
        const SizedBox(width: 12),
        _buildLoginButton(context),
      ],
    );

    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.1)),
    //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildLanguageDropdown(), const SizedBox(width: 12), _buildLoginButton(context)]),
    // );
  }

  Widget _buildLanguageDropdown() {
    return Obx(
      () => CustomDropDownSelectLanguage(
        selectedItem: controller.selectedLanguage.value, //
        onChanged: (value) => controller.changeLanguage(value!),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return GBSystem_SubmitButton(context, controller.loginFunction, GBSystem_Application_Strings.str_connexion.tr);
  }

  Widget _buildFooterSection(BuildContext context) {
    return const SizedBox.shrink(); // Placeholder if needed
  }

  Widget _buildCopyrightFooter(BuildContext context) {
    return Visibility(
      visible: !controller.textFieldFocusNodeEmail.hasFocus && !controller.textFieldFocusNodePassword.hasFocus,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
          child: GBSystem_TextHelper().smallText(text: "${GBSystem_Application_Strings.str_droits_reserved_part_1} ${DateTime.now().year} ${GBSystem_Application_Strings.str_droits_reserved_part_2.tr}", textColor: GBSystem_Application_Strings.str_primary_color),
        ),
      ),
    );
  }
}
