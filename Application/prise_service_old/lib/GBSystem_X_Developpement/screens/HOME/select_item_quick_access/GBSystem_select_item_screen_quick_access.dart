import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_type_questionnaire_quick_access_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_quick_access/GBSystem_select_item_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_CardView_Widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystem_SelectItemQuickAccessScreen extends StatelessWidget {
  GBSystem_SelectItemQuickAccessScreen(
      {super.key,
      required this.type,
      required this.selectedQuestionTypeModel,
      this.isCauserie = false});

  final String type;
  final bool isCauserie;
  final TypeQuestionnaireModel? selectedQuestionTypeModel;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemQuickAccessController m =
        Get.put(GBSystemSelectItemQuickAccessController(
      isCauserie: isCauserie,
      type: type,
      context: context,
    ));

    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                centerTitle: true,
                elevation: 4.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                toolbarHeight: 80,
                backgroundColor: GbsSystemServerStrings.str_primary_color,
                title: const Text(
                  GbsSystemStrings.str_app_bar_select_item,
                  style: TextStyle(color: Colors.white),
                ),
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.02),
                    vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                        context, 0.02)),
                child: Column(
                  children: [
                    SearchBar(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      hintText: GbsSystemStrings.str_rechercher,
                      controller: m.controllerSearch,
                      leading: const Icon(CupertinoIcons.search),
                      trailing: [
                        GestureDetector(
                            onTap: () {
                              m.controllerSearch.text = "";
                              m.text?.value = "";
                            },
                            child: const Icon(Icons.close))
                      ],
                      onChanged: (String query) {
                        type == GbsSystemStrings.str_type_site
                            ? m.filterDataSite(query)
                            : type == GbsSystemStrings.str_type_questionnaire
                                ? m.filterDataQuestionnaire(query)
                                : m.filterDataTypeQuestionnaire(query);
                      },
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    m.text != null && m.text != ''
                        ? (type == GbsSystemStrings.str_type_site
                                ? m.filtredSites.isNotEmpty
                                : type ==
                                        GbsSystemStrings.str_type_questionnaire
                                    ? m.filtredQuestionnaire.isNotEmpty
                                    : m.filtredTypeQuestionnaire.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: type ==
                                          GbsSystemStrings.str_type_site
                                      ? m.filtredSites.length
                                      : type ==
                                              GbsSystemStrings
                                                  .str_type_questionnaire
                                          ? m.filtredQuestionnaire.length
                                          : m.filtredTypeQuestionnaire.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: type ==
                                              GbsSystemStrings.str_type_site
                                          ? GBSystem_Root_CardViewWidgetGenerique(
                                              tileColor: index % 2 == 0
                                                  ? Colors.grey.withOpacity(0.2)
                                                  : Colors.white,
                                              onTap: () async {
                                                m.onSelectedSite(
                                                    m.filtredSites[index]);
                                              },
                                              title:
                                                  m.filtredSites[index].LIE_LIB,
                                              optStr1: m
                                                  .filtredSites[index].LIE_CODE,
                                              optStr2: null,
                                              optStr3: null,
                                            )
                                          : type ==
                                                  GbsSystemStrings
                                                      .str_type_questionnaire
                                              ? GBSystem_Root_CardViewWidgetGenerique(
                                                  tileColor: index % 2 == 0
                                                      ? Colors.grey
                                                          .withOpacity(0.2)
                                                      : Colors.white,
                                                  onTap: () {
                                                    m.onSelectedQuestionnaire(
                                                        m.filtredQuestionnaire[
                                                            index]);
                                                  },
                                                  optStr1: m
                                                      .filtredQuestionnaire[
                                                          index]
                                                      .LIEINSPQSNR_LIB,
                                                  title: m
                                                      .filtredQuestionnaire[
                                                          index]
                                                      .LIEINSPQSNR_CODE,
                                                  optStr2: m
                                                      .filtredQuestionnaire[
                                                          index]
                                                      .LIEINSTYP_LIB,
                                                  optStr3: m
                                                      .filtredQuestionnaire[
                                                          index]
                                                      .LIEINSQUESTYP_LIB,
                                                )
                                              : GBSystem_Root_CardViewWidgetGenerique(
                                                  tileColor: index % 2 == 0
                                                      ? Colors.grey
                                                          .withOpacity(0.2)
                                                      : Colors.white,
                                                  onTap: () {
                                                    m.onSelectedTypeQuestionnaire(
                                                        m.filtredTypeQuestionnaire[
                                                            index]);
                                                  },
                                                  title: m
                                                      .filtredTypeQuestionnaire[
                                                          index]
                                                      .LIEINSQUESTYP_CODE,
                                                  optStr1: m
                                                      .filtredTypeQuestionnaire[
                                                          index]
                                                      .LIEINSQUESTYP_LIB,
                                                  optStr2: null,
                                                  optStr3: null,
                                                ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data,
                              ))
                        : (type == GbsSystemStrings.str_type_site
                                ? m.sites.isNotEmpty
                                : type ==
                                        GbsSystemStrings.str_type_questionnaire
                                    ? m.questionnaires.isNotEmpty
                                    : m.typeQuestionnaires.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      type == GbsSystemStrings.str_type_site
                                          ? m.sites.length
                                          : type ==
                                                  GbsSystemStrings
                                                      .str_type_questionnaire
                                              ? m.questionnaires.length
                                              : m.typeQuestionnaires.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: type ==
                                              GbsSystemStrings.str_type_site
                                          ? GBSystem_Root_CardViewWidgetGenerique(
                                              tileColor: index % 2 == 0
                                                  ? Colors.grey.withOpacity(0.2)
                                                  : Colors.white,
                                              onTap: () async {
                                                m.onSelectedSite(
                                                    m.sites[index]);
                                              },
                                              title: m.sites[index].LIE_LIB,
                                              optStr1: m.sites[index].LIE_CODE,
                                              optStr2: null,
                                              optStr3: null,
                                            )
                                          : type ==
                                                  GbsSystemStrings
                                                      .str_type_questionnaire
                                              ? GBSystem_Root_CardViewWidgetGenerique(
                                                  tileColor: index % 2 == 0
                                                      ? Colors.grey
                                                          .withOpacity(0.2)
                                                      : Colors.white,
                                                  onTap: () {
                                                    m.onSelectedQuestionnaire(m
                                                        .questionnaires[index]);
                                                  },
                                                  optStr1: m
                                                      .questionnaires[index]
                                                      .LIEINSPQSNR_LIB,
                                                  title: m.questionnaires[index]
                                                      .LIEINSPQSNR_CODE,
                                                  optStr2: m
                                                      .questionnaires[index]
                                                      .LIEINSTYP_LIB,
                                                  optStr3: m
                                                      .questionnaires[index]
                                                      .LIEINSQUESTYP_LIB,
                                                )
                                              : GBSystem_Root_CardViewWidgetGenerique(
                                                  tileColor: index % 2 == 0
                                                      ? Colors.grey
                                                          .withOpacity(0.2)
                                                      : Colors.white,
                                                  onTap: () {
                                                    m.onSelectedTypeQuestionnaire(
                                                        m.typeQuestionnaires[
                                                            index]);
                                                  },
                                                  title: m
                                                      .typeQuestionnaires[index]
                                                      .LIEINSQUESTYP_CODE,
                                                  optStr1: m
                                                      .typeQuestionnaires[index]
                                                      .LIEINSQUESTYP_LIB,
                                                  optStr2: null,
                                                  optStr3: null,
                                                ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data,
                              )),
                  ],
                ),
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
