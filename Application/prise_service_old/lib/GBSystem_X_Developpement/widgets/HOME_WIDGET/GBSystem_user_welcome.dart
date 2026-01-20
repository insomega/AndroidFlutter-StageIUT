import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_model.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

class UserWelcome extends Card {
  const UserWelcome({
    super.key,
    required this.salarie,
    required this.imageBase,
  });
  final String imageBase;
  final SalarieModel salarie;

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(imageBase.split(',').last);

    return Container(
      height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.23),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              width: 0.4, color: Colors.grey, style: BorderStyle.solid),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: -40,
              blurRadius: 22,
              offset: const Offset(10, 40), // changes the shadow position
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: -40,
              blurRadius: 22,
              offset: const Offset(-10, -40), // changes the shadow position
            ),
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, //MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width:
                      GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                  child: GBSystem_TextHelper().normalText(
                    text: GbsSystemStrings.str_bienvenue,
                    textColor: Colors.grey,
                  ),
                ),
                SizedBox(
                  width:
                      GBSystem_ScreenHelper.screenWidthPercentage(context, 0.6),
                  child: GBSystem_TextHelper().normalText(
                    text: "${salarie.SVR_PRNOM} ${salarie.SVR_NOM}",
                    textColor: Colors.black,
                    maxLines: 3,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.left,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialogSalarieInfo(
                        context: context, salarie: salarie, bytes: bytes);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                            context, 0.03)),
                    child: SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.63),
                        child: GBSystem_TextHelper().smallText(
                          text: GbsSystemStrings.str_acceder_a_vos_informations,
                          textColor: GbsSystemServerStrings.str_primary_color,
                          textAlign: TextAlign.left,
                        )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02)),
              child: ClipOval(
                child: Image.memory(
                  bytes,
                  fit: BoxFit.fill,
                  width: GBSystem_ScreenHelper.screenWidthPercentage(
                      context, 0.25),
                  height: GBSystem_ScreenHelper.screenWidthPercentage(
                      context, 0.25),
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.2),
                    height: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: GbsSystemServerStrings.str_primary_color),
                    child: Center(
                        child: GBSystem_TextHelper().largeText(
                            text:
                                "${salarie.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie.SVR_NOM.substring(0, 1).toUpperCase()}",
                            textColor: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDialogSalarieInfo(
      {required BuildContext context,
      required SalarieModel salarie,
      required bytes}) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Set your desired radius here
                ),
                backgroundColor:
                    GbsSystemServerStrings.str_primary_color.withOpacity(0.85),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipOval(
                            child: Image.memory(
                              bytes,
                              fit: BoxFit.fill,
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.25),
                              height:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.25),
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.2),
                                height:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(300),
                                    color: Colors.white),
                                child: Center(
                                    child: GBSystem_TextHelper().largeText(
                                        text:
                                            "${salarie.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie.SVR_NOM.substring(0, 1).toUpperCase()}",
                                        textColor: GbsSystemServerStrings
                                            .str_primary_color)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GBSystem_TextHelper().normalText(
                              text: salarie.SVR_PRNOM,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold),
                          GBSystem_TextHelper().normalText(
                              text: salarie.SVR_NOM,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textColor: Colors.grey.shade400,
                              fontWeight: FontWeight.bold),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.phone_fill,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GBSystem_TextHelper().smallText(
                                  text: salarie.SVR_TELPOR,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.mail_solid,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GBSystem_TextHelper().smallText(
                                  text: salarie.SVR_EMAIL,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.location_solid,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GBSystem_TextHelper().smallText(
                                  text: salarie.VIL_LIB,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                        textStyle: const TextStyle(
                            color: GbsSystemServerStrings.str_primary_color)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        GbsSystemStrings.str_fermer,
                        style: TextStyle(
                            color: GbsSystemServerStrings.str_primary_color),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
