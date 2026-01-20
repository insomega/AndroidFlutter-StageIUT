class GBSystem_MenuItemModel {
  final String id;
  final String title;
  final String icon;
  final String? route;
  final bool visible;
  final List<GBSystem_MenuItemModel> children;

  GBSystem_MenuItemModel({required this.id, required this.title, required this.icon, this.route, this.visible = true, this.children = const []});

  factory GBSystem_MenuItemModel.fromJson(Map<String, dynamic> json) {
    return GBSystem_MenuItemModel(id: json['id'], title: json['title'], icon: json['icon'], route: json['route'], visible: json['visible'] ?? true, children: (json['children'] as List? ?? []).map((child) => GBSystem_MenuItemModel.fromJson(child)).toList());
  }
}
