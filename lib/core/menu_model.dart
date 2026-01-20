// lib/core/menu_model.dart

class MenuModel {
  final String caption;
  final String icon;
  final String id; // Désormais obligatoire comme ID unique
  final String? classColor;
  final List<MenuModel> child;

  MenuModel({
    required this.caption, 
    required this.icon, 
    required this.id, 
    this.classColor, 
    this.child = const []
  });

  // Logique d'extraction : "../../path/page.html" -> "page"
  String get pageId {
    if (id.isEmpty) return 'home_link';
    
    // 1. On prend la partie après le dernier "/" -> "bmserver_svr_planning.html"
    String fileName = id.split('/').last;
    
    // 2. On retire l'extension ".html" -> "bmserver_svr_planning"
    if (fileName.contains('.html')) {
      return fileName.replaceAll('.html', '');
    }
    
    return fileName;
  }

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    var list = json['child'] as List? ?? [];
    return MenuModel(
      caption: json['caption'] ?? '',
      icon: json['icon'] ?? '',
      // On utilise href s'il existe, sinon on peut mettre l'id en secours
      id: json['href'] ?? json['bmsyu_objet'] ?? json['id'] ?? 'home_link',
      classColor: json['classColor'],
      child: list.map((i) => MenuModel.fromJson(i)).toList(),
    );
  }
}