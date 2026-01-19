// class MenuData {
//   final String caption;
//   final String id;
//   final String icon;
//   final String type;
//   final String? classColor; // Pour la couleur it-red, it-green, etc.
//   final List<MenuData> child; // Pour les sous-menus

//   MenuData({
//     required this.caption,
//     required this.id,
//     required this.icon,
//     required this.type,
//     this.classColor,
//     this.child = const [],
//   });

//   factory MenuData.fromJson(Map<String, dynamic> json) {
//     var list = json['child'] as List? ?? [];
//     List<MenuData> childList = list.map((i) => MenuData.fromJson(i)).toList();

//     return MenuData(
//       caption: json['caption'] ?? '',
//       id: json['bmsyu_objet'] ?? json['id'] ?? '', // On mappe bmsyu_objet sur id
//       icon: json['icon'] ?? '',
//       type: json['type'] ?? '',
//       classColor: json['classColor'],
//       child: childList,
//     );
//   }
// }