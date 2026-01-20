import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
//
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';

class SlideToActWidget extends StatelessWidget {
  const SlideToActWidget({super.key, required this.onSubmit});
  final void Function() onSubmit;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: GBSystem_Application_Strings.str_primary_color),
        child: GradientSlideToAct(
          text: GBSystem_Application_Strings.str_glisser_pour_ouvrir,
          textStyle: const TextStyle(fontSize: 18, color: Colors.black),
          backgroundColor: const Color(0xffD9D9D9),
          draggableWidget: const Icon(CupertinoIcons.lock_circle_fill, size: 50, color: Colors.black),
          onSubmit: onSubmit,
          dragableIconBackgroundColor: Colors.black54,
        ),
      ),
    );
  }
}

class GBSystem_SlideToAaction_Call_Phone_Widget extends StatelessWidget {
  const GBSystem_SlideToAaction_Call_Phone_Widget({super.key, required this.onSubmit});
  final void Function() onSubmit;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade500),
        child: GradientSlideToAct(
          submittedIcon: CupertinoIcons.check_mark,
          text: GBSystem_Application_Strings.str_glisser_pour_appeler,
          textStyle: const TextStyle(fontSize: 16, color: Colors.black),
          backgroundColor: const Color(0xffD9D9D9),
          draggableWidget: const Icon(CupertinoIcons.phone_circle_fill, size: 50, color: Colors.black),
          onSubmit: onSubmit,
          dragableIconBackgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
