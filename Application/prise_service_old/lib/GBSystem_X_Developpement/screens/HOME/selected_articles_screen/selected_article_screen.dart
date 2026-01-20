import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/selected_articles_screen/selected_article_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_GESTION_STOCK_WIDGETS/article_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class SelectedArticleScreen extends StatelessWidget {
  const SelectedArticleScreen({super.key, required this.updateUI});

  final Function updateUI;
  @override
  Widget build(BuildContext context) {
    final SelectedArticleScreenController m =
        Get.put(SelectedArticleScreenController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                  )),
              elevation: 4.0,
              centerTitle: true,
              shadowColor: Colors.grey.withOpacity(0.5),
              toolbarHeight: 70,
              backgroundColor: GbsSystemServerStrings.str_primary_color,
              title: Text(
                GbsSystemStrings.str_article_selectionner,
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: m.articlesController.getSelectedArticle != null
                ? ArticleWidgetTypeTwo(
                    onBtnTap: () async {
                      try {
                        m.isLoading.value = true;
                        await GBSystem_AuthService(context)
                            .affectuerArticle(
                                salarie: m.salarieGestionStockController
                                    .getCurrentSalarie!,
                                site: m
                                    .siteGestionStockController.getCurrentSite!,
                                article:
                                    m.articlesController.getSelectedArticle!)
                            .then(
                          (value) {
                            m.isLoading.value = false;
                            if (value != null) {
                              m.articlesAndDatasetController
                                  .setCurrentArticles = value;
                              showSuccesDialog(context,
                                  GbsSystemStrings.str_operation_effectuer);
                              updateUI();

                              Get.back();
                            } else {
                              // showErrorDialog(context,
                              //     GbsSystemStrings.str_error_send_data);
                            }
                          },
                        );
                      } catch (e) {
                        m.isLoading.value = false;
                        GBSystem_ManageCatchErrors().catchErrors(context,
                            message: e.toString(),
                            method: "affectuerArticle",
                            page: "selected_article_screen");
                      }
                    },
                    textBtn: GbsSystemStrings.str_ajouter,
                    article: m.articlesController.getSelectedArticle!,
                  )
                : EmptyDataWidget(),
          ),
          m.isLoading.value ? Waiting() : Container()
        ],
      ),
    );
  }
}
