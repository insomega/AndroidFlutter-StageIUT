import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_ref_model.dart';
import 'package:get/get.dart';

class ArticlesAddController extends GetxController {
  List<GbsystemArticleRefModel>? _allArticles;
  Rx<GbsystemArticleRefModel?> _selectedArticle = Rx<GbsystemArticleRefModel?>(null);

  set setSelectedArticle(GbsystemArticleRefModel? article) {
    _selectedArticle.value = article;
    update();
  }

  set setAllArticles(List<GbsystemArticleRefModel>? Articles) {
    _allArticles = Articles;
    update();
  }

  GbsystemArticleRefModel? get getSelectedArticle => _selectedArticle.value;
  Rx<GbsystemArticleRefModel?> get getSelectedArticleObx => _selectedArticle;

  List<GbsystemArticleRefModel>? get getAllArticles => _allArticles;
}
