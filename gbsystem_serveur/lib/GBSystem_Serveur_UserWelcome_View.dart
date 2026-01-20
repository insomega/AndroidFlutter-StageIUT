//import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
//import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

import 'GBSystem_Serveur_UserWelcome_Controller.dart';

class GBSystem_Serveur_View_Card extends Card {
  // final String imageBase;
  // final GBSystem_Serveur_Info_Model salarie;

  @override
  Widget build(BuildContext context) {
    //  final imageBase_b64 = base64Decode(imageBase.split(',').last);
    // final fullName = '${salarie.SVR_PRNOM} ${salarie.SVR_NOM}';
    // final initials = '${salarie.SVR_PRNOM.substring(0, 1)}${salarie.SVR_NOM.substring(0, 1)}'.toUpperCase();
    Get.put(GBSystem_Serveur_UserWelcome_Controller());

    return GetX<GBSystem_Serveur_UserWelcome_Controller>(
      init: Get.find<GBSystem_Serveur_UserWelcome_Controller>(),
      builder: (controller) {
        if (controller.isLoading.value) {
          return Waiting();
        }

        return Container(
          height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.23),
          decoration: _buildCardDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, //
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildUserInfoSection(context, controller), //
                _buildUserAvatar(context, controller.imageBase_b64(), controller.initials()),
              ],
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(width: 0.4, color: Colors.grey, style: BorderStyle.solid),
      boxShadow: _buildCardShadows(),
    );
  }

  List<BoxShadow> _buildCardShadows() {
    return [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: -40, blurRadius: 22, offset: const Offset(10, 40)), BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: -40, blurRadius: 22, offset: const Offset(-10, -40))];
  }

  Widget _buildUserInfoSection(BuildContext context, GBSystem_Serveur_UserWelcome_Controller controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [_buildWelcomeText(context), _buildNameText(context, controller.fullName()), _buildInfoLink(context, controller.imageBase_b64(), controller)],
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return SizedBox(
      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
      child: GBSystem_TextHelper().normalText(text: GBSystem_Application_Strings.str_bienvenue, textColor: Colors.grey),
    );
  }

  Widget _buildNameText(BuildContext context, String fullName) {
    return SizedBox(
      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.6),
      child: GBSystem_TextHelper().normalText(text: fullName, textColor: Colors.black, maxLines: 3, fontWeight: FontWeight.bold, textAlign: TextAlign.left),
    );
  }

  Widget _buildInfoLink(BuildContext context, Uint8List bytes, GBSystem_Serveur_UserWelcome_Controller controller) {
    return InkWell(
      onTap: () => _showQuickInfoDialog(context, bytes, controller),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.03)),
        child: SizedBox(
          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.63),
          child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_acceder_a_vos_informations, textColor: GBSystem_Application_Strings.str_primary_color, textAlign: TextAlign.left),
        ),
      ),
    );
  }

  Widget _buildUserAvatar(BuildContext context, Uint8List bytes, String initials) {
    return Padding(
      padding: EdgeInsets.only(top: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
      child: ClipOval(
        child: Image.memory(
          bytes, //
          fit: BoxFit.fill,
          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.25),
          height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.25),
          errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(context, initials),
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar(BuildContext context, String initials) {
    return Container(
      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
      height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: GBSystem_Application_Strings.str_primary_color),
      child: Center(
        child: GBSystem_TextHelper().largeText(text: initials, textColor: Colors.white),
      ),
    );
  }

  void _showQuickInfoDialog(BuildContext context, Uint8List bytes, GBSystem_Serveur_UserWelcome_Controller controller) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context, builder: (context) => _buildQuickInfoDialog(bytes, controller));
    });
  }

  Widget _buildQuickInfoDialog(Uint8List bytes, GBSystem_Serveur_UserWelcome_Controller controller) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.85),
      content: _buildDialogContent(bytes, controller),
      actions: [_buildCloseButton()],
    );
  }

  Widget _buildDialogContent(Uint8List bytes, GBSystem_Serveur_UserWelcome_Controller controller) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDialogAvatar(bytes, controller),
          const SizedBox(height: 20),
          _buildDialogNameText(controller),
          const SizedBox(height: 40),
          _buildContactInfo(icon: CupertinoIcons.phone_fill, text: controller.salarie!.SVR_TELPOR),
          const SizedBox(height: 20),
          _buildContactInfo(icon: CupertinoIcons.mail_solid, text: controller.salarie!.SVR_EMAIL),
          const SizedBox(height: 20),
          _buildContactInfo(icon: CupertinoIcons.location_solid, text: controller.salarie!.VIL_LIB),
        ],
      ),
    );
  }

  Widget _buildDialogAvatar(Uint8List bytes, GBSystem_Serveur_UserWelcome_Controller controller) {
    return ClipOval(
      child: Image.memory(
        bytes,
        fit: BoxFit.fill,
        width: GBSystem_ScreenHelper.screenWidthPercentage(Get.context!, 0.25),
        height: GBSystem_ScreenHelper.screenWidthPercentage(Get.context!, 0.25),
        errorBuilder: (context, error, stackTrace) => Container(
          width: GBSystem_ScreenHelper.screenWidthPercentage(Get.context!, 0.2),
          height: GBSystem_ScreenHelper.screenWidthPercentage(Get.context!, 0.2),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: Colors.white),
          child: Center(
            child: GBSystem_TextHelper().largeText(
              text:
                  "${controller.salarie!.SVR_PRNOM.substring(0, 1).toUpperCase()}"
                  "${controller.salarie!.SVR_NOM.substring(0, 1).toUpperCase()}",
              textColor: GBSystem_Application_Strings.str_primary_color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogNameText(GBSystem_Serveur_UserWelcome_Controller controller) {
    return Column(
      children: [
        GBSystem_TextHelper().normalText(text: controller.salarie!.SVR_PRNOM, maxLines: 2, textAlign: TextAlign.center, textColor: Colors.white, fontWeight: FontWeight.bold),
        GBSystem_TextHelper().normalText(text: controller.salarie!.SVR_NOM, maxLines: 2, textAlign: TextAlign.center, textColor: Colors.grey.shade400, fontWeight: FontWeight.bold),
      ],
    );
  }

  Widget _buildContactInfo({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 10),
        GBSystem_TextHelper().smallText(text: text, maxLines: 2, textAlign: TextAlign.center, textColor: Colors.white, fontWeight: FontWeight.bold),
      ],
    );
  }

  Widget _buildCloseButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: const TextStyle(color: GBSystem_Application_Strings.str_primary_color),
      ),
      onPressed: () => Get.back(),
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(GBSystem_Application_Strings.str_fermer, style: TextStyle(color: GBSystem_Application_Strings.str_primary_color)),
      ),
    );
  }
}

