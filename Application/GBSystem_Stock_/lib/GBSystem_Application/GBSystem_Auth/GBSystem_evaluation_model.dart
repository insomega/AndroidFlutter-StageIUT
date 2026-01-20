class EvaluationModel {
  final String EVAL_MOYENNE;
  final String EVAL_STAT;

  const EvaluationModel({
    required this.EVAL_MOYENNE,
    required this.EVAL_STAT,
  });

  static EvaluationModel fromJson(json) {
    return EvaluationModel(
      EVAL_MOYENNE: json["EVAL_MOYENNE"].toString(),
      EVAL_STAT: json["EVAL_STAT"],
    );
  }

  static List<EvaluationModel> convertDynamictoListEvaluation(
      List<dynamic> evaluationDynamic) {
    List<EvaluationModel> listSalaries = [];
    for (var i = 0; i < evaluationDynamic.length; i++) {
      listSalaries.add(EvaluationModel.fromJson(evaluationDynamic[i]));
    }
    return listSalaries;
  }
}
