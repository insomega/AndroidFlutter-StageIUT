import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_photo_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_type_model.dart';

class QuestionsSalariesCauserieModel {
  final List<QuestionTypeModel> questions;
  final List<GBSystemSalarieWithPhotoCauserieModel> salariesWithPhoto;
  QuestionsSalariesCauserieModel(
      {required this.questions, required this.salariesWithPhoto});
}
