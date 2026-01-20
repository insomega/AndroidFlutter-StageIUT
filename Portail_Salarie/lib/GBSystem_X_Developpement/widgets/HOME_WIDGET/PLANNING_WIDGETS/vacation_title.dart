import 'package:flutter/material.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationTitle extends StatelessWidget {
  const VacationTitle(
      {super.key,
      required this.title,
      this.width,
      this.maxLines,
      this.color,
      this.textColor});

  final String? title;
  final double? width;
  final Color? color, textColor;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.width * 0.015,
      ),
      decoration: BoxDecoration(
        color: color ?? GbsSystemStrings.str_primary_color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title ?? "",
          maxLines: maxLines,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.white,
              overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
