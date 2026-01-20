import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gbsystem_root/custom_app_bar.dart';
import 'GBSystem_Login_MDP_Oublier_Controller.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_root/custom_button.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_Root_Params.dart';
//import 'package:gbsystem_root/GBSystem_custom_text_field.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_TextField_Email.dart';

class GBSystem_MDP_Oublier_View extends GetView<GBSystem_MDP_Oublier_Controller> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            appBar: CustomAppBar(leadingIcon: const Icon(CupertinoIcons.arrow_left), onLeadingTap: Get.back),
            resizeToAvoidBottomInset: false,
            body: _buildBody(context),
          ),
          // ✅ Observer et afficher un succès si applicable
          Obx(() {
            final msg = controller.resetResultMessage.value;
            if (msg != null) {
              Future.delayed(Duration.zero, () {
                showSuccesDialog(msg);
                controller.resetResultMessage.value = null; // reset après affichage
              });
            }
            return const SizedBox.shrink();
          }),
          // Obx pour observer un indicateur de chargement (facultatif)
          // Obx(() => controller.isLoading.value ? const Waiting() : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: controller.formKey,
      autovalidateMode: controller.autovalidateMode,
      child: Column(children: [_buildHeader(context), _buildFormContent(context)]),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                //
                GBSystem_System_Strings.str_logo_image_path,
                color: Colors.white,
                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.4),
                height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.3),
              ),
            ),
            GBSystem_TextHelper().largeText(text: AppParams.Title, textColor: Colors.white, fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.1), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, //
        children: [
          _buildTitleSection(context), //
          const SizedBox(height: 12),
          _buildEmailField(),
          //const SizedBox(height: 16),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GBSystem_TextHelper().normalText(
          text: GBSystem_Application_Strings.str_mot_de_passe_oublier.tr, //
          maxLines: 1,
          fontWeight: FontWeight.w500,
          textColor: GBSystem_Application_Strings.str_primary_color,
        ),
        const Divider(thickness: 2, color: GBSystem_Application_Strings.str_primary_color),
      ],
    );
  }

  Widget _buildEmailField() {
    return GBSystem_TextField_Email(
      controller: controller.controllerEmail, //
      labelText: GBSystem_Application_Strings.str_mail.tr,
      // emptyError: GBSystem_Application_Strings.str_validat_svp_enter_mail.tr,
      //invalidError: GBSystem_Application_Strings.str_email_invalide_msg.tr,
    );

    // return CustomTextField(
    //   controller: controller.controllerEmail, //
    //   validator: _validateEmail,
    //   keyboardType: TextInputType.emailAddress,
    //   text: GBSystem_Application_Strings.str_mail.tr,
    // );
  }

  // String? _validateEmail(String? data) {
  //   if (data == null || data.isEmpty) {
  //     return GBSystem_Application_Strings.str_validat_svp_enter_mail.tr;
  //   } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+").hasMatch(data)) {
  //     return GBSystem_Application_Strings.str_validat_svp_enter_site_valide.tr;
  //   }
  //   return null;
  // }

  Widget _buildSubmitButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GBSystem_SubmitButton(context, _handleSubmit, GBSystem_Application_Strings.str_ok.tr),
        // CustomButton(
        //   horPadding: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.1),
        //   verPadding: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
        //   textSize: 18,
        //   textBold: true,
        //   text: GBSystem_Application_Strings.str_ok.tr,
        //   onTap: () async {
        //     if (controller.formKey.currentState!.validate()) {
        //       //   await controller.changePassword(ancientPass: _oldPasswordController.text, mail: _emailController.text, newPass: _newPasswordController.text, newPassConf: _confirmPasswordController.text);
        //     } else {
        //       controller.autovalidateMode = AutovalidateMode.always;
        //     }
        //   },
        // ),
      ],
    );

    // Align(
    //   alignment: Alignment.centerRight,
    //   child: GBSystem_SubmitButton(context, _handleSubmit, GBSystem_Application_Strings.str_ok.tr),
    //   // CustomButton(
    //   //   horPadding: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.1), //
    //   //   verPadding: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015),
    //   //   textSize: 18,
    //   //   textBold: true,
    //   //   text: GBSystem_Application_Strings.str_ok.tr,
    //   //   onTap: () => _handleSubmit(),
    //   // ),
    // );
  }

  void _handleSubmit() async {
    if (controller.formKey.currentState!.validate()) {
      await controller.resetPassword(controller.controllerEmail.text);
    } else {
      controller.autovalidateMode = AutovalidateMode.always;
    }
  }
}
