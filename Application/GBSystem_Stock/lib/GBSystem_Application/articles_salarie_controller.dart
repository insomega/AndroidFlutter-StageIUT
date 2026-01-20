import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_salarie_gestion_stock_model.dart';
import 'package:get/get.dart';

class ArticlesSalarieController extends GetxController {
  List<ArticleSalarieGestionStockModel>? _allArticles;
  Rx<ArticleSalarieGestionStockModel?> _selectedArticle = Rx<ArticleSalarieGestionStockModel?>(null);

  set setSelectedArticle(ArticleSalarieGestionStockModel? article) {
    _selectedArticle.value = article;
    update();
  }

  set setAllArticles(List<ArticleSalarieGestionStockModel>? Articles) {
    _allArticles = Articles;
    update();
  }

  ArticleSalarieGestionStockModel? get getSelectedArticle => _selectedArticle.value;

  List<ArticleSalarieGestionStockModel>? get getAllArticles => _allArticles;
}
