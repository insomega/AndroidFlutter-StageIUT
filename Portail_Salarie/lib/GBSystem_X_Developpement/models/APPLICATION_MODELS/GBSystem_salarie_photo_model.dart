import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_app_info_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_salarie_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_topic_model.dart';

class GBSystemSalarieWithPhotoModel {
  final SalarieModel salarieModel;
  final String? imageSalarie;
  final String? mapToken;
  final List<GbsystemTopicModel>? listTopics;
  final GbsystemAppInfoModel? appInfo;

  GBSystemSalarieWithPhotoModel({
    required this.salarieModel,
    required this.imageSalarie,
    required this.mapToken,
    required this.listTopics,
    required this.appInfo,
  });
}
