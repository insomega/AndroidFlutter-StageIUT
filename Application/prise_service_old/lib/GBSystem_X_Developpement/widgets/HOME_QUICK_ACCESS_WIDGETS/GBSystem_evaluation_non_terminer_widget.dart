import 'dart:convert';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_evaluation_en_cours_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class EvaluationNonTerminerWidget extends StatefulWidget {
  const EvaluationNonTerminerWidget({
    super.key,
    required this.evaluationNonTerminer,
    required this.imageSalarie,
    this.onTap,
  });

  final EvaluationEnCoursModel evaluationNonTerminer;
  final String? imageSalarie;
  final void Function()? onTap;

  @override
  State<EvaluationNonTerminerWidget> createState() =>
      _EvaluationNonTerminerWidgetState();
}

class _EvaluationNonTerminerWidgetState
    extends State<EvaluationNonTerminerWidget> {
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
                  PageSalarie1(
                      evaluationNonTerminer: widget.evaluationNonTerminer,
                      imageSalarie: widget.imageSalarie),
                  // PageSalarie2(
                  //     evaluationNonTerminer: widget.evaluationNonTerminer),
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
    required this.evaluationNonTerminer,
    required this.imageSalarie,
    this.onTap,
  });
  final EvaluationEnCoursModel evaluationNonTerminer;
  String? imageSalarie;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FutureBuilder<String?>(
            future: GBSystem_AuthService(context).getPhotoSalarieQuickAccess(
              SVR_IDF: evaluationNonTerminer.SVR_IDF,
              // evaluationNonTerminer: evaluationNonTerminer.salarieModel
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                imageSalarie = snapshot.data;
                // evaluationNonTerminer.imageSalarie = imageSalarie;
              }
              return Transform.translate(
                offset: const Offset(0, 10),
                child: ClipOval(
                  child: imageSalarie != null
                      ? Image.memory(
                          base64Decode(imageSalarie!.split(',').last),
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
                                        "${evaluationNonTerminer.SVR_LIB.substring(0, 1).toUpperCase()}${evaluationNonTerminer.SVR_LIB.substring(1, 2).toUpperCase()}",
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
                                      "${evaluationNonTerminer.SVR_LIB.substring(0, 1).toUpperCase()}${evaluationNonTerminer.SVR_LIB.substring(1, 2).toUpperCase()}",
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: GBSystem_TextHelper().normalText(
                  textAlign: TextAlign.start,
                  textColor: Colors.black,
                  text: evaluationNonTerminer.CLI_LIB,
                  maxLines: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, 0),
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          CupertinoIcons.location_solid,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 80,
                          child: GBSystem_TextHelper().smallText(
                              text: evaluationNonTerminer.LIE_LIB,
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              textColor: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          CupertinoIcons.person_alt,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 80,
                          child: GBSystem_TextHelper().smallText(
                              text: evaluationNonTerminer.SVR_LIB,
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              textColor: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(-5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.type_specimen,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 75,
                          child: GBSystem_TextHelper().smallText(
                              text: evaluationNonTerminer.LIEINSPQSNR_LIB,
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              // textAlign: TextAlign.center,
                              textColor: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.calendar,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 75,
                          child: GBSystem_TextHelper().smallText(
                              text:
                                  evaluationNonTerminer.LIEINSPSVR_START_DATE !=
                                          null
                                      ? ConvertDateService().parseDateAndTime(
                                          date: evaluationNonTerminer
                                              .LIEINSPSVR_START_DATE!)
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
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PageSalarie2 extends StatelessWidget {
  const PageSalarie2({super.key, required this.evaluationNonTerminer});
  final EvaluationEnCoursModel evaluationNonTerminer;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    CupertinoIcons.calendar,
                    color: Colors.black,
                  ),
                  Positioned(
                      bottom: -5,
                      right: -5,
                      child: GBSystem_TextHelper().superSmallText(
                          textColor: Colors.black,
                          text: "D",
                          fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                // width: 90,
                child: GBSystem_TextHelper().smallText(
                    text: evaluationNonTerminer.LIEINSPSVR_START_DATE != null
                        ? ConvertDateService().parseDateAndTime(
                            date: evaluationNonTerminer.LIEINSPSVR_START_DATE!)
                        : "",
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    CupertinoIcons.calendar,
                    color: Colors.black,
                  ),
                  Positioned(
                      bottom: -5,
                      right: -5,
                      child: GBSystem_TextHelper().superSmallText(
                          textColor: Colors.black,
                          text: "F",
                          fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                // width: 90,
                child: GBSystem_TextHelper().smallText(
                    text: evaluationNonTerminer.LIEINSPSVR_END_DATE != null
                        ? ConvertDateService().parseDateAndTime(
                            date: evaluationNonTerminer.LIEINSPSVR_END_DATE!)
                        : "",
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                CupertinoIcons.gift_fill,
                color: Colors.black,
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 60,
                child: GBSystem_TextHelper().smallText(
                    text: evaluationNonTerminer.LIEINSPQSNR_LIB,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                    textColor: Colors.black),
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
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 100,
                child: GBSystem_TextHelper().smallText(
                    text: evaluationNonTerminer.SVR_LIB,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                    textColor: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
