import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

class GBSystem_DisplayPhoneNumberWidget extends StatelessWidget {
  const GBSystem_DisplayPhoneNumberWidget({super.key, required this.phoneNumber});

  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 3, color: GBSystem_Application_Strings.str_primary_color),
            borderRadius: BorderRadius.circular(3),
          ),
          child: GBSystem_TextHelper().normalText(text: phoneNumber, textColor: Colors.black),
        ),
        Positioned(
          top: -5,
          left: -40,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: GBSystem_Application_Strings.str_primary_color,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(CupertinoIcons.phone_fill, color: GBSystem_Application_Strings.str_primary_color),
            ),
          ),
        ),
      ],
    );
  }
}
