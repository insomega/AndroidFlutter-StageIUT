import 'dart:convert';
import 'dart:typed_data';

import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'GBSystem_Serveur_Info_Photo_Model.dart';
import 'GBSystem_Serveur_Info_Model.dart';

class GBSystem_Serveur_UserWelcome_Controller extends GBSystem_Root_Controller {
  GBSystem_Serveur_Info_Model? salarie;
  String? imageSalarie;

  Uint8List imageBase_b64() => base64Decode(imageSalarie!.split(',').last);

  String fullName() => '${salarie?.SVR_PRNOM} ${salarie?.SVR_NOM}';

  String initials() => '${salarie?.SVR_PRNOM.substring(0, 1)}${salarie?.SVR_NOM.substring(0, 1)}'.toUpperCase();

  @override
  void onInit() {
    super.onInit();
    _Load_Data_from_Server();
  }

  Future<void> _Load_Data_from_Server() async {
    try {
      isLoading.value = true;
      //   await faireQuelqueChose();
      //Get.log('start----------------------------------------_initializeData_For_Connected_Server');
      ResponseModel data = await Execute_Server_post(
        data: {
          "OKey": GBSystem_System_Strings.str_server_okey, //
          "ACT_ID": "44E1F828CA8245DB8FFD4209C0CB275C",
        },
      );
      //Get.log('end call api----------------------------------------_initializeData_For_Connected_Server');
      final salarieWithPhoto = GBSystem_Serveur_Info_Photo_Model.fromResponse(data);
      salarie = salarieWithPhoto?.Serveur_Info;
      imageSalarie = salarieWithPhoto?.imageSalarie ?? '';
      //Get.log('end----------------------------------------_initializeData_For_Connected_Server');
      //imageSalarie.value = salarieWithPhoto.imageSalarie;
    } catch (e) {
      GBSystem_Add_LogEvent(message: e.toString(), method: "_Load_Data_from_Server", page: "GBSystem_Serveur_UserWelcome_Controller");
    } finally {
      //Get.log('end----------------------------------------_initializeData');
      isLoading.value = false;
    }
  }
}
