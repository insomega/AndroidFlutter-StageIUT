import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_publication_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_title.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class PublicationWidget extends StatelessWidget {
  const PublicationWidget(
      {super.key,
      required this.publicationModel,
      this.onTelechargerTap,
      this.onTap,
      this.onAfficherTap,
      this.showDownloadBtn = true,
      this.btnDisplayText});
  final bool showDownloadBtn;
  final String? btnDisplayText;
  final PublicationModel publicationModel;
  final void Function()? onTelechargerTap, onAfficherTap, onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VacationTitle(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.7),
                    maxLines: 3,
                    title: publicationModel.SVRPPH_START_DATE != null
                        ? PublicationModel.convertDate(
                            publicationModel.SVRPPH_START_DATE!)
                        : ""),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${GbsSystemStrings.str_debut.tr} : ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: GbsSystemStrings.str_primary_color),
                ),
                Flexible(
                  child: Text(
                    publicationModel.SVRPPH_START_DATE != null
                        ? PublicationModel.convertDate(
                            publicationModel.SVRPPH_START_DATE!)
                        : "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${GbsSystemStrings.str_fin.tr} : ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: GbsSystemStrings.str_primary_color),
                ),
                Flexible(
                  child: Text(
                    publicationModel.SVRPPH_END_DATE != null
                        ? PublicationModel.convertDate(
                            publicationModel.SVRPPH_END_DATE!)
                        : "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${GbsSystemStrings.str_publication.tr} : ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: GbsSystemStrings.str_primary_color),
                ),
                Flexible(
                  child: Text(
                    publicationModel.SVRPPH_HIST != null
                        ? PublicationModel.convertDate(
                            publicationModel.SVRPPH_HIST!)
                        : "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: showDownloadBtn,
                  child: CustomButtonWithTrailling(
                      onTap: onTelechargerTap,
                      trailling: Icon(
                        CupertinoIcons.cloud_download,
                        color: Colors.white,
                        size: 16,
                      ),
                      textSize: 16,
                      verPadding: 5,
                      horPadding: 5,
                      text: GbsSystemStrings.str_telecharger.tr),
                ),
                SizedBox(
                  width: 5,
                ),
                CustomButtonWithTrailling(
                    onTap: onAfficherTap,
                    trailling: Icon(
                      CupertinoIcons.eye,
                      color: Colors.white,
                      size: 16,
                    ),
                    textSize: 16,
                    verPadding: 5,
                    horPadding: 5,
                    text: btnDisplayText ?? GbsSystemStrings.str_afficher.tr),
              ],
            )
          ],
        ),
      ),
    );
  }
}
