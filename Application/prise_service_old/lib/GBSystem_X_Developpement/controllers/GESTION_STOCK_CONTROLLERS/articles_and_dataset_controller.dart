import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_articles_and_dataset_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_article_salarie_gestion_stock_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_dataset_gestion_stock_model.dart';
import 'package:get/get.dart';

class ArticlesAndDatasetController extends GetxController {
  Rx<ArticleAndDataSetModel?>? _currentArticlesAndDataSet =
      Rx<ArticleAndDataSetModel?>(null);

  set setNewArticle(ArticleSalarieGestionStockModel newArticle) {
    _currentArticlesAndDataSet?.value?.listArticles.add(newArticle);
    update();
  }

  set setCurrentArticlesAndDataSet(ArticleAndDataSetModel? articlesAndDataSet) {
    _currentArticlesAndDataSet?.value = articlesAndDataSet;
    update();
  }

  set setCurrentArticles(
      List<ArticleSalarieGestionStockModel> articlesSalarie) {
    _currentArticlesAndDataSet?.value?.listArticles = articlesSalarie;
    update();
  }

  set setArticleToLeft(ArticleSalarieGestionStockModel newArticle) {
    _currentArticlesAndDataSet?.value?.listArticles.insert(0, newArticle);
    update();
  }

  set setArticleToRight(ArticleSalarieGestionStockModel newArticle) {
    _currentArticlesAndDataSet?.value?.listArticles.insert(
        _currentArticlesAndDataSet?.value?.listArticles.length ?? 0,
        newArticle);
    update();
  }

  set setAllArticles(List<ArticleSalarieGestionStockModel> articles) {
    _currentArticlesAndDataSet?.value?.listArticles = articles;
    update();
  }

  List<ArticleSalarieGestionStockModel>? get getAllArticles =>
      _currentArticlesAndDataSet?.value?.listArticles;

  Rx<List<ArticleSalarieGestionStockModel>?> get getAllArticlesRx =>
      Rx(_currentArticlesAndDataSet?.value?.listArticles);

  ArticleAndDataSetModel? get getCurrentArticlesAndDataSet =>
      _currentArticlesAndDataSet?.value;
  SalarieDataSetGestionStockModel? get getCurrentDataSet =>
      _currentArticlesAndDataSet?.value?.salarieDataSetModel;

  Rx<ArticleAndDataSetModel?>? get getCurrentArticlesAndDataSetRx =>
      _currentArticlesAndDataSet;
}
