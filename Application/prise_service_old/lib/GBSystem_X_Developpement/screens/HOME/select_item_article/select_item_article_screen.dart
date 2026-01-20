import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_article/select_item_article_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_CardView_Widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_Card_Home_Widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystem_SelectItemArticleScreen extends StatelessWidget {
  const GBSystem_SelectItemArticleScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemArticleScreenController m =
        Get.put(GBSystemSelectItemArticleScreenController(context: context));

    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                elevation: 4.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                toolbarHeight: 70,
                backgroundColor: GbsSystemServerStrings.str_primary_color,
                title: Text(
                  GbsSystemStrings.str_app_bar_select_item.tr,
                  style: TextStyle(color: Colors.white),
                ),
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                    )),
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
                        m.filterDataSite(query);
                      },
                    ),
                    SizedBox(
                      height: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),

                    m.text != null && m.text != ''
                        ? m.filtredArticles.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.filtredArticles.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child:
                                          GBSystem_Root_CardViewWidgetGenerique(
                                        tileColor: index % 2 == 0
                                            ? Colors.grey.withOpacity(0.2)
                                            : Colors.white,
                                        onTap: () {
                                          m.selectItemSiteFunction(
                                              selectedArt:
                                                  m.filtredArticles[index]);

                                          // controllerTxtField.text =
                                          //     m.filtredArticles[index].ARTREF_LIB;
                                        },
                                        title:
                                            m.filtredArticles[index].ARTREF_LIB,
                                        optStr1:
                                            m.filtredArticles[index].ARTCAT_LIB,
                                        optStr2: m.filtredArticles[index]
                                            .ARTREF_DUREE_VIE_TYPE,
                                        optStr3: m.filtredArticles[index]
                                            .ARTREF_DUREE_VIE_UNIT,

                                        // article: m.filtredArticles[index],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data.tr,
                              ))
                        : (m.articles.isNotEmpty)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: m.articles.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child:
                                          GBSystem_Root_CardViewWidgetGenerique(
                                        tileColor: index % 2 == 0
                                            ? Colors.grey.withOpacity(0.2)
                                            : Colors.white,
                                        onTap: () {
                                          m.selectItemSiteFunction(
                                              selectedArt: m.articles[index]);
                                          // controllerTxtField.text =
                                          //     m.articles[index].ARTREF_LIB;

                                          // m.sitePlanningController
                                          //     .setCurrentSite = m.habiliter[index];
                                          // Get.back();
                                        },
                                        title: m.articles[index].ARTREF_LIB,
                                        optStr1: m.articles[index].ARTCAT_LIB,
                                        optStr2: m.articles[index]
                                            .ARTREF_DUREE_VIE_TYPE,
                                        optStr3: m.articles[index]
                                            .ARTREF_DUREE_VIE_UNIT,

                                        // article: m.articles[index],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: GBSystem_TextHelper().smallText(
                                text: GbsSystemStrings.str_empty_data.tr,
                              )),
                    // SizedBox(
                    //   height: GBSystem_ScreenHelper.screenHeightPercentage(
                    //       context, 0.02),
                    // ),
                  ],
                ),
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