/*
class GBSystem_Serveur_View_Card extends Card {
  const GBSystem_Serveur_View_Card({super.key, required this.salarie, required this.imageBase});
  final String imageBase;
  final GBSystem_Serveur_Info_Model salarie;

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(imageBase.split(',').last);

    return Container(
      height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.23),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 0.4, color: Colors.grey, style: BorderStyle.solid),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: -40,
            blurRadius: 22,
            offset: const Offset(10, 40), // changes the shadow position
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: -40,
            blurRadius: 22,
            offset: const Offset(-10, -40), // changes the shadow position
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                  child: GBSystem_TextHelper().normalText(text: GBSystem_Application_Strings.str_bienvenue, textColor: Colors.grey),
                ),
                SizedBox(
                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.6),
                  child: GBSystem_TextHelper().normalText(text: "${salarie.SVR_PRNOM} ${salarie.SVR_NOM}", textColor: Colors.black, maxLines: 3, fontWeight: FontWeight.bold, textAlign: TextAlign.left),
                ),
                InkWell(
                  onTap: () {
                    GBSystem_Serveur_View_QuickInfo(context: context, salarie: salarie, bytes: bytes);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.03)),
                    child: SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.63),
                      child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_acceder_a_vos_informations, textColor: GBSystem_Application_Strings.str_primary_color, textAlign: TextAlign.left),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
              child: ClipOval(
                child: Image.memory(
                  bytes,
                  fit: BoxFit.fill,
                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.25),
                  height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.25),
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                    height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: GBSystem_Application_Strings.str_primary_color),
                    child: Center(
                      child: GBSystem_TextHelper().largeText(text: "${salarie.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie.SVR_NOM.substring(0, 1).toUpperCase()}", textColor: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> GBSystem_Serveur_View_QuickInfo({required BuildContext context, required GBSystem_Serveur_Info_Model salarie, required bytes}) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Set your desired radius here
              ),
              backgroundColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.85),
              content: StatefulBuilder(
                builder: (context, setState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: Image.memory(
                            bytes,
                            fit: BoxFit.fill,
                            width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.25),
                            height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.25),
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                              height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: Colors.white),
                              child: Center(
                                child: GBSystem_TextHelper().largeText(text: "${salarie.SVR_PRNOM.substring(0, 1).toUpperCase()}${salarie.SVR_NOM.substring(0, 1).toUpperCase()}", textColor: GBSystem_Application_Strings.str_primary_color),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GBSystem_TextHelper().normalText(text: salarie.SVR_PRNOM, maxLines: 2, textAlign: TextAlign.center, textColor: Colors.white, fontWeight: FontWeight.bold),
                        GBSystem_TextHelper().normalText(text: salarie.SVR_NOM, maxLines: 2, textAlign: TextAlign.center, textColor: Colors.grey.shade400, fontWeight: FontWeight.bold),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.phone_fill, color: Colors.white),
                            const SizedBox(width: 10),
                            GBSystem_TextHelper().smallText(text: salarie.SVR_TELPOR, maxLines: 2, textAlign: TextAlign.center, textColor: Colors.white, fontWeight: FontWeight.bold),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.mail_solid, color: Colors.white),
                            const SizedBox(width: 10),
                            GBSystem_TextHelper().smallText(text: salarie.SVR_EMAIL, maxLines: 2, textAlign: TextAlign.center, textColor: Colors.white, fontWeight: FontWeight.bold),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.location_solid, color: Colors.white),
                            const SizedBox(width: 10),
                            GBSystem_TextHelper().smallText(text: salarie.VIL_LIB, maxLines: 2, textAlign: TextAlign.center, textColor: Colors.white, fontWeight: FontWeight.bold),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(GBSystem_Application_Strings.str_fermer, style: TextStyle(color: GBSystem_Application_Strings.str_primary_color)),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}*/
