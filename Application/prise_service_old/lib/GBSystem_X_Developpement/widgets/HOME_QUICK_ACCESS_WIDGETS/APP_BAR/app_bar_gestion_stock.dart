import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_dataset_gestion_stock_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

class GBSystemAppBarGestionStock extends StatelessWidget
    implements PreferredSizeWidget {
  GBSystemAppBarGestionStock({
    super.key,
    required this.salarie,
    this.onBackTap,
  });

  final SalarieDataSetGestionStockModel salarie;
  final void Function()? onBackTap;
  String? imageSalarie;
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 200,
        padding: EdgeInsets.symmetric(
            horizontal:
                GBSystem_ScreenHelper.screenWidthPercentage(context, 0.015),
            vertical:
                GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
        decoration: BoxDecoration(
            color: GbsSystemServerStrings.str_primary_color,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: const Offset(2, 2))
            ]),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              GestureDetector(
                onTap: onBackTap,
                child: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                ),
              )
            ]),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<String?>(
                        future: GBSystem_AuthService(context)
                            .getPhotoRoot(type: 1, idf: salarie.SVR_IDF),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            imageSalarie = snapshot.data;
                          }
                          return Transform.translate(
                            offset: const Offset(0, 10),
                            child: ClipOval(
                              child: imageSalarie != null
                                  ? Image.memory(
                                      base64Decode(
                                          imageSalarie!.split(',').last),
                                      fit: BoxFit.fill,
                                      width: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.12),
                                      height: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.12),
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        width: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.12),
                                        height: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.12),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            color: GbsSystemServerStrings
                                                .str_primary_color),
                                        child: Center(
                                            child: GBSystem_TextHelper().largeText(
                                                text:
                                                    "${salarie.SVR_LIB.substring(0, 1).toUpperCase()}${salarie.SVR_LIB.substring(1, 2).toUpperCase()}",
                                                textColor: Colors.white)),
                                      ),
                                    )
                                  : Container(
                                      width: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.12),
                                      height: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.12),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          color: GbsSystemServerStrings
                                              .str_primary_color),
                                      child: Center(
                                          child: GBSystem_TextHelper().largeText(
                                              text:
                                                  "${salarie.SVR_LIB.substring(0, 1).toUpperCase()}${salarie.SVR_LIB.substring(1, 2).toUpperCase()}",
                                              textColor: Colors.white)),
                                    ),
                            ),
                          );
                        }),
                    // Container(
                    //   width: GBSystem_ScreenHelper.screenWidthPercentage(
                    //       context, 0.12),
                    //   height: GBSystem_ScreenHelper.screenWidthPercentage(
                    //       context, 0.12),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(200),
                    //       color: Colors.white),
                    //   child: Center(
                    //     child: GBSystem_TextHelper().normalText(
                    //         // text:
                    //         //     "${salarie.SVR_LIB.substring(0, 1).toUpperCase()}${salarie.SVR_LIB.substring(1, 2).toUpperCase()}",
                    //         text: "SA",
                    //         textColor: GbsSystemServerStrings.str_primary_color,
                    //         fontWeight: FontWeight.normal),
                    //   ),
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(
                              context, 0.6),
                          child: GBSystem_TextHelper().smallText(
                              text: salarie.SVR_LIB,
                              textColor: Colors.white,
                              maxLines: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.location_solid,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.6),
                              child: GBSystem_TextHelper().smallText(
                                  text: salarie.SVR_ADR1 ?? "",
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range_sharp,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.6),
                              child: GBSystem_TextHelper().smallText(
                                  text: salarie.SVR_TELPH != null
                                      ? " ${salarie.SVR_TELPH}"
                                      : " ",
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 0.8,
              color: Colors.white,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GBSystem_TextHelper().smallText(
                            text: "veste : ",
                            textColor: GbsSystemServerStrings.str_primary_color,
                            fontWeight: FontWeight.normal),
                        GBSystem_TextHelper().smallText(
                            text: salarie.SVR_TAILLE_VESTE ?? "",
                            textColor: GbsSystemServerStrings.str_primary_color,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GBSystem_TextHelper().smallText(
                            text: "pointure : ",
                            textColor: GbsSystemServerStrings.str_primary_color,
                            fontWeight: FontWeight.normal),
                        GBSystem_TextHelper().smallText(
                            text: salarie.SVR_POINTURE ?? "",
                            textColor: GbsSystemServerStrings.str_primary_color,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GBSystem_TextHelper().smallText(
                            text: "pantalon : ",
                            textColor: GbsSystemServerStrings.str_primary_color,
                            fontWeight: FontWeight.normal),
                        GBSystem_TextHelper().smallText(
                            text: salarie.SVR_TAILLE_PANTALON ?? "",
                            textColor: GbsSystemServerStrings.str_primary_color,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GBSystem_TextHelper().smallText(
                            text: "jupe : ",
                            textColor: GbsSystemServerStrings.str_primary_color,
                            fontWeight: FontWeight.normal),
                        GBSystem_TextHelper().smallText(
                            text: salarie.SVR_TAILLE_JUPE ?? "",
                            textColor: GbsSystemServerStrings.str_primary_color,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(200);
}
