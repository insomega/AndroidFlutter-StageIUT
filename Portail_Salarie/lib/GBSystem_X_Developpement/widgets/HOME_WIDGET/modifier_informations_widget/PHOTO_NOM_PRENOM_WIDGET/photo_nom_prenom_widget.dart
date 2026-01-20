import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/photo_nom_prenom_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class PhotoNomPrenomWidget extends StatelessWidget {
  PhotoNomPrenomWidget({
    super.key,
    required this.salarie,
    this.onSuivantTap,
  });
  final GBSystemSalarieWithPhotoModel? salarie;
  final void Function()? onSuivantTap;
  @override
  Widget build(BuildContext context) {
    final PhotoNomPrenomController m =
        Get.put(PhotoNomPrenomController(salarie: salarie));

    var size = MediaQuery.of(context).size;
    return Stack(
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
            child: Column(
              children: [
                SizedBox(
                  height: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
                ClipOval(
                  child: salarie!.imageSalarie != null
                      ? Image.memory(
                          base64Decode(salarie!.imageSalarie!.split(',').last),
                          fit: BoxFit.fill,
                          width: size.width * 0.22,
                          height: size.width * 0.22,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: size.width * 0.22,
                            height: size.width * 0.22,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: GbsSystemStrings.str_primary_color),
                            child: Center(
                                child: GBSystem_TextHelper().largeText(
                                    text:
                                        "${salarie!.salarieModel.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie!.salarieModel.SVR_NOM.substring(0, 1).toUpperCase()}",
                                    textColor: Colors.white)),
                          ),
                        )
                      : Container(
                          width: size.width * 0.22,
                          height: size.width * 0.22,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: GbsSystemStrings.str_primary_color),
                          child: Center(
                              child: GBSystem_TextHelper().largeText(
                                  text:
                                      "${salarie!.salarieModel.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie!.salarieModel.SVR_NOM.substring(0, 1).toUpperCase()}",
                                  textColor: Colors.white)),
                        ),
                ),
                SizedBox(
                  height: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
                Obx(
                  () => CustomTextField(
                    controller: m.controllerNom.value,
                    text: GbsSystemStrings.str_nom.tr,
                    enabled: false,
                  ),
                ),
                SizedBox(
                  height: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
                Obx(
                  () => CustomTextField(
                      controller: m.controllerPrenom.value,
                      enabled: false,
                      text: GbsSystemStrings.str_prenom.tr),
                ),
                SizedBox(
                  height: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
              ],
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
      ],
    );
  }
}
