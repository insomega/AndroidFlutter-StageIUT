import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';

class GBSystemInfoVacationWaiting extends StatelessWidget {
  const GBSystemInfoVacationWaiting({super.key, this.text});

  final String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              width: 0.4, color: Colors.grey, style: BorderStyle.solid),
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
          ]),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingAnimationWidget.fourRotatingDots(
              color: GbsSystemServerStrings.str_primary_color,
              size: 30,
            ),
            const SizedBox(
              height: 20,
            ),
            text != null
                ? GBSystem_TextHelper().smallText(text: text!)
                : Container()
          ],
        ),
      ),
    );
  }
}
