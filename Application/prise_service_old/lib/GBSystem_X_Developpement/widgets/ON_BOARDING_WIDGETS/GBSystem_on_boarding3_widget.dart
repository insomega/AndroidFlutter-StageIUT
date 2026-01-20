import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:lottie/lottie.dart';

class GBSystem_OnBoardingWidget3 extends StatelessWidget {
  const GBSystem_OnBoardingWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: GbsSystemServerStrings.str_primary_color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: Lottie.asset(
                GbsSystemServerStrings.str_boarding3_lottie_path,
                height:
                    GBSystem_ScreenHelper.screenHeightPercentage(context, 0.35),
                width: GBSystem_ScreenHelper.screenWidth(context)),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: GBSystem_ScreenHelper.screenWidth(context),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.1),
                    vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                        context, 0.05)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              GBSystem_ScreenHelper.screenHeightPercentage(
                                  context, 0.01)),
                      child: const Text(
                        GbsSystemStrings.boarding_3_title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Text(
                      GbsSystemStrings.boarding_3_subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black26,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
