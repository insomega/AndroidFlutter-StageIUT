import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

// ignore: must_be_immutable
class FocusedImageSalarieWidget extends StatelessWidget {
  FocusedImageSalarieWidget(
      {super.key, required this.salarie_idf, required this.salarie_lib});

  String salarie_idf, salarie_lib;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        FutureBuilder<String?>(
            future: GBSystem_AuthService(context)
                .getPhotoSalarieQuickAccess(SVR_IDF: salarie_idf),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // salarieWithPhotoModel.imageSalarie = snapshot.data;
              }
              return Center(
                child: Container(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0), // you can adjust blur radius here
                    child: Container(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.4),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: ClipOval(
                        child: snapshot.data != null
                            ? Image.memory(
                                base64Decode(snapshot.data!.split(',').last),
                                fit: BoxFit.fill,
                                width:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.4),
                                height:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.4),
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: GBSystem_ScreenHelper
                                      .screenWidthPercentage(context, 0.4),
                                  height: GBSystem_ScreenHelper
                                      .screenWidthPercentage(context, 0.4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(300),
                                      color: Colors.white),
                                  child: Center(
                                    child: GBSystem_TextHelper().largeText(
                                        text:
                                            "${salarie_lib.substring(0, 1).toUpperCase()}${salarie_lib.substring(1, 2).toUpperCase()}",
                                        textColor: GbsSystemServerStrings
                                            .str_primary_color),
                                  ),
                                ),
                              )
                            : Container(
                                width:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.4),
                                height:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    color: Colors.white),
                                child: Center(
                                  child: GBSystem_TextHelper().largeText(
                                      text:
                                          "${salarie_lib.substring(0, 1).toUpperCase()}${salarie_lib.substring(1, 2).toUpperCase()}",
                                      textColor: GbsSystemServerStrings
                                          .str_primary_color),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              );
            }),
        // make color context
      ],
    );
  }
}
