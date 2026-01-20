import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_article_gestion_stock_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/articles_non_affectuer_screen/articles_non_affectuer_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_GESTION_STOCK_WIDGETS/article_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class ArticlesNonAffectuerScreen extends StatefulWidget {
  const ArticlesNonAffectuerScreen({super.key});

  @override
  State<ArticlesNonAffectuerScreen> createState() =>
      _ArticlesNonAffectuerScreenState();
}

class _ArticlesNonAffectuerScreenState
    extends State<ArticlesNonAffectuerScreen> {
  List<GbsystemArticleGestionStockModel> items = [];
  final Map<String, bool> _categoryVisibility = {};
  @override
  void initState() {
    items = m.articlesController.getAllArticles ?? [];
    // Initialize visibility for each category (collapsed by default)
    for (var item in items) {
      if (!_categoryVisibility.containsKey(item.ARTCAT_IDF)) {
        _categoryVisibility[item.ARTCAT_LIB] = false; // Initially collapsed
      }
    }
    super.initState();
  }

// Function to toggle the visibility of a category
  void toggleCategory(String category) {
    setState(() {
      // Toggle the category visibility state
      _categoryVisibility[category] = !_categoryVisibility[category]!;
    });
  }

  final ArticlesNonAffectuerScreenController m =
      Get.put(ArticlesNonAffectuerScreenController());

  @override
  Widget build(BuildContext context) {
    // Grouping items by category
    Map<String, List<GbsystemArticleGestionStockModel>> groupedItems = {};
    for (var item in items) {
      if (groupedItems[item.ARTCAT_LIB] == null) {
        groupedItems[item.ARTCAT_LIB] = [];
      }
      groupedItems[item.ARTCAT_LIB]!.add(item);
    }

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              CupertinoIcons.arrow_left,
              color: Colors.white,
            )),
        elevation: 4.0,
        centerTitle: true,
        shadowColor: Colors.grey.withOpacity(0.5),
        toolbarHeight: 70,
        backgroundColor: GbsSystemServerStrings.str_primary_color,
        title: Text(
          GbsSystemStrings.str_article_non_affectuer,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: m.articlesController.getAllArticles != null &&
              m.articlesController.getAllArticles!.isNotEmpty
          ? ListView(
              children: groupedItems.keys.map((category) {
                // Fetching the items for the category
                var categoryItems = groupedItems[category]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(category,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Icon(
                        _categoryVisibility[category] == true
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onTap: () => toggleCategory(category),
                    ),
                    if (_categoryVisibility[category] == true)
                      ...categoryItems.map(
                        (item) => ArticleNonAffectuerWidget(
                            textBtn: GbsSystemStrings.str_affecter,
                            onBtnTap: () async {
                              await GBSystem_AuthService(context)
                                  .affectuerArticleToSalaries(
                                      listSalariesSelectionner: m
                                              .salarieGestionStockController
                                              .getAllSelectedSalaries ??
                                          [],
                                      articleNonAffectuer: item)
                                  .then(
                                (value) {
                                  if (value != null) {
                                    showSuccesDialog(context,
                                        "${GbsSystemStrings.str_article_bien_affectuer}");
                                  }
                                },
                              );
                            },
                            article: item),
                      )
                  ],
                );
              }).toList(),
            )

          // ListView.builder(
          //     itemCount: m.articlesController.getAllArticles?.length,
          //     itemBuilder: (context, index) => ArticleNonAffectuerWidget(
          //         textBtn: GbsSystemStrings.str_affecter,
          //         onBtnTap: () async {
          //           await GBSystem_AuthService(context)
          //               .affectuerArticleToSalaries(
          //                   listSalariesSelectionner: m
          //                           .salarieGestionStockController
          //                           .getAllSelectedSalaries ??
          //                       [],
          //                   articleNonAffectuer:
          //                       m.articlesController.getAllArticles![index])
          //               .then(
          //             (value) {
          //               if (value != null) {
          //                 showSuccesDialog(context,
          //                     "${m.articlesController.getAllArticles![index].ARTCAT_LIB} (${m.articlesController.getAllArticles![index].ARTREF_LIB}) ${GbsSystemStrings.str_article_bien_affectuer}");
          //               }
          //             },
          //           );
          //         },
          //         article: m.articlesController.getAllArticles![index]),
          //   )
          : Center(
              child: EmptyDataWidget(),
            ),
    );
  }
}
