import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_article_salarie_gestion_stock_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_salarie_dataset_gestion_stock_model.dart';

class ArticleAndDataSetModel {
  List<ArticleSalarieGestionStockModel> listArticles;
  SalarieDataSetGestionStockModel salarieDataSetModel;
  ArticleAndDataSetModel(
      {required this.listArticles, required this.salarieDataSetModel});
}
