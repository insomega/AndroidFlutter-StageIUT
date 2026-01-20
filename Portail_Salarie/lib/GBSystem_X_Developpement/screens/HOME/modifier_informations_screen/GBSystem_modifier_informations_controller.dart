import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/ADRESSE_WIDGET/adresse_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/EMAIL_WIDGET/email_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/PHOTO_NOM_PRENOM_WIDGET/photo_nom_prenom_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/TELEPHONE_WIDGET/telephone_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class ModifierInformationController extends GetxController {
  ModifierInformationController(
    this.context,
  );
  RxInt current = RxInt(0);
  GBSystemSalarieWithPhotoModel? salarie;
  BuildContext context;
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

  ////
  RxBool isLoading = RxBool(false);
/////

  @override
  void onInit() {
    initTypeAndQuestions();
    pageController.addListener(() {
      currentIndex = RxDouble(pageController.page!.toDouble());
    });

    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();

    super.onClose();
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
        },
        salarie: salarie));
    listPagesFormulaires.add(AdresseWidget(
        updateLoading: (valueBool) {
          isLoading.value = valueBool;
        },
        onPrecedentTap: () {
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
        },
        onSuivantTap: () {
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
        },
        salarie: salarie));
    listPagesFormulaires.add(TelephoneWidget(
        updateLoading: (valueBool) {
          isLoading.value = valueBool;
        },
        onPrecedentTap: () {
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
        },
        onSuivantTap: () {
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
        },
        salarie: salarie));

    listPagesFormulaires.add(EmailWidget(
        updateLoading: (valueBool) {
          isLoading.value = valueBool;
        },
        onPrecedentTap: () {
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
        },
        onSuivantTap: () {
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
        },
        salarie: salarie));
  }
}
