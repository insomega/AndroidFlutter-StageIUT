import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_Root_Params.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/AUTH/reset_password_screen/GBSystem_reset_password_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/APP_BAR/custom_app_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class GBSystemResetPasswordScreen extends StatelessWidget {
  const GBSystemResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final m = Get.put<GBSystemResetPasswordController>(
        GBSystemResetPasswordController(context));

    return Obx(() => SafeArea(
          child: Stack(
            children: [
              Scaffold(
                extendBodyBehindAppBar: true,
                appBar: CustomAppBar(
                  leadingIcon: const Icon(CupertinoIcons.arrow_left),
                  onLeadingTap: () {
                    Get.back();
                  },
                ),
                resizeToAvoidBottomInset: false,
                body: Form(
                  key: m.formKey,
                  autovalidateMode: m.autovalidateMode,
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
                                    context, 0.05)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: GBSystem_ScreenHelper
                                    .screenHeightPercentage(context, 0.01),
                                bottom: GBSystem_ScreenHelper
                                    .screenHeightPercentage(context, 0.02),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GBSystem_TextHelper().normalText(
                                          text: GbsSystemStrings
                                              .str_mot_de_passe_oublier.tr,
                                          maxLines: 1,
                                          fontWeight: FontWeight.w500,
                                          textColor: GbsSystemStrings
                                              .str_primary_color),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 2,
                                    color: GbsSystemStrings.str_primary_color,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: GBSystem_ScreenHelper
                                      .screenHeightPercentage(context, 0.02)),
                              child: CustomTextField(
                                  controller: m.controllerEmail,
                                  validator: (data) {
                                    if (data == null || data.isEmpty) {
                                      return GbsSystemStrings
                                          .str_validat_svp_enter_mail.tr;
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(data)) {
                                      return GbsSystemStrings
                                          .str_validat_svp_enter_site_valide.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  text: GbsSystemStrings.str_mail.tr),
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
                                        .screenHeightPercentage(context, 0.02),
                                    textSize: 18,
                                    textBold: true,
                                    text: GbsSystemStrings.str_ok.tr,
                                    onTap: () async {
                                      if (m.formKey.currentState!.validate()) {
                                        m.resetPassword();
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
              m.isLoading.value ? Waiting() : Container()
            ],
          ),
        ));
  }
}
