import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_button_entrer_sortie.dart';
import 'package:gbsystem_root/GBSystem_convert_date_service.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_vacation_model.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

class GBSystem_Root_CardViewWidgetGenerique extends StatelessWidget {
  const GBSystem_Root_CardViewWidgetGenerique({super.key, required this.optStr1, required this.optStr2, required this.optStr3, required this.title, this.onTap, this.tileColor, this.circleColor, this.textCircleColor, this.showCircleBorder});
  final String? optStr1, optStr2, optStr3;
  final String title;
  final Color? tileColor, circleColor, textCircleColor;
  final bool? showCircleBorder;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 0.4, color: Colors.grey),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1)],
        borderRadius: BorderRadius.circular(12),
        color: tileColor,
      ),
      child: ListTile(
        onTap: onTap,
        isThreeLine: true,
        title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(optStr1 ?? "", maxLines: 2, overflow: TextOverflow.ellipsis),
            optStr2 != null ? Text(optStr2!, maxLines: 2, overflow: TextOverflow.ellipsis) : Container(),
            Text(optStr3 ?? "", maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
        leading: CircleAvatar(
          radius: showCircleBorder == true ? 32 : 30,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: circleColor ?? Colors.blue,
            child: GBSystem_TextHelper().normalText(text: title.substring(0, 1).toUpperCase(), textColor: textCircleColor ?? Colors.white),
          ),
        ),
        // trailing: Text(
        //   site.LIE_CODE,
        //   maxLines: 2,
        //   overflow: TextOverflow.ellipsis,
        // ),
      ),
    );
  }
}

// class GBSystem_Root_CardViewWidget extends StatelessWidget {
//   const GBSystem_Root_CardViewWidget({
//     super.key,
//     required this.site,
//     this.onTap,
//     this.tileColor,
//   });
//   final SitePlanningModel site;
//   final Color? tileColor;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 5),
//       decoration: BoxDecoration(
//           border: Border.all(width: 0.4),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 1,
//               spreadRadius: 1,
//             ),
//           ],
//           borderRadius: BorderRadius.circular(12),
//           color: tileColor),
//       child: ListTile(
//         onTap: onTap,
//         isThreeLine: true,
//         title: Text(
//           site.LIE_LIB,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               site.LIE_ADR1,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             site.LIE_ADR2 != null
//                 ? Text(
//                     site.LIE_ADR2!,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   )
//                 : Container(),
//             Text(
//               site.VIL_LIB,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//         leading: CircleAvatar(
//           radius: 30,
//           backgroundColor: Colors.blue,
//           child: GBSystem_TextHelper().normalText(
//               text: site.LIE_LIB.substring(0, 1).toUpperCase(),
//               textColor: Colors.white),
//         ),
//         // trailing: Text(
//         //   site.LIE_CODE,
//         //   maxLines: 2,
//         //   overflow: TextOverflow.ellipsis,
//         // ),
//       ),
//     );
//   }
// }

