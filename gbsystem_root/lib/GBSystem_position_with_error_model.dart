import 'package:geolocator/geolocator.dart';

class PositionWithErrorModel {
  final Position? position;
  final bool isPermissionNotGranted;
  final bool isPhoneDontSupport;
  final bool isTimeOut;
  final String? messageErr;

  PositionWithErrorModel({
    required this.isPermissionNotGranted,
    required this.isPhoneDontSupport,
    required this.isTimeOut,
    required this.messageErr,
    required this.position,
  });
}
