import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/signature_salarie_model.dart';
import 'package:get/get.dart';

class GBSystemSignatureController extends GetxController {
  String? _currentSignature;
  List<SignatureSalarieModel> _listSignatureSalaries = [];
  bool _isClotureDone = false;

  set setSignatureBase64(String signature) {
    _currentSignature = signature;
    update();
  }

  set setIsCloture(bool isCloture) {
    _isClotureDone = isCloture;
    update();
  }

  set setAllSignatureSalaries(
      List<SignatureSalarieModel> listSignatureSalaries) {
    _listSignatureSalaries = listSignatureSalaries;
    update();
  }

  void addSignatureSalarie(SignatureSalarieModel signatureSalaries) {
    _listSignatureSalaries.add(signatureSalaries);
    update();
  }

  String? get getSignatureBase64 => _currentSignature;
  bool get getIsCloture => _isClotureDone;
  List<SignatureSalarieModel> get getAllSignatureSalaries =>
      _listSignatureSalaries;
}
