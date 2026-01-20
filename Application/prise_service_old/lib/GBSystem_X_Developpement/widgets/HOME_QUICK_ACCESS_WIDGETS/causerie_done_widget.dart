import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

class CauserieDoneWidget extends StatelessWidget {
  const CauserieDoneWidget(
      {super.key,
      required this.causerieModel,
      this.onDeleteTap,
      this.onViewTap});
  final CauserieModel causerieModel;
  final void Function()? onDeleteTap, onViewTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black45),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: GbsSystemServerStrings.str_primary_color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GBSystem_TextHelper().smallText(
                            text: causerieModel.SVR_LIB,
                            textColor: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  GBSystem_TextHelper().smallText(
                      text: "${GbsSystemStrings.str_lieu} : ",
                      fontWeight: FontWeight.bold,
                      textColor: Colors.black),
                  GBSystem_TextHelper().smallText(
                      text: causerieModel.LIE_LIB, textColor: Colors.black),
                ],
              ),
              Row(
                children: [
                  GBSystem_TextHelper().smallText(
                      text: "${GbsSystemStrings.str_date_debut} : ",
                      fontWeight: FontWeight.bold,
                      textColor: Colors.black),
                  GBSystem_TextHelper().smallText(
                      text: causerieModel.LIEINSPSVR_START_DATE != null
                          ? ConvertDateService().parseDateAndTime(
                              date: causerieModel.LIEINSPSVR_START_DATE!)
                          : "",
                      textColor: Colors.black),
                ],
              ),
              Row(
                children: [
                  GBSystem_TextHelper().smallText(
                      text: "${GbsSystemStrings.str_date_fin} : ",
                      fontWeight: FontWeight.bold,
                      textColor: Colors.black),
                  GBSystem_TextHelper().smallText(
                      text: causerieModel.LIEINSPSVR_END_DATE != null
                          ? ConvertDateService().parseDateAndTime(
                              date: causerieModel.LIEINSPSVR_END_DATE!)
                          : "",
                      textColor: Colors.black),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: onViewTap,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200),
                        child: Icon(
                          CupertinoIcons.eye,
                          color: Colors.black,
                        ),
                      )),
                  InkWell(
                      onTap: onDeleteTap,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200),
                        child: Icon(
                          CupertinoIcons.delete,
                          color: Colors.black,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
        // Positioned(
        //   top: -10,
        //   right: 8,
        //   child: CircleAvatar(
        //       radius: 12,
        //       backgroundColor: Colors.green,
        //       child: Icon(
        //         Icons.done,
        //         color: Colors.white,
        //       )),
        // ),
      ],
    );
  }
}
