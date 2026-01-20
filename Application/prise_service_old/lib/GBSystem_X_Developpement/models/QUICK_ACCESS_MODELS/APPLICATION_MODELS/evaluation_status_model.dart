import 'package:hive/hive.dart';

class EvaluationStatus extends HiveObject {
  String LIEINSPSVR_IDF;
  int questionTypeIndex;
  int questionIndex;

  EvaluationStatus({
    required this.LIEINSPSVR_IDF,
    required this.questionTypeIndex,
    required this.questionIndex,
  });
}
