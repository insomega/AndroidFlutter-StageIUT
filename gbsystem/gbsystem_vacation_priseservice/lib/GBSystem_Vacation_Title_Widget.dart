import 'package:flutter/material.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

class GBSystem_Vacation_Title_Widget extends StatelessWidget {
  const GBSystem_Vacation_Title_Widget({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: size.width * 0.015),
      decoration: BoxDecoration(color: GBSystem_Application_Strings.str_primary_color, borderRadius: BorderRadius.circular(10)),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
