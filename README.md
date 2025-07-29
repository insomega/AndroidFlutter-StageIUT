# Prise de Services Automatique (Web & Mobile)

---

## 🚀 Vue d'ensemble

"Prise de Services Automatique" est une application Flutter conçue pour simplifier la gestion des plannings de services, notamment pour les employés. Elle permet l'importation, la visualisation, la modification et l'exportation de données de services via des fichiers Excel. Que vous soyez sur le web ou un appareil mobile, l'application s'adapte pour vous offrir une expérience fluide et réactive.

## ✨ Utilité de l'Application

Cette application a pour objectif principal de faciliter la gestion quotidienne des services en offrant les fonctionnalités clés suivantes :

* **Importation Facile :** Chargez vos plannings existants depuis des fichiers Excel (.xlsx) en quelques clics.
* **Visualisation Claire :** Affichez les services organisés en colonnes "Début", "Fin" et "Résultat", avec la possibilité de filtrer par nom d'employé et de naviguer par date.
* **Modification Intuitive :** Ajustez les horaires, marquez les employés comme absents ou validez les services directement depuis l'interface.
* **Exportation Pratique :** Sauvegardez vos données modifiées ou mises à jour dans un nouveau fichier Excel, prêt à être partagé ou archivé.
* **Responsive Design :** L'interface s'adapte automatiquement à la taille de l'écran, offrant une expérience optimisée sur les navigateurs web et les appareils mobiles.

---

## 🛠️ Fonctionnalités Clés

* **Gestion des Dates :**
    * Sélectionnez une plage de dates de début et de fin.
    * Naviguez rapidement entre les mois et les jours.
* **Recherche d'Employés :**
    * Champ de recherche intégré pour filtrer les services par nom d'employé.
* **Affichage des Services en Colonnes :**
    * **Début :** Affiche l'heure de début planifiée du service.
    * **Fin :** Affiche l'heure de fin planifiée du service.
    * **Résultat :** Affiche la durée calculée du service.
    * **Visibilité des Colonnes :** Basculez l'affichage des colonnes "Début", "Fin" et "Résultat" via des boutons dédiés (D, F, R).
* **Cartes de Détail de Service (`TimeDetailCard`) :**
    * Affiche les informations essentielles pour chaque service (nom de l'employé, heure, statut).
    * Permet de modifier l'heure, marquer comme absent/présent, et valider le service.
    * Synchronisation du défilement entre les colonnes pour une meilleure lisibilité.
* **Importation/Exportation Excel :**
    * Bouton "Importer services" / "Changer fichier" pour charger un nouveau planning.
    * Bouton "Exporter services" pour sauvegarder le planning actuel avec les modifications.
* **Adaptabilité (Responsive) :**
    * L'application utilise des utilitaires de réactivité (`responsive_utils_web.dart`) pour ajuster dynamiquement la taille des éléments (padding, polices, icônes, hauteurs, largeurs) en fonction de la largeur de l'écran. Cela garantit une ergonomie optimale sur toutes les tailles d'écrans web et mobiles.

---

## ⚙️ Comment Ça Marche (Vue Développeur)

L'application est développée en **Flutter**, garantissant une base de code unique pour les déploiements web et mobiles.

### Architecture Principale

* **`lib/prise_service_web.dart`** : Le fichier principal de l'interface utilisateur qui orchestre les différentes sections (AppBar, sélecteurs de date, barre de recherche, colonnes de services et pied de page). C'est le cœur de la logique de présentation.
* **`lib/time_detail_card.dart`** : Widget réutilisable qui représente une seule carte de service avec ses options de modification et d'affichage.
* **`lib/models/service.dart`** : Définit le modèle de données `Service` utilisé pour structurer les informations de chaque service.
* **`lib/utils/responsive_utils_web.dart`** : Un utilitaire crucial pour l'adaptabilité de l'interface. Il contient des fonctions qui calculent des tailles (padding, font size, icon size, width, height) proportionnellement à la largeur de l'écran, en se basant sur une largeur de référence (`_baseWebWidth`). Ceci est essentiel pour que l'interface soit agréable à utiliser sur des écrans de toutes tailles.
* **Importation/Exportation Excel :** L'application utilise la bibliothèque `file_picker` pour la sélection de fichiers et la bibliothèque `excel` pour la lecture et l'écriture des données dans des fichiers `.xlsx`.

### Synchronisation des Colonnes

Les trois colonnes de services (Début, Fin, Résultat) utilisent des `ScrollController` partagés ou synchronisés. Lorsqu'un utilisateur défile dans une colonne, la position de défilement est répercutée sur les autres colonnes pour maintenir les services alignés horizontalement, améliorant ainsi l'expérience utilisateur.

---

## 🚀 Démarrer l'Application

Pour lancer cette application sur votre machine :

1.  **Prérequis :**
    * **Flutter SDK** installé ([Guide d'installation](https://flutter.dev/docs/get-started/install)).
    * **VS Code** avec l'extension **Flutter** et **Dart** installée.


2.  **Installer les dépendances :**
    Exécutez cette commande dans le répertoire racine du projet :
    ```bash
    flutter pub get
    ```

### Utilisation avec VS Code

1.  **Ouvrir le Projet dans VS Code :**
    * Lancez **VS Code**.
    * Allez dans `File > Open Folder...` et sélectionnez le dossier `mon_projet` que vous venez de cloner.

2.  **Sélectionner un Appareil/Navigateur :**
    * Dans la **barre d'état** de VS Code (en bas à droite), cliquez sur le nom de l'appareil actuellement sélectionné (ex: "Chrome", "Windows", "No Device").
    * Une liste des appareils disponibles (émulateurs, navigateurs web, appareils physiques) apparaîtra en haut. Sélectionnez celui sur lequel vous souhaitez exécuter l'application (par exemple, un émulateur Android, ou `Chrome` pour le web).

3.  **Lancer l'Application :**
    * Appuyez sur **`F5`** pour démarrer le débogage (ce qui lancera l'application).
    * Vous pouvez aussi aller dans `Run > Start Debugging`.
    * Alternativement, cliquez sur l'icône **"Run and Debug"** dans la barre latérale gauche de VS Code, puis cliquez sur le bouton **"Run"** (triangle vert).

---

## 👨‍💻 Contribution

Ce projet est maintenu par BMSoft. Pour toute question ou suggestion, veuillez contacter l'équipe de développement.

---

**© BMSoft 2025, tous droits réservés.**