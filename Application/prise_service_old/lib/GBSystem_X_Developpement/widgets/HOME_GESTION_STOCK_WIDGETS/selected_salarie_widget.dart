import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_gestion_stock_model.dart';

class SelectedSalarieWidgetGestionStock extends Card {
  const SelectedSalarieWidgetGestionStock({
    super.key,
    required this.salarie,
    this.onDeleteTap,
  });

  final SalarieGestionStockModel? salarie;
  final void Function()? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GBSystem_TextHelper().normalText(
                        text: salarie?.SVR_LIB ?? "",
                        maxLines: 2,
                        textColor: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: onDeleteTap,
                    child: const Icon(
                      CupertinoIcons.delete,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.8),
                    child: GBSystem_TextHelper().smallText(
                        text: salarie?.SVR_LIB ?? "",
                        maxLines: 2,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.8),
                    child: GBSystem_TextHelper().smallText(
                        text: salarie?.SVR_CODE ?? "",
                        maxLines: 3,
                        textColor: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
