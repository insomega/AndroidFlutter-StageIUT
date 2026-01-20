import 'dart:convert';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_photo_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_quick_acces_with_image_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_quick_acces_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class SalarieQuickAccessWidget extends StatefulWidget {
  const SalarieQuickAccessWidget({super.key, required this.salarieQuickAccessModel, required this.imageSalarie, this.onTap, this.onNbr1Tap, this.onNbr2Tap, this.onNbr3Tap});
  final GBSystemSalarieQuickAccessWithPhotoModel salarieQuickAccessModel;
  final String? imageSalarie;
  final void Function()? onTap, onNbr1Tap, onNbr2Tap, onNbr3Tap;

  @override
  State<SalarieQuickAccessWidget> createState() => _SalarieQuickAccessWidgetState();
}

class _SalarieQuickAccessWidgetState extends State<SalarieQuickAccessWidget> {
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
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: widget.onTap,
      child: Container(
          height: 150,
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
                  PageSalarie1(onNbr1Tap: widget.onNbr1Tap, onNbr2Tap: widget.onNbr2Tap, onNbr3Tap: widget.onNbr3Tap, salarieQuickAccessModel: widget.salarieQuickAccessModel, imageSalarie: widget.imageSalarie),
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
    );
  }
}

// ignore: must_be_immutable
class PageSalarie1 extends StatelessWidget {
  PageSalarie1({super.key, required this.salarieQuickAccessModel, required this.imageSalarie, this.onTap, this.onNbr1Tap, this.onNbr2Tap, this.onNbr3Tap});
  final GBSystemSalarieQuickAccessWithPhotoModel salarieQuickAccessModel;
  String? imageSalarie;
  final void Function()? onTap, onNbr1Tap, onNbr2Tap, onNbr3Tap;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FutureBuilder<String?>(
            future: GBSystem_AuthService(context).getPhotoSalarieQuickAccess(
              SVR_IDF: salarieQuickAccessModel.salarieModel.SVR_IDF,
              // salarieQuickAccessModel: salarieQuickAccessModel.salarieModel
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                imageSalarie = snapshot.data;
                salarieQuickAccessModel.imageSalarie = imageSalarie;
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
                            child: Center(child: GBSystem_TextHelper().largeText(text: "${salarieQuickAccessModel.salarieModel.SVR_LIB.substring(0, 1).toUpperCase()}${salarieQuickAccessModel.salarieModel.SVR_LIB.substring(1, 2).toUpperCase()}", textColor: Colors.white)),
                          ),
                        )
                      : Container(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                          height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: GbsSystemServerStrings.str_primary_color),
                          child: Center(child: GBSystem_TextHelper().largeText(text: "${salarieQuickAccessModel.salarieModel.SVR_LIB.substring(0, 1).toUpperCase()}${salarieQuickAccessModel.salarieModel.SVR_LIB.substring(1, 2).toUpperCase()}", textColor: Colors.white)),
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
              SizedBox(
                width: 180,
                child: GBSystem_TextHelper().normalText(
                  textAlign: TextAlign.start,
                  textColor: Colors.black,
                  text: salarieQuickAccessModel.salarieModel.SVR_LIB,
                  maxLines: 3,
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
                            child:
                                GBSystem_TextHelper().smallText(text: salarieQuickAccessModel.salarieModel.SVR_TELPOR.isNotEmpty && salarieQuickAccessModel.salarieModel.SVR_TELPOR != " " ? salarieQuickAccessModel.salarieModel.SVR_TELPOR : GbsSystemStrings.str_aucune_phone_number, fontWeight: FontWeight.w500, maxLines: 2, textColor: Colors.black),
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
                            child:
                                GBSystem_TextHelper().smallText(text: salarieQuickAccessModel.salarieModel.SVR_TELPH1.isNotEmpty && salarieQuickAccessModel.salarieModel.SVR_TELPH1 != " " ? salarieQuickAccessModel.salarieModel.SVR_TELPH1 : GbsSystemStrings.str_aucune_phone_number, fontWeight: FontWeight.w500, maxLines: 2, textColor: Colors.black),
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
                        child: GBSystem_TextHelper().smallText(text: salarieQuickAccessModel.salarieModel.SVR_TELPH.isNotEmpty && salarieQuickAccessModel.salarieModel.SVR_TELPH != " " ? salarieQuickAccessModel.salarieModel.SVR_TELPH : GbsSystemStrings.str_aucune_phone_number, fontWeight: FontWeight.w500, maxLines: 2, textColor: Colors.black),
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

class PageSalarie2 extends StatelessWidget {
  const PageSalarie2({super.key, required this.salarieQuickAccessModel});
  final SalarieQuickAccessModel salarieQuickAccessModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                CupertinoIcons.location_solid,
                color: Colors.black,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 90,
                child: GBSystem_TextHelper().smallText(text: salarieQuickAccessModel.VIL_LIB, fontWeight: FontWeight.w500, maxLines: 2, textColor: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                CupertinoIcons.gift_fill,
                color: Colors.black,
              ),

              // GBSystem_TextHelper().smallText(
              //     text: "Date Naissance : ",
              //     fontWeight: FontWeight.bold,
              //     textColor: Colors.black),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 60,
                child: GBSystem_TextHelper().smallText(text: "${salarieQuickAccessModel.SVR_NAIDATE?.day}/${salarieQuickAccessModel.SVR_NAIDATE?.month}/${salarieQuickAccessModel.SVR_NAIDATE?.year}", fontWeight: FontWeight.w500, maxLines: 2, textColor: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.male,
                color: Colors.black,
              ),

              // GBSystem_TextHelper().smallText(
              //     text: "Sexe : ",
              //     fontWeight: FontWeight.bold,
              //     textColor: Colors.black),
              const SizedBox(
                width: 10,
              ),

              SizedBox(
                width: 100,
                child: GBSystem_TextHelper().smallText(text: salarieQuickAccessModel.SEX_LIB, fontWeight: FontWeight.w500, maxLines: 2, textColor: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SalarieCauserieWidget extends StatefulWidget {
  const SalarieCauserieWidget({super.key, required this.salarieCauserieModel, this.onTap, required this.isSelected});
  final GBSystemSalarieWithPhotoCauserieModel salarieCauserieModel;
  final void Function()? onTap;
  final bool isSelected;

  @override
  State<SalarieCauserieWidget> createState() => _SalarieCauserieWidgetState();
}

class _SalarieCauserieWidgetState extends State<SalarieCauserieWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: widget.onTap,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: 300,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            // border: Border.all(
            //     width: widget.isSelected ? 2 : 1,
            //     color: widget.isSelected ? Colors.amber : Colors.black54),
            //  color: Colors.grey.shade100,
            border: Border.all(width: 0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],

            color: widget.isSelected
                ? GbsSystemServerStrings.str_primary_color.withOpacity(0.8)
                // Colors.black54
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ClipOval(
                  child: widget.salarieCauserieModel.imageSalarie != null
                      ? Image.memory(
                          base64Decode(widget.salarieCauserieModel.imageSalarie!.split(',').last),
                          fit: BoxFit.fill,
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                          height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                            height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: GbsSystemServerStrings.str_primary_color),
                            child: Center(child: GBSystem_TextHelper().largeText(text: "${widget.salarieCauserieModel.salarieCauserieModel.SVR_LIB.substring(0, 1).toUpperCase()}${widget.salarieCauserieModel.salarieCauserieModel.SVR_LIB.substring(1, 2).toUpperCase()}", textColor: Colors.white)),
                          ),
                        )
                      : Container(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                          height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: GbsSystemServerStrings.str_primary_color),
                          child: Center(child: GBSystem_TextHelper().largeText(text: "${widget.salarieCauserieModel.salarieCauserieModel.SVR_LIB.substring(0, 1).toUpperCase()}${widget.salarieCauserieModel.salarieCauserieModel.SVR_LIB.substring(1, 2).toUpperCase()}", textColor: Colors.white)),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: GBSystem_TextHelper().normalText(
                      textColor: widget.isSelected ? Colors.white : Colors.black,
                      textAlign: TextAlign.center,
                      text: widget.salarieCauserieModel.salarieCauserieModel.SVR_LIB,
                      maxLines: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.person_alt,
                    color: widget.isSelected ? Colors.white : Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 90,
                    child: GBSystem_TextHelper().smallText(
                      text: widget.salarieCauserieModel.salarieCauserieModel.SVR_LIB,
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                      textColor: widget.isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        CupertinoIcons.calendar,
                        color: widget.isSelected ? Colors.white : Colors.black,
                      ),
                      Positioned(bottom: -5, right: -5, child: GBSystem_TextHelper().superSmallText(textColor: widget.isSelected ? Colors.white : Colors.black, text: "D", fontWeight: FontWeight.bold))
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: GBSystem_TextHelper().smallText(
                      text: widget.salarieCauserieModel.salarieCauserieModel.VAC_START_HOUR != null ? ConvertDateService().parseDateAndTime(date: widget.salarieCauserieModel.salarieCauserieModel.VAC_START_HOUR!) : "",
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                      textColor: widget.isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        CupertinoIcons.calendar,
                        color: widget.isSelected ? Colors.white : Colors.black,
                      ),
                      Positioned(bottom: -5, right: -5, child: GBSystem_TextHelper().superSmallText(textColor: widget.isSelected ? Colors.white : Colors.black, text: "F", fontWeight: FontWeight.bold))
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: GBSystem_TextHelper().smallText(
                      text: widget.salarieCauserieModel.salarieCauserieModel.VAC_END_HOUR != null ? ConvertDateService().parseDateAndTime(date: widget.salarieCauserieModel.salarieCauserieModel.VAC_END_HOUR!) : "",
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                      textColor: widget.isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
