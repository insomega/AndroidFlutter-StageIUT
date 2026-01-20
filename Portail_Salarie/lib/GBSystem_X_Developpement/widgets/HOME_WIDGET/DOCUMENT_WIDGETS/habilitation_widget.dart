import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_agrement_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_diplome_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_officiel_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_habilitation_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class HabilitationWidget extends StatefulWidget {
  const HabilitationWidget(
      {super.key,
      required this.habilitationModel,
      this.onDeleteTap,
      this.onUpdateTap});
  final HabilitationModel habilitationModel;
  final void Function()? onDeleteTap, onUpdateTap;

  @override
  State<HabilitationWidget> createState() => _HabilitationWidgetState();
}

class _HabilitationWidgetState extends State<HabilitationWidget> {
  bool showDeleteAndUpdate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 0.3),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_habilitations.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.habilitationModel.FOR_LIB,
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_date_obtention.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.habilitationModel.SFOR_DATD != null
                        ? HabilitationModel.convertDate(
                            widget.habilitationModel.SFOR_DATD!)
                        : "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_fin_validiter.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.habilitationModel.SFOR_DATF != null
                        ? HabilitationModel.convertDate(
                            widget.habilitationModel.SFOR_DATF!)
                        : "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_description.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.habilitationModel.SFOR_COMM ?? "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_valider_le.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.habilitationModel.VALID_DATE != null
                        ? HabilitationModel.convertDate(
                            widget.habilitationModel.VALID_DATE!)
                        : "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: showDeleteAndUpdate ? Colors.transparent : Colors.pink,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: showDeleteAndUpdate
                    ? Row(
                        children: [
                          InkWell(
                              onTap: widget.onDeleteTap,
                              child: Icon(CupertinoIcons.delete_solid)),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: widget.onUpdateTap,
                              child:
                                  Icon(CupertinoIcons.arrow_clockwise_circle)),
                        ],
                      )
                    : GBSystem_TextHelper().smallText(
                        text: GbsSystemStrings.str_habilitations.tr,
                        textColor: Colors.white),
              ),
              InkWell(
                  onTap: () async {
                    setState(() {
                      showDeleteAndUpdate
                          ? showDeleteAndUpdate = false
                          : showDeleteAndUpdate = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.shade300),
                        child: Icon(
                          CupertinoIcons.ellipsis,
                        )),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class AgrementWidget extends StatefulWidget {
  const AgrementWidget(
      {super.key,
      required this.agrementModel,
      this.onDeleteTap,
      this.onUpdateTap});
  final AgrementModel agrementModel;
  final void Function()? onDeleteTap, onUpdateTap;

  @override
  State<AgrementWidget> createState() => _AgrementWidgetState();
}

class _AgrementWidgetState extends State<AgrementWidget> {
  bool showDeleteAndUpdate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 0.3),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_agrements.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.agrementModel.HAB_LIB,
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_date_obtention.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.agrementModel.SHAB_DATD != null
                        ? AgrementModel.convertDate(
                            widget.agrementModel.SHAB_DATD!)
                        : "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_fin_validiter.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.agrementModel.SHAB_DATF != null
                        ? AgrementModel.convertDate(
                            widget.agrementModel.SHAB_DATF!)
                        : "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_valider_le.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.agrementModel.VALID_DATE != null
                        ? AgrementModel.convertDate(
                            widget.agrementModel.VALID_DATE!)
                        : "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color:
                      showDeleteAndUpdate ? Colors.transparent : Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: showDeleteAndUpdate
                    ? Row(
                        children: [
                          InkWell(
                              onTap: widget.onDeleteTap,
                              child: Icon(CupertinoIcons.delete_solid)),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: widget.onUpdateTap,
                              child:
                                  Icon(CupertinoIcons.arrow_clockwise_circle)),
                        ],
                      )
                    : GBSystem_TextHelper().smallText(
                        text: GbsSystemStrings.str_agrement.tr,
                        textColor: Colors.white),
              ),
              InkWell(
                  onTap: () async {
                    setState(() {
                      showDeleteAndUpdate
                          ? showDeleteAndUpdate = false
                          : showDeleteAndUpdate = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.shade300),
                        child: Icon(
                          CupertinoIcons.ellipsis,
                        )),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class DiplomeWidget extends StatefulWidget {
  const DiplomeWidget(
      {super.key,
      required this.diplomeModel,
      this.onDeleteTap,
      this.onUpdateTap});
  final DiplomeModel diplomeModel;
  final void Function()? onDeleteTap, onUpdateTap;

  @override
  State<DiplomeWidget> createState() => _DiplomeWidgetState();
}

class _DiplomeWidgetState extends State<DiplomeWidget> {
  bool showDeleteAndUpdate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 0.3),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_diplomes.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.diplomeModel.DIP_LIB,
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_date_obtention.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.diplomeModel.SVRDIP_DATD != null
                        ? DiplomeModel.convertDate(
                            widget.diplomeModel.SVRDIP_DATD!)
                        : "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_valider_le.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.diplomeModel.VALID_DATE != null
                        ? DiplomeModel.convertDate(
                            widget.diplomeModel.VALID_DATE!)
                        : "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: showDeleteAndUpdate ? Colors.transparent : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: showDeleteAndUpdate
                    ? Row(
                        children: [
                          InkWell(
                              onTap: widget.onDeleteTap,
                              child: Icon(CupertinoIcons.delete_solid)),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: widget.onUpdateTap,
                              child:
                                  Icon(CupertinoIcons.arrow_clockwise_circle)),
                        ],
                      )
                    : GBSystem_TextHelper().smallText(
                        text: GbsSystemStrings.str_diplome.tr,
                        textColor: Colors.white),
              ),
              InkWell(
                  onTap: () async {
                    setState(() {
                      showDeleteAndUpdate
                          ? showDeleteAndUpdate = false
                          : showDeleteAndUpdate = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.shade300),
                        child: Icon(
                          CupertinoIcons.ellipsis,
                        )),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class DocumentOfficielWidget extends StatefulWidget {
  const DocumentOfficielWidget(
      {super.key,
      required this.documentOfficielModel,
      this.onDeleteTap,
      this.onUpdateTap});
  final DocumentOfficielModel documentOfficielModel;
  final void Function()? onDeleteTap, onUpdateTap;

  @override
  State<DocumentOfficielWidget> createState() => _DocumentOfficielWidgetState();
}

class _DocumentOfficielWidgetState extends State<DocumentOfficielWidget> {
  bool showDeleteAndUpdate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 0.3),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_documents_officiels.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.documentOfficielModel.DOCOFF_LIB,
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_numero_document.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.documentOfficielModel.SDF_NUM,
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_type.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.documentOfficielModel.SDF_PRO_TYPE,
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_departement.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.documentOfficielModel.SDF_PRO_DEPTM,
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_date_obtention.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.documentOfficielModel.SDF_DATD != null
                        ? DocumentOfficielModel.convertDate(
                            widget.documentOfficielModel.SDF_DATD!)
                        : "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              GBSystem_TextHelper().smallText(
                  text: GbsSystemStrings.str_valider_le.tr + " : ",
                  textColor: GbsSystemStrings.str_primary_color),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: widget.documentOfficielModel.VALID_DATE != null
                        ? DocumentOfficielModel.convertDate(
                            widget.documentOfficielModel.VALID_DATE!)
                        : "",
                    maxLines: 1,
                    textColor: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: showDeleteAndUpdate ? Colors.transparent : Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: showDeleteAndUpdate
                    ? Row(
                        children: [
                          InkWell(
                              onTap: widget.onDeleteTap,
                              child: Icon(CupertinoIcons.delete_solid)),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: widget.onUpdateTap,
                              child:
                                  Icon(CupertinoIcons.arrow_clockwise_circle)),
                        ],
                      )
                    : GBSystem_TextHelper().smallText(
                        text: GbsSystemStrings.str_documents_officiel.tr,
                        textColor: Colors.white),
              ),
              InkWell(
                  onTap: () async {
                    setState(() {
                      showDeleteAndUpdate
                          ? showDeleteAndUpdate = false
                          : showDeleteAndUpdate = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.shade300),
                        child: Icon(
                          CupertinoIcons.ellipsis,
                        )),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
