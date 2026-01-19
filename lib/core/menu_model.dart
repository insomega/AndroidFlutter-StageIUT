// lib/core/menu_model.dart

class MenuModel {
  final String caption;
  final String id;
  final String icon;
  final String type;
  final String? classColor;
  final List<MenuModel> child;

  MenuModel({
    required this.caption,
    required this.id,
    required this.icon,
    required this.type,
    this.classColor,
    this.child = const [],
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    var list = json['child'] as List? ?? [];
    return MenuModel(
      caption: json['caption'] ?? '',
      id: json['bmsyu_objet'] ?? json['id'] ?? '',
      icon: json['icon'] ?? '',
      type: json['type'] ?? '',
      classColor: json['classColor'],
      child: list.map((i) => MenuModel.fromJson(i)).toList(),
    );
  }
}