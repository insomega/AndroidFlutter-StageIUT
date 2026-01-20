import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_document_entreprise_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_type_filtre_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class DocumentEntrepriseMainWidgetController extends GetxController {
  DocumentEntrepriseMainWidgetController(this.context);

BuildContext context;
final documentEntrepriseController = Get.put<GBSystemDocumentEntrepriseController>(
        GBSystemDocumentEntrepriseController());
final typeFiltreController = Get.put<GBSystemTypeFiltreController>(
        GBSystemTypeFiltreController());

         List<String> listType = [
    GbsSystemStrings.str_detail_contact.tr,
    GbsSystemStrings.str_document_administratif.tr,
    GbsSystemStrings.str_tous.tr
  ];
    Rx<String?> selectedType = Rx<String?>(null);
     Rx<int?> selectedIndex = Rx<int?>(null);

}