import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:lottie/lottie.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key, this.heightLottie});

  final double? heightLottie;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(GbsSystemServerStrings.no_data_lottie_path,
              height: heightLottie ??
                  GBSystem_ScreenHelper.screenHeightPercentage(context, 0.2)),
          GBSystem_TextHelper().largeText(
              text: GbsSystemStrings.str_empty_data,
              textColor: Colors.black,
              fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