// class GBSystem_Root_CardView_SalarieWidget extends StatelessWidget {
//   const GBSystem_Root_CardView_SalarieWidget({
//     super.key,
//     required this.salarie,
//     this.onTap,
//     this.tileColor,
//   });
//   final SalariePlanningModel salarie;
//   final Color? tileColor;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: tileColor),
//       child: ListTile(
//         onTap: onTap,
//         isThreeLine: true,
//         title: Text(
//           "${salarie.SVR_NOM} ${salarie.SVR_PRNOM}",
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               salarie.VIL_LIB,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             Text(
//               salarie.VIL_CODE,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//         leading: CircleAvatar(
//           radius: 30,
//           backgroundColor: Colors.blue,
//           child: GBSystem_TextHelper().normalText(
//               text: salarie.SVR_NOM.substring(0, 1).toUpperCase() +
//                   salarie.SVR_PRNOM.substring(0, 1).toUpperCase(),
//               textColor: Colors.white),
//         ),
//         // trailing: Text(
//         //   salarie.SVR_CODE,
//         //   maxLines: 2,
//         //   overflow: TextOverflow.ellipsis,
//         // ),
//       ),
//     );
//   }
// }

// class GBSystem_Root_CardView_SiteQuickAccess extends StatelessWidget {
//   const GBSystem_Root_CardView_SiteQuickAccess({
//     super.key,
//     required this.site,
//     this.onTap,
//     this.tileColor,
//   });
//   final SiteQuickAccesModel site;
//   final Color? tileColor;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: tileColor),
//       child: ListTile(
//         onTap: onTap,
//         isThreeLine: true,
//         title: Text(
//           site.LIE_LIB,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               site.LIE_CODE,
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//         leading: CircleAvatar(
//           radius: 30,
//           backgroundColor: Colors.blue,
//           child: GBSystem_TextHelper().normalText(
//               text: site.LIE_LIB.substring(0, 1).toUpperCase() +
//                   site.LIE_LIB.substring(0, 1).toUpperCase(),
//               maxLines: 2,
//               textColor: Colors.white),
//         ),
//         // trailing: Text(
//         //   site.LIE_LIB,
//         //   maxLines: 2,
//         //   overflow: TextOverflow.ellipsis,
//         // ),
//       ),
//     );
//   }
// }

// class GBSystem_Root_CardView_QuestionnaireQuickAccess extends StatelessWidget {
//   const GBSystem_Root_CardView_QuestionnaireQuickAccess({
//     super.key,
//     required this.questionnaire,
//     this.onTap,
//     this.tileColor,
//   });
//   final QuestionnaireModel questionnaire;
//   final Color? tileColor;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: tileColor),
//       child: ListTile(
//         onTap: onTap,
//         isThreeLine: true,
//         title: Text(
//           questionnaire.LIEINSPQSNR_CODE,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               questionnaire.LIEINSPQSNR_LIB,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//         leading: CircleAvatar(
//           radius: 30,
//           backgroundColor: Colors.blue,
//           child: GBSystem_TextHelper().normalText(
//               text: questionnaire.LIEINSPQSNR_CODE
//                       .substring(0, 1)
//                       .toUpperCase() +
//                   questionnaire.LIEINSPQSNR_CODE.substring(0, 1).toUpperCase(),
//               textColor: Colors.white),
//         ),
//         // trailing: Text(
//         //   questionnaire.LIEINSQUESTYP_LIB,
//         //   maxLines: 2,
//         //   overflow: TextOverflow.ellipsis,
//         // ),
//       ),
//     );
//   }
// }

// class GBSystem_Root_CardView_TypeQuestionnaireQuickAccess
//     extends StatelessWidget {
//   const GBSystem_Root_CardView_TypeQuestionnaireQuickAccess({
//     super.key,
//     required this.typeQuestionnaire,
//     this.onTap,
//     this.tileColor,
//   });
//   final TypeQuestionnaireModel typeQuestionnaire;
//   final Color? tileColor;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: tileColor),
//       child: ListTile(
//         onTap: onTap,
//         isThreeLine: true,
//         title: Text(
//           typeQuestionnaire.LIEINSQUESTYP_CODE,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               typeQuestionnaire.LIEINSQUESTYP_LIB,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//         leading: CircleAvatar(
//           radius: 30,
//           backgroundColor: Colors.blue,
//           child: GBSystem_TextHelper().normalText(
//               text: typeQuestionnaire.LIEINSQUESTYP_LIB
//                       .substring(0, 1)
//                       .toUpperCase() +
//                   typeQuestionnaire.LIEINSQUESTYP_LIB
//                       .substring(0, 1)
//                       .toUpperCase(),
//               textColor: Colors.white),
//         ),
//         // trailing: Text(
//         //   typeQuestionnaire.LIEINSQUESTYP_LIB,
//         //   maxLines: 2,
//         //   overflow: TextOverflow.ellipsis,
//         // ),
//       ),
//     );
//   }
// }

// class GBSystem_Root_CardView_SiteGestionStockWidget extends StatelessWidget {
//   const GBSystem_Root_CardView_SiteGestionStockWidget({
//     super.key,
//     required this.site,
//     this.onTap,
//     this.tileColor,
//   });
//   final SiteGestionStockModel site;
//   final Color? tileColor;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: tileColor),
//       child: ListTile(
//         onTap: onTap,
//         isThreeLine: true,
//         title: Text(
//           "${site.DOS_LIB}",
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               site.DOS_CODE,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             // Text(
//             //   site.DOS_LIB,
//             //   maxLines: 2,
//             //   overflow: TextOverflow.ellipsis,
//             // ),
//           ],
//         ),
//         leading: CircleAvatar(
//           radius: 30,
//           backgroundColor: Colors.blue,
//           child: GBSystem_TextHelper()
//               .normalText(text: "AG", textColor: Colors.white),
//         ),
//         // trailing: Text(
//         //   salarie.SVR_CODE,
//         //   maxLines: 2,
//         //   overflow: TextOverflow.ellipsis,
//         // ),
//       ),
//     );
//   }
// }

// class GBSystem_Root_CardView_SalarieGestionStockWidget extends StatelessWidget {
//   const GBSystem_Root_CardView_SalarieGestionStockWidget({super.key, required this.salarie, this.onTap, this.tileColor});
//   final SalarieGestionStockModel salarie;
//   final Color? tileColor;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoButton(
//       onPressed: onTap,
//       child: Container(
//         decoration: BoxDecoration(color: tileColor),
//         child: ListTile(
//           // onTap: onTap,
//           isThreeLine: true,
//           title: Text("${salarie.SVR_LIB}", maxLines: 2, overflow: TextOverflow.ellipsis),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(salarie.SVR_CODE, maxLines: 2, overflow: TextOverflow.ellipsis),
//               // Text(
//               //   salarie.SVR_LIB,
//               //   maxLines: 2,
//               //   overflow: TextOverflow.ellipsis,
//               // ),
//             ],
//           ),
//           leading: CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.blue,
//             child: GBSystem_TextHelper().normalText(text: "SAL", textColor: Colors.white),
//           ),
//           // trailing: Text(
//           //   salarie.SVR_CODE,
//           //   maxLines: 2,
//           //   overflow: TextOverflow.ellipsis,
//           // ),
//         ),
//       ),
//     );
//   }
// }

class GBSystem_Root_CardView_VacationWidget extends StatelessWidget {
  const GBSystem_Root_CardView_VacationWidget({
    super.key,
    required this.vacation,
    this.onTap,
    this.tileColor,
    this.isSelected = false,
    this.onLongPress,
    this.onEnterTap,
    this.onSortieTap,
    this.onCallTap,
    this.onLeadingTap, // 👈 nouveau callback
  });

  final GBSystem_Vacation_Model vacation;
  final Color? tileColor;
  final void Function()? onTap, onEnterTap, onSortieTap, onCallTap, onLongPress, onLeadingTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(color: isSelected ? Colors.black38 : tileColor),
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        isThreeLine: true,
        title: Text(vacation.SVR_CODE_LIB, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(vacation.EVT_LIB, maxLines: 2, overflow: TextOverflow.ellipsis),
            Text(vacation.LIE_LIB, maxLines: 2, overflow: TextOverflow.ellipsis),
            Text(
              "${GBSystem_convert_date_service().parseTimeOfDayString(dateDynamic: vacation.HEURE_DEBUT)}-${GBSystem_convert_date_service().parseTimeOfDayString(dateDynamic: vacation.HEURE_FIN)}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: vacation.TPH_PSA == "1",
              child: Row(
                children: [
                  ButtonEntrerSortieWithIconAndText(
                    onTap: onEnterTap,
                    disableBtn: vacation.PNTGS_IN_NBR != null && vacation.PNTGS_IN_NBR!.isNotEmpty,
                    number: vacation.PNTGS_IN_NBR != null && vacation.PNTGS_IN_NBR!.isNotEmpty ? int.parse(vacation.PNTGS_IN_NBR!) : null,
                    icon: const Icon(CupertinoIcons.hand_draw_fill, color: Colors.white),
                    width: 80,
                    verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
                    horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
                    text: GBSystem_Application_Strings.str_entrer,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  ButtonEntrerSortieWithIconAndText(
                    onTap: onSortieTap,
                    disableBtn: vacation.PNTGS_OUT_NBR != null && vacation.PNTGS_OUT_NBR!.isNotEmpty,
                    number: vacation.PNTGS_OUT_NBR != null && vacation.PNTGS_OUT_NBR!.isNotEmpty ? int.parse(vacation.PNTGS_OUT_NBR!) : null,
                    icon: const Icon(CupertinoIcons.hand_draw_fill, color: Colors.white),
                    width: 80,
                    verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
                    horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
                    text: GBSystem_Application_Strings.str_sortie,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: GestureDetector(
          onTap: onLeadingTap, // 👈 appel du callback
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: getColorCircleAvatar(vacation), begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: isSelected ? const Icon(Icons.check, color: Colors.white) : GBSystem_TextHelper().normalText(text: "VAC", textColor: Colors.white),
            ),
          ),
        ),
        // trailing: InkWell(
        //   onTap: onCallTap,
        //   child: Icon(CupertinoIcons.phone_circle_fill, size: 40, color: Colors.grey[700]),
        // ),

        trailing: (vacation.SVR_TELPH != null && vacation.SVR_TELPH!.isNotEmpty)
            ? InkWell(
                onTap: onCallTap,
                child: Icon(
                  CupertinoIcons.phone_circle_fill,
                  size: 40,
                  color: Colors.grey[700],
                ),
              )
            : null,
      ),
    );
  }

  List<Color> getColorCircleAvatar(GBSystem_Vacation_Model vacation) {
    if (vacation.PNTGS_IN_NBR != null && vacation.PNTGS_IN_NBR!.isNotEmpty && vacation.PNTGS_OUT_NBR != null && vacation.PNTGS_OUT_NBR!.isNotEmpty) {
      return [Colors.green, Colors.red];
    } else if ((vacation.PNTGS_IN_NBR == null || vacation.PNTGS_IN_NBR!.isEmpty) && (vacation.PNTGS_OUT_NBR != null && vacation.PNTGS_OUT_NBR!.isNotEmpty)) {
      return [Colors.red, Colors.red];
    } else if ((vacation.PNTGS_OUT_NBR == null || vacation.PNTGS_OUT_NBR!.isEmpty) && vacation.PNTGS_IN_NBR != null && vacation.PNTGS_IN_NBR!.isNotEmpty) {
      return [Colors.green, Colors.green];
    } else {
      return [Colors.blue, Colors.blue];
    }
  }
}
