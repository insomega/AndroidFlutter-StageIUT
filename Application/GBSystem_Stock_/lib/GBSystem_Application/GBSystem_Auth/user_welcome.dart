import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

import 'GBSystem_salarie_photo_model.dart';
import 'GBSystem_salarie_model.dart';
import 'GBSystem_modifier_informations_screen.dart';

class UserWelcome extends Card {
  const UserWelcome({this.onAccederTap, super.key, required this.salarie});
  final GBSystemSalarieWithPhotoModel salarie;
  final void Function()? onAccederTap;
  @override
  Widget build(BuildContext context) {
    Uint8List? bytes = salarie.imageSalarie != null ? base64Decode(salarie.imageSalarie!.split(',').last) : null;
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 0.4, color: Colors.grey, style: BorderStyle.solid),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1)],

        // boxShadow: [
        // BoxShadow(
        //   color: Colors.grey.withOpacity(0.3),
        //   spreadRadius: -40,
        //   blurRadius: 22,
        //   offset: const Offset(10, 40), // changes the shadow position
        // ),
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: -40,
        //     blurRadius: 22,
        //     offset: const Offset(-10, -40), // changes the shadow position
        //   ),
        // ]
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(),
                SizedBox(
                  width: size.width * 0.5,
                  child: GBSystem_TextHelper().normalText(text: GBSystem_Application_Strings.str_Welcome.tr, textColor: Colors.grey, maxLines: 1),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: size.width * 0.5,
                  child: GBSystem_TextHelper().largeText(text: "${salarie.salarieModel.SVR_PRNOM} ${salarie.salarieModel.SVR_NOM}", textAlign: TextAlign.left, textColor: Colors.black, maxLines: 2, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                CupertinoButton(
                  onPressed: onAccederTap,
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    width: size.width * 0.5,
                    child: GBSystem_TextHelper().smallText(text: "${GBSystem_Application_Strings.str_carte_proffisionel.tr}", textAlign: TextAlign.left, textColor: GBSystem_Application_Strings.str_primary_color, maxLines: 2, fontWeight: FontWeight.w500),
                  ),
                ),
                Spacer(),
              ],
            ),
            InkWell(
              onTap: () {
                showDialogSalarieInfo(context: context, salarie: salarie.salarieModel, bytes: bytes);
              },
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: ClipOval(
                  child: bytes != null
                      ? Image.memory(
                          bytes,
                          fit: BoxFit.fill,
                          width: size.width * 0.25,
                          height: size.width * 0.25,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: size.width * 0.2,
                            height: size.width * 0.2,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: GBSystem_Application_Strings.str_primary_color),
                            child: Center(
                              child: GBSystem_TextHelper().largeText(text: "${salarie.salarieModel.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie.salarieModel.SVR_NOM.substring(0, 1).toUpperCase()}", textColor: Colors.white),
                            ),
                          ),
                        )
                      : Container(
                          width: size.width * 0.2,
                          height: size.width * 0.2,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: GBSystem_Application_Strings.str_primary_color),
                          child: Center(
                            child: GBSystem_TextHelper().largeText(text: "${salarie.salarieModel.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie.salarieModel.SVR_NOM.substring(0, 1).toUpperCase()}", textColor: Colors.white),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDialogSalarieInfo({required BuildContext context, required SalarieModel salarie, required bytes}) async {
    var size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Set your desired radius here
              ),
              backgroundColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.85),
              content: StatefulBuilder(
                builder: (context, setState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: bytes != null
                              ? Image.memory(
                                  bytes,
                                  fit: BoxFit.fill,
                                  width: size.width * 0.25,
                                  height: size.width * 0.25,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: size.width * 0.2,
                                    height: size.width * 0.2,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: Colors.white),
                                    child: Center(
                                      child: GBSystem_TextHelper().largeText(text: "${salarie.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie.SVR_NOM.substring(0, 1).toUpperCase()}", textColor: GBSystem_Application_Strings.str_primary_color),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: size.width * 0.2,
                                  height: size.width * 0.2,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: Colors.white),
                                  child: Center(
                                    child: GBSystem_TextHelper().largeText(text: "${salarie.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie.SVR_NOM.substring(0, 1).toUpperCase()}", textColor: GBSystem_Application_Strings.str_primary_color),
                                  ),
                                ),
                        ),
                        SizedBox(height: 20),
                        GBSystem_TextHelper().normalText(text: '${salarie.SVR_PRNOM}', maxLines: 2, textAlign: TextAlign.center, textColor: Colors.white, fontWeight: FontWeight.bold),
                        GBSystem_TextHelper().normalText(text: '${salarie.SVR_NOM}', maxLines: 2, textAlign: TextAlign.center, textColor: Colors.grey.shade400, fontWeight: FontWeight.bold),
                        SizedBox(height: 20),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(CupertinoIcons.phone_fill, color: Colors.white),
                            SizedBox(width: 10),
                            GBSystem_TextHelper().smallText(text: '${salarie.SVR_TELPOR}', maxLines: 2, textAlign: TextAlign.center, textColor: Colors.white, fontWeight: FontWeight.bold),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(CupertinoIcons.mail_solid, color: Colors.white),
                            SizedBox(width: 10),
                            GBSystem_TextHelper().smallText(text: '${salarie.SVR_EMAIL}', maxLines: 2, textAlign: TextAlign.center, textColor: Colors.white, fontWeight: FontWeight.bold),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(CupertinoIcons.location_solid, color: Colors.white),
                            SizedBox(width: 10),
                            GBSystem_TextHelper().smallText(text: '${salarie.VIL_LIB}', maxLines: 2, textAlign: TextAlign.center, textColor: Colors.white, fontWeight: FontWeight.bold),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                  ),
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Get.back();
                      Get.to(GBSystemModifierInformationsScreen());
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(GBSystem_Application_Strings.str_modifier.tr, style: TextStyle(color: GBSystem_Application_Strings.str_primary_color)),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(GBSystem_Application_Strings.str_quitter.tr, style: TextStyle(color: GBSystem_Application_Strings.str_primary_color)),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
