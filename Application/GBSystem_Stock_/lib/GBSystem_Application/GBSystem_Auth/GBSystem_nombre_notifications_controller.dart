import 'package:get/get.dart';

class GBSystemNotificationController extends GetxController {
  RxString? _nbrNoti = RxString("");
  set setNbrNoti(String nbrNoti) {
    _nbrNoti?.value = nbrNoti;
    update();
  }

  RxString? get getNBrNoti => _nbrNoti;
}
