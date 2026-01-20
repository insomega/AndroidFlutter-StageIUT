import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

import 'GBSystem_Root_Lookup.dart';
import 'package:gbsystem_root/GBSystem_Root_DataModel.dart';

class GBSystem_Exemple_Serveur_Lookup_Model extends GBSystem_Root_DataModel_Lookup {
  final String svr_idf;
  final String matricule;
  final String nom;
  final String prenom;
  final String departement;
  final String statut;
  final String dateEmbauche;

  GBSystem_Exemple_Serveur_Lookup_Model({required this.svr_idf, required this.matricule, required this.nom, required this.prenom, required this.departement, required this.statut, required this.dateEmbauche});

  @override
  String get code => matricule;

  @override
  String get libelle => '$nom $prenom ($matricule)';

  @override
  String get id => svr_idf;

  @override
  Map<String, dynamic> toJson() => {'id': id, 'matricule': matricule, 'nom': nom, 'prenom': prenom, 'departement': departement, 'statut': statut, 'dateEmbauche': dateEmbauche};
}

class GBSystem_Exemple_Serveur_Lookup_Controller extends GBSystem_Root_Lookup_Controller<GBSystem_Exemple_Serveur_Lookup_Model> {
  @override
  final Widget Function(GBSystem_Exemple_Serveur_Lookup_Model) itemBuilder = _defaultItemBuilder_Exemple_Serveur;

  static Widget _defaultItemBuilder_Exemple_Serveur<T extends GBSystem_Root_DataModel_Lookup>(GBSystem_Exemple_Serveur_Lookup_Model item) {
    return ListTile(
      title: Text(item.libelle),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //
        children: [
          Text('Matricule: ${item.matricule}'), //
          Text('Département: ${item.departement}'),
          Text('Statut: ${item.statut}'),
          Text('Embauche: ${item.dateEmbauche}'),
        ],
      ),
      leading: CircleAvatar(child: Text(item.nom[0])),
    );
  }

  @override
  Future<List<GBSystem_Exemple_Serveur_Lookup_Model>> loadData() async {
    // Implémentation spécifique pour charger les salariés
    // Par exemple:
    // 1. Depuis une API
    // return await SalarieApi.fetchAll();

    // 2. Depuis une base de données locale
    // return await DatabaseHelper.getSalaries();

    // 3. Depuis des données mock (pour les tests)
    return salarieData;
  }

  // void loadSalaries() {
  //   isLoading(true);
  //   items.assignAll(salarieData);
  //   isLoading(false);
  //   applyFilters();
  // }
  @override
  String get labelText => "Agence";
  @override
  Map<String, dynamic Function(GBSystem_Exemple_Serveur_Lookup_Model item)> get availableFilters => {'Département': (item) => item.departement, 'Statut': (item) => item.statut, 'Année embauche': (item) => item.dateEmbauche.substring(0, 4)};
}

/*------------------------------------- */

class GBSystem_Exemple_Serveur_Lookup_TextField extends GBSystem_Root_Lookup_TextField {
  GBSystem_Exemple_Serveur_Lookup_TextField({super.key})
    : //
      super(controller_lookup: Get.put(GBSystem_Exemple_Serveur_Lookup_Controller()));
}

final salarieParams = Root_Lookup_Params<GBSystem_Exemple_Serveur_Lookup_Model>(
  title: 'Recherche de salariés',
  dataLoader: () async => salarieData, // ou appel API
  availableFilters: {'Département': (item) => item.departement, 'Statut': (item) => item.statut},
  //itemBuilder: (salarie) => ListTile(title: Text(salarie.libelle), subtitle: Text('${salarie.departement} - ${salarie.statut}')),
  itemBuilder: (salarie) => ListTile(
    title: Text(salarie.libelle),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start, //
      children: [
        Text('Matricule: ${salarie.matricule}'), //
        Text('Département: ${salarie.departement}'),
        Text('Statut: ${salarie.statut}'),
        Text('Embauche: ${salarie.dateEmbauche}'),
      ],
    ),
    leading: CircleAvatar(child: Text(salarie.nom[0])),
  ),
  hintText: 'Sélectionner une agence',
);

// Données statiques pour les tests
final salarieData = [
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '1', matricule: 'EMP001', nom: 'Dupont', prenom: 'Jean', departement: 'IT', statut: 'CDI', dateEmbauche: '2020-01-15'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '2', matricule: 'EMP002', nom: 'Martin', prenom: 'Sophie', departement: 'RH', statut: 'CDD', dateEmbauche: '2021-05-20'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '3', matricule: 'EMP003', nom: 'Bernard', prenom: 'Pierre', departement: 'IT', statut: 'CDI', dateEmbauche: '2019-11-10'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '4', matricule: 'EMP004', nom: 'Petit', prenom: 'Marie', departement: 'Marketing', statut: 'CDI', dateEmbauche: '2022-02-28'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '5', matricule: 'EMP005', nom: 'Leroy', prenom: 'Thomas', departement: 'IT', statut: 'Stagiaire', dateEmbauche: '2023-03-01'),

  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '01', matricule: 'EMP001', nom: 'Dupont', prenom: 'Jean', departement: 'IT', statut: 'CDI', dateEmbauche: '2020-01-15'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '02', matricule: 'EMP002', nom: 'Martin', prenom: 'Sophie', departement: 'RH', statut: 'CDD', dateEmbauche: '2021-05-20'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '03', matricule: 'EMP003', nom: 'Bernard', prenom: 'Pierre', departement: 'IT', statut: 'CDI', dateEmbauche: '2019-11-10'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '04', matricule: 'EMP004', nom: 'Petit', prenom: 'Marie', departement: 'Marketing', statut: 'CDI', dateEmbauche: '2022-02-28'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '05', matricule: 'EMP005', nom: 'Leroy', prenom: 'Thomas', departement: 'IT', statut: 'Stagiaire', dateEmbauche: '2023-03-01'),

  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '101', matricule: 'EMP001', nom: 'Dupont', prenom: 'Jean', departement: 'IT', statut: 'CDI', dateEmbauche: '2020-01-15'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '102', matricule: 'EMP002', nom: 'Martin', prenom: 'Sophie', departement: 'RH', statut: 'CDD', dateEmbauche: '2021-05-20'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '103', matricule: 'EMP003', nom: 'Bernard', prenom: 'Pierre', departement: 'IT', statut: 'CDI', dateEmbauche: '2019-11-10'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '104', matricule: 'EMP004', nom: 'Petit', prenom: 'Marie', departement: 'Marketing', statut: 'CDI', dateEmbauche: '2022-02-28'),
  GBSystem_Exemple_Serveur_Lookup_Model(svr_idf: '105', matricule: 'EMP005', nom: 'Leroy', prenom: 'Thomas', departement: 'IT', statut: 'Stagiaire', dateEmbauche: '2023-03-01'),
];
