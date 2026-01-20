import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:lottie/lottie.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key, this.heightLottie});

  final double? heightLottie;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(GBSystem_System_Strings.no_data_lottie_path, height: heightLottie ?? GBSystem_ScreenHelper.screenHeightPercentage(context, 0.2)),
          GBSystem_TextHelper().largeText(text: GBSystem_Application_Strings.str_no_item, textColor: Colors.black, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
