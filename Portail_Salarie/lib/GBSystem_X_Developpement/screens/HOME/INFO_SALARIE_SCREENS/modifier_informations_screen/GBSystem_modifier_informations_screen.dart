import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/tab_bar.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/ADRESSE_WIDGET/adresse_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/EMAIL_WIDGET/email_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/PHOTO_NOM_PRENOM_WIDGET/photo_nom_prenom_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/TELEPHONE_WIDGET/telephone_widget.dart';

class GBSystemModifierInformationsScreen extends StatefulWidget {
  GBSystemModifierInformationsScreen(
      {super.key, this.isCommingFromOut = false});
  final bool isCommingFromOut;

  @override
  State<GBSystemModifierInformationsScreen> createState() =>
      _GBSystemModifierInformationsScreenState();
}

class _GBSystemModifierInformationsScreenState
    extends State<GBSystemModifierInformationsScreen> {
  late double screenWidth;

  RxInt current = RxInt(0);
  GBSystemSalarieWithPhotoModel? salarie;

  List<Widget> listPagesFormulaires = [];
  List<String> items = [];
  RxInt selectedIndex = RxInt(0);
  RxDouble currentIndex = RxDouble(0);
  RxDouble currentIndexTabBar = RxDouble(0);
  final PageController pageController = PageController(initialPage: 0);
  Rx<ScrollController> scrollController =
      Rx<ScrollController>(ScrollController(initialScrollOffset: 0));

  final salarieController =
      Get.put<GBSystemSalarieController>(GBSystemSalarieController());

  final String pageName = "GBSystem_modifier_informations_controller";
  ////
  RxBool isLoading = RxBool(false);
/////

  @override
  void initState() {
    initTypeAndQuestions();
    pageController.addListener(() {
      currentIndex = RxDouble(pageController.page!.toDouble());
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.close();
    current.value = 0;
    currentIndex.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    current.value = 0;
    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                centerTitle: true,
                elevation: 4.0,
                shadowColor: GbsSystemStrings.str_primary_color,
                toolbarHeight: 80,
                backgroundColor: GbsSystemStrings.str_primary_color,
                title: Text(
                  GbsSystemStrings.str_my_info.tr,
                  style: TextStyle(color: Colors.white),
                ),
                leading: widget.isCommingFromOut != true
                    ? InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
              ),
              body: Column(
                children: [
                  TabBarWidget(
                    pageController: pageController,
                    items: items,
                    current: current,
                    scrollController: scrollController,
                  ),
                  Expanded(
                    child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: pageController,
                        children: listPagesFormulaires),
                  )
                ],
              ),
            ),
            isLoading.value ? Waiting() : Container()
          ],
        ));
  }

  void initTypeAndQuestions() {
    items = [
      GbsSystemStrings.str_photo.tr,
      GbsSystemStrings.str_adresse.tr,
      GbsSystemStrings.str_telephone.tr,
      GbsSystemStrings.str_mail.tr
    ];
    salarie = salarieController.getSalarie;
    listPagesFormulaires.add(PhotoNomPrenomWidget(
        onSuivantTap: () {
          try {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              current++;
              pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear);

              double scrollOffset = (currentIndex + 1) *
                  (GBSystem_ScreenHelper.screenWidth(context) * 0.6);

              scrollController.value.animateTo(
                scrollOffset,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              );
            });
          } catch (e) {
            GBSystem_ManageCatchErrors().catchErrors(context,
                message: e.toString(),
                method: "onSuivantTap(PhotoNomPrenomWidget)",
                page: pageName);
          }
        },
        salarie: salarie));
    listPagesFormulaires.add(AdresseWidget(
        updateLoading: (valueBool) {
          isLoading.value = valueBool;
        },
        onPrecedentTap: () {
          try {
            current--;
            pageController.animateToPage(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
            double scrollOffset = (currentIndex - 1) *
                (GBSystem_ScreenHelper.screenWidth(context) * 0.6);
            scrollController.value.animateTo(
              scrollOffset,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          } catch (e) {
            GBSystem_ManageCatchErrors().catchErrors(context,
                message: e.toString(),
                method: "onPrecedentTap(AdresseWidget)",
                page: pageName);
          }
        },
        onSuivantTap: () {
          try {
            current++;
            pageController.animateToPage(2,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
            double scrollOffset = (currentIndex + 1) *
                (GBSystem_ScreenHelper.screenWidth(context) * 0.6);
            scrollController.value.animateTo(
              scrollOffset,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          } catch (e) {
            GBSystem_ManageCatchErrors().catchErrors(context,
                message: e.toString(),
                method: "onSuivantTap(AdresseWidget)",
                page: pageName);
          }
        },
        salarie: salarie));
    listPagesFormulaires.add(TelephoneWidget(
        updateLoading: (valueBool) {
          isLoading.value = valueBool;
        },
        onPrecedentTap: () {
          try {
            current--;
            pageController.animateToPage(1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
            double scrollOffset = (currentIndex - 1) *
                (GBSystem_ScreenHelper.screenWidth(context) * 0.6);
            scrollController.value.animateTo(
              scrollOffset,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          } catch (e) {
            GBSystem_ManageCatchErrors().catchErrors(context,
                message: e.toString(),
                method: "onPrecedentTap(TelephoneWidget)",
                page: pageName);
          }
        },
        onSuivantTap: () {
          try {
            current++;
            pageController.animateToPage(3,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
            double scrollOffset = (currentIndex + 1) *
                (GBSystem_ScreenHelper.screenWidth(context) * 0.6);
            scrollController.value.animateTo(
              scrollOffset,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          } catch (e) {
            GBSystem_ManageCatchErrors().catchErrors(context,
                message: e.toString(),
                method: "onSuivantTap(TelephoneWidget)",
                page: pageName);
          }
        },
        salarie: salarie));

    listPagesFormulaires.add(EmailWidget(
        updateLoading: (valueBool) {
          isLoading.value = valueBool;
        },
        onPrecedentTap: () {
          try {
            current--;
            pageController.animateToPage(2,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
            double scrollOffset = (currentIndex - 1) *
                (GBSystem_ScreenHelper.screenWidth(context) * 0.6);
            scrollController.value.animateTo(
              scrollOffset,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          } catch (e) {
            GBSystem_ManageCatchErrors().catchErrors(context,
                message: e.toString(),
                method: "onPrecedentTap(EmailWidget)",
                page: pageName);
          }
        },
        onSuivantTap: () {
          try {
            current++;
            pageController.animateToPage(4,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
            double scrollOffset = (currentIndex + 1) *
                (GBSystem_ScreenHelper.screenWidth(context) * 0.6);
            scrollController.value.animateTo(
              scrollOffset,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          } catch (e) {
            GBSystem_ManageCatchErrors().catchErrors(context,
                message: e.toString(),
                method: "onSuivantTap(EmailWidget)",
                page: pageName);
          }
        },
        salarie: salarie));
  }
}
