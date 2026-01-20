import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_image_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_image_type_two_model.dart';
import 'package:image_picker/image_picker.dart';

class ImageWithModel {
  XFile fileImage;
  ImageModel imageModel;
  ImageWithModel({required this.fileImage, required this.imageModel});
}

class ImageTypeTwoWithModel {
  String fileImage;
  ImageTypeTwoModel imageModel;
  ImageTypeTwoWithModel({required this.fileImage, required this.imageModel});
}
