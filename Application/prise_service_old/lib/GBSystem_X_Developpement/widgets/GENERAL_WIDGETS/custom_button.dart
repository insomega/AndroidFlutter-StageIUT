import 'package:flutter/material.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onTap,
      required this.text,
      this.color,
      this.textColor,
      this.horPadding,
      this.verPadding,
      this.shadowColor,
      this.width,
      this.textSize,
      this.textBold = false,
      this.numberImage,
      this.showNumber = false,
      this.leading,
      this.borderRaduis});
  final void Function()? onTap;
  final String text;
  final Color? color, textColor, shadowColor;
  final double? horPadding, verPadding, width, textSize, borderRaduis;
  final bool textBold;
  final int? numberImage;
  final bool showNumber;

  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRaduis ?? 6),
          color: color ?? GbsSystemServerStrings.str_primary_color,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: verPadding ?? size.height * 0.025,
              horizontal: horPadding ?? size.width * 0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: textSize ?? 18,
                    letterSpacing: 2,
                    color: textColor ?? Colors.white,
                    fontWeight: textBold ? FontWeight.bold : FontWeight.normal),
              ),
              showNumber
                  ? Text(
                      numberImage != null ? "($numberImage)" : '(0)',
                      style: TextStyle(
                          fontSize: textSize ?? 18,
                          letterSpacing: 2,
                          color: textColor ?? Colors.white,
                          fontWeight:
                              textBold ? FontWeight.bold : FontWeight.normal),
                    )
                  : Container(),
              leading != null
                  ? Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        leading!,
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithTrailling extends StatelessWidget {
  const CustomButtonWithTrailling(
      {super.key,
      this.onTap,
      required this.text,
      this.color,
      this.textColor,
      this.horPadding,
      this.verPadding,
      this.shadowColor,
      this.width,
      this.textSize,
      this.textBold = false,
      required this.trailling,
      this.addBorder = false,
      this.borderColor});
  final void Function()? onTap;
  final String text;
  final Color? color, textColor, shadowColor, borderColor;
  final double? horPadding, verPadding, width, textSize;
  final bool textBold, addBorder;
  final Widget trailling;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: borderColor ?? GbsSystemServerStrings.str_primary_color),
          borderRadius: BorderRadius.circular(6),
          color: color ?? GbsSystemServerStrings.str_primary_color,
          boxShadow: shadowColor != null
              ? [
                  BoxShadow(
                    color: shadowColor!,
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: const Offset(1, 2), // changes the shadow position
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: verPadding ?? size.height * 0.025,
              horizontal: horPadding ?? size.width * 0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              trailling,
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: textSize ?? 18,
                      letterSpacing: 2,
                      color: textColor ?? Colors.white,
                      fontWeight:
                          textBold ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.onTap,
    required this.icon,
    this.color,
    this.horPadding,
    this.verPadding,
    this.shadowColor,
    this.width,
  });
  final void Function()? onTap;
  final Icon icon;
  final Color? color, shadowColor;
  final double? horPadding, verPadding, width;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color ?? GbsSystemServerStrings.str_primary_color,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: verPadding ?? size.width * 0.02,
              horizontal: horPadding ?? size.width * 0.02),
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}
