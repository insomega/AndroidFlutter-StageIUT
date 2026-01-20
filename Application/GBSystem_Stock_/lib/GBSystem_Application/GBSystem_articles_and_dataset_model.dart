import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_salarie_gestion_stock_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_dataset_gestion_stock_model.dart';

class ArticleAndDataSetModel {
  List<ArticleSalarieGestionStockModel> listArticles;
  SalarieDataSetGestionStockModel salarieDataSetModel;
  ArticleAndDataSetModel({required this.listArticles, required this.salarieDataSetModel});
}
