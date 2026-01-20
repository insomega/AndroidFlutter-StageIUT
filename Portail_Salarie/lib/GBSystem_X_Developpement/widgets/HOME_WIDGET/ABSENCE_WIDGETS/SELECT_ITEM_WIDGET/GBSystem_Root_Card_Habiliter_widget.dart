import 'package:flutter/material.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_habiliter_select_item_model.dart';

class GBSystem_Root_CardView_Habiliter_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_Habiliter_Widget({
    super.key,
    required this.habiliter,
    this.onTap,
    this.tileColor,
  });
  final getHabiliterSelectItemModel habiliter;
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
          habiliter.FOR_LIB,
          maxLines: 2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              habiliter.FOR_LIB,
              maxLines: 2,
            ),
            Text(
              habiliter.FOR_IDF,
              maxLines: 2,
            ),
            Text(
              habiliter.DGRP_LIB ?? "",
              maxLines: 2,
            ),

            // Text(habiliter.TPH_LIB),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper().normalText(
              text: habiliter.FOR_LIB.substring(0, 1).toUpperCase(),
              textColor: Colors.white),
        ),
        // trailing: Text(habiliter.FOR_LIB),
      ),
    );
  }
}
