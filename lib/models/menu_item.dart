class MenuItem {
  final String caption;
  final String id;
  final String icon;
  final String type; // 'font' ou 'asset'

  MenuItem({
    required this.caption,
    required this.id,
    required this.icon,
    required this.type,
  });

  // Transforme le JSON en objet Dart
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      caption: json['caption'] ?? '',
      id: json['id'] ?? '',
      icon: json['icon'] ?? '',
      type: json['type'] ?? 'font',
    );
  }
}