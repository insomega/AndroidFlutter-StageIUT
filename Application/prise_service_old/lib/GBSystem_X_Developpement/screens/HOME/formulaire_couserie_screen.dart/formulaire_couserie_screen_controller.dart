import 'package:flutter/widgets.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_formulaire_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_salarie_causerie_with_image_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_signature_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_question_type_with_his_questions_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/GBSystem_formulaire_causerie_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class FormulaireCouserieScreenController extends GetxController {
  FormulaireCouserieScreenController(this.context,
      {this.causerieModel, required this.isViewMode});

  final bool isViewMode;
  final CauserieModel? causerieModel;
  final GBSystemSalarieCauserieWithImageController
      salarieCauserieWithImageController =
      Get.put(GBSystemSalarieCauserieWithImageController());

  RxInt current = RxInt(0);
  BuildContext context;
  List<Widget> listPagesFormulaires = [];
  final FormulaireController formulaireController =
      Get.put(FormulaireController());
  final bool showDate = false;
  Rx<DateTime?>? selectedDate = Rx<DateTime?>(null);
  List<String> items = [];
  RxInt selectedIndex = RxInt(0);
  RxDouble currentIndex = RxDouble(0);
  RxDouble currentIndexTabBar = RxDouble(0);

  final PageController pageController = PageController(initialPage: 0);
  Rx<ScrollController> scrollController =
      Rx<ScrollController>(ScrollController(initialScrollOffset: 0));

  ////
  RxBool isImageFocused = RxBool(false);
  RxBool isLoading = RxBool(false);
/////
  List<QuestionTypeWithHisQuestionsModel> listQCM = [];
  final GBSystemSignatureController signatureController =
      Get.put(GBSystemSignatureController());

  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());

  // final CauserieController qcmController = Get.put(CauserieController());

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

  void updateImageBool(bool newValue) {
    isImageFocused.value = newValue;
    update();
  }

  Future chargerData() async {
    if (signatureController.getSignatureBase64 != null) {
      isLoading.value = true;
      await GBSystem_AuthService(context)
          .sendReponseCloseEvaluation(
              LIEINSPSVR_IDF: formulaireController.get_LIEINSPSVR_IDF!)
          .then((reponse) {
        isLoading.value = false;

        if (reponse != null) {
          print(reponse.LIEINSPSVR_END_DATE);
          signatureController.setIsCloture = true;
          evaluationSurSiteController.setDateFinCloture =
              reponse.LIEINSPSVR_END_DATE;
          showSuccesDialog(context, GbsSystemStrings.str_operation_effectuee);
        } else {
          showErrorDialog(context, GbsSystemStrings.str_error_send_data);
        }
      });
    } else {
      showErrorDialog(context, GbsSystemStrings.str_signature_neccessaire);
    }
  }

  Future chargerDataView({required CauserieModel causerieModel}) async {
    isLoading.value = true;
    await GBSystem_AuthService(context)
        .sendReponseCloseEvaluation(
            LIEINSPSVR_IDF: causerieModel.LIEINSPSVR_IDF)
        .then((reponse) {
      isLoading.value = false;

      if (reponse != null) {
        signatureController.setIsCloture = true;
        showSuccesDialog(context, GbsSystemStrings.str_operation_effectuee);
      }
      // else {
      //   showErrorDialog(context, GbsSystemStrings.str_error_send_data);
      // }
    });
  }

  void initTypeAndQuestions() {
    formulaireController.getAllQuestionTypeWithHisQuestionsModel!
        .forEach((element) {
      items.add(element.questionType.LIEINSPCAT_LIB);

      listPagesFormulaires.add(FormulaireCauserieType(
        causerieModel: causerieModel,
        isViewMode: isViewMode,
        questions: element.questions,
        salaries: salarieCauserieWithImageController.getAllSelectedSalaries!,
      ));
    });
  }
}
