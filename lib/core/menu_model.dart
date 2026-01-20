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
    
    // 1. On récupère le nom du fichier (ex: home_QA.png)
    String fileName = id.split('/').last;
    
    // 2. On supprime l'extension finale (tout ce qui suit le dernier point)
    // Résultat : "home_QA.png" -> "home_QA" | "page.html" -> "page"
    return fileName.contains('.') 
        ? fileName.substring(0, fileName.lastIndexOf('.')) 
        : fileName;
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