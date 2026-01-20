import 'package:flutter/material.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class GBSystemSignatureWidgetController extends GetxController {
  late final SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: GbsSystemServerStrings.str_primary_color,
    exportBackgroundColor: Colors.white,
  );
}
