import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GBSystem_ScreenHelper.dart';
import 'GBSystem_text_helper.dart';

class ChooseModeButtonWidget extends StatelessWidget {
  const ChooseModeButtonWidget({super.key, required this.text, required this.icon, this.onTap, this.hideWidget = false});
  final String text;
  final Widget icon;
  final void Function()? onTap;
  final bool hideWidget;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        // height: hideWidget ? 0 : null,
        width: GBSystem_ScreenHelper.screenWidth(context),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
            border: Border.all(width: 0.8, color: Colors.black54)),
        child: Column(
          children: [
            icon,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: GBSystem_TextHelper().normalText(text: text, maxLines: 2, textAlign: TextAlign.center, textColor: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
