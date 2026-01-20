import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_gestion_stock_model.dart';
import 'package:get/get.dart';

class ArticlesController extends GetxController {
  List<GbsystemArticleGestionStockModel>? _allArticles;
  Rx<GbsystemArticleGestionStockModel?> _selectedArticle = Rx<GbsystemArticleGestionStockModel?>(null);

  set setSelectedArticle(GbsystemArticleGestionStockModel? article) {
    _selectedArticle.value = article;
    update();
  }

  set setAllArticles(List<GbsystemArticleGestionStockModel>? Articles) {
    _allArticles = Articles;
    update();
  }

  GbsystemArticleGestionStockModel? get getSelectedArticle => _selectedArticle.value;

  List<GbsystemArticleGestionStockModel>? get getAllArticles => _allArticles;
}
