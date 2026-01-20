// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// abstract class LookupModel {
//   String get id;
//   String get code;
//   String get libelle;

//   @override
//   bool operator ==(Object other) => identical(this, other) || other is LookupModel && runtimeType == other.runtimeType && id == other.id;

//   @override
//   int get hashCode => id.hashCode;

//   Map<String, dynamic> toJson();
// }

// // models/salarie_model.dart
// class SalarieModel extends LookupModel {
//   final String id;
//   final String matricule;
//   final String nom;
//   final String prenom;
//   final String departement;
//   final String statut;
//   final DateTime dateEmbauche;

//   SalarieModel({
//     required this.id, //
//     required this.matricule,
//     required this.nom,
//     required this.prenom,
//     required this.departement,
//     required this.statut,
//     required this.dateEmbauche,
//   });

//   @override
//   String get code => matricule;

//   @override
//   String get libelle => '$nom $prenom';

//   @override
//   Map<String, dynamic> toJson() => {'id': id, 'matricule': matricule, 'nom': nom, 'prenom': prenom};
// }

// class SalarieLookup extends StatelessWidget {
//   const SalarieLookup({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SalarieLookupController());

//     return GenericLookup<SalarieModel>(
//       title: 'Recherche de salarié',
//       controller: controller,
//       itemBuilder: (salarie) => ListTile(
//         title: Text(salarie.libelle),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start, //
//           children: [
//             Text('Matricule: ${salarie.matricule}'), //
//             Text('Département: ${salarie.departement}'),
//             Text('Statut: ${salarie.statut}'),
//           ],
//         ),
//         leading: CircleAvatar(child: Text(salarie.nom[0])),
//       ),
//       filterPanel: _buildCustomFilterPanel(controller),
//     );
//   }

//   Widget _buildCustomFilterPanel(SalarieLookupController controller) {
//     return Obx(() {
//       final departements = controller.items.map((e) => e.departement).toSet().toList();

//       final statuts = controller.items.map((e) => e.statut).toSet().toList();

//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Column(
//           children: [
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(labelText: 'Département'),
//               items: departements.map((dept) {
//                 return DropdownMenuItem(value: dept, child: Text(dept));
//               }).toList(),
//               onChanged: (value) => controller.setFilter('Département', value),
//             ),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(labelText: 'Statut'),
//               items: statuts.map((statut) {
//                 return DropdownMenuItem(value: statut, child: Text(statut));
//               }).toList(),
//               onChanged: (value) => controller.setFilter('Statut', value),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }


// class SalarieLookupController extends GenericLookupController<SalarieModel> {
//   final SalarieRepository _repository = Get.find();

//   @override
//   Future<void> fetchItems() async {
//     try {
//       isLoading(true);
//       final result = await _repository.getAllSalaries();
//       items.assignAll(result);
//     } finally {
//       isLoading(false);
//     }
//   }

//   @override
//   List<String> get availableFilters => ['Département', 'Statut', 'Date embauche'];

//   @override
//   String getFilterValue(SalarieModel item, String filterKey) {
//     switch (filterKey) {
//       case 'Département':
//         return item.departement;
//       case 'Statut':
//         return item.statut;
//       case 'Date embauche':
//         return item.dateEmbauche.year.toString();
//       default:
//         return '';
//     }
//   }
// }


// /*----------------------------------------------------------------------------- */
// /*----------------------------------------------------------------------------- */
// /*----------------------------------------------------------------------------- */
// /*----------------------------------------------------------------------------- */



// class GenericLookup<T extends LookupModel> extends StatelessWidget {
//   final String title;
//   final GenericLookupController<T> controller;
//   final Widget Function(T) itemBuilder;
//   final Widget? filterPanel;

//   const GenericLookup({Key? key, required this.title, required this.controller, required this.itemBuilder, this.filterPanel}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         actions: [
//           IconButton(
//             icon: Obx(() => Badge(showBadge: controller.activeFilters.isNotEmpty, child: Icon(Icons.filter_alt))),
//             onPressed: () => _showFilterDialog(context),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Barre de recherche principale
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Rechercher',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//                 suffixIcon: Obx(
//                   () => controller.searchQuery.isNotEmpty
//                       ? IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                             controller.searchQuery.value = '';
//                             controller.applyFilters();
//                           },
//                         )
//                       : null,
//                 ),
//               ),
//               onChanged: controller.onSearchChanged,
//             ),
//           ),

//           // Panneau de filtres optionnel
//           if (filterPanel != null) filterPanel!,

//           // Affichage des filtres actifs
//           Obx(() => controller.activeFilters.isNotEmpty ? _buildActiveFiltersChips() : SizedBox.shrink()),

