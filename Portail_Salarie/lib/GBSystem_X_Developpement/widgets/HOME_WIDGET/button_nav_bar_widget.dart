import 'package:flutter/material.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';

class ButtonNavBarWidget extends StatelessWidget {
  const ButtonNavBarWidget({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final void Function()? onTap;
  final Widget icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Flexible(
              child: GBSystem_TextHelper().smallText(
                  maxLines: 2, text: text, textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
