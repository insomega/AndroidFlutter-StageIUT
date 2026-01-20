import 'package:flutter/material.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_ref_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/articles_add_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/qr_code_screen.dart';

import 'package:get/get.dart';

class GBSystemSelectItemArticleScreenController extends GetxController {
  GBSystemSelectItemArticleScreenController({required this.context});
  BuildContext context;

  RxBool isLoading = RxBool(false);
  RxList<GbsystemArticleRefModel> articles = RxList<GbsystemArticleRefModel>([]);
  RxList<GbsystemArticleRefModel> filtredArticles = RxList<GbsystemArticleRefModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final ArticlesAddController articlesController = Get.put(ArticlesAddController());

  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    articles.value = articlesController.getAllArticles ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredArticles.value = articles.where((art) {
      return art.ARTREF_LIB.toString().toLowerCase().contains(query.toLowerCase()) || art.ARTCAT_LIB.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void selectItemSiteFunction({required GbsystemArticleRefModel selectedArt}) async {
    articlesController.setSelectedArticle = selectedArt;
    Get.to(QrCodeScreen(articleRefModel: selectedArt));

    // Get.back();
  }
}
