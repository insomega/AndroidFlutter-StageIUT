import 'dart:convert';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_agence_salarie_quick_acces_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class AgenceQuickAccessWidget extends StatefulWidget {
  const AgenceQuickAccessWidget({
    super.key,
    required this.salarieQuickAccessModel,
    this.onTap,
  });
  final AgenceSalarieQuickAccesModel salarieQuickAccessModel;

  final void Function()? onTap;

  @override
  State<AgenceQuickAccessWidget> createState() =>
      _AgenceQuickAccessWidgetState();
}

class _AgenceQuickAccessWidgetState extends State<AgenceQuickAccessWidget> {
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
                    agenceSalarieQuickAccessModel:
                        widget.salarieQuickAccessModel,
                  ),
                ],
              ),
              Visibility(
                visible: false,
                child: Positioned(
                  bottom: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.01),
                  child: Obx(() {
                    return DotsIndicator(
                      decorator: const DotsDecorator(
                          color: Colors.black,
                          activeColor: GbsSystemServerStrings.str_primary_color,
                          activeSize: Size(12, 12),
                          size: Size(12, 12)),
                      dotsCount: 2,
                      onTap: (position) {
                        pageController.animateToPage(position,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut);
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
  PageSalarie1({
    super.key,
    required this.agenceSalarieQuickAccessModel,
    this.onTap,
  });
  final AgenceSalarieQuickAccesModel agenceSalarieQuickAccessModel;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FutureBuilder<String?>(
            future: GBSystem_AuthService(context).getPhotoRoot(
              type: 4,
              idf: agenceSalarieQuickAccessModel.LIE_IDF ?? "",
            ),
            builder: (context, snapshot) {
              return Transform.translate(
                offset: const Offset(0, 10),
                child: ClipOval(
                  child: snapshot.data != null
                      ? Image.memory(
                          base64Decode(snapshot.data!.split(',').last),
                          fit: BoxFit.fill,
                          width: GBSystem_ScreenHelper.screenWidthPercentage(
                              context, 0.2),
                          height: GBSystem_ScreenHelper.screenWidthPercentage(
                              context, 0.2),
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.2),
                            height: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color:
                                    GbsSystemServerStrings.str_primary_color),
                            child: Center(
                                child: GBSystem_TextHelper().largeText(
                                    text:
                                        "${agenceSalarieQuickAccessModel.LIE_LIB ?? "LIEU".substring(0, 1).toUpperCase()}${agenceSalarieQuickAccessModel.LIE_LIB ?? "LIEU".substring(1, 2).toUpperCase()}",
                                    textColor: Colors.white)),
                          ),
                        )
                      : Container(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(
                              context, 0.2),
                          height: GBSystem_ScreenHelper.screenWidthPercentage(
                              context, 0.2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: GbsSystemServerStrings.str_primary_color),
                          child: Center(
                              child: GBSystem_TextHelper().largeText(
                                  text:
                                      "${agenceSalarieQuickAccessModel.LIE_LIB ?? "LIEU".substring(0, 1).toUpperCase()}${agenceSalarieQuickAccessModel.LIE_LIB ?? "LIEU".substring(1, 2).toUpperCase()}",
                                  textColor: Colors.white)),
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
                  text: agenceSalarieQuickAccessModel.LIE_LIB ?? "",
                  maxLines: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CupertinoButton(
                onPressed: null,
                padding: EdgeInsets.zero,
                child: Transform.translate(
                  offset: const Offset(0, 0),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(
                                CupertinoIcons.calendar,
                                color: Colors.black,
                              ),
                              Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: GBSystem_TextHelper().superSmallText(
                                      text: "D",
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 80,
                            child: GBSystem_TextHelper().smallText(
                                text: agenceSalarieQuickAccessModel
                                            .START_PERIODE !=
                                        null
                                    ? ConvertDateService().parseDate(
                                        date: agenceSalarieQuickAccessModel
                                            .START_PERIODE!)
                                    : "",
                                fontWeight: FontWeight.w500,
                                maxLines: 2,
                                textColor: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(
                                CupertinoIcons.calendar,
                                color: Colors.black,
                              ),
                              Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: GBSystem_TextHelper().superSmallText(
                                      text: "F",
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 80,
                            child: GBSystem_TextHelper().smallText(
                                text:
                                    agenceSalarieQuickAccessModel.END_PERIODE !=
                                            null
                                        ? ConvertDateService().parseDate(
                                            date: agenceSalarieQuickAccessModel
                                                .END_PERIODE!)
                                        : "",
                                fontWeight: FontWeight.w500,
                                maxLines: 2,
                                textColor: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Transform.translate(
                offset: const Offset(-5, -5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      CupertinoIcons.doc_chart_fill,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 90,
                      child: GBSystem_TextHelper().smallText(
                          text: agenceSalarieQuickAccessModel.LIEINSPQSNR_LIB ??
                              "",
                          fontWeight: FontWeight.w500,
                          maxLines: 2,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
