import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/checked_with_type_reponse_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_reponse_qcm_model.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

class QCMQuestionWidget extends StatelessWidget {
  const QCMQuestionWidget(
      {super.key,
      required this.reponseQCMModel,
      required this.index,
      required this.showChecked,
      this.onTap});
  final ReponseQCMModel reponseQCMModel;
  final int index;
  final CheckedWithTypeReponseModel showChecked;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading:
          GBSystem_TextHelper().smallText(text: index.toString(), maxLines: 1),
      title: GBSystem_TextHelper()
          .smallText(text: "${reponseQCMModel.LIEINSPQCM_LIB}", maxLines: 10),
      trailing: showChecked.isChecked
          ? showChecked.isTrueAnswer
              ? const Icon(
                  Icons.check_box,
                  color: GbsSystemServerStrings.str_primary_color,
                )
              : const Icon(
                  Icons.edit_document,
                  color: Colors.red,
                )
          : null,
    );
  }
}
