import 'package:flutter/material.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_diplome_select_item_model.dart';

class GBSystem_Root_CardView_Diplome_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_Diplome_Widget({
    super.key,
    required this.diplome,
    this.onTap,
    this.tileColor,
  });
  final getDiplomeSelectItemModel diplome;
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
          diplome.DIP_LIB,
          maxLines: 2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              diplome.DIP_IDF,
              maxLines: 2,
            ),
            Text(
              diplome.DGRP_LIB ?? "",
              maxLines: 2,
            ),

            // Text(diplome.TPH_LIB),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper().normalText(
              text: diplome.DIP_LIB.substring(0, 1).toUpperCase(),
              textColor: Colors.white),
        ),
        // trailing: Text(diplome.DIP_LIB),
      ),
    );
  }
}