//           // Liste des résultats
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return controller.filteredItems.isEmpty
//                   ? Center(child: Text('Aucun résultat trouvé'))
//                   : ListView.builder(
//                       itemCount: controller.filteredItems.length,
//                       itemBuilder: (context, index) {
//                         final item = controller.filteredItems[index];
//                         return InkWell(onTap: () => controller.selectItem(item), child: itemBuilder(item));
//                       },
//                     );
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActiveFiltersChips() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Wrap(
//         spacing: 4.0,
//         children: controller.activeFilters.entries.map((entry) {
//           return Chip(label: Text('${entry.key}: ${entry.value}'), onDeleted: () => controller.setFilter(entry.key, null));
//         }).toList(),
//       ),
//     );
//   }

//   void _showFilterDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Filtres'),
//         content: _buildFilterOptions(),
//         actions: [
//           TextButton(
//             onPressed: () {
//               controller.activeFilters.clear();
//               controller.applyFilters();
//               Get.back();
//             },
//             child: Text('Réinitialiser'),
//           ),
//           TextButton(onPressed: () => Get.back(), child: Text('Appliquer')),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterOptions() {
//     return Obx(() {
//       final availableFilters = controller.availableFilters;
//       return SizedBox(
//         width: double.maxFinite,
//         child: ListView(
//           shrinkWrap: true,
//           children: availableFilters.map((filterKey) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(filterKey, style: TextStyle(fontWeight: FontWeight.bold)),
//                 _buildFilterWidgetForType(filterKey),
//                 SizedBox(height: 16),
//               ],
//             );
//           }).toList(),
//         ),
//       );
//     });
//   }

//   Widget _buildFilterWidgetForType(String filterKey) {
//     // Cette méthode devrait être surchargée dans les widgets spécifiques
//     // Voici une implémentation générique simple
//     return TextField(
//       decoration: InputDecoration(hintText: 'Filtrer par $filterKey', border: OutlineInputBorder()),
//       onChanged: (value) => controller.setFilter(filterKey, value.isEmpty ? null : value),
//     );
//   }
// }

// abstract class GenericLookupController<T extends LookupModel> extends GetxController {
//   final RxList<T> items = <T>[].obs;
//   final RxList<T> filteredItems = <T>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString searchQuery = ''.obs;
//   final Rxn<T> selectedItem = Rxn<T>();
//   final RxMap<String, dynamic> activeFilters = <String, dynamic>{}.obs;

//   // Méthode à implémenter par les classes filles
//   Future<void> fetchItems();
//   List<String> get availableFilters;
//   String getFilterValue(T item, String filterKey);

//   void onSearchChanged(String query) {
//     searchQuery.value = query;
//     applyFilters();
//   }

//   void setFilter(String key, dynamic value) {
//     if (value == null) {
//       activeFilters.remove(key);
//     } else {
//       activeFilters[key] = value;
//     }
//     applyFilters();
//   }

//   void applyFilters() {
//     if (isLoading.value) return;

//     filteredItems.assignAll(
//       items.where((item) {
//         // Filtre par recherche texte
//         final matchesSearch = searchQuery.value.isEmpty || item.libelle.toLowerCase().contains(searchQuery.value.toLowerCase()) || item.code.toLowerCase().contains(searchQuery.value.toLowerCase());

//         // Filtres supplémentaires
//         bool matchesAllFilters = true;
//         activeFilters.forEach((key, value) {
//           if (value != null) {
//             final itemValue = getFilterValue(item, key);
//             if (value is List) {
//               matchesAllFilters = matchesAllFilters && value.contains(itemValue);
//             } else {
//               matchesAllFilters = matchesAllFilters && (itemValue == value);
//             }
//           }
//         });

//         return matchesSearch && matchesAllFilters;
//       }),
//     );
//   }

//   @override
//   void onReady() {
//     super.onReady();
//     ever(items, (_) => applyFilters());
//   }

//   void selectItem(T item) {
//     selectedItem.value = item;
//     Get.back(result: item);
//   }
// }

// class MyFormView extends StatelessWidget {
//   final Rx<SalarieModel?> selectedSalarie = Rx<SalarieModel?>(null);
//   final Rx<ClientModel?> selectedClient = Rx<ClientModel?>(null);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Formulaire')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Champ Salarié
//             Obx(
//               () => LookupField(
//                 label: 'Salarié',
//                 value: selectedSalarie.value?.libelle,
//                 onTap: () async {
//                   final result = await Get.to(() => SalarieLookup());
//                   if (result != null) {
//                     selectedSalarie.value = result;
//                   }
//                 },
//               ),
//             ),

//             // Champ Client
//             Obx(
//               () => LookupField(
//                 label: 'Client',
//                 value: selectedClient.value?.libelle,
//                 onTap: () async {
//                   final result = await Get.to(() => ClientLookup());
//                   if (result != null) {
//                     selectedClient.value = result;
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Widget réutilisable pour afficher le champ de lookup
// class LookupField extends StatelessWidget {
//   final String label;
//   final String? value;
//   final VoidCallback onTap;

//   const LookupField({Key? key, required this.label, required this.value, required this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: InputDecorator(
//         decoration: InputDecoration(labelText: label, border: OutlineInputBorder(), suffixIcon: Icon(Icons.search)),
//         child: Text(value ?? 'Sélectionner...'),
//       ),
//     );
//   }
// }

// class MyFormView extends StatelessWidget {
//   final Rx<SalarieModel?> selectedSalarie = Rx<SalarieModel?>(null);
//   final Rx<ClientModel?> selectedClient = Rx<ClientModel?>(null);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Formulaire')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Champ Salarié
//             Obx(
//               () => LookupField(
//                 label: 'Salarié',
//                 value: selectedSalarie.value?.libelle,
//                 onTap: () async {
//                   final result = await Get.to(() => SalarieLookup());
//                   if (result != null) {
//                     selectedSalarie.value = result;
//                   }
//                 },
//               ),
//             ),

//             // Champ Client
//             Obx(
//               () => LookupField(
//                 label: 'Client',
//                 value: selectedClient.value?.libelle,
//                 onTap: () async {
//                   final result = await Get.to(() => ClientLookup());
//                   if (result != null) {
//                     selectedClient.value = result;
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Widget réutilisable pour afficher le champ de lookup
// class LookupField extends StatelessWidget {
//   final String label;
//   final String? value;
//   final VoidCallback onTap;

//   const LookupField({Key? key, required this.label, required this.value, required this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: InputDecorator(
//         decoration: InputDecoration(labelText: label, border: OutlineInputBorder(), suffixIcon: Icon(Icons.search)),
//         child: Text(value ?? 'Sélectionner...'),
//       ),
//     );
//   }
// }

// // widgets/client_lookup.dart
// class ClientLookup extends StatelessWidget {
//   const ClientLookup({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ClientLookupController());

//     return GenericLookup<ClientModel>(
//       title: 'Recherche de client',
//       controller: controller,
//       itemBuilder: (client) => ListTile(title: Text(client.raisonSociale), subtitle: Text(client.codeClient), leading: Icon(Icons.business)),
//     );
//   }
// }

// class GenericLookup<T extends LookupModel> extends StatelessWidget {
//   final String title;
//   final GenericLookupController<T> controller;
//   final Widget Function(T) itemBuilder;

//   const GenericLookup({Key? key, required this.title, required this.controller, required this.itemBuilder}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(labelText: 'Rechercher', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
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
//                   return InkWell(onTap: () => controller.selectItem(item), child: itemBuilder(item));
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // controllers/salarie_lookup_controller.dart
// class SalarieLookupController extends GenericLookupController<SalarieModel> {
//   final SalarieRepository _repository = Get.find();

//   @override
//   Future<void> fetchItems() async {
//     try {
//       isLoading(true);
//       final result = await _repository.searchSalaries(searchQuery.value);
//       items.assignAll(result);
//     } finally {
//       isLoading(false);
//     }
//   }
// }

// // controllers/client_lookup_controller.dart
// class ClientLookupController extends GenericLookupController<ClientModel> {
//   final ClientRepository _repository = Get.find();

//   @override
//   Future<void> fetchItems() async {
//     try {
//       isLoading(true);
//       final result = await _repository.searchClients(searchQuery.value);
//       items.assignAll(result);
//     } finally {
//       isLoading(false);
//     }
//   }
// }

// abstract class GenericLookupController<T extends LookupModel> extends GetxController {
//   final RxList<T> items = <T>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString searchQuery = ''.obs;
//   final Rxn<T> selectedItem = Rxn<T>();

//   Future<void> fetchItems();

//   void onSearchChanged(String query) {
//     searchQuery.value = query;
//     fetchItems();
//   }

//   void selectItem(T item) {
//     selectedItem.value = item;
//     Get.back(result: item);
//   }
// }

// // models/client_model.dart
// class ClientModel extends LookupModel {
//   final String id;
//   final String codeClient;
//   final String raisonSociale;

//   ClientModel({required this.id, required this.codeClient, required this.raisonSociale});

//   @override
//   String get code => codeClient;

//   @override
//   String get libelle => raisonSociale;

//   @override
//   Map<String, dynamic> toJson() => {'id': id, 'codeClient': codeClient, 'raisonSociale': raisonSociale};
// }
