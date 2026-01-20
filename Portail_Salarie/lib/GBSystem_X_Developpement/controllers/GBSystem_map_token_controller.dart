import 'package:get/get.dart';

class GBSystemMapTokenController extends GetxController {
  String? _currentToken;

  set setCurrentToken(String? token) {
    _currentToken = token;
    update();
  }

  String? get getCurrentToken => _currentToken;
}
