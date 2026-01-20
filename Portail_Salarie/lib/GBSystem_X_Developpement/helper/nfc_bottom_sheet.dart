import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class NFCBottomSheet {
  static void openSnackBar({required void Function()? onPressed}) {
    Get.dialog(
        AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: GBSystem_TextHelper().normalText(
              text: GbsSystemStrings.str_nfc.tr,
              textColor: Colors.black,
              fontWeight: FontWeight.bold),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WaitingWidgets(
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(
                  height: 15,
                ),
                GBSystem_TextHelper().smallText(
                    text: "${GbsSystemStrings.str_waiting_for_tag.tr} ...",
                    textColor: Colors.black),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: onPressed,
                child: GBSystem_TextHelper().smallText(
                    text: GbsSystemStrings.str_fermer.tr,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold))
          ],
        ),
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5));

    // Get.rawSnackbar(
    //   padding: EdgeInsets.symmetric(vertical: 30),
    //   mainButton: Visibility(
    //     visible: true,
    //     child: TextButton(
    //         onPressed: onPressed,
    //         child: GBSystem_TextHelper().smallText(
    //             text: GbsSystemStrings.str_fermer.tr,
    //             textColor: Colors.black,
    //             fontWeight: FontWeight.bold)),
    //   ),
    //   snackStyle: SnackStyle.FLOATING,
    //   snackPosition: SnackPosition.BOTTOM,
    //   messageText: GBSystem_TextHelper().smallText(
    //       text: GbsSystemStrings.str_waiting_for_tag.tr,
    //       textColor: Colors.black),
    //   icon: const Icon(
    //     Icons.nfc,
    //     color: Colors.black54,
    //   ),
    //   isDismissible: false,
    //   duration: const Duration(minutes: 2),
    //   backgroundColor: Colors.white,
    //   showProgressIndicator: true,
    // );
  }

  static void openBottomSheetAdresse(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.bottomSheet(
        isScrollControlled:
            true, // Enable scrolling if the content exceeds the available height
        FractionallySizedBox(
          heightFactor: 0.8,
          widthFactor: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GBSystem_TextHelper().largeText(
                      text: GbsSystemStrings.str_ready_to_scan.tr,
                      textColor: Colors.grey,
                      fontWeight: FontWeight.w500),
                  Lottie.asset(GbsSystemServerStrings.nfc_lottie_path),
                  GBSystem_TextHelper().smallText(
                    text: GbsSystemStrings
                        .str_hold_your_device_near_the_nfc_tag.tr,
                    textColor: Colors.black,
                  ),
                  CustomButton(
                      onTap: () async {
                        print("btm sheet : ${Get.isBottomSheetOpen}");
                        if (Get.isBottomSheetOpen == true) {
                          Get.back();
                        }

                        // Future Function() myFunc = onExit as Future Function();
                        // await myFunc();
                      },
                      color: Colors.grey.withOpacity(0.4),
                      textColor: Colors.black,
                      horPadding: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.3),
                      text: GbsSystemStrings.str_fermer.tr),

                  SizedBox(
                    height: 20,
                  )
                  // Add other content here if needed
                ],
              ),
            ),
          ),
        ),
      );

      // showModalBottomSheet(
      //   context: context,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(30),
      //       topRight: Radius.circular(30),
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   builder: (BuildContext context) {
      //     return FractionallySizedBox(
      //       heightFactor: 0.5,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           GBSystem_TextHelper().largeText(
      //               text: GbsSystemStrings.str_ready_to_scan.tr,
      //               textColor: Colors.grey,
      //               fontWeight: FontWeight.w500),
      //           Lottie.asset(GbsSystemStrings.nfc_lottie_path),
      //           GBSystem_TextHelper().smallText(
      //             text:
      //                 GbsSystemStrings.str_hold_your_device_near_the_nfc_tag.tr,
      //             textColor: Colors.black,
      //           ),
      //           Padding(
      //             padding: EdgeInsets.symmetric(
      //                 horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
      //                     context, 0.1)),
      //             child: CustomButton(
      //                 onTap: () {
      //                   Get.back();
      //                 },
      //                 color: Colors.grey.withOpacity(0.4),
      //                 textColor: Colors.black,
      //                 horPadding: GBSystem_ScreenHelper.screenWidthPercentage(
      //                     context, 0.3),
      //                 text: GbsSystemStrings.str_fermer.tr),
      //           )
      //         ],
      //       ),
      //     );
      //   },
      // );

      // Get.bottomSheet(
      //   AlertDialog(
      //     shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(30),
      //         topRight: Radius.circular(30),
      //       ),
      //     ),
      //     backgroundColor: Colors.white,
      //     content: Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         GBSystem_TextHelper().largeText(
      //             text: GbsSystemStrings.str_ready_to_scan.tr,
      //             textColor: Colors.grey,
      //             fontWeight: FontWeight.w500),
      //         Lottie.asset(GbsSystemStrings.nfc_lottie_path),
      //         GBSystem_TextHelper().smallText(
      //           text: GbsSystemStrings.str_hold_your_device_near_the_nfc_tag.tr,
      //           textColor: Colors.black,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.symmetric(
      //               horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
      //                   context, 0.1)),
      //           child: CustomButton(
      //               onTap: () {
      //                 Get.back();
      //               },
      //               color: Colors.grey.withOpacity(0.4),
      //               textColor: Colors.black,
      //               horPadding: GBSystem_ScreenHelper.screenWidthPercentage(
      //                   context, 0.3),
      //               text: GbsSystemStrings.str_fermer.tr),
      //         )
      //       ],
      //     ),
      //     actions: <Widget>[],
      //   ),
      // );
    });

    // showModalBottomSheet(
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(30),s
    //       topRight: Radius.circular(30),
    //     ),
    //   ),
    //   context: context,
    //   builder: (BuildContext context) {
    //     return StatefulBuilder(
    //       builder: (context, setState) {
    //         return
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             GBSystem_TextHelper().largeText(
    //                 text: GbsSystemStrings.str_ready_to_scan.tr,
    //                 textColor: Colors.grey,
    //                 fontWeight: FontWeight.w500),
    //             Lottie.asset(GbsSystemStrings.nfc_lottie_path),
    //             GBSystem_TextHelper().smallText(
    //               text:
    //                   GbsSystemStrings.str_hold_your_device_near_the_nfc_tag.tr,
    //               textColor: Colors.black,
    //             ),
    //             Padding(
    //               padding: EdgeInsets.symmetric(
    //                   horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
    //                       context, 0.1)),
    //               child: CustomButton(
    //                   onTap: () {
    //                     Get.back();
    //                   },
    //                   color: Colors.grey.withOpacity(0.4),
    //                   textColor: Colors.black,
    //                   horPadding: GBSystem_ScreenHelper.screenWidthPercentage(
    //                       context, 0.3),
    //                   text: GbsSystemStrings.str_fermer.tr),
    //             )
    //           ],
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
