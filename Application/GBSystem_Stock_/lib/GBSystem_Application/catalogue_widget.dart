import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_catalogue_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_convert_date_service.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

class CatalogueWidget extends StatelessWidget {
  const CatalogueWidget({super.key, required this.catalogueModel, this.onAddStockTap, this.onUpdateTap, this.onDeleteTap});
  final GbsystemCatalogueModel catalogueModel;
  final void Function()? onAddStockTap, onUpdateTap, onDeleteTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: GBSystem_Application_Strings.str_primary_color,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: -30,
            blurRadius: 18,
            offset: const Offset(10, 40), // changes the shadow position
          ),
          BoxShadow(
            color: Colors.black12,
            spreadRadius: -30,
            blurRadius: 18,
            offset: const Offset(30, 45), // changes the shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [GBSystem_TextHelper().normalText(text: "Catalogue", fontWeight: FontWeight.bold, textColor: GBSystem_Application_Strings.str_primary_color)],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: GBSystem_TextHelper().smallText(text: 'Catégorie : ', textColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GBSystem_TextHelper().smallText(text: catalogueModel.ARTCAT_LIB, textColor: Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 85,
                    child: GBSystem_TextHelper().smallText(text: 'Code Article : ', textColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GBSystem_TextHelper().smallText(text: catalogueModel.ARTREF_CODE, textColor: Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                    child: GBSystem_TextHelper().smallText(text: 'Libellé article : ', textColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GBSystem_TextHelper().smallText(text: catalogueModel.ARTREF_LIB, textColor: Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 35,
                    child: GBSystem_TextHelper().smallText(text: 'Prix : ', textColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GBSystem_TextHelper().smallText(text: catalogueModel.ARTFOUREF_PRIX, textColor: Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    child: GBSystem_TextHelper().smallText(text: 'Couleur : ', textColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GBSystem_TextHelper().smallText(text: catalogueModel.CLR_LIB, textColor: Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 45,
                    child: GBSystem_TextHelper().smallText(text: 'Taille : ', textColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GBSystem_TextHelper().smallText(text: catalogueModel.TPOI_LIB, textColor: Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: GBSystem_TextHelper().smallText(text: 'Date de Début : ', textColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GBSystem_TextHelper().smallText(
                    text: catalogueModel.ARTFOUREF_START_DATE != null ? ConvertDateService().parseDate(date: catalogueModel.ARTFOUREF_START_DATE!) : "",
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                    child: GBSystem_TextHelper().smallText(text: 'Date de Fin : ', textColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GBSystem_TextHelper().smallText(
                    text: catalogueModel.ARTFOUREF_END_DATE != null ? ConvertDateService().parseDate(date: catalogueModel.ARTFOUREF_END_DATE!) : "",
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 85,
                    child: GBSystem_TextHelper().smallText(text: 'Fournisseur : ', textColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GBSystem_TextHelper().smallText(text: catalogueModel.FOU_LIB, textColor: Colors.white),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: onDeleteTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_delete, textColor: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: onUpdateTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(color: Colors.yellow[800], borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_update, textColor: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onAddStockTap,
                child: Container(
                  width: 150,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_add_stock, textColor: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
