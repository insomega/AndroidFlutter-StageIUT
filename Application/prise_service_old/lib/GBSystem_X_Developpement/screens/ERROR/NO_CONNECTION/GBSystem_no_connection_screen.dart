import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/ERROR/NO_CONNECTION/GBSystem_no_connection_controller.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:blobs/blobs.dart';

class NoConnectionPage extends StatelessWidget {
  NoConnectionPage({
    super.key,
    required this.destination,
  });

  final Widget destination;
  final m = Get.put<GBSystem_no_connection_controller>(
      GBSystem_no_connection_controller());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: GbsSystemServerStrings.str_primary_color,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                        context, 0.02)),
                child: SizedBox(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.8),
                    child: GBSystem_TextHelper().largeText(
                      text: GbsSystemStrings.str_error_no_connection_title,
                      textColor: Colors.white,
                      maxLines: 2,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    )),
              ),
              Center(
                child: Lottie.asset(
                    GbsSystemServerStrings.str_error_no_connection_lottie_path,
                    width: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.8),
                    height: GBSystem_ScreenHelper.screenHeightPercentage(
                        context, 0.5),
                    fit: BoxFit.fill),
              ),
              InkWell(
                onTap: () async {
                  m.initConnectivity();
                  bool isConnected = m.isConnected.value;
                  if (isConnected) {
                    Get.off(destination);
                  }
                },
                child: Blob.animatedRandom(
                  styles: BlobStyles(color: Colors.amber),
                  size: 200,
                  edgesCount: 5,
                  minGrowth: 4,
                  loop: true,
                  duration: const Duration(seconds: 3),
                  child: Center(
                      child: GBSystem_TextHelper().normalText(
                    text: GbsSystemStrings.str_refresh,
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
