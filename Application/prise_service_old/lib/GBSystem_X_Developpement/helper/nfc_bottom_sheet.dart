import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NFCBottomSheet {
  static void openSnackBar({required void Function()? onPressed}) {
    Get.rawSnackbar(
      mainButton: Visibility(
        visible: true,
        child: TextButton(
            onPressed: onPressed,
            child: GBSystem_TextHelper()
                .smallText(text: GbsSystemStrings.str_fermer.tr)),
      ),
      snackPosition: SnackPosition.BOTTOM,
      messageText: GBSystem_TextHelper().smallText(
          text: GbsSystemStrings.str_waiting_for_tag.tr,
          textColor: Colors.white),
      icon: const Icon(
        Icons.nfc,
        color: Colors.white,
      ),
      isDismissible: false,
      duration: const Duration(minutes: 2),
      backgroundColor: Colors.green,
      showProgressIndicator: true,
    );
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
