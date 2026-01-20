// ignore_for_file: prefer_null_aware_operators

import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_memo_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_questionnaire_quick_acces_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_quick_access_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_type_questionnaire_quick_access_model.dart';

class CustomDropDownButtonSite extends StatelessWidget {
  const CustomDropDownButtonSite({
    super.key,
    required this.selectedItem,
    required this.listItems,
    required this.hint,
    this.onChanged,
    this.validator,
    this.onTap,
  });

  final SiteQuickAccesModel? selectedItem;
  final List<SiteQuickAccesModel> listItems;
  final String hint;
  final void Function()? onTap;
  final String? Function(SiteQuickAccesModel?)? validator;
  final void Function(SiteQuickAccesModel?)? onChanged;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(size.width * 0.01),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 0),
            borderRadius: BorderRadius.circular(20)),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<SiteQuickAccesModel>(
              // onTap: onTap,
              decoration: const InputDecoration(border: InputBorder.none),
              validator: validator,
              isExpanded: true,
              hint: selectedItem == null
                  ? Center(child: Text(hint))
                  : Text(selectedItem!.CLI_IDF),
              value: selectedItem,
              items: listItems
                  .map((item) => DropdownMenuItem<SiteQuickAccesModel>(
                      value: item,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            item.LIE_LIB,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18,
                                //fontFamily: 'BebasNeue',
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            item.LIE_CODE,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18,
                                //fontFamily: 'BebasNeue',
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )))
                  .toList(),
              onChanged: onChanged),
        ),
      ),
    );
  }
}

class CustomDropDownButtonQuestionnaire extends StatelessWidget {
  const CustomDropDownButtonQuestionnaire({
    super.key,
    required this.selectedItem,
    required this.listItems,
    required this.hint,
    this.onChanged,
    this.validator,
    this.isExpanded = true,
    this.width,
    this.onTap,
    this.enable = true,
  });
  final bool enable;
  final QuestionnaireModel? selectedItem;
  final List<QuestionnaireModel> listItems;
  final String hint;
  final void Function()? onTap;
  final String? Function(QuestionnaireModel?)? validator;
  final void Function(QuestionnaireModel?)? onChanged;
  final bool isExpanded;
  final double? width;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.all(size.width * 0.01),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 0),
            borderRadius: BorderRadius.circular(20)),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<QuestionnaireModel>(
              decoration: const InputDecoration(border: InputBorder.none),
              validator: validator,
              isExpanded: isExpanded,
              hint: selectedItem == null
                  ? Center(child: Text(hint))
                  : Center(child: Text(selectedItem!.LIEINSPQSNR_CODE)),
              value: selectedItem,
              items: listItems
                  .map((item) => DropdownMenuItem<QuestionnaireModel>(
                        enabled: enable,
                        value: item,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              item.LIEINSPQSNR_CODE,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18,
                                  //fontFamily: 'BebasNeue',
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const VerticalDivider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              item.LIEINSQUESTYP_LIB,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18,
                                  //fontFamily: 'BebasNeue',
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: onChanged),
        ),
      ),
    );
  }
}

class CustomDropDownButtonTypeQuestionnaire extends StatelessWidget {
  const CustomDropDownButtonTypeQuestionnaire({
    super.key,
    required this.selectedItem,
    required this.listItems,
    required this.hint,
    this.onChanged,
    this.validator,
    this.isExpanded = true,
    this.width,
    this.onTap,
  });

  final TypeQuestionnaireModel? selectedItem;
  final List<TypeQuestionnaireModel> listItems;
  final String hint;
  final void Function()? onTap;
  final String? Function(TypeQuestionnaireModel?)? validator;
  final void Function(TypeQuestionnaireModel?)? onChanged;
  final bool isExpanded;
  final double? width;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: width,
      padding: EdgeInsets.all(size.width * 0.01),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0),
          borderRadius: BorderRadius.circular(20)),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<TypeQuestionnaireModel>(
            onTap: onTap,
            decoration: const InputDecoration(border: InputBorder.none),
            validator: validator,
            isExpanded: isExpanded,
            hint: selectedItem == null
                ? Center(child: Text(hint))
                : Center(child: Text(selectedItem!.LIEINSQUESTYP_CODE)),
            value: selectedItem,
            items: listItems
                .map((item) => DropdownMenuItem<TypeQuestionnaireModel>(
                      value: item,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            item.LIEINSQUESTYP_CODE,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18,
                                //fontFamily: 'BebasNeue',
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            item.LIEINSQUESTYP_LIB,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18,
                                //fontFamily: 'BebasNeue',
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: onChanged),
      ),
    );
  }
}

class CustomDropDownButtonString extends StatelessWidget {
  const CustomDropDownButtonString({
    super.key,
    required this.selectedItem,
    required this.listItems,
    required this.hint,
    this.onChanged,
    this.validator,
    this.onTap,
    this.width,
  });
  final double? width;
  final String? selectedItem;
  final List<String?>? listItems;
  final String hint;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: width,
      padding: EdgeInsets.all(size.width * 0.01),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(12)),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
            onTap: onTap,
            decoration: const InputDecoration(border: InputBorder.none),
            validator: validator,
            isExpanded: true,
            hint: selectedItem == null
                ? Center(child: Text(hint))
                : Text(selectedItem!),
            value: selectedItem,
            items: listItems != null
                ? listItems!
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item!,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ))
                    .toList()
                : null,
            onChanged: onChanged),
      ),
    );
  }
}

class CustomDropDownButtonMemo extends StatelessWidget {
  const CustomDropDownButtonMemo({
    super.key,
    required this.selectedItem,
    required this.listItems,
    required this.hint,
    this.onChanged,
    this.validator,
    this.isExpanded = true,
    this.width,
    this.onTap,
  });

  final MemoQuestionModel? selectedItem;
  final List<MemoQuestionModel?>? listItems;
  final String hint;
  final void Function()? onTap;
  final String? Function(MemoQuestionModel?)? validator;
  final void Function(MemoQuestionModel?)? onChanged;
  final bool isExpanded;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0),
          borderRadius: BorderRadius.circular(8)),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<MemoQuestionModel>(
            onTap: onTap,
            decoration: const InputDecoration(border: InputBorder.none),
            validator: validator,
            isExpanded: isExpanded,
            hint: selectedItem == null
                ? Center(child: Text(hint))
                : Center(child: Text(selectedItem!.LIEINSMMO_LIB)),
            value: selectedItem,
            items: listItems!
                .map((item) => DropdownMenuItem<MemoQuestionModel>(
                      value: item,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item!.LIEINSMMO_LIB,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: onChanged),
      ),
    );
  }
}
