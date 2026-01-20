import 'package:flutter/material.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_agrement_select_item_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_ville_model.dart';

class GBSystem_Root_CardView_Agrement_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_Agrement_Widget({
    super.key,
    required this.agrements,
    this.onTap,
    this.tileColor,
  });
  final getAgrementSelectItemModel agrements;
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
          agrements.HAB_LIB,
          maxLines: 2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              agrements.HAB_IDF,
              maxLines: 2,
            ),
            Text(
              agrements.DGRP_LIB ?? "",
              maxLines: 2,
            ),

            // Text(agrements.TPH_LIB),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper().normalText(
              text: agrements.HAB_LIB.substring(0, 1).toUpperCase(),
              textColor: Colors.white),
        ),
        // trailing: Text(agrements.HAB_LIB),
      ),
    );
  }
}

class GBSystem_Root_CardView_Ville_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_Ville_Widget({
    super.key,
    required this.ville,
    this.onTap,
    this.tileColor,
  });
  final GbsystemVilleModel ville;
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
          ville.VIL_LIB,
          maxLines: 2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ville.VIL_CODE,
              maxLines: 2,
            ),
            // Text(
            //   ville.DGRP_LIB,
            //   maxLines: 2,
            // ),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper()
              .normalText(text: "VIL", textColor: Colors.white),
        ),
      ),
    );
  }
}
