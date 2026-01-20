import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/evaluation_status_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_local_database_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class TabBarWidget extends StatelessWidget {
  TabBarWidget(
      {Key? key,
      required this.items,
      required this.pageController,
      this.color1,
      required this.current,
      required this.scrollController,
      this.color2,
      required this.evaluationEnCoursModel_LIEINSPSVR_IDF})
      : super(key: key);
  final String? evaluationEnCoursModel_LIEINSPSVR_IDF;
  final List<String> items;
  PageController pageController;
  Rx<ScrollController> scrollController;
  RxInt current;
  final Color? color1, color2;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: double.infinity,
          margin: const EdgeInsets.all(5),
          child: SizedBox(
            width: double.infinity,
            height: 80,
            child: ListView.builder(
                controller: scrollController.value,
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          current.value = index;
                          changeTabAndQuestionIndex(current.value, 0);
                          pageController.animateToPage(
                            current.value,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease,
                          );
                        },
                        child: Obx(
                          () => AnimatedContainer(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            height: 55,
                            width: 220,
                            decoration: BoxDecoration(
                              color: current.value == index
                                  ? color1 ??
                                      GbsSystemServerStrings.str_primary_color
                                  : Colors.grey.shade200,
                              borderRadius: current.value == index
                                  ? BorderRadius.circular(12)
                                  : BorderRadius.circular(7),
                              border: current.value == index
                                  ? Border.all(
                                      color: GbsSystemServerStrings
                                          .str_primary_color,
                                      width: 2.5)
                                  : Border.all(
                                      color: Colors.grey.shade300, width: 2),
                            ),
                            child: Center(
                                child: GBSystem_TextHelper().smallText(
                              text: items[index],
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              textColor: current.value == index
                                  ? Colors.white
                                  : Colors.black45,
                            )),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                              color: GbsSystemServerStrings.str_primary_color,
                              shape: BoxShape.circle),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ));
  }

  Future changeTabIndex(int newIndex) async {
    final status = LocalDatabaseService.getByIdfEval(
        evaluationEnCoursModel_LIEINSPSVR_IDF!);
    EvaluationStatus? oldStatus;
    if (status != null) {
      oldStatus = EvaluationStatus(
        LIEINSPSVR_IDF: status['LIEINSPSVR_IDF'] as String,
        questionIndex: status['questionIndex'] as int,
        questionTypeIndex: status['questionTypeIndex'] as int,
      );
    }
    await LocalDatabaseService.saveOrUpdateEval(
      LIEINSPSVR_IDF: evaluationEnCoursModel_LIEINSPSVR_IDF!,
      questionTypeIndex: newIndex,
      questionIndex: oldStatus?.questionIndex ?? 0,
    );
  }

  Future changeQuestionIndex(int newIndex) async {
    final status = LocalDatabaseService.getByIdfEval(
        evaluationEnCoursModel_LIEINSPSVR_IDF!);
    EvaluationStatus? oldStatus;
    if (status != null) {
      oldStatus = EvaluationStatus(
        LIEINSPSVR_IDF: status['LIEINSPSVR_IDF'] as String,
        questionIndex: status['questionIndex'] as int,
        questionTypeIndex: status['questionTypeIndex'] as int,
      );
    }
    await LocalDatabaseService.saveOrUpdateEval(
      LIEINSPSVR_IDF: evaluationEnCoursModel_LIEINSPSVR_IDF!,
      questionTypeIndex: oldStatus?.questionTypeIndex ?? 0,
      questionIndex: newIndex,
    );
  }

  Future changeTabAndQuestionIndex(
      int newIndexTab, int newIndexQuestion) async {
    await LocalDatabaseService.saveOrUpdateEval(
      LIEINSPSVR_IDF: evaluationEnCoursModel_LIEINSPSVR_IDF!,
      questionTypeIndex: newIndexTab,
      questionIndex: newIndexQuestion,
    );
  }
}
