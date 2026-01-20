import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_absence_model.dart';

class GBSystem_Root_CardViewHome_Widget extends Card {
  const GBSystem_Root_CardViewHome_Widget(
      {super.key, required this.typeAbsence, this.onSearchTap, required this.title});

  final TypeAbsenceModel? typeAbsence;
  final void Function()? onSearchTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          onTap: onSearchTap,
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical:
                    GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
                horizontal:
                    GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.8),
                      child: GBSystem_TextHelper().largeText(
                          text: typeAbsence!.TPH_LIB,
                          maxLines: 2,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.8),
                      child: GBSystem_TextHelper().normalText(
                          text: typeAbsence!.TPH_CODE,
                          maxLines: 3,
                          textColor: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.8),
                      child: GBSystem_TextHelper().normalText(
                          text: typeAbsence!.TPH_LIB,
                          maxLines: 3,
                          textColor: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.8),
                      child: GBSystem_TextHelper().smallText(
                          text: typeAbsence!.TPH_LIB,
                          textColor: Colors.black,
                          maxLines: 2,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -5,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal:
                    GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
            decoration: const BoxDecoration(color: Colors.white),
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: onSearchTap,
            child: const Icon(
              CupertinoIcons.search,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );

  }
}
