import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_salarie_causerie_with_image_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_quick_access_model.dart';
import 'package:get/get.dart';

class HomeCouserieScreenController extends GetxController {
  BuildContext context;
  RxBool isLoading = RxBool(false);
  HomeCouserieScreenController({required this.context});
  Rx<SiteQuickAccesModel?> selectedSite = Rx<SiteQuickAccesModel?>(null);
  List<SiteQuickAccesModel>? listSites;

  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());
  final GBSystemSalarieCauserieWithImageController
      salarieCauserieWithImageController =
      Get.put(GBSystemSalarieCauserieWithImageController());

//  late Rx<DateTime?> dateDebut, dateFin;
//      dateDebut =
//         DateTime(DateTime.now().year, DateTime.now().month, 1);
//      lastDateMonth =
//         DateTime(DateTime.now().year, DateTime.now().month + 1, 1)
//             .subtract(Duration(days: 1));

  Rx<DateTime?> dateDebut =
      Rx<DateTime?>(DateTime(DateTime.now().year, DateTime.now().month, 1));
  Rx<DateTime?> dateFin = Rx<DateTime?>(
      DateTime(DateTime.now().year, DateTime.now().month + 1, 1)
          .subtract(Duration(days: 1)));

  // final GBSystemSalarieQuickAccessController salarieQuickAccessController =
  //     Get.put(GBSystemSalarieQuickAccessController());
  // final GBSystemSalarieQuickAccessWithImageController
  //     salarieQuickAccessWithImageController =
  //     Get.put(GBSystemSalarieQuickAccessWithImageController());

  @override
  void onInit() {
    listSites = evaluationSurSiteController.getAllSites;

    super.onInit();
  }

  // Future chargerDataQuestionnaire() async {
  //   if (evaluationSurSiteController.getSelectedQuestionnaire != null &&
  //       evaluationSurSiteController.getSelectedTypeQuestionnaire != null) {
  //     isLoading.value = true;
  //     await GBSystem_AuthService(context)
  //         .getSalariesQuickAccess(
  //             questionnaireModel:
  //                 evaluationSurSiteController.getSelectedQuestionnaire!,
  //             typeQuestionnaire:
  //                 evaluationSurSiteController.getSelectedTypeQuestionnaire!,
  //             siteQuickAccesModel: evaluationSurSiteController.getSelectedSite,
  //             type: selectedType.value)
  //         .then((salaries) async {
  //       if (salaries != null) {
  //         await getImageOfSalariesAndUpdateController(
  //             salarieQuickAccessModel: salaries);

  //         isLoading.value = false;
  //         Get.to(GBSystemListSalariesScreen());
  //       } else {
  //         isLoading.value = false;
  //         showErrorDialog(context, GbsSystemStrings.str_no_salarie);
  //       }
  //     });
  //   } else {
  //     showErrorDialog(context, GbsSystemStrings.str_remplie_cases);
  //   }
  // }

  // Future getImageOfSalariesAndUpdateController(
  //     {required List<SalarieQuickAccessModel> salarieQuickAccessModel}) async {
  //   List<GBSystemSalarieQuickAccessWithPhotoModel> listSalariesImage = [];

  //   /// this boucle remplace the lines below (get salaries without his photos)
  //   for (var i = 0; i < salarieQuickAccessModel.length; i++) {
  //     listSalariesImage.add(GBSystemSalarieQuickAccessWithPhotoModel(
  //         salarieModel: salarieQuickAccessModel[i], imageSalarie: null));
  //   }

  //   /// this lines get the photo of chaque salarie i do it as comment because it take long time

  //   // for (var i = 0; i < salarieQuickAccessModel.length; i++) {
  //   //   await GBSystem_AuthService(context)
  //   //       .getPhotoSalarieQuickAccess(
  //   //           salarieQuickAccessModel: salarieQuickAccessModel[i])
  //   //       .then((image) {
  //   //     listSalariesImage.add(GBSystemSalarieQuickAccessWithPhotoModel(
  //   //         salarieModel: salarieQuickAccessModel[i], imageSalarie: image));
  //   //   });
  //   // }

  //   salarieQuickAccessWithImageController.setAllSalaries = listSalariesImage;
  // }
}
