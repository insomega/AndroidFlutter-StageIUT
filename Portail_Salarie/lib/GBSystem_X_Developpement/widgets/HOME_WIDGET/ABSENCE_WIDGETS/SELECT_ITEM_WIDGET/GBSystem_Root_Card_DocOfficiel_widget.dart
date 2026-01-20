import 'package:flutter/material.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_officiel_select_item_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_de_jour_model.dart';

class GBSystem_Root_CardView_DocOfficiel_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_DocOfficiel_Widget({
    super.key,
    required this.docOff,
    this.onTap,
    this.tileColor,
  });
  final getDocumentOfficielSelectItemModel docOff;
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
          docOff.DOCOFF_LIB,
          maxLines: 2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              docOff.DOCOFF_IDF,
              maxLines: 2,
            ),
            Text(
              docOff.DGRP_LIB ?? "",
              maxLines: 2,
            ),

            // Text(docOff.TPH_LIB),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper().normalText(
              text: docOff.DOCOFF_LIB.substring(0, 1).toUpperCase(),
              textColor: Colors.white),
        ),
        // trailing: Text(docOff.DOCOFF_LIB),
      ),
    );
  }
}

class GBSystem_Root_CardView_TypeJour_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_TypeJour_Widget({
    super.key,
    required this.typeDeJour,
    this.onTap,
    this.tileColor,
  });
  final TypeDeJourModel typeDeJour;
  final Color? tileColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: tileColor),
      child: ListTile(
        onTap: onTap,
        isThreeLine: true,
        title: Text(typeDeJour.SYSDAY_SHORTDESC),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(typeDeJour.SYSDAY_NUM),
            Text(typeDeJour.SYSDAY_LONGDESC),

            // Text(typeDeJour.TPH_LIB),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper().normalText(
              text: typeDeJour.SYSDAY_SHORTDESC.substring(0, 1).toUpperCase(),
              textColor: Colors.white),
        ),
        // trailing: Text(typeDeJour.DOCOFF_LIB),
      ),
    );
  }
}
