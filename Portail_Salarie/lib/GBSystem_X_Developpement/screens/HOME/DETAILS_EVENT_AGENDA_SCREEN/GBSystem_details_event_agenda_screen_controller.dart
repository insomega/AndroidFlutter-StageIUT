import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';

class DetailsEventsAgendaScreenController extends GetxController {
  GBSystemSalarieWithPhotoModel? salarie;
  RxBool markerLocationVisibility = RxBool(false);
  RxBool markerUserVisibility = RxBool(false);

  LatLng? myPosition;

  final vacationController =
      Get.put<GBSystemVacationController>(GBSystemVacationController());
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());

  @override
  void onInit() {
    salarie = salarieController.getSalarie;
    myPosition = initPositionMap();
    super.onInit();
  }

  LatLng? initPositionMap() {
    if ((vacationController.getCurrentVacation?.LIE_LATITUDE != null &&
            vacationController.getCurrentVacation!.LIE_LATITUDE.isNotEmpty) &&
        (vacationController.getCurrentVacation?.LIE_LONGITUDE != null &&
            vacationController.getCurrentVacation!.LIE_LONGITUDE.isNotEmpty)) {
      final myPosition = LatLng(
          double.parse(vacationController.getCurrentVacation!.LIE_LATITUDE
              .replaceAll(",", ".")),
          double.parse(vacationController.getCurrentVacation!.LIE_LONGITUDE
              .replaceAll(",", ".")));
      return myPosition;
    }
    // else if (salarieController.getSalarie?.salarieModel.SVR_LATITUDE !=
    //         null &&
    //     salarieController.getSalarie?.salarieModel.SVR_LONGITUDE != null) {
    //   final myPosition = LatLng(
    //       double.parse(salarieController.getSalarie!.salarieModel.SVR_LATITUDE
    //           .replaceAll(",", ".")),
    //       double.parse(salarieController.getSalarie!.salarieModel.SVR_LONGITUDE
    //           .replaceAll(",", ".")));
    //   return myPosition;
    // }
    else {
      return null;
    }
  }
}
