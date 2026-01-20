class GBSystem_MenuItem {
  final String id;
  final String title;
  final String icon;
  final String route;
  final List<String> requiredPermissions;
  final bool isActive;
  final List<GBSystem_MenuItem>? subItems; // Sous-items pour le niveau 2
  final bool isExpandable; // Si l'item peut être développé

  GBSystem_MenuItem({required this.id, required this.title, required this.icon, required this.route, this.requiredPermissions = const [], this.isActive = true, this.subItems, this.isExpandable = false});

  factory GBSystem_MenuItem.fromJson(Map<String, dynamic> json) {
    return GBSystem_MenuItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      route: json['route'] ?? '',
      requiredPermissions: List<String>.from(json['requiredPermissions'] ?? []),
      isActive: json['isActive'] ?? true,
      subItems: json['subItems'] != null ? (json['subItems'] as List).map((item) => GBSystem_MenuItem.fromJson(item)).toList() : null,
      isExpandable: json['isExpandable'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'icon': icon, 'route': route, 'requiredPermissions': requiredPermissions, 'isActive': isActive, 'subItems': subItems?.map((item) => item.toJson()).toList(), 'isExpandable': isExpandable};

  bool get hasSubItems => subItems != null && subItems!.isNotEmpty;
}

class GBSystem_MenuConfig {
  final List<GBSystem_MenuItem> items;
  final String version;
  final DateTime lastUpdated;

  GBSystem_MenuConfig({required this.items, required this.version, required this.lastUpdated});

  factory GBSystem_MenuConfig.fromJson(Map<String, dynamic> json) {
    return GBSystem_MenuConfig(items: (json['items'] as List).map((item) => GBSystem_MenuItem.fromJson(item)).toList(), version: json['version'] ?? '1.0.0', lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()));
  }

  Map<String, dynamic> toJson() => {'items': items.map((item) => item.toJson()).toList(), 'version': version, 'lastUpdated': lastUpdated.toIso8601String()};
}
