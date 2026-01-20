import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_article_model.dart';

class GBSystemArticlesController extends GetxController {
  List<GbsystemArticleModel>? _allArticles;
  GbsystemArticleModel? _currentArticle;

  set setArticle(GbsystemArticleModel Article) {
    _allArticles?.add(Article);
    update();
  }

  set setCurrentArticle(GbsystemArticleModel? Article) {
    _currentArticle = Article;
    update();
  }

  set setArticleToLeft(GbsystemArticleModel Article) {
    _allArticles?.insert(0, Article);
    update();
  }

  set setArticleToRight(GbsystemArticleModel Article) {
    _allArticles?.insert(_allArticles!.length, Article);
    update();
  }

  set setAllArticle(List<GbsystemArticleModel>? Articles) {
    _allArticles = Articles;
    update();
  }

  List<GbsystemArticleModel>? get getAllArticles => _allArticles;
  GbsystemArticleModel? get getCurrentArticle => _currentArticle;
}
