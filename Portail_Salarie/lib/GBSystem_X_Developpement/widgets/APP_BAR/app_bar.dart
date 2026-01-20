import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_nombre_notifications_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_Root_Params.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

// ignore: must_be_immutable
class APP_BAR extends StatefulWidget implements PreferredSizeWidget {
  const APP_BAR({
    super.key,
    this.onLogoutTap,
    this.onMessageTap,
    this.onChangeTap,
    required this.showDisconnect,
  });
  final void Function()? onLogoutTap, onMessageTap, onChangeTap;
  final RxBool showDisconnect;
  @override
  State<APP_BAR> createState() => _APP_BARState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _APP_BARState extends State<APP_BAR> {
  final notificationController =
      Get.put<GBSystemNotificationController>(GBSystemNotificationController());
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal:
                GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
            vertical:
                GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015)),
        decoration: BoxDecoration(
          color: GbsSystemStrings.str_primary_color,
          boxShadow: [
            BoxShadow(
              color: GbsSystemServerStrings.str_primary_color.withOpacity(0.5),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
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
                  child: GBSystem_TextHelper().smallText(
                    text: ActiveApplication_Params.Title,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
            Spacer(),
            InkWell(
                onTap: widget.onMessageTap,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.white,
                      size: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.08),
                    ),
                    Obx(
                      () => Visibility(
                        visible: (notificationController.getNBrNoti?.value !=
                                null) &&
                            notificationController.getNBrNoti!.value.isNotEmpty,
                        child: Positioned(
                          top: -10,
                          right: -8,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: GBSystem_TextHelper().superSmallText(
                                text: notificationController.getNBrNoti!.value,
                                textColor: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(
              width: 5,
            ),
            Visibility(
              visible: false,
              child: InkWell(
                  onTap: widget.onChangeTap,
                  child: Icon(
                    Icons.replay_rounded,
                    color: Colors.white,
                    size: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.08),
                  )),
            ),
            Obx(
              () => Visibility(
                visible: !widget.showDisconnect.value,
                child: InkWell(
                    onTap: widget.onLogoutTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                        size: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.08),
                      ),
                    )),
              ),
            )
          ],
        ));
  }
}
