import 'package:flutter/material.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

class VacationTitle extends StatelessWidget {
  const VacationTitle({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.01,
        vertical: size.width * 0.015,
      ),
      decoration: BoxDecoration(
        color: GbsSystemServerStrings.str_primary_color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
