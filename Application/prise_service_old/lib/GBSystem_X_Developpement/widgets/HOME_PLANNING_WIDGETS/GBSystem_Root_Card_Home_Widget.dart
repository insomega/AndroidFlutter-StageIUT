import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_gestion_stock_with_image_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_article_ref_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_color_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_enterpot_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_fournisseur_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_gestion_stock_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_planning_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_gestion_stock_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_planning_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_vacation_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_button_entrer_sortie.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'dart:convert';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystem_Root_CardViewHome_Widget_Generique extends Card {
  const GBSystem_Root_CardViewHome_Widget_Generique({
    super.key,
    this.onSearchTap,
    required this.title,
    required this.opt1,
    required this.opt2,
    required this.opt3,
    required this.opt4,
  });

  final String? opt1, opt2, opt3, opt4;
  final void Function()? onSearchTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onSearchTap,
      child: Stack(
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    GBSystem_TextHelper().largeText(text: title, maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.bold),
                    InkWell(
                      onTap: onSearchTap,
                      child: const Icon(
                        CupertinoIcons.search,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Divider(
                  indent: 0,
                  color: Colors.transparent,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                        child: GBSystem_TextHelper().normalText(text: opt1 ?? "", maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                        child: GBSystem_TextHelper().smallText(text: opt2 ?? "", maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                        child: GBSystem_TextHelper().smallText(text: opt3 ?? "", maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                        child: GBSystem_TextHelper().smallText(text: opt4 ?? "", textColor: Colors.black, maxLines: 2, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GBSystem_Root_CardViewHome_Widget extends Card {
  const GBSystem_Root_CardViewHome_Widget({super.key, required this.site, this.onSearchTap, required this.title});

  final SitePlanningModel? site;
  final void Function()? onSearchTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onSearchTap,
      child: Stack(
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    GBSystem_TextHelper().largeText(text: title, maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.bold),
                    // Text(
                    //   title,
                    //   style: CupertinoTheme.of(context)
                    //       .textTheme
                    //       .navTitleTextStyle,
                    // ),
                    InkWell(
                      onTap: onSearchTap,
                      child: const Icon(
                        CupertinoIcons.search,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Divider(
                  indent: 0,
                  color: Colors.transparent,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                        child: GBSystem_TextHelper().normalText(text: site!.LIE_LIB, maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                        child: GBSystem_TextHelper().smallText(text: site!.LIE_ADR1, maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                        child: GBSystem_TextHelper().smallText(text: site!.VIL_LIB, maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                        child: GBSystem_TextHelper().smallText(text: site!.LIE_CODE, textColor: Colors.black, maxLines: 2, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          onTap: onSearchTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02), horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                      child: GBSystem_TextHelper().largeText(text: site!.LIE_LIB, maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                      child: GBSystem_TextHelper().normalText(text: site!.LIE_ADR1, maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                      child: GBSystem_TextHelper().normalText(text: site!.VIL_LIB, maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                      child: GBSystem_TextHelper().smallText(text: site!.LIE_CODE, textColor: Colors.black, maxLines: 2, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
            decoration: const BoxDecoration(color: Colors.white),
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: onSearchTap,
            child: const Icon(
              CupertinoIcons.search,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class SalarieGestionStockWidget extends StatefulWidget {
  const SalarieGestionStockWidget({super.key, required this.salarieGestionStockModel, this.onDeleteTap, this.onTap, this.onNbr1Tap, this.onNbr2Tap, this.onNbr3Tap, required this.showDeleteOrSearch, required this.isSearch});
  final GbsystemSalarieGestionStockWithImageModel salarieGestionStockModel;

  final void Function()? onTap, onNbr1Tap, onNbr2Tap, onNbr3Tap, onDeleteTap;
  final bool showDeleteOrSearch, isSearch;
  @override
  State<SalarieGestionStockWidget> createState() => _SalarieGestionStockWidgetState();
}

class _SalarieGestionStockWidgetState extends State<SalarieGestionStockWidget> {
  PageController pageController = PageController();
  RxDouble currentIndex = 0.0.obs;

  @override
  void initState() {
    pageController.addListener(() {
      currentIndex.value = pageController.page ?? 0.0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: widget.onTap,
          child: Container(
              height: 130,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    children: [
                      PageSalarie1(
                        onNbr1Tap: widget.onNbr1Tap,
                        onNbr2Tap: widget.onNbr2Tap,
                        onNbr3Tap: widget.onNbr3Tap,
                        salarieGestionStockModel: widget.salarieGestionStockModel!,
                      ),
                      // PageSalarie2(
                      //     salarieQuickAccessModel:
                      //         widget.salarieQuickAccessModel.salarieModel),
                    ],
                  ),
                  Visibility(
                    visible: false,
                    child: Positioned(
                      bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01),
                      child: Obx(() {
                        return DotsIndicator(
                          decorator: const DotsDecorator(color: Colors.black, activeColor: GbsSystemServerStrings.str_primary_color, activeSize: Size(12, 12), size: Size(12, 12)),
                          dotsCount: 2,
                          onTap: (position) {
                            pageController.animateToPage(position, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                          },
                          position: currentIndex.round().toDouble(),
                        );
                      }),
                    ),
                  ),
                ],
              )),
        ),
        Visibility(
          visible: widget.showDeleteOrSearch,
          child: widget.isSearch ? Positioned(top: 8, right: 8, child: InkWell(onTap: widget.onTap, child: Icon(CupertinoIcons.search))) : Positioned(top: 8, right: 8, child: InkWell(onTap: widget.onDeleteTap, child: Icon(CupertinoIcons.delete))),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class PageSalarie1 extends StatelessWidget {
  PageSalarie1({super.key, required this.salarieGestionStockModel, this.onTap, this.onNbr1Tap, this.onNbr2Tap, this.onNbr3Tap});
  final GbsystemSalarieGestionStockWithImageModel salarieGestionStockModel;
  String? imageSalarie;
  final void Function()? onTap, onNbr1Tap, onNbr2Tap, onNbr3Tap;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FutureBuilder<String?>(
            future: GBSystem_AuthService(context).getPhotoRoot(type: 1, idf: salarieGestionStockModel.salarieModel.SVR_IDF),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                imageSalarie = snapshot.data;
                salarieGestionStockModel.imageSalarie = imageSalarie;
              }
              return Transform.translate(
                offset: const Offset(0, 10),
                child: ClipOval(
                  child: imageSalarie != null
                      ? Image.memory(
                          base64Decode(imageSalarie!.split(',').last),
                          fit: BoxFit.fill,
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                          height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                            height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: GbsSystemServerStrings.str_primary_color),
                            child: Center(child: GBSystem_TextHelper().largeText(text: "${salarieGestionStockModel.salarieModel.SVR_LIB.substring(0, 1).toUpperCase()}${salarieGestionStockModel.salarieModel.SVR_LIB.substring(1, 2).toUpperCase()}", textColor: Colors.white)),
                          ),
                        )
                      : Container(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                          height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: GbsSystemServerStrings.str_primary_color),
                          child: Center(child: GBSystem_TextHelper().largeText(text: "${salarieGestionStockModel.salarieModel.SVR_LIB.substring(0, 1).toUpperCase()}${salarieGestionStockModel.salarieModel.SVR_LIB.substring(1, 2).toUpperCase()}", textColor: Colors.white)),
                        ),
                ),
              );
            }),
        SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: GBSystem_TextHelper().normalText(
                  textAlign: TextAlign.start,
                  textColor: Colors.black,
                  text: salarieGestionStockModel.salarieModel.SVR_LIB,
                  maxLines: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, 0),
                child: Row(
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: onNbr1Tap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            CupertinoIcons.phone_circle_fill,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 80,
                            child: GBSystem_TextHelper().smallText(
                                text: salarieGestionStockModel.salarieModel.SVR_TELPOR != null && salarieGestionStockModel.salarieModel.SVR_TELPOR!.isNotEmpty && salarieGestionStockModel.salarieModel.SVR_TELPOR != " " ? salarieGestionStockModel.salarieModel.SVR_TELPOR! : "", fontWeight: FontWeight.w500, maxLines: 2, textColor: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: onNbr2Tap,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            CupertinoIcons.phone_fill,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 80,
                            child: GBSystem_TextHelper().smallText(
                                text: salarieGestionStockModel.salarieModel.SVR_TELPH1 != null && salarieGestionStockModel.salarieModel.SVR_TELPH1!.isNotEmpty && salarieGestionStockModel.salarieModel.SVR_TELPH1 != " " ? salarieGestionStockModel.salarieModel.SVR_TELPH1! : "", fontWeight: FontWeight.w500, maxLines: 2, textColor: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(-5, -5),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onNbr3Tap,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            CupertinoIcons.phone_fill,
                            color: Colors.black,
                          ),
                          Positioned(top: 0, right: 0, child: GBSystem_TextHelper().superSmallText(text: "2", textColor: Colors.black, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 90,
                        child: GBSystem_TextHelper()
                            .smallText(text: salarieGestionStockModel.salarieModel.SVR_TELPH != null && salarieGestionStockModel.salarieModel.SVR_TELPH!.isNotEmpty && salarieGestionStockModel.salarieModel.SVR_TELPH != " " ? salarieGestionStockModel.salarieModel.SVR_TELPH! : "", fontWeight: FontWeight.w500, maxLines: 2, textColor: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class GBSystem_Root_CardViewHome_Widget extends Card {
//   const GBSystem_Root_CardViewHome_Widget(
//       {super.key, required this.site, this.onSearchTap, required this.title});

//   final SitePlanningModel? site;
//   final void Function()? onSearchTap;
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       alignment: Alignment.topCenter,
//       children: [
//         InkWell(
//           onTap: onSearchTap,
//           child: Container(
//             padding: EdgeInsets.symmetric(
//                 vertical:
//                     GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
//                 horizontal:
//                     GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black38, width: 1),
//               borderRadius: BorderRadius.circular(8),
//               shape: BoxShape.rectangle,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: GBSystem_ScreenHelper.screenWidthPercentage(
//                           context, 0.8),
//                       child: GBSystem_TextHelper().largeText(
//                           text: site!.LIE_LIB,
//                           maxLines: 2,
//                           textColor: Colors.black,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(
//                       width: GBSystem_ScreenHelper.screenWidthPercentage(
//                           context, 0.8),
//                       child: GBSystem_TextHelper().normalText(
//                           text: site!.LIE_ADR1,
//                           maxLines: 3,
//                           textColor: Colors.grey,
//                           fontWeight: FontWeight.normal),
//                     ),
//                     SizedBox(
//                       width: GBSystem_ScreenHelper.screenWidthPercentage(
//                           context, 0.8),
//                       child: GBSystem_TextHelper().normalText(
//                           text: site!.VIL_LIB,
//                           maxLines: 3,
//                           textColor: Colors.grey,
//                           fontWeight: FontWeight.normal),
//                     ),
//                     const SizedBox(height: 5),
//                     SizedBox(
//                       width: GBSystem_ScreenHelper.screenWidthPercentage(
//                           context, 0.8),
//                       child: GBSystem_TextHelper().smallText(
//                           text: site!.LIE_CODE,
//                           textColor: Colors.black,
//                           maxLines: 2,
//                           fontWeight: FontWeight.normal),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: -5,
//           child: Container(
//             padding: EdgeInsets.symmetric(
//                 horizontal:
//                     GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
//             decoration: const BoxDecoration(color: Colors.white),
//             child: Text(
//               title,
//               style: TextStyle(color: Colors.black, fontSize: 12),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 10,
//           right: 10,
//           child: InkWell(
//             onTap: onSearchTap,
//             child: const Icon(
//               CupertinoIcons.search,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );

//     // Stack(
//     //   alignment: Alignment.center,
//     //   children: <Widget>[
//     //     InkWell(
//     //       onTap: onSearchTap,
//     //       child: Container(
//     //         width: GBSystem_ScreenHelper.screenWidth(context),
//     //         margin: EdgeInsets.fromLTRB(5, 20, 5, 10),
//     //         padding: EdgeInsets.symmetric(
//     //             vertical:
//     //                 GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01),
//     //             horizontal:
//     //                 GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
//     //         decoration: BoxDecoration(
//     //           border: Border.all(color: Colors.black38, width: 1),
//     //           borderRadius: BorderRadius.circular(8),
//     //           shape: BoxShape.rectangle,
//     //         ),
//     //         child: Row(
//     //           mainAxisAlignment: MainAxisAlignment.start,
//     //           children: [
//     //             Column(
//     //               mainAxisSize: MainAxisSize.min,
//     //               mainAxisAlignment: MainAxisAlignment.start,
//     //               crossAxisAlignment: CrossAxisAlignment.start,
//     //               children: [
//     //                 SizedBox(
//     //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
//     //                       context, 0.8),
//     //                   child: GBSystem_TextHelper().largeText(
//     //                       text: site!.LIE_LIB,
//     //                       maxLines: 3,
//     //                       textColor: Colors.black,
//     //                       fontWeight: FontWeight.w500),
//     //                 ),
//     //                 SizedBox(
//     //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
//     //                       context, 0.8),
//     //                   child: GBSystem_TextHelper().normalText(
//     //                       text: site!.LIE_ADR1,
//     //                       maxLines: 3,
//     //                       textColor: Colors.grey,
//     //                       fontWeight: FontWeight.normal),
//     //                 ),
//     //                 SizedBox(
//     //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
//     //                       context, 0.8),
//     //                   child: GBSystem_TextHelper().normalText(
//     //                       text: site!.VIL_LIB,
//     //                       maxLines: 3,
//     //                       textColor: Colors.grey,
//     //                       fontWeight: FontWeight.normal),
//     //                 ),
//     //                 const SizedBox(height: 5),
//     //                 SizedBox(
//     //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
//     //                       context, 0.8),
//     //                   child: GBSystem_TextHelper().smallText(
//     //                       text: site!.LIE_CODE,
//     //                       textColor: Colors.black,
//     //                       maxLines: 2,
//     //                       fontWeight: FontWeight.normal),
//     //                 ),
//     //               ],
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //     Positioned(
//     //       left: 50,
//     //       top: 12,
//     //       child: Container(
//     //         padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
//     //         color: Colors.white,
//     //         child: Text(
//     //           title,
//     //           style: TextStyle(color: Colors.black, fontSize: 12),
//     //         ),
//     //       ),
//     //     ),
//     //     Positioned(
//     //       top: 30,
//     //       right: 15,
//     //       child: InkWell(
//     //         onTap: onSearchTap,
//     //         child: const Icon(
//     //           CupertinoIcons.search,
//     //           color: Colors.black,
//     //         ),
//     //       ),
//     //     ),
//     //   ],
//     // );
//   }
// }

class GBSystem_Root_CardViewHome_Salarie_Widget extends Card {
  const GBSystem_Root_CardViewHome_Salarie_Widget({super.key, required this.salarie, this.onCallTap, this.onSearchTap, required this.title, this.onEnterTap, this.onSortieTap});

  final SalariePlanningModel? salarie;
  final void Function()? onSearchTap, onEnterTap, onSortieTap, onCallTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onSearchTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: salarie != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            GBSystem_TextHelper().largeText(text: title, maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.bold),
                            // Text(
                            //   title,
                            //   style: CupertinoTheme.of(context)
                            //       .textTheme
                            //       .navTitleTextStyle,
                            // ),
                            InkWell(
                              onTap: onSearchTap,
                              child: const Icon(
                                CupertinoIcons.search,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Divider(
                          color: Colors.transparent,
                          indent: 0,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                                child: GBSystem_TextHelper().normalText(text: salarie?.SVR_LIB ?? "", maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                                child: GBSystem_TextHelper().smallText(text: salarie?.SVR_NOM ?? "", maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                                child: GBSystem_TextHelper().smallText(text: salarie?.SVR_PRNOM ?? "", maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                                child: GBSystem_TextHelper().smallText(text: salarie?.VIL_LIB ?? "", textColor: Colors.black, maxLines: 2, fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ButtonEntrerSortieWithIconAndText(
                                    text: GbsSystemStrings.str_entrer,
                                    number: null,
                                    verPadd: 8,
                                    horPadd: 5,
                                    icon: const Icon(
                                      CupertinoIcons.hand_draw_fill,
                                      color: Colors.white,
                                    ),
                                    color: Colors.green,
                                    onTap: onEnterTap,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ButtonEntrerSortieWithIconAndText(
                                    text: GbsSystemStrings.str_sortie,
                                    number: null,
                                    verPadd: 8,
                                    horPadd: 5,
                                    icon: const Icon(
                                      CupertinoIcons.hand_draw_fill,
                                      color: Colors.white,
                                    ),
                                    color: Colors.red,
                                    onTap: onSortieTap,
                                  ),
                                  ButtonEntrerSortieWithIconAndText(
                                    text: GbsSystemStrings.str_appeler,
                                    number: null,
                                    verPadd: 8,
                                    horPadd: 5,
                                    icon: const Icon(
                                      CupertinoIcons.phone,
                                      color: Colors.white,
                                    ),
                                    color: GbsSystemServerStrings.str_primary_color,
                                    onTap: onCallTap,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [GBSystem_TextHelper().smallText(text: GbsSystemStrings.str_no_item)],
                        )
                      ],
                    )),
        ],
      ),
    );

    Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          onTap: onSearchTap,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02), horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.rectangle,
              ),
              child: salarie != null
                  ? Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: onSearchTap,
                            child: const Icon(
                              CupertinoIcons.search,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                                  child: GBSystem_TextHelper().largeText(text: "${salarie!.SVR_NOM} ${salarie!.SVR_PRNOM}", maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 2),
                                SizedBox(
                                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                                  child: GBSystem_TextHelper().normalText(text: salarie!.VIL_LIB, maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                                  child: GBSystem_TextHelper().normalText(text: salarie!.VIL_CODE, maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.9),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: GBSystem_TextHelper().smallText(text: salarie!.SVR_CODE, textColor: Colors.black, maxLines: 2, fontWeight: FontWeight.normal),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ButtonEntrerSortieWithIconAndText(
                                            text: GbsSystemStrings.str_entrer,
                                            number: null,
                                            verPadd: 2,
                                            horPadd: 5,
                                            icon: const Icon(
                                              CupertinoIcons.hand_draw_fill,
                                              color: Colors.white,
                                            ),
                                            color: Colors.green,
                                            onTap: onEnterTap,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ButtonEntrerSortieWithIconAndText(
                                            text: GbsSystemStrings.str_sortie,
                                            number: null,
                                            verPadd: 2,
                                            horPadd: 5,
                                            icon: const Icon(
                                              CupertinoIcons.hand_draw_fill,
                                              color: Colors.white,
                                            ),
                                            color: Colors.red,
                                            onTap: onSortieTap,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [GBSystem_TextHelper().smallText(text: GbsSystemStrings.str_no_item)],
                        )
                      ],
                    )),
        ),
        Positioned(
          top: -5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
            decoration: const BoxDecoration(color: Colors.white),
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}

class GBSystem_Root_CardViewHome_Vacation_Widget extends StatelessWidget {
  const GBSystem_Root_CardViewHome_Vacation_Widget({super.key, required this.vacation, this.onSearchTap, required this.title});

  final VacationModel vacation;
  final void Function()? onSearchTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          onTap: onSearchTap,
          child: Container(
            // height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.2),
            padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02), horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white, border: Border.all(width: 1, color: Colors.black)),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: onSearchTap,
                    child: const Icon(
                      CupertinoIcons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                          child: GBSystem_TextHelper().largeText(text: "${vacation.LIE_LIB}", maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
                        ),
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                          child: GBSystem_TextHelper().normalText(text: vacation.LIE_TLPH, maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                          child: GBSystem_TextHelper().normalText(text: vacation.TITLE, maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
                        ),
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                          child: GBSystem_TextHelper().smallText(text: vacation.LIE_ADR, textColor: Colors.black, maxLines: 2, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
            decoration: const BoxDecoration(color: Colors.white),
            child: GBSystem_TextHelper().normalText(text: title, textColor: Colors.black),
          ),
        ),
      ],
    );
  }
}

class GBSystem_Root_CardViewHome_Widget_Site_Gestion_Stock extends Card {
  const GBSystem_Root_CardViewHome_Widget_Site_Gestion_Stock({super.key, required this.site, this.onSearchTap, required this.title});

  final SiteGestionStockModel? site;
  final void Function()? onSearchTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          onTap: onSearchTap,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02), horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.rectangle,
              ),
              child: site != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                              child: GBSystem_TextHelper().largeText(text: site?.DOS_LIB ?? "", maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                              child: GBSystem_TextHelper().normalText(text: site?.DOS_CODE ?? "", maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                              child: GBSystem_TextHelper().normalText(text: "", maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                              child: GBSystem_TextHelper().smallText(text: "", textColor: Colors.black, maxLines: 2, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(
                      height: 150,
                      child: Center(
                        child: GBSystem_TextHelper().smallText(text: GbsSystemStrings.str_aucune_agence_selectionner),
                      ),
                    )),
        ),
        Positioned(
          top: -5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 0.5), color: Colors.white),
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: onSearchTap,
            child: const Icon(
              CupertinoIcons.search,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );

    // Stack(
    //   alignment: Alignment.center,
    //   children: <Widget>[
    //     InkWell(
    //       onTap: onSearchTap,
    //       child: Container(
    //         width: GBSystem_ScreenHelper.screenWidth(context),
    //         margin: EdgeInsets.fromLTRB(5, 20, 5, 10),
    //         padding: EdgeInsets.symmetric(
    //             vertical:
    //                 GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01),
    //             horizontal:
    //                 GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
    //         decoration: BoxDecoration(
    //           border: Border.all(color: Colors.black38, width: 1),
    //           borderRadius: BorderRadius.circular(8),
    //           shape: BoxShape.rectangle,
    //         ),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Column(
    //               mainAxisSize: MainAxisSize.min,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 SizedBox(
    //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
    //                       context, 0.8),
    //                   child: GBSystem_TextHelper().largeText(
    //                       text: site!.LIE_LIB,
    //                       maxLines: 3,
    //                       textColor: Colors.black,
    //                       fontWeight: FontWeight.w500),
    //                 ),
    //                 SizedBox(
    //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
    //                       context, 0.8),
    //                   child: GBSystem_TextHelper().normalText(
    //                       text: site!.LIE_ADR1,
    //                       maxLines: 3,
    //                       textColor: Colors.grey,
    //                       fontWeight: FontWeight.normal),
    //                 ),
    //                 SizedBox(
    //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
    //                       context, 0.8),
    //                   child: GBSystem_TextHelper().normalText(
    //                       text: site!.VIL_LIB,
    //                       maxLines: 3,
    //                       textColor: Colors.grey,
    //                       fontWeight: FontWeight.normal),
    //                 ),
    //                 const SizedBox(height: 5),
    //                 SizedBox(
    //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
    //                       context, 0.8),
    //                   child: GBSystem_TextHelper().smallText(
    //                       text: site!.LIE_CODE,
    //                       textColor: Colors.black,
    //                       maxLines: 2,
    //                       fontWeight: FontWeight.normal),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       left: 50,
    //       top: 12,
    //       child: Container(
    //         padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    //         color: Colors.white,
    //         child: Text(
    //           title,
    //           style: TextStyle(color: Colors.black, fontSize: 12),
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       top: 30,
    //       right: 15,
    //       child: InkWell(
    //         onTap: onSearchTap,
    //         child: const Icon(
    //           CupertinoIcons.search,
    //           color: Colors.black,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}

class GBSystem_Root_CardViewHome_Widget_Salarie_Gestion_Stock extends Card {
  const GBSystem_Root_CardViewHome_Widget_Salarie_Gestion_Stock({
    super.key,
    required this.salarie,
    this.onSearchTap,
    required this.title,
    this.onNFCTap,
  });

  final SalarieGestionStockModel? salarie;
  final void Function()? onSearchTap, onNFCTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          onTap: onSearchTap,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02), horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.rectangle,
              ),
              child: salarie != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                              child: GBSystem_TextHelper().largeText(text: salarie?.SVR_LIB ?? "", maxLines: 2, textColor: Colors.black, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                              child: GBSystem_TextHelper().normalText(text: salarie?.SVR_CODE ?? "", maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                              child: GBSystem_TextHelper().normalText(text: "", maxLines: 3, textColor: Colors.grey, fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                              child: GBSystem_TextHelper().smallText(text: "", textColor: Colors.black, maxLines: 2, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(
                      height: 150,
                      child: Center(
                        child: GBSystem_TextHelper().smallText(text: GbsSystemStrings.str_aucune_salarie_selectionner),
                      ),
                    )),
        ),
        Positioned(
          top: -5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 0.5), color: Colors.white),
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: onSearchTap,
            child: const Icon(
              CupertinoIcons.search,
              color: Colors.black,
            ),
          ),
        ),
        Visibility(
          visible: false,
          child: Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              onTap: onNFCTap,
              child: const Icon(
                Icons.nfc,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );

    // Stack(
    //   alignment: Alignment.center,
    //   children: <Widget>[
    //     InkWell(
    //       onTap: onSearchTap,
    //       child: Container(
    //         width: GBSystem_ScreenHelper.screenWidth(context),
    //         margin: EdgeInsets.fromLTRB(5, 20, 5, 10),
    //         padding: EdgeInsets.symmetric(
    //             vertical:
    //                 GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01),
    //             horizontal:
    //                 GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
    //         decoration: BoxDecoration(
    //           border: Border.all(color: Colors.black38, width: 1),
    //           borderRadius: BorderRadius.circular(8),
    //           shape: BoxShape.rectangle,
    //         ),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Column(
    //               mainAxisSize: MainAxisSize.min,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 SizedBox(
    //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
    //                       context, 0.8),
    //                   child: GBSystem_TextHelper().largeText(
    //                       text: site!.LIE_LIB,
    //                       maxLines: 3,
    //                       textColor: Colors.black,
    //                       fontWeight: FontWeight.w500),
    //                 ),
    //                 SizedBox(
    //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
    //                       context, 0.8),
    //                   child: GBSystem_TextHelper().normalText(
    //                       text: site!.LIE_ADR1,
    //                       maxLines: 3,
    //                       textColor: Colors.grey,
    //                       fontWeight: FontWeight.normal),
    //                 ),
    //                 SizedBox(
    //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
    //                       context, 0.8),
    //                   child: GBSystem_TextHelper().normalText(
    //                       text: site!.VIL_LIB,
    //                       maxLines: 3,
    //                       textColor: Colors.grey,
    //                       fontWeight: FontWeight.normal),
    //                 ),
    //                 const SizedBox(height: 5),
    //                 SizedBox(
    //                   width: GBSystem_ScreenHelper.screenWidthPercentage(
    //                       context, 0.8),
    //                   child: GBSystem_TextHelper().smallText(
    //                       text: site!.LIE_CODE,
    //                       textColor: Colors.black,
    //                       maxLines: 2,
    //                       fontWeight: FontWeight.normal),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       left: 50,
    //       top: 12,
    //       child: Container(
    //         padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    //         color: Colors.white,
    //         child: Text(
    //           title,
    //           style: TextStyle(color: Colors.black, fontSize: 12),
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       top: 30,
    //       right: 15,
    //       child: InkWell(
    //         onTap: onSearchTap,
    //         child: const Icon(
    //           CupertinoIcons.search,
    //           color: Colors.black,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}

class GBSystem_Root_CardView_Fournisseur_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_Fournisseur_Widget({
    super.key,
    required this.fournisseur,
    this.onTap,
    this.tileColor,
  });
  final GbsystemFournisseurModel fournisseur;
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
          fournisseur.FOU_LIB,
          maxLines: 2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fournisseur.FOU_TEL,
              maxLines: 2,
            ),
            Text(
              fournisseur.FOU_ADR1,
              maxLines: 2,
            ),
            Text(
              fournisseur.FOU_TELPOR,
              maxLines: 2,
            ),

            // Text(fournisseur.TPH_LIB),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper().normalText(text: fournisseur.FOU_LIB.substring(0, 1).toUpperCase(), textColor: Colors.white),
        ),
        // trailing: Text(habiliter.FOR_LIB),
      ),
    );
  }
}

class GBSystem_Root_CardView_Color_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_Color_Widget({
    super.key,
    required this.color,
    this.onTap,
    this.tileColor,
  });
  final GbsystemColorModel color;
  final Color? tileColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:
              // tileColor
              Color(int.parse(
        '0xFF${color.CLR_CODE_colorweb.replaceAll(r"#", "").replaceAll(r"$", "")}',
      ))),
      child: ListTile(
        onTap: onTap,
        isThreeLine: true,
        title: Text(
          color.CLR_LIB,
          maxLines: 2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              color.CLRCAT_LIB,
              maxLines: 2,
            ),
            Text(
              color.DGRP_LIB,
              maxLines: 2,
            ),
            Text(
              color.CLR_CAT,
              maxLines: 2,
            ),

            // Text(color.TPH_LIB),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper().normalText(text: color.CLR_LIB.substring(0, 1).toUpperCase(), textColor: Colors.white),
        ),
        // trailing: Text(habiliter.FOR_LIB),
      ),
    );
  }
}

class GBSystem_Root_CardView_Enterpot_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_Enterpot_Widget({
    super.key,
    required this.enterpot,
    this.onTap,
    this.tileColor,
  });
  final GbsystemEnterpotModel enterpot;
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
          enterpot.ENTR_LIB,
          maxLines: 2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              enterpot.ENTR_EMAIL,
              maxLines: 2,
            ),
            Text(
              enterpot.ENTR_TELPH,
              maxLines: 2,
            ),
            Text(
              enterpot.VIL_LIB,
              maxLines: 2,
            ),

            // Text(enterpot.TPH_LIB),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper().normalText(text: enterpot.ENTR_LIB.substring(0, 1).toUpperCase(), textColor: Colors.white),
        ),
        // trailing: Text(habiliter.FOR_LIB),
      ),
    );
  }
}

class GBSystem_Root_CardView_Article_Widget extends StatelessWidget {
  const GBSystem_Root_CardView_Article_Widget({
    super.key,
    required this.article,
    this.onTap,
    this.tileColor,
  });
  final GbsystemArticleRefModel article;
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
          article.ARTREF_LIB,
          maxLines: 2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.ARTCAT_LIB,
              maxLines: 2,
            ),
            Text(
              article.ARTREF_DUREE_VIE_TYPE,
              maxLines: 2,
            ),
            Text(
              article.ARTREF_DUREE_VIE_UNIT,
              maxLines: 2,
            ),

            // Text(article.TPH_LIB),
          ],
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: GBSystem_TextHelper().normalText(text: article.ARTREF_LIB.substring(0, 1).toUpperCase(), textColor: Colors.white),
        ),
        // trailing: Text(habiliter.FOR_LIB),
      ),
    );
  }
}
