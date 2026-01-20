import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

class CauserieQuestionWidget extends StatefulWidget {
  const CauserieQuestionWidget(
      {super.key, required this.questionModel, this.onInfoTap});
  final QuestionModel questionModel;
  final void Function()? onInfoTap;
  @override
  State<CauserieQuestionWidget> createState() => _CauserieQuestionWidgetState();
}

class _CauserieQuestionWidgetState extends State<CauserieQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: -15,
              blurRadius: 18,
              offset: const Offset(10, 20), // changes the shadow position
            ),
          ],
          border: Border.all(width: 1, color: Colors.black45),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade200),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: widget.questionModel.questionWithoutMemoModel
                            .LIEINSPQU_HELP !=
                        null &&
                    widget.questionModel.questionWithoutMemoModel
                        .LIEINSPQU_HELP!.isNotEmpty,
                child: InkWell(
                  onTap: widget.onInfoTap,
                  child: Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      CupertinoIcons.info_circle_fill,
                      color: GbsSystemServerStrings.str_primary_color,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 85,
                child: GBSystem_TextHelper().smallText(
                    text: "${GbsSystemStrings.str_question} : ",
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget
                        .questionModel.questionWithoutMemoModel.LIEINSPQU_LIB,
                    maxLines: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}
