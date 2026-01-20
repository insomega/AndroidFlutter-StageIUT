import 'package:flutter/material.dart';

import '../../../helper/GBSystem_text_helper.dart';
import '../../../models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_agence_model.dart';

class GBSystem_Root_CardView_Agence_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_Agence_Widget({
    super.key,
    required this.agence,
    this.onTap,
    this.tileColor,
  });
  final GbsystemAgenceModel agence;
  final Color? tileColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: tileColor),
      child: ListTile(
        onTap: onTap,
        isThreeLine: true,
        title: Text(
          agence.DOS_LIB,
          maxLines: 2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              agence.DOS_CODE,
              maxLines: 2,
            ),
            Text(
              "",
              maxLines: 2,
            ),

            // Text(agence.TPH_LIB),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper().normalText(
              text: agence.DOS_LIB.substring(0, 1).toUpperCase(),
              textColor: Colors.white),
        ),
        // trailing: Text(agence.DIP_LIB),
      ),
    );
  }
}
