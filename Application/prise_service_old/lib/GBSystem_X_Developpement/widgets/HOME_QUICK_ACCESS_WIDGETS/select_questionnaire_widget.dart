import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

// class SelectQuestionnaireWidget extends StatelessWidget {
//   const SelectQuestionnaireWidget(
//       {super.key,
//       required this.questionnaireModel,
//       this.onTap,
//       this.onDeleteTap});
//   final QuestionnaireModel? questionnaireModel;
//   final void Function()? onTap, onDeleteTap;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//             horizontal:
//                 GBSystem_ScreenHelper.screenWidthPercentage(context, 0.05),
//             vertical:
//                 GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: GbsSystemServerStrings.str_primary_color.withOpacity(0.3),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GBSystem_TextHelper().smallText(
//                     text: questionnaireModel?.LIEINSPQSNR_CODE ??
//                         GbsSystemStrings.str_no_item_selected,
//                     fontWeight: FontWeight.bold,
//                     textColor: Colors.black),
//                 InkWell(
//                   onTap: onDeleteTap,
//                   child: const Icon(
//                     CupertinoIcons.delete,
//                     color: GbsSystemServerStrings.str_primary_color,
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               children: [
//                 Flexible(
//                   child: GBSystem_TextHelper().smallText(
//                       text: questionnaireModel?.LIEINSPQSNR_LIB ??
//                           questionnaireModel?.LIEINSQUESTYP_LIB ??
//                           "",
//                       fontWeight: FontWeight.bold,
//                       textColor: Colors.black),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GBSystem_TextHelper().smallText(
//                   text: GbsSystemStrings.str_questionnaire,
//                   textColor: GbsSystemServerStrings.str_primary_color,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 const Icon(
//                   CupertinoIcons.arrow_right,
//                   color: GbsSystemServerStrings.str_primary_color,
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SelectSiteWidget extends StatelessWidget {
//   const SelectSiteWidget(
//       {super.key, required this.siteModel, this.onTap, this.onDeleteTap});
//   final SiteQuickAccesModel? siteModel;
//   final void Function()? onTap, onDeleteTap;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//             horizontal:
//                 GBSystem_ScreenHelper.screenWidthPercentage(context, 0.05),
//             vertical:
//                 GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: GbsSystemServerStrings.str_primary_color.withOpacity(0.3),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GBSystem_TextHelper().smallText(
//                     text: siteModel?.LIE_LIB ??
//                         GbsSystemStrings.str_no_item_selected,
//                     fontWeight: FontWeight.bold,
//                     textColor: Colors.black),
//                 InkWell(
//                   onTap: onDeleteTap,
//                   child: const Icon(
//                     CupertinoIcons.delete,
//                     color: GbsSystemServerStrings.str_primary_color,
//                   ),
//                 )
//               ],
//             ),
//             GBSystem_TextHelper().smallText(
//                 text: siteModel?.LIE_CODE ?? "",
//                 fontWeight: FontWeight.bold,
//                 textColor: Colors.black),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GBSystem_TextHelper().smallText(
//                   text: GbsSystemStrings.str_lieu,
//                   textColor: GbsSystemServerStrings.str_primary_color,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 const Icon(
//                   CupertinoIcons.arrow_right,
//                   color: GbsSystemServerStrings.str_primary_color,
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SelectTypeQuestionnaireWidget extends StatelessWidget {
//   const SelectTypeQuestionnaireWidget(
//       {super.key,
//       required this.typeQuestionnaire,
//       this.onTap,
//       this.onDeleteTap});
//   final TypeQuestionnaireModel? typeQuestionnaire;
//   final void Function()? onTap, onDeleteTap;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//             horizontal:
//                 GBSystem_ScreenHelper.screenWidthPercentage(context, 0.05),
//             vertical:
//                 GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: GbsSystemServerStrings.str_primary_color,
//           // .withOpacity(0.3),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GBSystem_TextHelper().smallText(
//                     text: typeQuestionnaire?.LIEINSQUESTYP_CODE ??
//                         GbsSystemStrings.str_no_item_selected,
//                     fontWeight: FontWeight.bold,
//                     textColor: Colors.white),
//                 InkWell(
//                   onTap: onDeleteTap,
//                   child: const Icon(
//                     CupertinoIcons.delete,
//                     color: Colors.white ??
//                         GbsSystemServerStrings.str_primary_color,
//                   ),
//                 )
//               ],
//             ),
//             GBSystem_TextHelper().smallText(
//                 text: typeQuestionnaire?.LIEINSQUESTYP_LIB ?? "",
//                 fontWeight: FontWeight.bold,
//                 textColor: Colors.white),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GBSystem_TextHelper().smallText(
//                   text: GbsSystemStrings.str_type_questionnaire,
//                   textColor:
//                       Colors.grey ?? GbsSystemServerStrings.str_primary_color,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 const Icon(
//                   CupertinoIcons.arrow_right,
//                   color:
//                       Colors.white ?? GbsSystemServerStrings.str_primary_color,
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SelectWidgetGenerique extends StatelessWidget {
  const SelectWidgetGenerique({
    super.key,
    required this.opt1Str,
    required this.selectedItemStr,
    this.onTap,
    this.onDeleteTap,
    required this.catStr,
    this.isObligatoire = false,
  });
  final String? selectedItemStr;
  final String? opt1Str;
  final String catStr;
  final bool isObligatoire;

  final void Function()? onTap, onDeleteTap;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal:
                GBSystem_ScreenHelper.screenWidthPercentage(context, 0.05),
            vertical:
                GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                GbsSystemServerStrings.str_primary_color.withOpacity(0.8),
                GbsSystemServerStrings.str_primary_color.withOpacity(0.4),
                // GbsSystemServerStrings.str_primary_color,
              ]),
          // color: GbsSystemServerStrings.str_primary_color.withOpacity(0.8),
          // .withOpacity(0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GBSystem_TextHelper().bettwenSmallAndNormalText(
                    text: selectedItemStr ??
                        (!isObligatoire
                            ? GbsSystemStrings.str_no_item_selected
                            : GbsSystemStrings.str_stp_select_item),
                    fontWeight: FontWeight.bold,
                    textColor: Colors.white),
                InkWell(
                  onTap: onDeleteTap,
                  child: const Icon(
                    CupertinoIcons.delete,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            GBSystem_TextHelper().smallText(
                text: opt1Str ?? "",
                fontWeight: FontWeight.bold,
                textColor: Colors.white),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GBSystem_TextHelper().smallText(
                      text: catStr,
                      // GbsSystemStrings.str_type_questionnaire,
                      textColor: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    isObligatoire
                        ? Icon(
                            Icons.ac_unit_outlined,
                            color: Colors.red,
                            size: 10,
                          )
                        : Container()
                  ],
                ),
                const Icon(
                  CupertinoIcons.arrow_right,
                  color: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
