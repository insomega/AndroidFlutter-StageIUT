// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:gbsystem_root/GBSystem_Root_DataModel.dart';


// class GBSystem_Root_View_Lookup<T extends GBSystem_Root_DataModel_Lookup> extends StatelessWidget {
//   final String title;
//   final GenericLookupController<T> controller;
//   final Widget Function(T) itemBuilder;

//   const GenericLookup({
//     Key? key,
//     required this.title,
//     required this.controller,
//     required this.itemBuilder,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Rechercher',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: controller.onSearchChanged,
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return ListView.builder(
//                 itemCount: controller.items.length,
//                 itemBuilder: (context, index) {
//                   final item = controller.items[index];
//                   return InkWell(
//                     onTap: () => controller.selectItem(item),
//                     child: itemBuilder(item),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class GBSystem_LookupView<T extends GBSystem_LookupItem, C extends GBSystem_LookupController<T>> extends StatelessWidget {
// //   final String title;

// //   const GBSystem_LookupView({super.key, required this.title});

// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = Get.put<C>(Get.find<C>());

// //     controller.loadData();

// //     return Scaffold(
// //       appBar: AppBar(title: Text(title)),
// //       body: Obx(() {
// //         if (controller.isLoading.value) {
// //           return const Center(child: CircularProgressIndicator());
// //         }
// //         return ListView.builder(
// //           itemCount: controller.items.length,
// //           itemBuilder: (_, index) {
// //             final item = controller.items[index];
// //             return ListTile(title: Text(item.label), subtitle: Text(item.code), onTap: () => controller.selectItem(item));
// //           },
// //         );
// //       }),
// //     );
// //   }
// }

// // 5️⃣ Vue spécifique
// // salarie_lookup_view.dart

// // dart
// // Copier
// // Modifier
// // import 'package:flutter/material.dart';
// // import '../controllers/salarie_lookup_controller.dart';
// // import '../models/salarie_item.dart';
// // import 'lookup_view.dart';

// // class SalarieLookupView extends LookupView<SalarieItem, SalarieLookupController> {
// //   const SalarieLookupView({super.key}) : super(title: 'Choisir un salarié');
// // }








// // 6️⃣ Utilisation dans ta View principale
// // dart
// // Copier
// // Modifier
// // ElevatedButton(
// //   onPressed: () async {
// //     final result = await Get.to(() => const SalarieLookupView());
// //     if (result != null) {
// //       print('ID: ${result.id}, Code: ${result.code}, Libellé: ${result.label}');
// //     }
// //   },
// //   child: Text('Sélectionner un salarié'),
// // )