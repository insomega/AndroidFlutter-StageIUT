import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystemCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const GBSystemCustomAppBar({
    super.key,
    required this.imageSalarie,
    required this.salarie,
    this.onDeconnexionTap,
  });

  final String? imageSalarie;
  final SalarieModel salarie;
  final void Function()? onDeconnexionTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal:
                GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
            vertical:
                GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
        decoration: const BoxDecoration(
          color: GbsSystemServerStrings.str_primary_color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  GbsSystemServerStrings.str_logo_image_path,
                  width: GBSystem_ScreenHelper.screenWidthPercentage(
                      context, 0.14),
                  height: GBSystem_ScreenHelper.screenWidthPercentage(
                      context, 0.14),
                  color: Colors.white,
                ),
                Transform.translate(
                  offset: const Offset(2, -12),
                  child: const Text(
                    GbsSystemStrings.str_app_name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            ),

            InkWell(
                onTap: onDeconnexionTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                    size: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.08),
                  ),
                )),

            // Transform.translate(
            //   offset: const Offset(0, -5),
            //   child: ClipOval(
            //     child: imageSalarie != null
            //         ? Image.memory(
            //             base64Decode(imageSalarie!.split(',').last),
            //             fit: BoxFit.fill,
            //             width: GBSystem_ScreenHelper.screenWidthPercentage(
            //                 context, 0.13),
            //             height: GBSystem_ScreenHelper.screenWidthPercentage(
            //                 context, 0.13),
            //             errorBuilder: (context, error, stackTrace) => Container(
            //               width: GBSystem_ScreenHelper.screenWidthPercentage(
            //                   context, 0.12),
            //               height: GBSystem_ScreenHelper.screenWidthPercentage(
            //                   context, 0.12),
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(300),
            //                   color: Colors.white),
            //               child: Center(
            //                 child: GBSystem_TextHelper().normalText(
            //                     text:
            //                         "${salarie.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie.SVR_NOM.substring(0, 1).toUpperCase()}",
            //                     textColor:
            //                         GbsSystemServerStrings.str_primary_color),
            //               ),
            //             ),
            //           )
            //         : Container(
            //             width: GBSystem_ScreenHelper.screenWidthPercentage(
            //                 context, 0.12),
            //             height: GBSystem_ScreenHelper.screenWidthPercentage(
            //                 context, 0.12),
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(200),
            //                 color: Colors.white),
            //             child: Center(
            //               child: GBSystem_TextHelper().normalText(
            //                   text:
            //                       "${salarie.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie.SVR_NOM.substring(0, 1).toUpperCase()}",
            //                   textColor:
            //                       GbsSystemServerStrings.str_primary_color),
            //             ),
            //           ),
            //   ),
            // ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);

  Future deconnexion() async {
    final GBSystemAgenceQuickAccessController agencesController =
        Get.put(GBSystemAgenceQuickAccessController());
    agencesController.setLoginAgence = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(GbsSystemServerStrings.kToken, "");
    await preferences.setString(GbsSystemServerStrings.kCookies, "");
    Get.offAll(GBSystemLoginScreen());
  }
}
