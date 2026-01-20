import 'package:flutter/cupertino.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_sur_site_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_formulaire_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_qcm_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_signature_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_list_qcm_with_his_reponses_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/evaluation_status_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_local_database_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/GBSystem_formulaire_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemFormulaireSignatureController extends GetxController {
  GBSystemFormulaireSignatureController(
      this.context,
      this.isQCM,
      this.isViewMode,
      this.screenWidth,
      this.evaluationEnCoursModel_LIEINSPSVR_IDF,
      {required this.evaluationStatus});
  final String evaluationEnCoursModel_LIEINSPSVR_IDF;
  final double screenWidth;
  final bool isQCM;
  final bool isViewMode;
  final EvaluationStatus? evaluationStatus;
  //here change   index of tab bar ex 2 = 3 eme element
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

  late PageController pageController;
  //here change   scroll of tab bar
  // Rx<ScrollController> scrollTabBarController =
  //     Rx<ScrollController>(ScrollController(initialScrollOffset: (3) * (screenWidth * 0.7)));
  late Rx<ScrollController> scrollTabBarController;

  RxBool isImageFocused = RxBool(false);
  RxBool isLoading = RxBool(false);

  List<QCMWithHisReponsesModel> listQCM = [];

  final GBSystemSignatureController signatureController =
      Get.put(GBSystemSignatureController());

  final GBSystemEvaluationSurSiteController evaluationSurSiteController =
      Get.put(GBSystemEvaluationSurSiteController());

  final QCMController qcmController = Get.put(QCMController());

  void initiliseCurrentQuestionFocused() {
    current.value = 2;
  }

  @override
  void onInit() {
    print(
        "initilise evaluation with data : ${evaluationStatus?.LIEINSPSVR_IDF} - ${evaluationStatus?.questionTypeIndex} : ${evaluationStatus?.questionIndex}");
    //here change   scroll of tab bar exemple : 3eme element == 2
    scrollTabBarController = Rx<ScrollController>(ScrollController(
        initialScrollOffset:
            (evaluationStatus?.questionTypeIndex ?? 0) * (screenWidth * 0.6)));
    current.value = evaluationStatus?.questionTypeIndex ?? 0;
    pageController =
        PageController(initialPage: evaluationStatus?.questionIndex ?? 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(
        current.value,
      );
    });

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
          signatureController.setIsCloture = true;

          showSuccesDialog(context, GbsSystemStrings.str_operation_effectuee);
        } else {
          showErrorDialog(context, GbsSystemStrings.str_error_send_data);
        }
      });
    } else {
      showErrorDialog(context, GbsSystemStrings.str_signature_neccessaire);
    }
  }

  Future changeTabIndex(int newIndex) async {
    final status = LocalDatabaseService.getByIdfEval(
        evaluationEnCoursModel_LIEINSPSVR_IDF);
    EvaluationStatus? oldStatus;
    if (status != null) {
      oldStatus = EvaluationStatus(
        LIEINSPSVR_IDF: status['LIEINSPSVR_IDF'] as String,
        questionIndex: status['questionIndex'] as int,
        questionTypeIndex: status['questionTypeIndex'] as int,
      );
    }
    await LocalDatabaseService.saveOrUpdateEval(
      LIEINSPSVR_IDF: evaluationEnCoursModel_LIEINSPSVR_IDF,
      questionTypeIndex: newIndex,
      questionIndex: oldStatus?.questionIndex ?? 0,
    );
  }

  Future changeQuestionIndex(int newIndex) async {
    final status = LocalDatabaseService.getByIdfEval(
        evaluationEnCoursModel_LIEINSPSVR_IDF);
    EvaluationStatus? oldStatus;
    if (status != null) {
      oldStatus = EvaluationStatus(
        LIEINSPSVR_IDF: status['LIEINSPSVR_IDF'] as String,
        questionIndex: status['questionIndex'] as int,
        questionTypeIndex: status['questionTypeIndex'] as int,
      );
    }
    await LocalDatabaseService.saveOrUpdateEval(
      LIEINSPSVR_IDF: evaluationEnCoursModel_LIEINSPSVR_IDF,
      questionTypeIndex: oldStatus?.questionTypeIndex ?? 0,
      questionIndex: newIndex,
    );
  }

  Future changeTabAndQuestionIndex(
      int newIndexTab, int newIndexQuestion) async {
    await LocalDatabaseService.saveOrUpdateEval(
      LIEINSPSVR_IDF: evaluationEnCoursModel_LIEINSPSVR_IDF,
      questionTypeIndex: newIndexTab,
      questionIndex: newIndexQuestion,
    );
  }

  void initTypeAndQuestions() {
    isQCM
        ? (qcmController.getAllQCMWithHisReponses?.forEach((element) {
            listQCM.add(element);
          }))
        : (evaluationSurSiteController
                    .getSelectedTypeQuestionnaire?.LIEINSQUESTYP_LIB ==
                GbsSystemStrings.str_selected_type_questionnaire_controle)
            ? formulaireController.getAllQuestionTypeWithHisQuestionsModel!
                .forEach((element) {
                items.add(element.questionType.LIEINSPCAT_LIB);
                //here change   scroll of page(quest) inside quest type
                // ex : 3 quest  // (3) * (GBSystem_ScreenHelper.screenWidth(context) * 0.7)
                // (3) * (GBSystem_ScreenHelper.screenWidth(context) - 20)
                ScrollController scrollController = ScrollController(
                    initialScrollOffset:
                        (evaluationStatus?.questionIndex ?? 0) *
                            (GBSystem_ScreenHelper.screenWidth(context) - 20));

                listPagesFormulaires.add(SizedBox(
                  height: 350,
                  width: GBSystem_ScreenHelper.screenWidth(context),
                  child: ListView.builder(
                      // shrinkWrap: true,
                      controller: scrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: element.questions.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FormulaireType(
                              isViewMode: isViewMode,
                              //this parametre is to chose like or dislike (true) , or Rating bar (false)
                              isLikedBool: true,
                              showSuivantButton: true,
                              showPrecedentButton: true,
                              onSuivTap: () async {
                                if (scrollController.position.pixels >=
                                    scrollController.position.maxScrollExtent) {
                                  if (current.value + 1 < items.length) {
                                    current.value++;
                                    //
                                    changeTabAndQuestionIndex(current.value, 0);
                                    //
                                    pageController.animateToPage(
                                      current.value,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.ease,
                                    );
                                    print(
                                        "sizeeze ${(GBSystem_ScreenHelper.screenWidth(context) - 10)}");
                                    print('current ${current.value}');
                                    print('index ${index}');
                                    print(
                                        'currentIndexTabBar ${currentIndexTabBar.value}');
                                    print(
                                        'selected index ${selectedIndex.value}');

                                    double scrollOffset = (current.value) *
                                        (GBSystem_ScreenHelper.screenWidth(
                                                context) *
                                            0.6);

                                    scrollTabBarController.value.animateTo(
                                      scrollOffset,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    showErrorDialog(
                                        context, GbsSystemStrings.str_no_item);
                                  }
                                } else {
                                  double scrollOffset = (index + 1) *
                                      (GBSystem_ScreenHelper.screenWidth(
                                              context) -
                                          20);
                                  //
                                  changeQuestionIndex(index + 1);
                                  //
                                  scrollController.animateTo(
                                    scrollOffset,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              onPrecTap: () {
                                if (scrollController.position.pixels <=
                                    scrollController.position.minScrollExtent) {
                                  // print("scroll in deferent quest type");

                                  if (current.value - 1 >= 0) {
                                    current.value--;
                                    //
                                    // changeTabIndex(current.value);
                                    //
                                    changeTabAndQuestionIndex(current.value, 0);
                                    //
                                    //
                                    pageController.animateToPage(
                                      current.value,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.ease,
                                    );

                                    double scrollOffset = (current.value) *
                                        (GBSystem_ScreenHelper.screenWidth(
                                                context) *
                                            0.6);

                                    scrollTabBarController.value.animateTo(
                                      scrollOffset,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    showErrorDialog(
                                        context, GbsSystemStrings.str_no_item);
                                  }
                                } else {
                                  // print("Scroll in the same quest type");
                                  double scrollOffset = (index - 1) *
                                      (GBSystem_ScreenHelper.screenWidth(
                                              context) -
                                          20);
                                  //
                                  changeQuestionIndex(index - 1);
                                  //
                                  scrollController.animateTo(
                                    scrollOffset,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.9),
                              questionModel: element.questions[index],
                              coeff: 1,
                              // imageSalarie: salarie.imageSalarie,
                              // salarie: salarie.salarieModel,
                            ),
                          )),
                ));
              })
            : (qcmController.getAllQCMWithHisReponses?.forEach((element) {
                listQCM.add(element);
              }));
  }
}
