import 'package:get/get.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemTranslationStrings extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "fr": {
          /// pas encore fait traduction
          GbsSystemStrings.str_fermer: "fermer",
          GbsSystemStrings.str_session_experer_sso: "Session expirée",

          ///
          GbsSystemStrings.str_operation_effectuer: "Opération effectuée",
          GbsSystemStrings.str_operation_non_autoriser:
              "opération non autorisée",
          GbsSystemStrings.str_partager: "Partager",

          GbsSystemStrings.str_actions_offline:
              "Données en attente de synchronisation",
          GbsSystemStrings.str_question_actions_offline:
              "Souhaitez-vous synchroniser vos données non enregistrées avec le serveur ?",
          GbsSystemStrings.str_non: "non",
          GbsSystemStrings.str_oui: "oui",

          GbsSystemStrings.str_code_entreprise: "Code Entreprise",
          GbsSystemStrings.str_are_you_sure_want_change_entreprise:
              "étez-vous sur de bien vouloir changer l'agence ?",
          GbsSystemStrings.str_validat_svp_code_entreprise_invalid:
              "le code entreprise est invalide",
          GbsSystemStrings.str_validat_svp_enter_code_client:
              "le code de l'entreprise est obligatoire",
          GbsSystemStrings.str_new_version_available:
              'Nouvelle version disponible!',
          GbsSystemStrings.str_new_version_desc:
              //"Nouveau version de l'application disponible , s'il vous plait mettre à jour pour profitez de nouvelles fonctions.",
              "Une nouvelle version de l’application est disponible. Afin de profiter des toutes dernières nouveautés, veuillez mettre à jour l’application en cliquant sur « Mettre à jour ».",
          GbsSystemStrings.str_try_later: 'Essayer plus tard',
          GbsSystemStrings.str_update_now: 'Mettre à jour',

          GbsSystemStrings.str_device_dont_support_biometrics:
              "Votre appareil ne prend pas en charge les biométries.",
          GbsSystemStrings.str_auth_please_authentificate:
              "Veuillez vous authentifier",

          GbsSystemStrings.str_auth_please_authentificate_to_proceed:
              "Veuillez vous authentifier pour continuer",

          GbsSystemStrings.str_auth_auth_success: "Authentification réussie",

          GbsSystemStrings.str_auth_auth_failed: "Échec de l'authentification",

          GbsSystemStrings.str_auth_biometric_auth:
              "Authentification biométrique",

          GbsSystemStrings.str_auth_auth_with_biometrics:
              "S'authentifier avec les biométries",

          GbsSystemStrings.str_auth_biometrics_not_available:
              "L'authentification biométrique n'est pas disponible.",

          GbsSystemStrings.str_auth_start_auth: "Démarrer l'authentification",

          GbsSystemStrings.str_proposition_s: "Proposition(s)",

          GbsSystemStrings.str_nfc: "NFC",
          GbsSystemStrings.str_taille: "Taille",
          GbsSystemStrings.str_qte: "Quantité",

          GbsSystemStrings.str_loading_map: "chargement de la map",

          GbsSystemStrings.str_rendre: "à rendre",
          GbsSystemStrings.str_pas_rendre: "n'est pas à rendre",

          GbsSystemStrings.str_demander_refuser: "Demander/Refuser",
          GbsSystemStrings.str_proposition: "proposition",
          GbsSystemStrings.str_indisponibiliter_ponctuelle:
              "Indisponibilités ponctuelle",
          GbsSystemStrings.str_action_non_autoriser: "Action non-autorisé",
          GbsSystemStrings.str_code_pin_wrong: "le code PIN est incorrect",
          GbsSystemStrings.str_nouvelle_connexion: "Nouvelle connexion",
          GbsSystemStrings.str_code_pin_oublier: "Code PIN oublié ?",
          GbsSystemStrings.str_enregistrer: "Enregistrer",
          GbsSystemStrings.str_enregistrement: "Enregistrement",
          GbsSystemStrings.str_enrigester_nv_code_pin:
              "Enregistrer un nouveau code PIN pour continuer",
          GbsSystemStrings.str_entrer_code_pin_deja_enrigester:
              "Entrer le code PIN qui est déja enregistré pour continuer",
          GbsSystemStrings.str_verification: "Vérification",
          GbsSystemStrings.str_code_pin: "Code PIN",
          GbsSystemStrings.str_map: "Map",
          GbsSystemStrings.str_pointage_en_cours: "pointage en cours ...",
          GbsSystemStrings.str_operation_en_cours: "opération en cours ...",

          ////

          GbsSystemStrings.str_details_vacation: "Détail de la vacation",
          GbsSystemStrings.str_Select_Time: "Veuillez sélectionner l'heure",
          GbsSystemStrings.str_hour: "heure",
          GbsSystemStrings.str_minute: "minute",
          GbsSystemStrings.str_timePickerInputHint: "Please enter time",
          GbsSystemStrings.str_selectDate: "Veuillez sélectionner la date",
          GbsSystemStrings.str_cancel: "Annuler",
          GbsSystemStrings.str_done: "Terminé",
          GbsSystemStrings.str_prevMonth: "Mois précédent",
          GbsSystemStrings.str_nextMonth: "Mois suivant",
          GbsSystemStrings.str_prevYear: "Année précédente",
          GbsSystemStrings.str_nextYear: "Année suivante",
          GbsSystemStrings.str_datePickerInputHint: "Veuillez entrer la date",
          GbsSystemStrings.str_datePickerHelpText:
              "Veuillez sélectionner la date",
          GbsSystemStrings.str_monday: "Lundi",
          GbsSystemStrings.str_tuesday: "Mardi",
          GbsSystemStrings.str_droits_reserved_part_2: "Tous droits réservés",
          GbsSystemStrings.str_connexion: "Connexion",
          GbsSystemStrings.str_ignorer: "Ignorer",
          GbsSystemStrings.str_waiting_for_tag: "En attente de la balise NFC",
          GbsSystemStrings.str_nfc_disabled:
              "L'autorisation de balise NFC est désactivée, veuillez activer l'autorisation NFC et réessayer",
          GbsSystemStrings.str_please_turn_on_nfc_service:
              "Veuillez activer le service NFC sur votre appareil",
          GbsSystemStrings.str_your_device_dont_support_nfc:
              "Votre appareil ne prend pas en charge le NFC",
          GbsSystemStrings.str_hold_your_device_near_the_nfc_tag:
              "Veuillez approcher votre appareil de l'étiquette NFC",
          GbsSystemStrings.str_ready_to_scan: "Prêt à numériser",
          GbsSystemStrings.str_deconnexion_question:
              "Voulez-vous vous déconnecter ?",
          GbsSystemStrings.str_no_item: "il n'y a aucun élément",
          GbsSystemStrings.str_filtrer: "Filtrer",
          GbsSystemStrings.str_detail_contact: "Détail du contrat",
          GbsSystemStrings.str_document_administratif:
              "Documents administratifs",
          GbsSystemStrings.str_tous: "Tous",
          GbsSystemStrings.str_empty_pdf: "Le pdf est vide",
          GbsSystemStrings.str_nombre_des_telechargement:
              "Nombre de téléchargements",
          GbsSystemStrings.str_creation: "Création",
          GbsSystemStrings.str_entreprise: "Entreprise",
          GbsSystemStrings.str_type_document: "Type de documents",
          GbsSystemStrings.str_placement_cet: "Placement CET",
          GbsSystemStrings.str_rachat_cet: "Rachat CET",
          GbsSystemStrings.str_prise_de_jours_cet: "Prise de jours CET",
          GbsSystemStrings.solde_des_jours_de_cet: "Solde des jours de CET",
          GbsSystemStrings.str_nombre_des_jours: "Nombre de Jours",
          GbsSystemStrings.mise_au_cet_en_cours: "Mise au CET en cours",
          GbsSystemStrings.mise_au_cet_annee_en_cours:
              "Mise au CET année en cours",
          GbsSystemStrings.rachat_cet_en_cours: "Rachat CET en cours",
          GbsSystemStrings.rachat_de_cet: "Rachat de CET",
          GbsSystemStrings.prise_de_cet_en_cours: "Prise de CET en cours",
          GbsSystemStrings.prise_de_cet: "Prise de CET",
          GbsSystemStrings.solde_de_cet: "Solde de CET",
          GbsSystemStrings.str_motif: "Motif",
          GbsSystemStrings.str_type_jour: "Type de jour",
          GbsSystemStrings.str_indisponibiliter_recurrentes:
              "Indisponibilités récurrentes",
          GbsSystemStrings.str_dispo_definitive: "Disponibilité définitive",
          GbsSystemStrings.str_dispo_recurrente: "Disponibilité récurrente",
          GbsSystemStrings.str_exclusions_propositions_vacation:
              "Exclusion/proposition de vacation",
          GbsSystemStrings.str_disponibiliter_propositions_de_vacation:
              "Disponibilité/proposition de vacation",
          GbsSystemStrings.str_date_pro: "Date de proposition de vacation",
          GbsSystemStrings.str_documents_officiel: "Documents officiels",
          GbsSystemStrings.str_date_validiter: "Validité du",
          GbsSystemStrings.str_departement: "Département",
          GbsSystemStrings.str_numero_document: "N° Doc",
          GbsSystemStrings.str_diplome: "Diplôme",
          GbsSystemStrings.str_agrement: "Agrément",
          GbsSystemStrings.str_remplie_cases: "Veuillez remplir les cases",
          GbsSystemStrings.str_creer: "Créer",
          GbsSystemStrings.str_depasser: "Dépassé",
          GbsSystemStrings.kRefuser: "Refuser",
          GbsSystemStrings.kDemander: "Demander",
          GbsSystemStrings.kAccepter: "Accepter",
          GbsSystemStrings.str_valider_le: "Valider le",
          GbsSystemStrings.str_date_obtention: "Date d'obtention",
          GbsSystemStrings.str_documents_officiels: "Documents officiels",
          GbsSystemStrings.str_diplomes: "Diplômes",
          GbsSystemStrings.str_agrements: "Agréments",
          GbsSystemStrings.str_habilitations: "Habilitations",
          GbsSystemStrings.str_notes_de_frais: "Notes de frais",
          GbsSystemStrings.str_changment_mot_de_passe:
              "Changement de mot de passe",
          GbsSystemStrings.str_carte_proffisionel: "Carte professionnelle",
          GbsSystemStrings.str_att_vos_devez_valider_docs:
              "Attention : vous devez valider vos documents",
          GbsSystemStrings.str_definitif: "Définitif",
          GbsSystemStrings.str_are_you_sure_want_delete:
              "Etes-vous sûre de bien vouloir supprimer cet élément ?",
          GbsSystemStrings.str_deleted_with_success: "Supprimer avec succès",
          GbsSystemStrings.str_exclu_definitive: "Exclusion définitive",
          GbsSystemStrings.str_exclu_recurrente: "Exclusion récurrente",
          GbsSystemStrings.str_list_preferences: "Liste des préférences",
          GbsSystemStrings.str_accepter_proposition: "Accepter proposition",
          GbsSystemStrings.svp_select_type:
              "Veuillez sélectionner un type s'il vous plait",
          GbsSystemStrings.svp_ecrire_un_message:
              "Veuillez écrire un messsage s'il vous plait",
          GbsSystemStrings.str_prise_de_service: "Prise de service",
          GbsSystemStrings.str_ecrire_votre_message_ici:
              "Veuillez écrire votre message ici s'il vous plait",
          GbsSystemStrings.str_terminer: "Terminer",
          GbsSystemStrings.str_document: "Document",
          GbsSystemStrings.str_documents_de_lentreprise:
              "Documents de l'entreprise",
          GbsSystemStrings.str_planning_non_consulter:
              "Plannings non consultés",
          GbsSystemStrings.str_valider_vos_documents: "Validez vos documents",
          GbsSystemStrings.str_proposer_le: "Proposée le",
          GbsSystemStrings.str_consulter: "Consulter",
          GbsSystemStrings.str_publier: "Publiée",
          GbsSystemStrings.str_geolocaliser: "Géolocaliser",
          GbsSystemStrings.str_demander: "Demandé",
          GbsSystemStrings.str_publier_le: "Publiée le",
          GbsSystemStrings.str_distance: "Distance",
          GbsSystemStrings.str_du: "du",
          GbsSystemStrings.str_charger: "Charger",
          GbsSystemStrings.str_demande_vacation: "Demande de vacation",
          GbsSystemStrings.str_app_bar_select_item:
              "Veuillez sélectionner un item s'il vous plait",
          GbsSystemStrings.str_svp_add_date_debut_fin:
              "Veuillez ajouter les dates de debut et fin s'il vous plait",
          GbsSystemStrings.str_cloturer: "Cloturé",
          GbsSystemStrings.str_propositions: "Propositions",
          GbsSystemStrings.str_description: "Description",
          GbsSystemStrings.str_list_des_indisponibiliter:
              "Liste des indisponibilités",
          GbsSystemStrings.str_commentaire_planificateur:
              "Commentaire Planificateur",
          GbsSystemStrings.str_commentaire_salarie: "Commentaire Salarié",
          GbsSystemStrings.str_en_attente: "En attente",
          GbsSystemStrings.str_accepter: "Accepté",
          GbsSystemStrings.str_refuser: "Refusé",
          GbsSystemStrings.str_list_des_absences: "Liste des absences",
          GbsSystemStrings.str_solde_des_absences: "Solde des absences",
          GbsSystemStrings.demander_solde_restant_a_prendre:
              "Solde restant à prendre",
          GbsSystemStrings.demander_demande_en_cours: "Demandes en cours",
          GbsSystemStrings.demander_a_venir: "À venir",
          GbsSystemStrings.demander_pris: "Pris",
          GbsSystemStrings.demander_acquis: "Acquis",
          GbsSystemStrings.str_demande: "Demande",
          GbsSystemStrings.str_piece_jointe: "Piéces jointes",
          GbsSystemStrings.str_choisie_un_fichier:
              "Veuillez choisir un fichier PDF s'il vous plait",
          GbsSystemStrings.str_aucune_fichier_choisie: "Aucun fichier choisi",
          GbsSystemStrings.str_calculer: "Calculer",
          GbsSystemStrings.str_comment: "Commentaire",
          GbsSystemStrings.str_select_date:
              "Veuillez sélectionner une date s'il vous plait",
          GbsSystemStrings.str_disponibiliter: "Disponibilité",
          GbsSystemStrings.str_indisponibiliter: "Indisponibilités",
          GbsSystemStrings.str_demande_indisponibiliter:
              "Demande d'indisponibilité",
          GbsSystemStrings.str_demande_absence: "Demande d'absence",
          GbsSystemStrings.str_options: "Options",
          GbsSystemStrings.str_messagerie: "Messagerie",
          GbsSystemStrings.str_tenue: "Tenue",
          GbsSystemStrings.str_aucune_vacation_suiv:
              "Il n'y a aucune vacation suivante",
          GbsSystemStrings.str_aucune_vacation_prec:
              "Il n'y a aucune vacation précédente",
          GbsSystemStrings.str_pointage_sortie_succes:
              "Pointage de sortie effectué avec succès",
          GbsSystemStrings.str_location_denied:
              "Veuillez accepter l'autorisation de localisation sur votre mobile",
          GbsSystemStrings.str_mal_tourner:
              "Oups...quelque chose s'est mal passé",
          GbsSystemStrings.str_pointage_entrer_succes:
              "Pointage d'entrée effectué avec succès",
          GbsSystemStrings.str_debut: "Début",
          GbsSystemStrings.str_fin: "Fin",
          GbsSystemStrings.str_aucune_vacation_trouver:
              "Aucune vacation trouvée",
          GbsSystemStrings.str_afficher: "Afficher",
          GbsSystemStrings.str_telecharger: "Télécharger",
          GbsSystemStrings.str_publication: "Publication",
          GbsSystemStrings.str_telechargement: "Téléchargement",
          GbsSystemStrings.str_consultation: "Consultation",
          GbsSystemStrings.str_file_uploaded_with_success:
              "Fichier téléchargé avec succès",
          GbsSystemStrings.str_agenda: "Agenda",
          GbsSystemStrings.str_prise_de_vacation: "Prise de vacation",
          GbsSystemStrings.str_qualification: "Qualification",
          GbsSystemStrings.str_pause: "Pause",
          GbsSystemStrings.str_duree: "Durée",
          GbsSystemStrings.str_plages_horaires: "Plages horaires",
          GbsSystemStrings.str_aucune_vacation: "Aucune vacation de planifiée",
          GbsSystemStrings.str_documents: "Documents",
          GbsSystemStrings.str_info_salarie: "Informations salarié",
          GbsSystemStrings.str_absence: "Absence",
          GbsSystemStrings.str_dispo_ponctuelle: "Disponibilité ponctuelle",
          GbsSystemStrings.str_exclu_ponctuelle: "Exclusion ponctuelle",
          GbsSystemStrings.str_etat: "Etat",
          GbsSystemStrings.str_date_debut: "Date de début",
          GbsSystemStrings.str_hour_debut: "Heure de début",
          GbsSystemStrings.str_date_fin: "Date de fin",
          GbsSystemStrings.str_hour_fin: "Heure de fin",
          GbsSystemStrings.str_lieu: "Lieu",
          GbsSystemStrings.str_date_demande: "Date de demande",
          GbsSystemStrings.str_preferences: "Préferences",
          GbsSystemStrings.str_list_des_vacations: "Liste des vacations",
          GbsSystemStrings.str_prise_de_vacations: "Prise de vacation",
          GbsSystemStrings.str_planning_du_mois: "Planning du mois",
          GbsSystemStrings.str_mois_de_selection: "Mois de sélection",
          GbsSystemStrings.str_empty_data: "Il n'y a aucun élément",
          GbsSystemStrings.str_entrer: "Entrée",
          GbsSystemStrings.str_sortie: "Sortie",
          GbsSystemStrings.str_clotures_le: "Clôturée le",
          GbsSystemStrings.str_refuser_le: "Refusée le",
          GbsSystemStrings.str_acceptation_le: "Acceptée le",
          GbsSystemStrings.str_demande_absence_du: "Demande d'absence du",
          GbsSystemStrings.str_au: "au",
          GbsSystemStrings.str_effectuee_le: "Effectuée le",
          GbsSystemStrings.str_vacation: "Vacation",
          GbsSystemStrings.str_planning: "Planning",
          GbsSystemStrings.str_historique: "Historique",
          GbsSystemStrings.str_field_required: "Champ obligatoire",
          GbsSystemStrings.str_code_email: "Code Email",
          GbsSystemStrings.str_code_sms: "Code SMS",
          GbsSystemStrings.str_portable: "Portable",
          GbsSystemStrings.str_precedent: "Précédent",
          GbsSystemStrings.str_ville: "Ville",
          GbsSystemStrings.str_longitude: "Longitude",
          GbsSystemStrings.str_latitude: "Latitude",
          GbsSystemStrings.str_valider: "Valider",
          GbsSystemStrings.str_photo: "Photo",
          GbsSystemStrings.str_adresse: "Adresse",
          GbsSystemStrings.str_telephone: "Téléphone",
          GbsSystemStrings.str_suivant: "Suivant",
          GbsSystemStrings.str_nom: "Nom",
          GbsSystemStrings.str_prenom: "Prénom",
          GbsSystemStrings.str_my_info: "Mes informations",
          GbsSystemStrings.str_modifier: "Modifier",
          GbsSystemStrings.str_home: "Accueil",
          GbsSystemStrings.str_afficher_historique: "Afficher l'historique",
          GbsSystemStrings.str_bienvenue: "Bienvenue",
          GbsSystemStrings.vacation_proposer: "Vacation(s) Proposée(s)",
          GbsSystemStrings.str_acceder_a_vos_informations:
              "Accéder à vos informations",
          GbsSystemStrings.demander_vacation: "Demander une vacation",
          GbsSystemStrings.str_fois_pour_activer_mode:
              "fois pour activer mode enregistrer serveur",
          GbsSystemStrings.str_error_no_connection_title:
              "Oups, pas de connexion Internet",
          GbsSystemStrings.str_error_connection_returned_title:
              "Connexion rétablie !",
          GbsSystemStrings.str_error_server_title:
              "Oups, quelque chose s'est mal passé",
          GbsSystemStrings.str_quitter: "Quitter",
          GbsSystemStrings.str_appyier: "Taper",
          GbsSystemStrings.str_fois_pour_quiter: "fois pour quitter",
          GbsSystemStrings.str_refresh: "Rafraîchir",
          GbsSystemStrings.str_password_changed:
              "mot de passe changé avec succès",
          GbsSystemStrings.str_mail_sended: "mail envoyé avec succès",
          GbsSystemStrings.boarding_1_subtitle:
              "Votre partenaire sur le terrain pour le traitement de l'information",
          GbsSystemStrings.boarding_2_subtitle:
              "A votre service pour une gestion plus fiable",
          GbsSystemStrings.boarding_3_title: "Temps réel",
          GbsSystemStrings.boarding_3_subtitle:
              "Information disponible en temps réel pour tous vos colaborateurs",
          GbsSystemStrings.boarding_4_subtitle:
              "Aidez-nous à l'améliorer pour un meilleur service",
          GbsSystemStrings.str_dialog_avertissement: "avertissement",
          GbsSystemStrings.str_annuler: "Annuler",
          GbsSystemStrings.str_dialog_erreur: "Erreur",
          GbsSystemStrings.str_dialog_succes: "Succès",
          GbsSystemStrings.str_dialog_info: "Information",
          GbsSystemStrings.str_mode_identification: "identification",
          GbsSystemStrings.str_mode_enregistrer_server: "Salarié enregistré",
          GbsSystemStrings.str_mode_enregistrer_server_active:
              "mode enregistrer serveur bien activer",
          GbsSystemStrings.str_validat_svp_enter_site:
              "Veuillez entrer le site s'il vous plait",
          GbsSystemStrings.str_validat_svp_enter_mail:
              "Veuillez saisir l'email s'il vous plait",
          GbsSystemStrings.str_validat_svp_enter_site_valide:
              "Veuillez renseigner un site valide s'il vous plait",
          GbsSystemStrings.str_site: "Site",
          GbsSystemStrings.str_validat_svp_enter_password:
              "Veuillez saisir le mot de passe s'il vous plait",
          GbsSystemStrings.str_validat_password_length:
              "Le mot de passe doit contenir au moins 8 caractères",
          GbsSystemStrings.str_email_required:
              "Veuillez saisir l'email s'il vous plait",
          GbsSystemStrings.str_enter_valid_email:
              "Veuillez saisir un email valide s'il vous plait",
          GbsSystemStrings.str_mail: "Email",
          GbsSystemStrings.str_password: "Mot de passe",
          GbsSystemStrings.str_password_required: "Le mot de passe est requis",
          GbsSystemStrings.str_password_contain_6_car:
              "Le mot de passe doit contenir au moins 8 caractères",
          GbsSystemStrings.str_mot_de_passe_oublier: "Mot de passe oublié ?",
          GbsSystemStrings.str_change_password: "Changer le mot de passe",
          GbsSystemStrings.str_ok: "ok",
          GbsSystemStrings.str_droits_reserved:
              "© BM Soft 2024 Tous droits réservés",
          GbsSystemStrings.str_changement_mot_passe:
              "Changement de mot de passe",
          GbsSystemStrings.str_old_password: "Ancien mot de passe",
          GbsSystemStrings.str_new_password: "Nouveau mot de passe",
          GbsSystemStrings.str_new_password_confirmation:
              "Confirmation nouveau mot de passe",
          GbsSystemStrings.str_reset_password: "Réinitialiser le mot de passe",
          GbsSystemStrings.str_validat_password_must_be_the_same:
              "Le mot de passe doit être le même"
        },
        "de": {
          GbsSystemStrings.str_session_experer_sso: "Sitzung abgelaufen",

          GbsSystemStrings.str_fermer: "schließen",

          GbsSystemStrings.str_operation_effectuer: "Vorgang abgeschlossen",
          GbsSystemStrings.str_operation_non_autoriser:
              "Vorgang nicht autorisiert",
          GbsSystemStrings.str_partager: "Teilen",

          GbsSystemStrings.str_actions_offline:
              "Daten warten auf Synchronisation",
          GbsSystemStrings.str_question_actions_offline:
              "Möchten Sie Ihre nicht gespeicherten Daten mit dem Server synchronisieren?",
          GbsSystemStrings.str_non: "nein",
          GbsSystemStrings.str_oui: "ja",

          GbsSystemStrings.str_code_entreprise: "Unternehmenscode",
          GbsSystemStrings.str_are_you_sure_want_change_entreprise:
              "Sind Sie sicher, dass Sie die Agentur wechseln möchten?",
          GbsSystemStrings.str_validat_svp_code_entreprise_invalid:
              "Der Unternehmenscode ist ungültig",
          GbsSystemStrings.str_validat_svp_enter_code_client:
              "Bitte geben Sie den Kundencode ein",
          GbsSystemStrings.str_new_version_available: "Neue Version verfügbar!",
          GbsSystemStrings.str_new_version_desc:
              "Eine neue Version der Anwendung ist verfügbar. Um die neuesten Funktionen zu nutzen, aktualisieren Sie bitte die App, indem Sie auf 'Aktualisieren' klicken.",
          GbsSystemStrings.str_try_later: "Später versuchen",
          GbsSystemStrings.str_update_now: "Aktualisieren",
          GbsSystemStrings.str_device_dont_support_biometrics:
              "Ihr Gerät unterstützt keine Biometrie.",

          GbsSystemStrings.str_auth_please_authentificate:
              "Bitte authentifizieren Sie sich",

          GbsSystemStrings.str_auth_please_authentificate_to_proceed:
              "Bitte authentifizieren Sie sich, um fortzufahren",

          GbsSystemStrings.str_auth_auth_success:
              "Authentifizierung erfolgreich",

          GbsSystemStrings.str_auth_auth_failed:
              "Authentifizierung fehlgeschlagen",

          GbsSystemStrings.str_auth_biometric_auth:
              "Biometrische Authentifizierung",

          GbsSystemStrings.str_auth_auth_with_biometrics:
              "Mit Biometrie authentifizieren",

          GbsSystemStrings.str_auth_biometrics_not_available:
              "Biometrische Authentifizierung ist nicht verfügbar.",

          GbsSystemStrings.str_auth_start_auth: "Authentifizierung starten",

          GbsSystemStrings.str_proposition_s: "Vorschlag(e)",

          GbsSystemStrings.str_nfc: "NFC",
          GbsSystemStrings.str_taille: "Größe",
          GbsSystemStrings.str_qte: "Menge",

          GbsSystemStrings.str_loading_map: "Karte wird geladen",

          GbsSystemStrings.str_rendre: "Zurückgeben",
          GbsSystemStrings.str_pas_rendre: "Nicht zurückzugeben",

          GbsSystemStrings.str_demander_refuser: "Anfragen/Abweisen",
          GbsSystemStrings.str_proposition: "Vorschlag",
          GbsSystemStrings.str_indisponibiliter_ponctuelle:
              "Vorübergehende Unverfügbarkeit",
          GbsSystemStrings.str_action_non_autoriser: "Aktion nicht autorisiert",
          GbsSystemStrings.str_code_pin_wrong: "Der PIN-Code ist falsch",
          GbsSystemStrings.str_nouvelle_connexion: "Neue Verbindung",
          GbsSystemStrings.str_code_pin_oublier: "PIN-Code vergessen?",
          GbsSystemStrings.str_enregistrer: "Speichern",
          GbsSystemStrings.str_enregistrement: "Speichern",
          GbsSystemStrings.str_enrigester_nv_code_pin:
              "Neuen PIN-Code speichern, um fortzufahren",
          GbsSystemStrings.str_entrer_code_pin_deja_enrigester:
              "Geben Sie den bereits gespeicherten PIN-Code ein, um fortzufahren",
          GbsSystemStrings.str_verification: "Überprüfung",
          GbsSystemStrings.str_code_pin: "PIN-Code",
          GbsSystemStrings.str_map: "Karte",
          GbsSystemStrings.str_pointage_en_cours:
              "Arbeitszeiterfassung läuft ...",
          GbsSystemStrings.str_operation_en_cours: "Operation läuft ...",
          GbsSystemStrings.str_details_vacation: "Detail Urlaub",
          //time picker
          GbsSystemStrings.str_Select_Time: "Zeit auswählen",
          GbsSystemStrings.str_hour: "Stunde",
          GbsSystemStrings.str_minute: "Minute",
          GbsSystemStrings.str_timePickerInputHint: "Uhrzeit eingeben",
          //date picker
          GbsSystemStrings.str_selectDate: "Datum auswählen",
          GbsSystemStrings.str_cancel: "Abbrechen",
          GbsSystemStrings.str_done: "Fertig",
          GbsSystemStrings.str_prevMonth: "Vorheriger Monat",
          GbsSystemStrings.str_nextMonth: "Nächster Monat",
          GbsSystemStrings.str_prevYear: "Vorheriges Jahr",
          GbsSystemStrings.str_nextYear: "Nächstes Jahr",
          GbsSystemStrings.str_datePickerInputHint: "Datum eingeben",
          GbsSystemStrings.str_datePickerHelpText: "Datum auswählen",
          //calendar
          GbsSystemStrings.str_monday: "Montag",
          GbsSystemStrings.str_tuesday: "Dienstag",
          //
          GbsSystemStrings.str_droits_reserved_part_2:
              "Alle Rechte vorbehalten",
          GbsSystemStrings.str_connexion: "Verbindung",
          GbsSystemStrings.str_ignorer: "Ignorieren",
          GbsSystemStrings.str_waiting_for_tag: "Warten auf NFC-Tag",
          GbsSystemStrings.str_nfc_disabled:
              "NFC-Tag-Berechtigung ist deaktiviert. Bitte aktivieren Sie die NFC-Berechtigung und versuchen Sie es erneut",
          GbsSystemStrings.str_please_turn_on_nfc_service:
              "Bitte aktivieren Sie den NFC-Dienst auf Ihrem Gerät",
          GbsSystemStrings.str_your_device_dont_support_nfc:
              "Ihr Gerät unterstützt kein NFC",
          GbsSystemStrings.str_hold_your_device_near_the_nfc_tag:
              "Halten Sie Ihr Gerät in der Nähe des NFC-Tags",
          GbsSystemStrings.str_ready_to_scan: "Bereit zum Scannen",
          GbsSystemStrings.str_deconnexion_question:
              "Möchten Sie sich abmelden?",
          GbsSystemStrings.str_no_item: "Es gibt keine Elemente",
          GbsSystemStrings.str_filtrer: "Filtern",
          GbsSystemStrings.str_detail_contact: "Vertragsdetail",
          GbsSystemStrings.str_document_administratif: "Verwaltungsdokument",
          GbsSystemStrings.str_tous: "Alle",
          GbsSystemStrings.str_empty_pdf: "Das PDF ist leer",
          GbsSystemStrings.str_nombre_des_telechargement:
              "Anzahl der Downloads",
          GbsSystemStrings.str_creation: "Erstellung",
          GbsSystemStrings.str_entreprise: "Unternehmen",
          GbsSystemStrings.str_type_document: "Dokumenttyp",
          GbsSystemStrings.str_placement_cet: "CET-Platzierung",
          GbsSystemStrings.str_rachat_cet: "CET-Rückkauf",
          GbsSystemStrings.str_prise_de_jours_cet: "CET-Tage nehmen",
          GbsSystemStrings.solde_des_jours_de_cet: "CET-Tageguthaben",
          GbsSystemStrings.str_nombre_des_jours: "Anzahl der Tage",
          GbsSystemStrings.mise_au_cet_en_cours: "CET-Einlagerung im Gange",
          GbsSystemStrings.mise_au_cet_annee_en_cours:
              "CET-Einlagerung im aktuellen Jahr",
          GbsSystemStrings.rachat_cet_en_cours: "CET-Rückkauf im Gange",
          GbsSystemStrings.rachat_de_cet: "CET-Rückkauf",
          GbsSystemStrings.prise_de_cet_en_cours: "CET-Aufnahme im Gange",
          GbsSystemStrings.prise_de_cet: "CET-Aufnahme",
          GbsSystemStrings.solde_de_cet: "CET-Guthaben",
          GbsSystemStrings.str_motif: "Begründung",
          GbsSystemStrings.str_type_jour: "Tagtyp",
          GbsSystemStrings.str_indisponibiliter_recurrentes:
              "Wiederkehrende Nichtverfügbarkeiten",
          GbsSystemStrings.str_dispo_definitive: "Endgültige Verfügbarkeit",
          GbsSystemStrings.str_dispo_recurrente: "Wiederkehrende Verfügbarkeit",
          GbsSystemStrings.str_exclusions_propositions_vacation:
              "Urlaubsausschluss/Vorschlag",
          GbsSystemStrings.str_disponibiliter_propositions_de_vacation:
              "Verfügbarkeit/Vorschlag für Urlaub",
          GbsSystemStrings.str_date_pro: "Berufsdatum",
          GbsSystemStrings.str_documents_officiel: "Offizielle Dokumente",
          GbsSystemStrings.str_date_validiter: "Gültigkeit des",
          GbsSystemStrings.str_departement: "Abteilung",
          GbsSystemStrings.str_numero_document: "Dokumentnummer",
          GbsSystemStrings.str_diplome: "Diplom",
          GbsSystemStrings.str_agrement: "Genehmigung",
          GbsSystemStrings.str_remplie_cases: "füllen Sie die Felder aus",
          GbsSystemStrings.str_creer: "Erstellen",
          GbsSystemStrings.str_depasser: "Überschritten",
          GbsSystemStrings.kRefuser: "Ablehnen",
          GbsSystemStrings.kDemander: "Anfragen",
          GbsSystemStrings.kAccepter: "Akzeptieren",
          GbsSystemStrings.str_valider_le: "Bestätigt am",
          GbsSystemStrings.str_date_obtention: "Erhaltungsdatum",
          GbsSystemStrings.str_documents_officiels: "Offizielle Dokumente",
          GbsSystemStrings.str_diplomes: "Diplome",
          GbsSystemStrings.str_agrements: "Genehmigungen",
          GbsSystemStrings.str_habilitations: "Qualifikationen",
          GbsSystemStrings.str_notes_de_frais: "Kostennotizen",
          GbsSystemStrings.str_changment_mot_de_passe: "Passwort ändern",
          GbsSystemStrings.str_carte_proffisionel: "Berufskarte",
          GbsSystemStrings.str_att_vos_devez_valider_docs:
              "Achtung: Sie müssen Ihre Dokumente bestätigen",
          GbsSystemStrings.str_definitif: "Endgültig",
          GbsSystemStrings.str_are_you_sure_want_delete:
              "Sind Sie sicher, dass Sie dieses Element löschen möchten?",
          GbsSystemStrings.str_deleted_with_success: "Erfolgreich gelöscht",
          GbsSystemStrings.str_exclu_definitive: "Endgültiger Ausschluss",
          GbsSystemStrings.str_exclu_recurrente: "Wiederkehrender Ausschluss",
          GbsSystemStrings.str_list_preferences: "Präferenzliste",
          GbsSystemStrings.str_accepter_proposition: "Vorschlag akzeptieren",
          GbsSystemStrings.svp_select_type: "Bitte wählen Sie einen Typ aus",
          GbsSystemStrings.svp_ecrire_un_message:
              "Bitte eine Nachricht schreiben",
          GbsSystemStrings.str_prise_de_service: "Servicepreis",
          GbsSystemStrings.str_ecrire_votre_message_ici:
              "Schreiben Sie Ihre Nachricht hier",
          GbsSystemStrings.str_terminer: "beenden",
          GbsSystemStrings.str_document: "Dokument",
          GbsSystemStrings.str_documents_de_lentreprise:
              "Unternehmensdokumente",
          GbsSystemStrings.str_planning_non_consulter:
              "Nicht eingesehene Zeitpläne",
          GbsSystemStrings.str_valider_vos_documents:
              "Ihre Dokumente bestätigen",
          GbsSystemStrings.str_proposer_le: "Vorgeschlagen am",
          GbsSystemStrings.str_consulter: "Konsultieren",
          GbsSystemStrings.str_publier: "Veröffentlicht",
          GbsSystemStrings.str_geolocaliser: "Geolokalisieren",
          GbsSystemStrings.str_demander: "Angefordert",
          GbsSystemStrings.str_publier_le: "Veröffentlicht am",
          GbsSystemStrings.str_distance: "Entfernung",
          GbsSystemStrings.str_du: "von",
          GbsSystemStrings.str_charger: "laden",
          GbsSystemStrings.str_demande_vacation: "Urlaubsanfrage",
          GbsSystemStrings.str_app_bar_select_item: "Ein Element auswählen",
          GbsSystemStrings.str_svp_add_date_debut_fin:
              "Bitte fügen Sie das Start- und Enddatum hinzu",
          GbsSystemStrings.str_cloturer: "Abgeschlossen",
          GbsSystemStrings.str_propositions: "Vorschläge",
          GbsSystemStrings.str_description: "Beschreibung",
          GbsSystemStrings.str_list_des_indisponibiliter:
              "Liste der Nichtverfügbarkeiten",
          /////
          GbsSystemStrings.str_commentaire_planificateur: "Planer Kommentar",
          GbsSystemStrings.str_commentaire_salarie: "Mitarbeiterkommentar",
          GbsSystemStrings.str_en_attente: "In Erwartung",
          GbsSystemStrings.str_accepter: "Akzeptiert",
          GbsSystemStrings.str_refuser: "Abgelehnt",
          GbsSystemStrings.str_list_des_absences: "Liste der Abwesenheiten",
          GbsSystemStrings.str_solde_des_absences: "Abwesenheitsbilanz",
          GbsSystemStrings.demander_solde_restant_a_prendre:
              "Verbleibender Bilanzwert zum Nehmen",
          GbsSystemStrings.demander_demande_en_cours: "Anfragen in Bearbeitung",
          GbsSystemStrings.demander_a_venir: "Bevorstehend",
          GbsSystemStrings.demander_pris: "Genommen",
          GbsSystemStrings.demander_acquis: "Erworben",
          GbsSystemStrings.str_demande: "Anfrage",
          GbsSystemStrings.str_piece_jointe: "Anhänge",
          GbsSystemStrings.str_choisie_un_fichier:
              "Bitte wählen Sie eine PDF-Datei aus",
          GbsSystemStrings.str_aucune_fichier_choisie: "Keine Datei ausgewählt",
          GbsSystemStrings.str_calculer: "Berechnen",
          GbsSystemStrings.str_comment: "Kommentar",
          GbsSystemStrings.str_select_date: "Wählen Sie ein Datum",
          GbsSystemStrings.str_disponibiliter: "Verfügbarkeit",
          GbsSystemStrings.str_indisponibiliter: "Nichtverfügbarkeiten",
          GbsSystemStrings.str_demande_indisponibiliter:
              "Anfrage zur Nichtverfügbarkeit",
          GbsSystemStrings.str_demande_absence: "Abwesenheitsanfrage",
          GbsSystemStrings.str_options: "Optionen",
          GbsSystemStrings.str_messagerie: "Nachrichtenaustausch",
          GbsSystemStrings.str_tenue: "Outfit",

          GbsSystemStrings.str_aucune_vacation_suiv:
              "Es gibt keine folgende Schicht",
          GbsSystemStrings.str_aucune_vacation_prec:
              "Es gibt keine vorherige Schicht",
          GbsSystemStrings.str_pointage_sortie_succes:
              "Ausstempelung erfolgreich",
          GbsSystemStrings.str_location_denied:
              "Sie müssen die Standortberechtigung akzeptieren",
          GbsSystemStrings.str_mal_tourner: "Etwas ist schief gelaufen",
          GbsSystemStrings.str_pointage_entrer_succes:
              "Einstempelung erfolgreich",
          GbsSystemStrings.str_debut: "Anfang",
          GbsSystemStrings.str_fin: "Ende",
          GbsSystemStrings.str_aucune_vacation_trouver: "Keine Ferien gefunden",
          GbsSystemStrings.str_afficher: "Anzeigen",
          GbsSystemStrings.str_telecharger: "Herunterladen",
          GbsSystemStrings.str_publication: "Veröffentlichung",
          GbsSystemStrings.str_telechargement: "Herunterladen",
          GbsSystemStrings.str_consultation: "Beratung",
          GbsSystemStrings.str_file_uploaded_with_success:
              "Datei erfolgreich heruntergeladen",
          GbsSystemStrings.str_agenda: "Agenda",
          GbsSystemStrings.str_prise_de_vacation: "Urlaub nehmen",
          GbsSystemStrings.str_qualification: "Qualifikation",
          GbsSystemStrings.str_pause: "Pause",
          GbsSystemStrings.str_duree: "Dauer",
          GbsSystemStrings.str_plages_horaires: "Zeitschlitze",
          GbsSystemStrings.str_aucune_vacation: "Kein Urlaub auf dem Server",
          GbsSystemStrings.str_documents: "Dokumente",
          GbsSystemStrings.str_info_salarie: "Mitarbeiterinformationen",
          GbsSystemStrings.str_absence: "Abwesenheit",
          GbsSystemStrings.str_dispo_ponctuelle: "Zeitliche Verfügbarkeit",
          GbsSystemStrings.str_exclu_ponctuelle: "Zeitliche Ausgrenzung",
          GbsSystemStrings.str_etat: "Zustand",
          GbsSystemStrings.str_date_debut: "Startdatum",
          GbsSystemStrings.str_hour_debut: "Startzeit",
          GbsSystemStrings.str_date_fin: "Enddatum",
          GbsSystemStrings.str_hour_fin: "Endzeit",
          GbsSystemStrings.str_lieu: "Ort",
          GbsSystemStrings.str_date_demande: "Anforderungsdatum",
          GbsSystemStrings.str_preferences: "Präferenzen",
          GbsSystemStrings.str_list_des_vacations: "Urlaubsliste",
          GbsSystemStrings.str_prise_de_vacations: "Urlaub nehmen",
          GbsSystemStrings.str_planning_du_mois: "Monatsplanung",
          GbsSystemStrings.str_mois_de_selection: "Ausgewählter Monat",
          GbsSystemStrings.str_empty_data: "Es gibt keine Elemente",
          GbsSystemStrings.str_entrer: "Eingang",
          GbsSystemStrings.str_sortie: "Ausgang",
          GbsSystemStrings.str_clotures_le: "Geschlossen am",
          GbsSystemStrings.str_refuser_le: "Abgelehnt am",
          GbsSystemStrings.str_acceptation_le: "Akzeptiert am",
          GbsSystemStrings.str_demande_absence_du: "Abwesenheitsanfrage vom",
          GbsSystemStrings.str_au: "bis",
          GbsSystemStrings.str_effectuee_le: "durchgeführt am",
          GbsSystemStrings.str_vacation: "Urlaub",
          GbsSystemStrings.str_planning: "Planung",
          GbsSystemStrings.str_historique: "Historie",
          GbsSystemStrings.str_field_required: "Erforderliches Feld",
          GbsSystemStrings.str_code_email: "E-Mail-Code",
          GbsSystemStrings.str_code_sms: "SMS-Code",
          GbsSystemStrings.str_portable: "Tragbar",
          GbsSystemStrings.str_precedent: "Vorherige",
          GbsSystemStrings.str_ville: "Stadt",
          GbsSystemStrings.str_longitude: "Längengrad",
          GbsSystemStrings.str_latitude: "Breitengrad",
          GbsSystemStrings.str_valider: "Validieren",
          GbsSystemStrings.str_photo: "Foto",
          GbsSystemStrings.str_adresse: "Adresse",
          GbsSystemStrings.str_telephone: "Telefon",
          GbsSystemStrings.str_suivant: "Weiter",
          GbsSystemStrings.str_nom: "Name",
          GbsSystemStrings.str_prenom: "Vorname",
          GbsSystemStrings.str_my_info: "Informationen meine",
          GbsSystemStrings.str_modifier: "Medify",
          GbsSystemStrings.str_home: "Startseite",
          GbsSystemStrings.str_afficher_historique: "Verlauf anzeigen",
          GbsSystemStrings.str_bienvenue: "Willkommen",
          GbsSystemStrings.vacation_proposer: "Vorgeschlagene(r) Urlaub(e)",
          GbsSystemStrings.str_acceder_a_vos_informations:
              "Zugriff auf Ihre Informationen",
          GbsSystemStrings.demander_vacation: "Einen Urlaub beantragen",
          GbsSystemStrings.str_fois_pour_activer_mode:
              "Mal, um den Server-Speichermodus zu aktivieren",
          GbsSystemStrings.str_error_no_connection_title:
              "Hoppla, keine Internetverbindung",
          GbsSystemStrings.str_error_connection_returned_title:
              "Verbindung wiederhergestellt!",
          GbsSystemStrings.str_error_server_title:
              "Hoppla, etwas ist schief gelaufen",
          GbsSystemStrings.str_quitter: "Verlassen",
          GbsSystemStrings.str_appyier: "Tippen",
          GbsSystemStrings.str_fois_pour_quiter: "mal zum Beenden",
          GbsSystemStrings.str_refresh: "Aktualisieren",
          GbsSystemStrings.str_password_changed:
              "Passwort erfolgreich geändert",
          GbsSystemStrings.str_mail_sended: "E-Mail erfolgreich gesendet",
          GbsSystemStrings.boarding_1_subtitle:
              "Ihr Partner bei der Informationsverarbeitung vor Ort",
          GbsSystemStrings.boarding_2_subtitle:
              "Zu Ihren Diensten für eine zuverlässigere Verwaltung",
          GbsSystemStrings.boarding_3_title: "Echtzeit",
          GbsSystemStrings.boarding_3_subtitle:
              "Echtzeitinformationen für alle Ihre Mitarbeiter verfügbar",
          GbsSystemStrings.boarding_4_subtitle:
              "Helfen Sie uns, unseren Service zu verbessern",
          GbsSystemStrings.str_dialog_avertissement: "Warnung",
          GbsSystemStrings.str_annuler: "Abbrechen",
          GbsSystemStrings.str_dialog_erreur: "Fehler",
          GbsSystemStrings.str_dialog_succes: "Erfolg",
          GbsSystemStrings.str_dialog_info: "Information",
          GbsSystemStrings.str_mode_identification: "Identifikation",
          GbsSystemStrings.str_mode_enregistrer_server: "Server sichern",
          GbsSystemStrings.str_mode_enregistrer_server_active:
              "Der Server-Speichermodus wurde erfolgreich aktiviert",
          GbsSystemStrings.str_validat_svp_enter_site:
              "Bitte geben Sie die Website ein",
          GbsSystemStrings.str_validat_svp_enter_mail:
              "Bitte geben Sie die E-Mail-Adresse ein",
          GbsSystemStrings.str_validat_svp_enter_site_valide:
              "Bitte geben Sie eine gültige Website ein",
          GbsSystemStrings.str_site: "Website",
          GbsSystemStrings.str_validat_svp_enter_password:
              "Bitte geben Sie das Passwort ein",
          GbsSystemStrings.str_validat_password_length:
              "Das Passwort muss mindestens 8 Zeichen enthalten",
          GbsSystemStrings.str_email_required: "E-Mail ist erforderlich",
          GbsSystemStrings.str_enter_valid_email:
              "Geben Sie eine gültige E-Mail-Adresse ein",
          GbsSystemStrings.str_mail: "Email",
          GbsSystemStrings.str_password: "Passwort",
          GbsSystemStrings.str_password_required: "Passwort wird benötigt",
          GbsSystemStrings.str_password_contain_6_car:
              "Das Passwort muss mindestens 6 Zeichen enthalten",
          GbsSystemStrings.str_mot_de_passe_oublier: "Passwort vergessen ?",
          GbsSystemStrings.str_change_password: "Kennwort ändern",
          GbsSystemStrings.str_ok: "ok",
          GbsSystemStrings.str_droits_reserved:
              "© BM Soft 2022 Alle Rechte vorbehalten",
          GbsSystemStrings.str_changement_mot_passe: "Passwortänderung",
          GbsSystemStrings.str_old_password: "Altes Passwort",
          GbsSystemStrings.str_new_password: "Neues Kennwort",
          GbsSystemStrings.str_new_password_confirmation:
              "Neues Passwort bestätigen",
          GbsSystemStrings.str_reset_password: "Passwort zurücksetzen",
          GbsSystemStrings.str_validat_password_must_be_the_same:
              "Das Passwort muss übereinstimmen",
        },
        "en": {
          GbsSystemStrings.str_session_experer_sso: "Session expired",

          GbsSystemStrings.str_fermer: "close",

          GbsSystemStrings.str_operation_effectuer: "Operation completed",
          GbsSystemStrings.str_operation_non_autoriser:
              "Operation not authorized",
          GbsSystemStrings.str_partager: "Share",

          GbsSystemStrings.str_actions_offline: "Data pending synchronization",
          GbsSystemStrings.str_question_actions_offline:
              "Do you want to synchronize your unsaved data with the server?",
          GbsSystemStrings.str_non: "no",
          GbsSystemStrings.str_oui: "yes",

          GbsSystemStrings.str_code_entreprise: "Company Code",
          GbsSystemStrings.str_are_you_sure_want_change_entreprise:
              "Are you sure you want to change the agency?",
          GbsSystemStrings.str_validat_svp_code_entreprise_invalid:
              "The company code is invalid",
          GbsSystemStrings.str_validat_svp_enter_code_client:
              "Please enter the client code",
          GbsSystemStrings.str_new_version_available: "New version available!",
          GbsSystemStrings.str_new_version_desc:
              "A new version of the application is available. To enjoy the latest features, please update the app by clicking on 'Update'.",
          GbsSystemStrings.str_try_later: "Try again later",
          GbsSystemStrings.str_update_now: "Update",

          GbsSystemStrings.str_device_dont_support_biometrics:
              "Your device doesn't support biometrics.",

          GbsSystemStrings.str_auth_please_authentificate:
              "Please authenticate",
          GbsSystemStrings.str_auth_please_authentificate_to_proceed:
              'Please authenticate to proceed',
          GbsSystemStrings.str_auth_auth_success: "Authentication successful",
          GbsSystemStrings.str_auth_auth_failed: "Authentication failed",
          GbsSystemStrings.str_auth_biometric_auth: 'Biometric Authentication',
          GbsSystemStrings.str_auth_auth_with_biometrics:
              'Authenticate with Biometrics',
          GbsSystemStrings.str_auth_biometrics_not_available:
              "Biometric authentication is not available.",
          GbsSystemStrings.str_auth_start_auth: 'Start Authentication',

          GbsSystemStrings.str_proposition_s: "Proposal(s)",

          GbsSystemStrings.str_nfc: "NFC",
          GbsSystemStrings.str_taille: "Size",
          GbsSystemStrings.str_qte: "Quantity",

          GbsSystemStrings.str_loading_map: "Loading map",

          GbsSystemStrings.str_rendre: "To return",
          GbsSystemStrings.str_pas_rendre: "Not to return",

          GbsSystemStrings.str_demander_refuser: "Request/Refuse",
          GbsSystemStrings.str_proposition: "Proposal",
          GbsSystemStrings.str_indisponibiliter_ponctuelle:
              "Temporary unavailability",
          GbsSystemStrings.str_action_non_autoriser: "Action not authorized",
          GbsSystemStrings.str_code_pin_wrong: "The PIN code is incorrect",
          GbsSystemStrings.str_nouvelle_connexion: "New connection",
          GbsSystemStrings.str_code_pin_oublier: "Forgot PIN code?",
          GbsSystemStrings.str_enregistrer: "Save",
          GbsSystemStrings.str_enregistrement: "Saving",
          GbsSystemStrings.str_enrigester_nv_code_pin:
              "Save a new PIN code to continue",
          GbsSystemStrings.str_entrer_code_pin_deja_enrigester:
              "Enter the PIN code that is already saved to continue",
          GbsSystemStrings.str_verification: "Verification",
          GbsSystemStrings.str_code_pin: "PIN code",
          GbsSystemStrings.str_map: "Map",
          GbsSystemStrings.str_pointage_en_cours: "Clocking in progress ...",
          GbsSystemStrings.str_operation_en_cours: "Operation in progress ...",
          GbsSystemStrings.str_details_vacation: "Vacation Details",
          //time picker
          GbsSystemStrings.str_Select_Time: "Select Time",
          GbsSystemStrings.str_hour: "hour",
          GbsSystemStrings.str_minute: "minute",
          GbsSystemStrings.str_timePickerInputHint: "Enter time",
          //date picker
          GbsSystemStrings.str_selectDate: "Select Date",
          GbsSystemStrings.str_cancel: "Cancel",
          GbsSystemStrings.str_done: "Done",
          GbsSystemStrings.str_prevMonth: "Previous Month",
          GbsSystemStrings.str_nextMonth: "Next Month",
          GbsSystemStrings.str_prevYear: "Previous Year",
          GbsSystemStrings.str_nextYear: "Next Year",
          GbsSystemStrings.str_datePickerInputHint: "Enter date",
          GbsSystemStrings.str_datePickerHelpText: "Select Date",
          //calendar
          GbsSystemStrings.str_monday: "Monday",
          GbsSystemStrings.str_tuesday: "Tuesday",
          //
          GbsSystemStrings.str_droits_reserved_part_2: "All rights reserved",
          GbsSystemStrings.str_connexion: "Connection",
          GbsSystemStrings.str_ignorer: "Ignore",
          GbsSystemStrings.str_waiting_for_tag: "Waiting for NFC Tag",
          GbsSystemStrings.str_nfc_disabled:
              "NFC Tag Permission is disabled please enable NFC permission and try Again",
          GbsSystemStrings.str_please_turn_on_nfc_service:
              "Please Turn On NFC service in your device",
          GbsSystemStrings.str_your_device_dont_support_nfc:
              "Your Device Don't support NFC",
          GbsSystemStrings.str_hold_your_device_near_the_nfc_tag:
              "Hold your device near The NFC Tag",
          GbsSystemStrings.str_ready_to_scan: "Ready to Scan",
          GbsSystemStrings.str_deconnexion_question: "Do you want to log out?",
          GbsSystemStrings.str_no_item: "There are no items",
          GbsSystemStrings.str_filtrer: "Filter",
          GbsSystemStrings.str_detail_contact: "Contract Detail",
          GbsSystemStrings.str_document_administratif:
              "Administrative Document",
          GbsSystemStrings.str_tous: "All",
          GbsSystemStrings.str_empty_pdf: "the pdf is empty",
          GbsSystemStrings.str_nombre_des_telechargement: "Number of Downloads",
          GbsSystemStrings.str_creation: "Creation",
          GbsSystemStrings.str_entreprise: "Enterprise",
          GbsSystemStrings.str_type_document: "Document Type",
          GbsSystemStrings.str_placement_cet: "CET Placement",
          GbsSystemStrings.str_rachat_cet: "CET Buyback",
          GbsSystemStrings.str_prise_de_jours_cet: "CET Days Taken",
          GbsSystemStrings.solde_des_jours_de_cet: "CET Days Balance",
          GbsSystemStrings.str_nombre_des_jours: "Number of Days",
          GbsSystemStrings.mise_au_cet_en_cours: "CET Placement in Progress",
          GbsSystemStrings.mise_au_cet_annee_en_cours:
              "CET Placement in Current Year",
          GbsSystemStrings.rachat_cet_en_cours: "CET Buyback in Progress",
          GbsSystemStrings.rachat_de_cet: "CET Buyback",
          GbsSystemStrings.prise_de_cet_en_cours: "CET Taken in Progress",
          GbsSystemStrings.prise_de_cet: "CET Taken",
          GbsSystemStrings.solde_de_cet: "CET Balance",
          GbsSystemStrings.str_motif: "Reason",
          GbsSystemStrings.str_type_jour: "Day Type",
          GbsSystemStrings.str_indisponibiliter_recurrentes:
              "Recurring Unavailabilities",
          GbsSystemStrings.str_dispo_definitive: "Definitive Availability",
          GbsSystemStrings.str_dispo_recurrente: "Recurring Availability",
          GbsSystemStrings.str_exclusions_propositions_vacation:
              "Excl/Propo of Vacation",
          GbsSystemStrings.str_disponibiliter_propositions_de_vacation:
              "Availability/Propo of Vacation",
          GbsSystemStrings.str_date_pro: "Professional Date",
          GbsSystemStrings.str_documents_officiel: "Official Documents",
          GbsSystemStrings.str_date_validiter: "Validity of",
          GbsSystemStrings.str_departement: "Department",
          GbsSystemStrings.str_numero_document: "Doc Number",
          GbsSystemStrings.str_diplome: "Diploma",
          GbsSystemStrings.str_agrement: "Approval",
          GbsSystemStrings.str_remplie_cases: "fill in the blanks",
          GbsSystemStrings.str_creer: "Create",
          GbsSystemStrings.str_depasser: "Exceeded",
          GbsSystemStrings.kRefuser: "Refuse",
          GbsSystemStrings.kDemander: "Request",
          GbsSystemStrings.kAccepter: "Accept",
          GbsSystemStrings.str_valider_le: "Validated On",
          GbsSystemStrings.str_date_obtention: "Date of Acquisition",
          GbsSystemStrings.str_documents_officiels: "Official Documents",
          GbsSystemStrings.str_diplomes: "Diplomas",
          GbsSystemStrings.str_agrements: "Approvals",
          GbsSystemStrings.str_habilitations: "Accreditations",
          GbsSystemStrings.str_notes_de_frais: "Expense Notes",
          GbsSystemStrings.str_changment_mot_de_passe: "Change Password",
          GbsSystemStrings.str_carte_proffisionel: "Professional Card",
          GbsSystemStrings.str_att_vos_devez_valider_docs:
              "Attention: You must validate your documents",
          GbsSystemStrings.str_definitif: "Final",
          GbsSystemStrings.str_are_you_sure_want_delete:
              "Are you sure you want to delete this item?",
          GbsSystemStrings.str_deleted_with_success: "Successfully deleted",
          GbsSystemStrings.str_exclu_definitive: "Definitive Exclusion",
          GbsSystemStrings.str_exclu_recurrente: "Recurrent Exclusion",
          GbsSystemStrings.str_list_preferences: "Preferences List",
          GbsSystemStrings.str_accepter_proposition: "Accept Proposal",
          GbsSystemStrings.svp_select_type: "please select a type",
          GbsSystemStrings.svp_ecrire_un_message: "please write a message",
          GbsSystemStrings.str_prise_de_service: "Service Price",
          GbsSystemStrings.str_ecrire_votre_message_ici:
              "write your message here",
          GbsSystemStrings.str_terminer: "finish",
          GbsSystemStrings.str_document: "document",
          GbsSystemStrings.str_documents_de_lentreprise: "Company Documents",
          GbsSystemStrings.str_planning_non_consulter: "Unconsulted Plans",
          GbsSystemStrings.str_valider_vos_documents: "validate your documents",
          GbsSystemStrings.str_proposer_le: "Proposed on",
          GbsSystemStrings.str_consulter: "Consult",
          GbsSystemStrings.str_publier: "Published",
          GbsSystemStrings.str_geolocaliser: "Geolocate",
          GbsSystemStrings.str_demander: "Requested",
          GbsSystemStrings.str_publier_le: "Published on",
          GbsSystemStrings.str_distance: "Distance",
          GbsSystemStrings.str_du: "of",
          GbsSystemStrings.str_charger: "load",
          GbsSystemStrings.str_demande_vacation: "Vacation Request",
          GbsSystemStrings.str_app_bar_select_item: "select an item",
          GbsSystemStrings.str_svp_add_date_debut_fin:
              "please add the start and end date",
          GbsSystemStrings.str_cloturer: "Closed",
          GbsSystemStrings.str_propositions: "Proposals",
          GbsSystemStrings.str_description: "Description",
          GbsSystemStrings.str_list_des_indisponibiliter:
              "List of Unavailabilities",
          GbsSystemStrings.str_commentaire_planificateur: "Planner Comment",
          GbsSystemStrings.str_commentaire_salarie: "Employee Comment",
          GbsSystemStrings.str_en_attente: "Pending",
          GbsSystemStrings.str_accepter: "Accepted",
          GbsSystemStrings.str_refuser: "Rejected",
          GbsSystemStrings.str_list_des_absences: "List of Absences",
          GbsSystemStrings.str_solde_des_absences: "Absence Balance",
          GbsSystemStrings.demander_solde_restant_a_prendre:
              "Remaining Balance to Take",
          GbsSystemStrings.demander_demande_en_cours: "Requests in Progress",
          GbsSystemStrings.demander_a_venir: "Upcoming",
          GbsSystemStrings.demander_pris: "Taken",
          GbsSystemStrings.demander_acquis: "Acquired",
          GbsSystemStrings.str_demande: "Request",
          GbsSystemStrings.str_piece_jointe: "Attachments",
          GbsSystemStrings.str_choisie_un_fichier: "Please choose a PDF file",
          GbsSystemStrings.str_aucune_fichier_choisie: "No file chosen",
          GbsSystemStrings.str_calculer: "Calculate",
          GbsSystemStrings.str_comment: "Comment",
          GbsSystemStrings.str_select_date: "Select a Date",
          GbsSystemStrings.str_disponibiliter: "Availability",
          GbsSystemStrings.str_indisponibiliter: "Unavailabilities",
          GbsSystemStrings.str_demande_indisponibiliter:
              "Unavailability Request",
          GbsSystemStrings.str_demande_absence: "Absence Request",
          GbsSystemStrings.str_options: "Options",
          GbsSystemStrings.str_messagerie: "Messaging",
          GbsSystemStrings.str_tenue: "Outfit",
          GbsSystemStrings.str_aucune_vacation_suiv: "no following vacation",
          GbsSystemStrings.str_aucune_vacation_prec: "no previous vacation",
          GbsSystemStrings.str_pointage_sortie_succes: "Check-out successful",
          GbsSystemStrings.str_location_denied:
              "you must accept the location permission",
          GbsSystemStrings.str_mal_tourner: "something went wrong",
          GbsSystemStrings.str_pointage_entrer_succes: "Check-in successful",
          GbsSystemStrings.str_debut: "start",
          GbsSystemStrings.str_fin: "end",
          GbsSystemStrings.str_aucune_vacation_trouver: "No vacation found",
          GbsSystemStrings.str_afficher: "Display",
          GbsSystemStrings.str_telecharger: "Download",
          GbsSystemStrings.str_publication: "Publication",
          GbsSystemStrings.str_telechargement: "Downloading",
          GbsSystemStrings.str_consultation: "Consultation",
          GbsSystemStrings.str_file_uploaded_with_success:
              "File downloaded successfully",
          GbsSystemStrings.str_agenda: "Agenda",
          GbsSystemStrings.str_prise_de_vacation: "Taking a vacation",
          GbsSystemStrings.str_qualification: "Qualification",
          GbsSystemStrings.str_pause: "Pause",
          GbsSystemStrings.str_duree: "Duration",
          GbsSystemStrings.str_plages_horaires: "Time Slots",
          GbsSystemStrings.str_aucune_vacation: "No vacation on server",
          GbsSystemStrings.str_documents: "Documents",
          GbsSystemStrings.str_info_salarie: "Employee Info",
          GbsSystemStrings.str_absence: "Absence",
          GbsSystemStrings.str_dispo_ponctuelle: "Point availability",
          GbsSystemStrings.str_exclu_ponctuelle: "Point exclusion",
          GbsSystemStrings.str_etat: "State",
          GbsSystemStrings.str_date_debut: "Start date",
          GbsSystemStrings.str_hour_debut: "Start time",
          GbsSystemStrings.str_date_fin: "End date",
          GbsSystemStrings.str_hour_fin: "End time",
          GbsSystemStrings.str_lieu: "Place",
          GbsSystemStrings.str_date_demande: "Request date",
          GbsSystemStrings.str_preferences: "Preferences",
          GbsSystemStrings.str_list_des_vacations: "List of vacations",
          GbsSystemStrings.str_prise_de_vacations: "Vacation taking",
          GbsSystemStrings.str_planning_du_mois: "Monthly Schedule",
          GbsSystemStrings.str_mois_de_selection: "Selection Month",
          GbsSystemStrings.str_empty_data: "There are no items",
          GbsSystemStrings.str_entrer: "Entry",
          GbsSystemStrings.str_sortie: "Exit",
          GbsSystemStrings.str_clotures_le: "Closed on",
          GbsSystemStrings.str_refuser_le: "Refused on",
          GbsSystemStrings.str_acceptation_le: "Accepted on",
          GbsSystemStrings.str_demande_absence_du: "Absence request from",
          GbsSystemStrings.str_au: "to",
          GbsSystemStrings.str_effectuee_le: "performed on",
          GbsSystemStrings.str_vacation: "Vacation",
          GbsSystemStrings.str_planning: "Planning",
          GbsSystemStrings.str_historique: "History",
          GbsSystemStrings.str_field_required: "required field",
          GbsSystemStrings.str_code_email: "Email Code",
          GbsSystemStrings.str_code_sms: "SMS Code",
          GbsSystemStrings.str_portable: "Mobile",
          GbsSystemStrings.str_precedent: "Previous",
          GbsSystemStrings.str_ville: "city",
          GbsSystemStrings.str_longitude: "longitude",
          GbsSystemStrings.str_latitude: "latitude",
          GbsSystemStrings.str_valider: "Validate",
          GbsSystemStrings.str_photo: "Photo",
          GbsSystemStrings.str_adresse: "address",
          GbsSystemStrings.str_telephone: "Phone",
          GbsSystemStrings.str_suivant: "Next",
          GbsSystemStrings.str_nom: "Name",
          GbsSystemStrings.str_prenom: "First Name",
          GbsSystemStrings.str_my_info: "My information",
          GbsSystemStrings.str_modifier: "Edit",
          GbsSystemStrings.str_home: "Home",
          GbsSystemStrings.str_afficher_historique: "Show history",
          GbsSystemStrings.str_bienvenue: "Welcome",
          GbsSystemStrings.vacation_proposer: "Proposed Vacation(s)",
          GbsSystemStrings.str_acceder_a_vos_informations:
              "Access your information",
          GbsSystemStrings.demander_vacation: "Request a vacation",
          GbsSystemStrings.str_fois_pour_activer_mode:
              "times to activate server save mode",
          GbsSystemStrings.str_error_no_connection_title:
              "Oops, no internet connection",
          GbsSystemStrings.str_error_connection_returned_title:
              "Connection restored!",
          GbsSystemStrings.str_error_server_title: "Oops, something went wrong",
          GbsSystemStrings.str_quitter: "Quit",
          GbsSystemStrings.str_appyier: "Type",
          GbsSystemStrings.str_fois_pour_quiter: "times to quit",
          GbsSystemStrings.str_refresh: "Refresh",
          GbsSystemStrings.str_password_changed:
              "Password changed successfully",
          GbsSystemStrings.str_mail_sended: "Mail sent successfully",
          GbsSystemStrings.boarding_1_subtitle:
              "Your partner in on-field information processing",
          GbsSystemStrings.boarding_2_subtitle:
              "At your service for more reliable management",
          GbsSystemStrings.boarding_3_title: "Real-time",
          GbsSystemStrings.boarding_3_subtitle:
              "Real-time information available to all your collaborators",
          GbsSystemStrings.boarding_4_subtitle:
              "Help us improve for better service",
          GbsSystemStrings.str_dialog_avertissement: "Warning",
          GbsSystemStrings.str_annuler: "Cancel",
          GbsSystemStrings.str_dialog_erreur: "Error",
          GbsSystemStrings.str_dialog_succes: "Success",
          GbsSystemStrings.str_dialog_info: "Info",
          GbsSystemStrings.str_mode_identification: "identification",
          GbsSystemStrings.str_mode_enregistrer_server: "save server",
          GbsSystemStrings.str_mode_enregistrer_server_active:
              "Server save mode is activated successfully",
          GbsSystemStrings.str_validat_svp_enter_site: "Please enter the site",
          GbsSystemStrings.str_validat_svp_enter_mail: "Please enter the email",
          GbsSystemStrings.str_validat_svp_enter_site_valide:
              "Please enter a valid site",
          GbsSystemStrings.str_site: "Site",
          GbsSystemStrings.str_validat_svp_enter_password:
              "Please enter the password",
          GbsSystemStrings.str_validat_password_length:
              "Password must contain at least 8 characters",
          GbsSystemStrings.str_email_required: "Email is required",
          GbsSystemStrings.str_enter_valid_email: "Enter a valid email",
          GbsSystemStrings.str_mail: "Email",
          GbsSystemStrings.str_password: "Password",
          GbsSystemStrings.str_password_required: "Password is required",
          GbsSystemStrings.str_password_contain_6_car:
              "Password must contain at least 6 caracters",
          GbsSystemStrings.str_mot_de_passe_oublier: "Forgot Password ?",
          GbsSystemStrings.str_change_password: "Change Password",
          GbsSystemStrings.str_ok: "ok",
          GbsSystemStrings.str_droits_reserved:
              "© BM Soft 2022 all rights reserved",
          GbsSystemStrings.str_changement_mot_passe: "Password change",
          GbsSystemStrings.str_old_password: "Old Password",
          GbsSystemStrings.str_new_password: "New Password",
          GbsSystemStrings.str_new_password_confirmation:
              "New Password Confirmation",
          GbsSystemStrings.str_reset_password: "Reset Password",
          GbsSystemStrings.str_validat_password_must_be_the_same:
              "The password must be the same",
        },
        "es": {
          GbsSystemStrings.str_session_experer_sso: "Sesión expirada",

          GbsSystemStrings.str_fermer: "cerca",

          GbsSystemStrings.str_operation_effectuer: "Operación completada",
          GbsSystemStrings.str_operation_non_autoriser:
              "Operación no autorizada",
          GbsSystemStrings.str_partager: "Compartir",

          GbsSystemStrings.str_actions_offline:
              "Datos pendientes de sincronización",
          GbsSystemStrings.str_question_actions_offline:
              "¿Desea sincronizar sus datos no guardados con el servidor?",
          GbsSystemStrings.str_non: "no",
          GbsSystemStrings.str_oui: "sí",

          GbsSystemStrings.str_code_entreprise: "Código de empresa",
          GbsSystemStrings.str_are_you_sure_want_change_entreprise:
              "¿Está seguro de que desea cambiar de agencia?",
          GbsSystemStrings.str_validat_svp_code_entreprise_invalid:
              "El código de empresa no es válido",
          GbsSystemStrings.str_validat_svp_enter_code_client:
              "Por favor, introduzca el código del cliente",
          GbsSystemStrings.str_new_version_available:
              "¡Nueva versión disponible!",
          GbsSystemStrings.str_new_version_desc:
              "Una nueva versión de la aplicación está disponible. Para disfrutar de las últimas funciones, actualice la aplicación haciendo clic en 'Actualizar'.",
          GbsSystemStrings.str_try_later: "Intentar más tarde",
          GbsSystemStrings.str_update_now: "Actualizar",

          GbsSystemStrings.str_device_dont_support_biometrics:
              "Su dispositivo no es compatible con la biometría.",

          GbsSystemStrings.str_auth_please_authentificate:
              "Por favor, autentíquese",

          GbsSystemStrings.str_auth_please_authentificate_to_proceed:
              "Por favor, autentíquese para continuar",

          GbsSystemStrings.str_auth_auth_success: "Autenticación exitosa",

          GbsSystemStrings.str_auth_auth_failed: "Autenticación fallida",

          GbsSystemStrings.str_auth_biometric_auth: "Autenticación biométrica",

          GbsSystemStrings.str_auth_auth_with_biometrics:
              "Autenticarse con biometría",

          GbsSystemStrings.str_auth_biometrics_not_available:
              "La autenticación biométrica no está disponible.",

          GbsSystemStrings.str_auth_start_auth: "Iniciar autenticación",

          GbsSystemStrings.str_proposition_s: "Propuesta(s)",

          GbsSystemStrings.str_nfc: "NFC",
          GbsSystemStrings.str_taille: "Tamaño",
          GbsSystemStrings.str_qte: "Cantidad",

          GbsSystemStrings.str_loading_map: "Cargando mapa",

          GbsSystemStrings.str_rendre: "Devolver",
          GbsSystemStrings.str_pas_rendre: "No devolver",

          GbsSystemStrings.str_demander_refuser: "Solicitar/Negar",
          GbsSystemStrings.str_proposition: "Propuesta",
          GbsSystemStrings.str_indisponibiliter_ponctuelle:
              "Indisponibilidad temporal",
          GbsSystemStrings.str_action_non_autoriser: "Acción no autorizada",
          GbsSystemStrings.str_code_pin_wrong: "El código PIN es incorrecto",
          GbsSystemStrings.str_nouvelle_connexion: "Nueva conexión",
          GbsSystemStrings.str_code_pin_oublier: "¿Olvidaste el código PIN?",
          GbsSystemStrings.str_enregistrer: "Guardar",
          GbsSystemStrings.str_enregistrement: "Guardando",
          GbsSystemStrings.str_enrigester_nv_code_pin:
              "Guardar un nuevo código PIN para continuar",
          GbsSystemStrings.str_entrer_code_pin_deja_enrigester:
              "Ingresa el código PIN que ya está guardado para continuar",
          GbsSystemStrings.str_verification: "Verificación",
          GbsSystemStrings.str_code_pin: "Código PIN",
          GbsSystemStrings.str_map: "Mapa",
          GbsSystemStrings.str_pointage_en_cours: "Registro en curso ...",
          GbsSystemStrings.str_operation_en_cours: "Operación en curso ...",
          GbsSystemStrings.str_details_vacation: "Detalles de Vacaciones",
          //time picker
          GbsSystemStrings.str_Select_Time: "Seleccionar Hora",
          GbsSystemStrings.str_hour: "hora",
          GbsSystemStrings.str_minute: "minuto",
          GbsSystemStrings.str_timePickerInputHint: "Ingrese la hora",
          //date picker
          GbsSystemStrings.str_selectDate: "Seleccionar Fecha",
          GbsSystemStrings.str_cancel: "Cancelar",
          GbsSystemStrings.str_done: "Hecho",
          GbsSystemStrings.str_prevMonth: "Mes Anterior",
          GbsSystemStrings.str_nextMonth: "Próximo Mes",
          GbsSystemStrings.str_prevYear: "Año Anterior",
          GbsSystemStrings.str_nextYear: "Próximo Año",
          GbsSystemStrings.str_datePickerInputHint: "Ingrese la fecha",
          GbsSystemStrings.str_datePickerHelpText: "Seleccionar Fecha",
          //calendar
          GbsSystemStrings.str_monday: "Lunes",
          GbsSystemStrings.str_tuesday: "Martes",
          //
          GbsSystemStrings.str_droits_reserved_part_2:
              "Todos los derechos reservados",
          GbsSystemStrings.str_connexion: "Conexión",
          GbsSystemStrings.str_ignorer: "Ignorar",
          GbsSystemStrings.str_waiting_for_tag: "Esperando la Etiqueta NFC",
          GbsSystemStrings.str_nfc_disabled:
              "El permiso de etiqueta NFC está desactivado, por favor habilite el permiso NFC e inténtelo de nuevo",
          GbsSystemStrings.str_please_turn_on_nfc_service:
              "Por favor, active el servicio NFC en su dispositivo",
          GbsSystemStrings.str_your_device_dont_support_nfc:
              "Su dispositivo no admite NFC",
          GbsSystemStrings.str_hold_your_device_near_the_nfc_tag:
              "Mantenga su dispositivo cerca de la etiqueta NFC",
          GbsSystemStrings.str_ready_to_scan: "Listo para escanear",
          GbsSystemStrings.str_deconnexion_question:
              "¿Quieres cerrar la sesión?",
          GbsSystemStrings.str_no_item: "No hay ningún elemento",

          GbsSystemStrings.str_filtrer: "Filtrar",
          GbsSystemStrings.str_detail_contact: "Detalle del Contrato",
          GbsSystemStrings.str_document_administratif:
              "Documento Administrativo",
          GbsSystemStrings.str_tous: "Todos",
          GbsSystemStrings.str_empty_pdf: "el PDF está vacío",
          GbsSystemStrings.str_nombre_des_telechargement: "Número de Descargas",
          GbsSystemStrings.str_creation: "Creación",
          GbsSystemStrings.str_entreprise: "Empresa",
          GbsSystemStrings.str_type_document: "Tipo de Documento",
          GbsSystemStrings.str_placement_cet: "Colocación de CET",
          GbsSystemStrings.str_rachat_cet: "Compra de CET",
          GbsSystemStrings.str_prise_de_jours_cet: "Días Tomados de CET",
          GbsSystemStrings.solde_des_jours_de_cet: "Saldo de Días de CET",
          GbsSystemStrings.str_nombre_des_jours: "Número de Días",
          GbsSystemStrings.mise_au_cet_en_cours: "Colocación de CET en Curso",
          GbsSystemStrings.mise_au_cet_annee_en_cours:
              "Colocación de CET en Año en Curso",
          GbsSystemStrings.rachat_cet_en_cours: "Compra de CET en Curso",
          GbsSystemStrings.rachat_de_cet: "Compra de CET",
          GbsSystemStrings.prise_de_cet_en_cours:
              "Días Tomados de CET en Curso",
          GbsSystemStrings.prise_de_cet: "Días Tomados de CET",
          GbsSystemStrings.solde_de_cet: "Saldo de CET",
          GbsSystemStrings.str_motif: "Motivo",
          GbsSystemStrings.str_type_jour: "Tipo de Día",
          GbsSystemStrings.str_indisponibiliter_recurrentes:
              "Indisponibilidades Recurrentes",
          GbsSystemStrings.str_dispo_definitive: "Disponibilidad Definitiva",
          GbsSystemStrings.str_dispo_recurrente: "Disponibilidad Recurrente",
          GbsSystemStrings.str_exclusions_propositions_vacation:
              "Exclusión/Propuesta de Vacaciones",
          GbsSystemStrings.str_disponibiliter_propositions_de_vacation:
              "Disponibilidad/Propuesta de Vacaciones",
          GbsSystemStrings.str_date_pro: "Fecha Profesional",
          GbsSystemStrings.str_documents_officiel: "Documentos Oficiales",
          GbsSystemStrings.str_date_validiter: "Validez de",
          GbsSystemStrings.str_departement: "Departamento",
          GbsSystemStrings.str_numero_document: "Núm. Doc.",
          GbsSystemStrings.str_diplome: "Diploma",
          GbsSystemStrings.str_agrement: "Aprobación",
          GbsSystemStrings.str_remplie_cases: "rellene los espacios",
          GbsSystemStrings.str_creer: "Crear",
          GbsSystemStrings.str_depasser: "Superado",
          GbsSystemStrings.kRefuser: "Rechazar",
          GbsSystemStrings.kDemander: "Solicitar",
          GbsSystemStrings.kAccepter: "Aceptar",
          GbsSystemStrings.str_valider_le: "Validado el",
          GbsSystemStrings.str_date_obtention: "Fecha de Obtención",
          GbsSystemStrings.str_documents_officiels: "Documentos Oficiales",
          GbsSystemStrings.str_diplomes: "Diplomas",
          GbsSystemStrings.str_agrements: "Aprobaciones",
          GbsSystemStrings.str_habilitations: "Habilitaciones",
          GbsSystemStrings.str_notes_de_frais: "Notas de Gastos",
          GbsSystemStrings.str_changment_mot_de_passe: "Cambio de Contraseña",
          GbsSystemStrings.str_carte_proffisionel: "Tarjeta Profesional",
          GbsSystemStrings.str_att_vos_devez_valider_docs:
              "Atención: Debe validar sus documentos",
          GbsSystemStrings.str_definitif: "Definitivo",
          GbsSystemStrings.str_are_you_sure_want_delete:
              "¿Está seguro de que desea eliminar este elemento?",
          GbsSystemStrings.str_deleted_with_success: "Eliminado con éxito",
          GbsSystemStrings.str_exclu_definitive: "Exclusión Definitiva",
          GbsSystemStrings.str_exclu_recurrente: "Exclusión Recurrente",
          GbsSystemStrings.str_list_preferences: "Lista de Preferencias",
          GbsSystemStrings.str_accepter_proposition: "Aceptar Propuesta",
          GbsSystemStrings.svp_select_type: "seleccione un tipo por favor",
          GbsSystemStrings.svp_ecrire_un_message:
              "escriba un mensaje por favor",
          GbsSystemStrings.str_prise_de_service: "Precio del Servicio",
          GbsSystemStrings.str_ecrire_votre_message_ici:
              "escriba su mensaje aquí",
          GbsSystemStrings.str_terminer: "terminar",
          GbsSystemStrings.str_document: "documento",
          GbsSystemStrings.str_documents_de_lentreprise:
              "Documentos de la Empresa",
          GbsSystemStrings.str_planning_non_consulter:
              "Planificaciones no Consultadas",
          GbsSystemStrings.str_valider_vos_documents: "valide sus documentos",
          GbsSystemStrings.str_proposer_le: "Propuesto el",
          GbsSystemStrings.str_consulter: "Consultar",
          GbsSystemStrings.str_publier: "Publicado",
          GbsSystemStrings.str_geolocaliser: "Geolocalizar",
          GbsSystemStrings.str_demander: "Solicitado",
          GbsSystemStrings.str_publier_le: "Publicado el",
          GbsSystemStrings.str_distance: "Distancia",
          GbsSystemStrings.str_du: "de",
          GbsSystemStrings.str_charger: "cargar",
          GbsSystemStrings.str_demande_vacation: "Solicitud de Vacaciones",
          GbsSystemStrings.str_app_bar_select_item: "seleccionar un elemento",
          GbsSystemStrings.str_svp_add_date_debut_fin:
              "por favor agregar la fecha de inicio y fin",
          GbsSystemStrings.str_cloturer: "Cerrado",
          GbsSystemStrings.str_propositions: "Propuestas",
          GbsSystemStrings.str_description: "Descripción",
          GbsSystemStrings.str_list_des_indisponibiliter:
              "Lista de Indisponibilidades",
          GbsSystemStrings.str_commentaire_planificateur:
              "Comentario del planificador",
          GbsSystemStrings.str_commentaire_salarie: "Comentario del empleado",
          GbsSystemStrings.str_en_attente: "Pendiente",
          GbsSystemStrings.str_accepter: "Aceptado",
          GbsSystemStrings.str_refuser: "Rechazado",
          GbsSystemStrings.str_list_des_absences: "Lista de ausencias",
          GbsSystemStrings.str_solde_des_absences: "Balance de ausencias",
          GbsSystemStrings.demander_solde_restant_a_prendre:
              "Saldo restante para tomar",
          GbsSystemStrings.demander_demande_en_cours: "Solicitudes en progreso",
          GbsSystemStrings.demander_a_venir: "Próximo",
          GbsSystemStrings.demander_pris: "Tomado",
          GbsSystemStrings.demander_acquis: "Adquirido",
          GbsSystemStrings.str_demande: "Solicitud",
          GbsSystemStrings.str_piece_jointe: "Archivos adjuntos",
          GbsSystemStrings.str_choisie_un_fichier: "Seleccione un archivo PDF",
          GbsSystemStrings.str_aucune_fichier_choisie:
              "Ningún archivo seleccionado",
          GbsSystemStrings.str_calculer: "Calcular",
          GbsSystemStrings.str_comment: "Comentario",
          GbsSystemStrings.str_select_date: "Seleccionar una fecha",
          GbsSystemStrings.str_disponibiliter: "Disponibilidad",
          GbsSystemStrings.str_indisponibiliter: "Indisponibilidades",
          GbsSystemStrings.str_demande_indisponibiliter:
              "Solicitud de indisponibilidad",
          GbsSystemStrings.str_demande_absence: "Solicitud de ausencia",
          GbsSystemStrings.str_options: "Opciones",
          GbsSystemStrings.str_messagerie: "Mensajería",
          GbsSystemStrings.str_tenue: "Atuendo",

          GbsSystemStrings.str_aucune_vacation_suiv:
              "no hay ningún turno siguiente",
          GbsSystemStrings.str_aucune_vacation_prec: "no hay turno anterior",
          GbsSystemStrings.str_pointage_sortie_succes:
              "Marca de salida exitosa",
          GbsSystemStrings.str_location_denied:
              "debes aceptar el permiso de ubicación",
          GbsSystemStrings.str_mal_tourner: "algo salió mal",
          GbsSystemStrings.str_pointage_entrer_succes:
              "Marca de entrada exitosa",
          GbsSystemStrings.str_debut: "inicio",
          GbsSystemStrings.str_fin: "fin",

          GbsSystemStrings.str_aucune_vacation_trouver:
              "No se encontraron vacaciones",
          GbsSystemStrings.str_afficher: "Mostrar",
          GbsSystemStrings.str_telecharger: "Descargar",
          GbsSystemStrings.str_publication: "Publicación",
          GbsSystemStrings.str_telechargement: "Descarga",
          GbsSystemStrings.str_consultation: "Consulta",
          GbsSystemStrings.str_file_uploaded_with_success:
              "Archivo descargado exitosamente",
          GbsSystemStrings.str_agenda: "Agenda",
          GbsSystemStrings.str_prise_de_vacation: "Toma de vacaciones",
          GbsSystemStrings.str_qualification: "Calificación",
          GbsSystemStrings.str_pause: "Pausa",
          GbsSystemStrings.str_duree: "Duración",
          GbsSystemStrings.str_plages_horaires: "Franjas horarias",
          GbsSystemStrings.str_aucune_vacation:
              "No hay vacaciones en el servidor",
          GbsSystemStrings.str_documents: "Documentos",
          GbsSystemStrings.str_info_salarie: "Información del empleado",
          GbsSystemStrings.str_absence: "Ausencia",
          GbsSystemStrings.str_dispo_ponctuelle: "Disponibilidad puntual",
          GbsSystemStrings.str_exclu_ponctuelle: "Exclusión puntual",
          GbsSystemStrings.str_etat: "Estado",
          GbsSystemStrings.str_date_debut: "Fecha de inicio",
          GbsSystemStrings.str_hour_debut: "Hora de inicio",
          GbsSystemStrings.str_date_fin: "Fecha de finalización",
          GbsSystemStrings.str_hour_fin: "Hora de finalización",
          GbsSystemStrings.str_lieu: "Lugar",
          GbsSystemStrings.str_date_demande: "Fecha de solicitud",
          GbsSystemStrings.str_preferences: "Preferencias",
          GbsSystemStrings.str_list_des_vacations: "Lista de vacaciones",
          GbsSystemStrings.str_prise_de_vacations: "Toma de vacaciones",
          GbsSystemStrings.str_planning_du_mois: "Planificación del mes",
          GbsSystemStrings.str_mois_de_selection: "Mes seleccionado",
          GbsSystemStrings.str_empty_data: "No hay ningún elemento",
          GbsSystemStrings.str_entrer: "Entrada",
          GbsSystemStrings.str_sortie: "Salida",
          GbsSystemStrings.str_clotures_le: "Cerrado el",
          GbsSystemStrings.str_refuser_le: "Rechazado el",
          GbsSystemStrings.str_acceptation_le: "Aceptado el",
          GbsSystemStrings.str_demande_absence_du: "Solicitud de ausencia del",
          GbsSystemStrings.str_au: "al",
          GbsSystemStrings.str_effectuee_le: "realizada el",
          GbsSystemStrings.str_vacation: "Vacaciones",
          GbsSystemStrings.str_planning: "Planificación",
          GbsSystemStrings.str_historique: "Historial",

          GbsSystemStrings.str_field_required: "Campo obligatorio",
          GbsSystemStrings.str_code_email: "Código de correo electrónico",
          GbsSystemStrings.str_code_sms: "Código SMS",
          GbsSystemStrings.str_portable: "Portátil",
          GbsSystemStrings.str_precedent: "Anterior",
          GbsSystemStrings.str_ville: "ciudad",
          GbsSystemStrings.str_longitude: "longitud",
          GbsSystemStrings.str_latitude: "latitud",
          GbsSystemStrings.str_valider: "Validar",
          GbsSystemStrings.str_photo: "Foto",
          GbsSystemStrings.str_adresse: "dirección",
          GbsSystemStrings.str_telephone: "Teléfono",
          GbsSystemStrings.str_suivant: "Siguiente",
          GbsSystemStrings.str_nom: "apellido",
          GbsSystemStrings.str_prenom: "nombre de pila",
          GbsSystemStrings.str_my_info: "mi información",
          GbsSystemStrings.str_modifier: "Medificar",
          ////

          GbsSystemStrings.str_home: "Inicio",
          GbsSystemStrings.str_afficher_historique: "Mostrar historial",
          GbsSystemStrings.str_bienvenue: "Bienvenido",
          GbsSystemStrings.vacation_proposer: "Vacaciones propuestas",
          GbsSystemStrings.str_acceder_a_vos_informations:
              "Acceder a su información",
          GbsSystemStrings.demander_vacation: "Solicitar una vacación",
          GbsSystemStrings.str_fois_pour_activer_mode:
              "veces para activar el modo de guardado del servidor",
          GbsSystemStrings.str_error_no_connection_title:
              "¡Oops, no hay conexión a internet!",
          GbsSystemStrings.str_error_connection_returned_title:
              "¡Conexión restablecida!",
          GbsSystemStrings.str_error_server_title: "¡Ups, algo salió mal!",
          GbsSystemStrings.str_quitter: "Salir",
          GbsSystemStrings.str_appyier: "Escribir",
          GbsSystemStrings.str_fois_pour_quiter: "veces para salir",
          GbsSystemStrings.str_refresh: "Refrescar",
          GbsSystemStrings.str_password_changed:
              "Contraseña cambiada con éxito",
          GbsSystemStrings.str_mail_sended: "Correo enviado con éxito",
          GbsSystemStrings.boarding_1_subtitle:
              "Su socio en el procesamiento de información en el campo",
          GbsSystemStrings.boarding_2_subtitle:
              "A su servicio para una gestión más confiable",
          GbsSystemStrings.boarding_3_title: "Tiempo real",
          GbsSystemStrings.boarding_3_subtitle:
              "Información disponible en tiempo real para todos sus colaboradores",
          GbsSystemStrings.boarding_4_subtitle:
              "Ayúdenos a mejorar para un mejor servicio",
          GbsSystemStrings.str_dialog_avertissement: "Advertencia",
          GbsSystemStrings.str_annuler: "Cancelar",
          GbsSystemStrings.str_dialog_erreur: "Error",
          GbsSystemStrings.str_dialog_succes: "Éxito",
          GbsSystemStrings.str_dialog_info: "Información",
          GbsSystemStrings.str_mode_identification: "identificación",
          GbsSystemStrings.str_mode_enregistrer_server: "guardar servidor",
          GbsSystemStrings.str_mode_enregistrer_server_active:
              "El modo de guardar en el servidor se ha activado correctamente",
          GbsSystemStrings.str_validat_svp_enter_site:
              "Por favor, ingrese el sitio",
          GbsSystemStrings.str_validat_svp_enter_mail:
              "Por favor, ingrese el correo electrónico",
          GbsSystemStrings.str_validat_svp_enter_site_valide:
              "Por favor, ingrese un sitio válido",
          GbsSystemStrings.str_site: "Sitio",
          GbsSystemStrings.str_validat_svp_enter_password:
              "Por favor, ingrese la contraseña",
          GbsSystemStrings.str_validat_password_length:
              "La contraseña debe tener al menos 8 caracteres",
          GbsSystemStrings.str_email_required:
              "correo electronico es requerido",
          GbsSystemStrings.str_enter_valid_email:
              "Introduzca un correo electrónico válido",
          GbsSystemStrings.str_mail: "Correo electrónico",
          GbsSystemStrings.str_password: "Contraseña",
          GbsSystemStrings.str_password_required: "se requiere contraseña",
          GbsSystemStrings.str_password_contain_6_car:
              "La contraseña debe contener al menos 6 caracteres",
          GbsSystemStrings.str_mot_de_passe_oublier:
              "Has olvidado tu contraseña ?",
          GbsSystemStrings.str_change_password: "Cambiar la contraseña",
          GbsSystemStrings.str_ok: "ok",
          GbsSystemStrings.str_droits_reserved:
              "© BM Soft 2022 reservados todos los derechos",
          GbsSystemStrings.str_changement_mot_passe: "Cambio de contraseña",
          GbsSystemStrings.str_old_password: "Contraseña anterior",
          GbsSystemStrings.str_new_password: "Nueva contraseña",
          GbsSystemStrings.str_new_password_confirmation:
              "Nueva confirmación de contraseña",
          GbsSystemStrings.str_reset_password: "Restablecer la contraseña",
          GbsSystemStrings.str_validat_password_must_be_the_same:
              "La contraseña debe ser la misma",
        },
        "el": {
          GbsSystemStrings.str_session_experer_sso: "Η συνεδρία έληξε",

          GbsSystemStrings.str_fermer: "κοντά",

          GbsSystemStrings.str_operation_effectuer: "Η λειτουργία ολοκληρώθηκε",
          GbsSystemStrings.str_operation_non_autoriser:
              "Η λειτουργία δεν έχει εξουσιοδοτηθεί",
          GbsSystemStrings.str_partager: "Κοινή χρήση",

          GbsSystemStrings.str_actions_offline:
              "Δεδομένα σε εκκρεμότητα για συγχρονισμό",
          GbsSystemStrings.str_question_actions_offline:
              "Θέλετε να συγχρονίσετε τα μη αποθηκευμένα δεδομένα σας με τον διακομιστή;",
          GbsSystemStrings.str_non: "όχι",
          GbsSystemStrings.str_oui: "ναι",

          GbsSystemStrings.str_code_entreprise: "Κωδικός εταιρείας",
          GbsSystemStrings.str_are_you_sure_want_change_entreprise:
              "Είστε σίγουροι ότι θέλετε να αλλάξετε πρακτορείο;",
          GbsSystemStrings.str_validat_svp_code_entreprise_invalid:
              "Ο κωδικός εταιρείας δεν είναι έγκυρος",
          GbsSystemStrings.str_validat_svp_enter_code_client:
              "Παρακαλώ εισάγετε τον κωδικό πελάτη",
          GbsSystemStrings.str_new_version_available: "Νέα έκδοση διαθέσιμη!",
          GbsSystemStrings.str_new_version_desc:
              "Μια νέα έκδοση της εφαρμογής είναι διαθέσιμη. Για να απολαύσετε τις τελευταίες λειτουργίες, ενημερώστε την εφαρμογή κάνοντας κλικ στο 'Ενημέρωση'.",
          GbsSystemStrings.str_try_later: "Δοκιμάστε αργότερα",
          GbsSystemStrings.str_update_now: "Ενημέρωση",

          GbsSystemStrings.str_device_dont_support_biometrics:
              "Η συσκευή σας δεν υποστηρίζει βιομετρικά δεδομένα.",

          GbsSystemStrings.str_auth_please_authentificate:
              "Παρακαλώ συνδεθείτε",

          GbsSystemStrings.str_auth_please_authentificate_to_proceed:
              "Παρακαλώ συνδεθείτε για να συνεχίσετε",

          GbsSystemStrings.str_auth_auth_success: "Επιτυχής αυθεντικοποίηση",

          GbsSystemStrings.str_auth_auth_failed: "Αυθεντικοποίηση απέτυχε",

          GbsSystemStrings.str_auth_biometric_auth:
              "Βιομετρική αυθεντικοποίηση",

          GbsSystemStrings.str_auth_auth_with_biometrics:
              "Αυθεντικοποίηση με βιομετρικά δεδομένα",

          GbsSystemStrings.str_auth_biometrics_not_available:
              "Η βιομετρική αυθεντικοποίηση δεν είναι διαθέσιμη.",

          GbsSystemStrings.str_auth_start_auth: "Έναρξη αυθεντικοποίησης",

          GbsSystemStrings.str_proposition_s: "Πρόταση(εις)",

          GbsSystemStrings.str_nfc: "NFC",
          GbsSystemStrings.str_taille: "Μέγεθος",
          GbsSystemStrings.str_qte: "Ποσότητα",

          GbsSystemStrings.str_loading_map: "Φόρτωση χάρτη",

          GbsSystemStrings.str_rendre: "Επιστροφή",
          GbsSystemStrings.str_pas_rendre: "Δεν είναι προς επιστροφή",

          GbsSystemStrings.str_demander_refuser: "Αίτηση/Απόρριψη",
          GbsSystemStrings.str_proposition: "Πρόταση",
          GbsSystemStrings.str_indisponibiliter_ponctuelle:
              "Προσωρινή μη διαθεσιμότητα",
          GbsSystemStrings.str_action_non_autoriser:
              "Μη εξουσιοδοτημένη ενέργεια",
          GbsSystemStrings.str_code_pin_wrong:
              "Ο κωδικός PIN είναι λανθασμένος",
          GbsSystemStrings.str_nouvelle_connexion: "Νέα σύνδεση",
          GbsSystemStrings.str_code_pin_oublier: "Ξεχάσατε τον κωδικό PIN;",
          GbsSystemStrings.str_enregistrer: "Αποθήκευση",
          GbsSystemStrings.str_enregistrement: "Αποθήκευση",
          GbsSystemStrings.str_enrigester_nv_code_pin:
              "Αποθηκεύστε έναν νέο κωδικό PIN για να συνεχίσετε",
          GbsSystemStrings.str_entrer_code_pin_deja_enrigester:
              "Εισάγετε τον ήδη αποθηκευμένο κωδικό PIN για να συνεχίσετε",
          GbsSystemStrings.str_verification: "Επαλήθευση",
          GbsSystemStrings.str_code_pin: "Κωδικός PIN",
          GbsSystemStrings.str_map: "Χάρτης",
          GbsSystemStrings.str_pointage_en_cours: "Καταμέτρηση σε εξέλιξη ...",
          GbsSystemStrings.str_operation_en_cours: "Ενέργεια σε εξέλιξη ...",
          GbsSystemStrings.str_details_vacation: "Λεπτομέρειες Διακοπών",
          //time picker
          GbsSystemStrings.str_Select_Time: "Επιλέξτε Ώρα",
          GbsSystemStrings.str_hour: "ώρα",
          GbsSystemStrings.str_minute: "λεπτό",
          GbsSystemStrings.str_timePickerInputHint: "Εισαγωγή Ώρας",
          //date picker
          GbsSystemStrings.str_selectDate: "Επιλογή Ημερομηνίας",
          GbsSystemStrings.str_cancel: "Ακύρωση",
          GbsSystemStrings.str_done: "Ολοκλήρωση",
          GbsSystemStrings.str_prevMonth: "Προηγούμενος Μήνας",
          GbsSystemStrings.str_nextMonth: "Επόμενος Μήνας",
          GbsSystemStrings.str_prevYear: "Προηγούμενος Χρόνος",
          GbsSystemStrings.str_nextYear: "Επόμενος Χρόνος",
          GbsSystemStrings.str_datePickerInputHint: "Εισαγωγή Ημερομηνίας",
          GbsSystemStrings.str_datePickerHelpText: "Επιλογή Ημερομηνίας",
          //calendar
          GbsSystemStrings.str_monday: "Δευτέρα",
          GbsSystemStrings.str_tuesday: "Τρίτη",
          //
          GbsSystemStrings.str_droits_reserved_part_2:
              "Με επιφύλαξη παντός δικαιώματος",
          GbsSystemStrings.str_connexion: "Σύνδεση",
          GbsSystemStrings.str_ignorer: "Παράβλεψη",
          GbsSystemStrings.str_waiting_for_tag: "Αναμονή για ετικέτα NFC",
          GbsSystemStrings.str_nfc_disabled:
              "Η άδεια ετικέτας NFC είναι απενεργοποιημένη, ενεργοποιήστε την άδεια NFC και προσπαθήστε ξανά",
          GbsSystemStrings.str_please_turn_on_nfc_service:
              "Παρακαλώ ενεργοποιήστε την υπηρεσία NFC στη συσκευή σας",
          GbsSystemStrings.str_your_device_dont_support_nfc:
              "Η συσκευή σας δεν υποστηρίζει NFC",
          GbsSystemStrings.str_hold_your_device_near_the_nfc_tag:
              "Κρατήστε τη συσκευή σας κοντά στην ετικέτα NFC",
          GbsSystemStrings.str_ready_to_scan: "Έτοιμο για σάρωση",
          GbsSystemStrings.str_deconnexion_question: "Θέλετε να αποσυνδεθείτε;",
          GbsSystemStrings.str_no_item: "Δεν υπάρχει στοιχείο",

          GbsSystemStrings.str_filtrer: "Φιλτράρισμα",
          GbsSystemStrings.str_detail_contact: "Λεπτομέρειες Σύμβασης",
          GbsSystemStrings.str_document_administratif: "Διοικητικό Έγγραφο",
          GbsSystemStrings.str_tous: "Όλα",
          GbsSystemStrings.str_empty_pdf: "το PDF είναι κενό",
          GbsSystemStrings.str_nombre_des_telechargement: "Αριθμός Λήψεων",
          GbsSystemStrings.str_creation: "Δημιουργία",
          GbsSystemStrings.str_entreprise: "Επιχείρηση",
          GbsSystemStrings.str_type_document: "Τύπος Εγγράφου",
          GbsSystemStrings.str_placement_cet: "Τοποθέτηση CET",
          GbsSystemStrings.str_rachat_cet: "Εξαγορά CET",
          GbsSystemStrings.str_prise_de_jours_cet: "Λήψη Ημερών CET",
          GbsSystemStrings.solde_des_jours_de_cet: "Υπόλοιπο Ημερών CET",
          GbsSystemStrings.str_nombre_des_jours: "Αριθμός Ημερών",
          GbsSystemStrings.mise_au_cet_en_cours: "Τρέχουσα Τοποθέτηση CET",
          GbsSystemStrings.mise_au_cet_annee_en_cours:
              "Τοποθέτηση CET έτους σε εξέλιξη",
          GbsSystemStrings.rachat_cet_en_cours: "Εξαγορά CET σε εξέλιξη",
          GbsSystemStrings.rachat_de_cet: "Εξαγορά CET",
          GbsSystemStrings.prise_de_cet_en_cours: "Λήψη CET σε εξέλιξη",
          GbsSystemStrings.prise_de_cet: "Λήψη CET",
          GbsSystemStrings.solde_de_cet: "Υπόλοιπο CET",
          GbsSystemStrings.str_motif: "Αιτία",
          GbsSystemStrings.str_type_jour: "Τύπος Ημέρας",
          GbsSystemStrings.str_indisponibiliter_recurrentes:
              "Επαναλαμβανόμενη Μη Διαθεσιμότητα",
          GbsSystemStrings.str_dispo_definitive: "Οριστική Διαθεσιμότητα",
          GbsSystemStrings.str_dispo_recurrente:
              "Επαναλαμβανόμενη Διαθεσιμότητα",
          GbsSystemStrings.str_exclusions_propositions_vacation:
              "Αποκλεισμός/Πρόταση Διακοπών",
          GbsSystemStrings.str_disponibiliter_propositions_de_vacation:
              "Διαθεσιμότητα/Πρόταση Διακοπών",
          GbsSystemStrings.str_date_pro: "Ημερομηνία Επαγγελματική",
          GbsSystemStrings.str_documents_officiel: "Επίσημα Έγγραφα",
          GbsSystemStrings.str_date_validiter: "Εγκυρότητα του",
          GbsSystemStrings.str_departement: "Τμήμα",
          GbsSystemStrings.str_numero_document: "Αριθμός Εγγράφου",
          GbsSystemStrings.str_diplome: "Δίπλωμα",
          GbsSystemStrings.str_agrement: "Έγκριση",
          GbsSystemStrings.str_remplie_cases: "συμπληρώνει τα κενά",
          GbsSystemStrings.str_creer: "Δημιουργία",
          GbsSystemStrings.str_depasser: "Υπερβεβλημένο",
          GbsSystemStrings.kRefuser: "Απόρριψη",
          GbsSystemStrings.kDemander: "Αίτηση",
          GbsSystemStrings.kAccepter: "Αποδοχή",
          GbsSystemStrings.str_valider_le: "Επικυρώθηκε Στις",
          GbsSystemStrings.str_date_obtention: "Ημερομηνία Λήψης",
          GbsSystemStrings.str_documents_officiels: "Επίσημα Έγγραφα",
          GbsSystemStrings.str_diplomes: "Διπλώματα",
          GbsSystemStrings.str_agrements: "Έγκριση",
          GbsSystemStrings.str_habilitations: "Εξουσιοδοτήσεις",
          GbsSystemStrings.str_notes_de_frais: "Λειτουργικά Έξοδα",
          GbsSystemStrings.str_changment_mot_de_passe:
              "Αλλαγή Κωδικού Πρόσβασης",
          GbsSystemStrings.str_carte_proffisionel: "Επαγγελματική Κάρτα",
          GbsSystemStrings.str_att_vos_devez_valider_docs:
              "Προσοχή: Πρέπει να επικυρώσετε τα έγγραφά σας",
          GbsSystemStrings.str_definitif: "Τελικό",
          GbsSystemStrings.str_are_you_sure_want_delete:
              "Είστε σίγουρος ότι θέλετε να διαγράψετε αυτό το στοιχείο;",
          GbsSystemStrings.str_deleted_with_success: "Διαγράφηκε με επιτυχία",
          GbsSystemStrings.str_exclu_definitive: "Τελική Αποκλεισμός",
          GbsSystemStrings.str_exclu_recurrente: "Επαναλαμβανόμενη Αποκλεισμός",
          GbsSystemStrings.str_list_preferences: "Λίστα Προτιμήσεων",
          GbsSystemStrings.str_accepter_proposition: "Αποδοχή Πρότασης",
          GbsSystemStrings.svp_select_type: "παρακαλώ επιλέξτε έναν τύπο",
          GbsSystemStrings.svp_ecrire_un_message: "παρακαλώ γράψτε ένα μήνυμα",
          GbsSystemStrings.str_prise_de_service: "Κόστος Υπηρεσίας",
          GbsSystemStrings.str_ecrire_votre_message_ici:
              "γράψτε το μήνυμά σας εδώ",
          GbsSystemStrings.str_terminer: "τέλος",
          GbsSystemStrings.str_document: "έγγραφο",
          GbsSystemStrings.str_documents_de_lentreprise: "Έγγραφα Επιχείρησης",
          GbsSystemStrings.str_planning_non_consulter:
              "Μη Ελεγχθείσες Προγραμματισμοί",
          GbsSystemStrings.str_valider_vos_documents:
              "επικυρώστε τα έγγραφά σας",
          GbsSystemStrings.str_proposer_le: "Προτάθηκε στις",
          GbsSystemStrings.str_consulter: "Διαβάστε",
          GbsSystemStrings.str_publier: "Δημοσιεύτηκε",
          GbsSystemStrings.str_geolocaliser: "Γεωτοποθέτηση",
          GbsSystemStrings.str_demander: "Ζητήθηκε",
          GbsSystemStrings.str_publier_le: "Δημοσιεύτηκε στις",
          GbsSystemStrings.str_distance: "Απόσταση",
          GbsSystemStrings.str_du: "του",
          GbsSystemStrings.str_charger: "φορτώνω",
          GbsSystemStrings.str_demande_vacation: "Αίτηση Άδειας",
          GbsSystemStrings.str_app_bar_select_item: "επιλέξτε ένα στοιχείο",
          GbsSystemStrings.str_svp_add_date_debut_fin:
              "παρακαλώ προσθέστε την ημερομηνία έναρξης και λήξης",
          GbsSystemStrings.str_cloturer: "Κλειστό",
          GbsSystemStrings.str_propositions: "Προτάσεις",
          GbsSystemStrings.str_description: "Περιγραφή",
          GbsSystemStrings.str_list_des_indisponibiliter:
              "Λίστα Μη Διαθεσιμοτήτων",
          GbsSystemStrings.str_commentaire_planificateur: "Σχόλιο Σχεδιαστή",
          GbsSystemStrings.str_commentaire_salarie: "Σχόλιο Υπαλλήλου",
          GbsSystemStrings.str_en_attente: "Σε Αναμονή",
          GbsSystemStrings.str_accepter: "Αποδεκτό",
          GbsSystemStrings.str_refuser: "Απορρίφθηκε",
          GbsSystemStrings.str_list_des_absences: "Λίστα Απουσιών",
          GbsSystemStrings.str_solde_des_absences: "Υπόλοιπο Απουσιών",
          GbsSystemStrings.demander_solde_restant_a_prendre:
              "Υπόλοιπο προς Πήριμο",
          GbsSystemStrings.demander_demande_en_cours: "Αιτήσεις σε Εξέλιξη",
          GbsSystemStrings.demander_a_venir: "Προσεχώς",
          GbsSystemStrings.demander_pris: "Παραληφθέντα",
          GbsSystemStrings.demander_acquis: "Κερδισμένα",
          GbsSystemStrings.str_demande: "Αίτηση",
          GbsSystemStrings.str_piece_jointe: "Συνημμένα",
          GbsSystemStrings.str_choisie_un_fichier:
              "Παρακαλούμε επιλέξτε ένα αρχείο PDF",
          GbsSystemStrings.str_aucune_fichier_choisie: "Δεν επιλέχθηκε αρχείο",
          GbsSystemStrings.str_calculer: "Υπολογισμός",
          GbsSystemStrings.str_comment: "Σχόλιο",
          GbsSystemStrings.str_select_date: "Επιλογή ημερομηνίας",
          GbsSystemStrings.str_disponibiliter: "Διαθεσιμότητα",
          GbsSystemStrings.str_indisponibiliter: "Μη διαθεσιμότητες",
          GbsSystemStrings.str_demande_indisponibiliter:
              "Αίτηση μη διαθεσιμότητας",
          GbsSystemStrings.str_demande_absence: "Αίτηση απουσίας",
          GbsSystemStrings.str_options: "Επιλογές",
          GbsSystemStrings.str_messagerie: "Μηνύματα",
          GbsSystemStrings.str_tenue: "Ενδυμασία",

          GbsSystemStrings.str_aucune_vacation_suiv:
              "δεν υπάρχει επόμενη βάρδια",
          GbsSystemStrings.str_aucune_vacation_prec:
              "δεν υπάρχει προηγούμενη βάρδια",
          GbsSystemStrings.str_pointage_sortie_succes: "Επιτυχής αποχώρηση",
          GbsSystemStrings.str_location_denied:
              "πρέπει να αποδεχτείτε την άδεια τοποθεσίας",
          GbsSystemStrings.str_mal_tourner: "κάτι πήγε στραβά",
          GbsSystemStrings.str_pointage_entrer_succes: "Επιτυχής είσοδος",
          GbsSystemStrings.str_debut: "αρχή",
          GbsSystemStrings.str_fin: "τέλος",

          GbsSystemStrings.str_aucune_vacation_trouver:
              "Δεν βρέθηκε καμία άδεια",
          GbsSystemStrings.str_afficher: "Εμφάνιση",
          GbsSystemStrings.str_telecharger: "Λήψη",
          GbsSystemStrings.str_publication: "Δημοσίευση",
          GbsSystemStrings.str_telechargement: "Λήψη",
          GbsSystemStrings.str_consultation: "Συμβουλή",
          GbsSystemStrings.str_file_uploaded_with_success:
              "Επιτυχής λήψη αρχείου",
          GbsSystemStrings.str_agenda: "Ημερολόγιο",
          GbsSystemStrings.str_prise_de_vacation: "Άδεια",
          GbsSystemStrings.str_qualification: "Προσόν",
          GbsSystemStrings.str_pause: "Διάλειμμα",
          GbsSystemStrings.str_duree: "Διάρκεια",
          GbsSystemStrings.str_plages_horaires: "Ωράριο",
          GbsSystemStrings.str_aucune_vacation:
              "Δεν υπάρχει άδεια στον εξυπηρετητή",
          GbsSystemStrings.str_documents: "Έγγραφα",
          GbsSystemStrings.str_info_salarie: "Πληροφορίες εργαζομένου",
          GbsSystemStrings.str_absence: "Απουσία",
          GbsSystemStrings.str_dispo_ponctuelle: "Προσωρινή διαθεσιμότητα",
          GbsSystemStrings.str_exclu_ponctuelle: "Προσωρινή αποκλεισμός",
          GbsSystemStrings.str_etat: "Κατάσταση",
          GbsSystemStrings.str_date_debut: "Ημερομηνία έναρξης",
          GbsSystemStrings.str_hour_debut: "Ώρα έναρξης",
          GbsSystemStrings.str_date_fin: "Ημερομηνία λήξης",
          GbsSystemStrings.str_hour_fin: "Ώρα λήξης",
          GbsSystemStrings.str_lieu: "Τοποθεσία",
          GbsSystemStrings.str_date_demande: "Ημερομηνία αίτησης",
          GbsSystemStrings.str_preferences: "Προτιμήσεις",
          GbsSystemStrings.str_list_des_vacations: "Λίστα διακοπών",
          GbsSystemStrings.str_prise_de_vacations: "Πήρε τις διακοπές",
          GbsSystemStrings.str_planning_du_mois: "Πρόγραμμα του μήνα",
          GbsSystemStrings.str_mois_de_selection: "Επιλεγμένος μήνας",
          GbsSystemStrings.str_empty_data: "Δεν υπάρχει στοιχείο",
          GbsSystemStrings.str_entrer: "Είσοδος",
          GbsSystemStrings.str_sortie: "Έξοδος",
          GbsSystemStrings.str_clotures_le: "Ολοκληρώθηκε στις",
          GbsSystemStrings.str_refuser_le: "Απορρίφθηκε στις",
          GbsSystemStrings.str_acceptation_le: "Αποδεκτή στις",
          GbsSystemStrings.str_demande_absence_du: "Αίτηση απουσίας από",
          GbsSystemStrings.str_au: "έως",
          GbsSystemStrings.str_effectuee_le: "πραγματοποιήθηκε στις",
          GbsSystemStrings.str_vacation: "Διακοπές",
          GbsSystemStrings.str_planning: "Σχεδιασμός",
          GbsSystemStrings.str_historique: "Ιστορικό",

          GbsSystemStrings.str_field_required: "Απαιτούμενο πεδίο",
          GbsSystemStrings.str_code_email: "Κωδικός email",
          GbsSystemStrings.str_code_sms: "Κωδικός SMS",
          GbsSystemStrings.str_portable: "Φορητό",
          GbsSystemStrings.str_precedent: "Προηγούμενο",
          GbsSystemStrings.str_ville: "πόλη",
          GbsSystemStrings.str_longitude: "γεωγραφικό μήκος",
          GbsSystemStrings.str_latitude: "γεωγραφικό πλάτος",
          GbsSystemStrings.str_valider: "Να επικυρώσω",
          GbsSystemStrings.str_photo: "φωτογραφία",
          GbsSystemStrings.str_adresse: "διεύθυνση",
          GbsSystemStrings.str_telephone: "Τηλέφωνο",
          GbsSystemStrings.str_suivant: "ΕΠΟΜΕΝΟ",
          GbsSystemStrings.str_nom: "Ονομα",
          GbsSystemStrings.str_prenom: "Ονομα",
          GbsSystemStrings.str_my_info: "η πληροφορία μου",
          GbsSystemStrings.str_modifier: "να τροποποιήσει",
          ////

          GbsSystemStrings.str_home: "Αρχική",
          GbsSystemStrings.str_afficher_historique: "Εμφάνιση ιστορικού",
          GbsSystemStrings.str_bienvenue: "Καλώς ήρθατε",
          GbsSystemStrings.vacation_proposer: "Προτεινόμενες διακοπές",
          GbsSystemStrings.str_acceder_a_vos_informations:
              "Πρόσβαση στις πληροφορίες σας",
          GbsSystemStrings.demander_vacation: "Ζητήστε ένα άδεια",
          GbsSystemStrings.str_fois_pour_activer_mode:
              "φορές για να ενεργοποιήσετε τη λειτουργία αποθήκευσης του διακομιστή",
          GbsSystemStrings.str_error_no_connection_title:
              "Ψόφια, χωρίς σύνδεση στο internet",
          GbsSystemStrings.str_error_connection_returned_title:
              "Η σύνδεση αποκαταστάθηκε!",
          GbsSystemStrings.str_error_server_title: "Ψόφια, κάτι πήγε στραβά",
          GbsSystemStrings.str_quitter: "Έξοδος",
          GbsSystemStrings.str_appyier: "Πληκτρολογήστε",
          GbsSystemStrings.str_fois_pour_quiter: "φορές για να βγείτε",
          GbsSystemStrings.str_refresh: "Ανανέωση",
          GbsSystemStrings.str_password_changed:
              "Ο κωδικός πρόσβασης άλλαξε με επιτυχία",
          GbsSystemStrings.str_mail_sended: "Το email στάλθηκε με επιτυχία",
          GbsSystemStrings.boarding_1_subtitle:
              "Ο σύντροφός σας στην επεξεργασία πληροφοριών στον τομέα",
          GbsSystemStrings.boarding_2_subtitle:
              "Στη διάθεσή σας για μια πιο αξιόπιστη διαχείριση",
          GbsSystemStrings.boarding_3_title: "Πραγματικός χρόνος",
          GbsSystemStrings.boarding_3_subtitle:
              "Πληροφορίες διαθέσιμες σε πραγματικό χρόνο για όλους τους συνεργάτες σας",
          GbsSystemStrings.boarding_4_subtitle:
              "Βοηθήστε μας να το βελτιώσουμε για καλύτερη εξυπηρέτηση",
          GbsSystemStrings.str_dialog_avertissement: "Προειδοποίηση",
          GbsSystemStrings.str_annuler: "Ακύρωση",
          GbsSystemStrings.str_dialog_erreur: "Σφάλμα",
          GbsSystemStrings.str_dialog_succes: "Επιτυχία",
          GbsSystemStrings.str_dialog_info: "Πληροφορίες",
          GbsSystemStrings.str_mode_identification: "ταυτοποίηση",
          GbsSystemStrings.str_mode_enregistrer_server: "αποθήκευση διακομιστή",
          GbsSystemStrings.str_mode_enregistrer_server_active:
              "Η λειτουργία αποθήκευσης εξυπηρετητή ενεργοποιήθηκε με επιτυχία",
          GbsSystemStrings.str_validat_svp_enter_site:
              "Παρακαλώ εισάγετε τον ιστότοπο",
          GbsSystemStrings.str_validat_svp_enter_mail:
              "Παρακαλώ εισάγετε το email",
          GbsSystemStrings.str_validat_svp_enter_site_valide:
              "Παρακαλώ εισάγετε έναν έγκυρο ιστότοπο",
          GbsSystemStrings.str_site: "Ιστότοπος",
          GbsSystemStrings.str_validat_svp_enter_password:
              "Παρακαλώ εισάγετε τον κωδικό",
          GbsSystemStrings.str_validat_password_length:
              "Ο κωδικός πρέπει να περιέχει τουλάχιστον 8 χαρακτήρες",
          GbsSystemStrings.str_email_required: "Απαιτείται email",
          GbsSystemStrings.str_enter_valid_email: "Εισαγάγετε ένα έγκυρο email",
          GbsSystemStrings.str_mail: "ΗΛΕΚΤΡΟΝΙΚΗ ΔΙΕΥΘΥΝΣΗ",
          GbsSystemStrings.str_password: "Κωδικός πρόσβασης",
          GbsSystemStrings.str_password_required: "Απαιτείται κωδικός",
          GbsSystemStrings.str_password_contain_6_car:
              "Ο κωδικός πρόσβασης πρέπει να περιέχει τουλάχιστον 6 χαρακτήρες",
          GbsSystemStrings.str_mot_de_passe_oublier: "Ξεχάσατε τον κωδικό ?",
          GbsSystemStrings.str_change_password: "Άλλαξε κωδικό",
          GbsSystemStrings.str_ok: "Εντάξει",
          GbsSystemStrings.str_droits_reserved:
              "© BM Soft 2022 Όλα τα δικαιώματα διατηρούνται",
          GbsSystemStrings.str_changement_mot_passe: "Αλλαγή κωδικού",
          GbsSystemStrings.str_old_password: "ΠΑΛΙΟΣ ΚΩΔΙΚΟΣ",
          GbsSystemStrings.str_new_password: "Νέος Κωδικός",
          GbsSystemStrings.str_new_password_confirmation:
              "Επιβεβαίωση νέου κωδικού πρόσβασης",
          GbsSystemStrings.str_reset_password:
              "Επαναφέρετε τον κωδικό πρόσβασης",
          GbsSystemStrings.str_validat_password_must_be_the_same:
              "Ο κωδικός πρέπει να είναι ο ίδιος",
        },
        "pt": {
          GbsSystemStrings.str_session_experer_sso: "Sessão expirada",

          GbsSystemStrings.str_fermer: "perto",

          GbsSystemStrings.str_operation_effectuer: "Operação concluída",
          GbsSystemStrings.str_operation_non_autoriser:
              "Operação não autorizada",
          GbsSystemStrings.str_partager: "Partilhar",
          GbsSystemStrings.str_actions_offline:
              "Dados pendentes de sincronização",
          GbsSystemStrings.str_question_actions_offline:
              "Deseja sincronizar seus dados não salvos com o servidor?",
          GbsSystemStrings.str_non: "não",
          GbsSystemStrings.str_oui: "sim",

          GbsSystemStrings.str_code_entreprise: "Código da empresa",
          GbsSystemStrings.str_are_you_sure_want_change_entreprise:
              "Tem certeza de que deseja mudar de agência?",
          GbsSystemStrings.str_validat_svp_code_entreprise_invalid:
              "O código da empresa é inválido",
          GbsSystemStrings.str_validat_svp_enter_code_client:
              "Por favor, insira o código do cliente",
          GbsSystemStrings.str_new_version_available: "Nova versão disponível!",
          GbsSystemStrings.str_new_version_desc:
              "Uma nova versão do aplicativo está disponível. Para aproveitar os recursos mais recentes, atualize o aplicativo clicando em 'Atualizar'.",
          GbsSystemStrings.str_try_later: "Tente mais tarde",
          GbsSystemStrings.str_update_now: "Atualizar",

          GbsSystemStrings.str_device_dont_support_biometrics:
              "O seu dispositivo não suporta biometria.",

          GbsSystemStrings.str_auth_please_authentificate:
              "Por favor, autentique-se",

          GbsSystemStrings.str_auth_please_authentificate_to_proceed:
              "Por favor, autentique-se para continuar",

          GbsSystemStrings.str_auth_auth_success: "Autenticação bem-sucedida",

          GbsSystemStrings.str_auth_auth_failed: "Falha na autenticação",

          GbsSystemStrings.str_auth_biometric_auth: "Autenticação biométrica",

          GbsSystemStrings.str_auth_auth_with_biometrics:
              "Autentique-se com biometria",

          GbsSystemStrings.str_auth_biometrics_not_available:
              "A autenticação biométrica não está disponível.",

          GbsSystemStrings.str_auth_start_auth: "Iniciar autenticação",

          GbsSystemStrings.str_proposition_s: "Proposta(s)",

          GbsSystemStrings.str_nfc: "NFC",
          GbsSystemStrings.str_taille: "Tamanho",
          GbsSystemStrings.str_qte: "Quantidade",

          GbsSystemStrings.str_loading_map: "Carregando mapa",

          GbsSystemStrings.str_rendre: "Devolver",
          GbsSystemStrings.str_pas_rendre: "Não é para devolver",

          GbsSystemStrings.str_demander_refuser: "Pedir/Recusar",
          GbsSystemStrings.str_proposition: "Proposta",
          GbsSystemStrings.str_indisponibiliter_ponctuelle:
              "Indisponibilidade temporária",
          GbsSystemStrings.str_action_non_autoriser: "Ação não autorizada",
          GbsSystemStrings.str_code_pin_wrong: "O código PIN está incorreto",
          GbsSystemStrings.str_nouvelle_connexion: "Nova conexão",
          GbsSystemStrings.str_code_pin_oublier: "Esqueceu o código PIN?",
          GbsSystemStrings.str_enregistrer: "Salvar",
          GbsSystemStrings.str_enregistrement: "Salvando",
          GbsSystemStrings.str_enrigester_nv_code_pin:
              "Salvar um novo código PIN para continuar",
          GbsSystemStrings.str_entrer_code_pin_deja_enrigester:
              "Digite o código PIN já salvo para continuar",
          GbsSystemStrings.str_verification: "Verificação",
          GbsSystemStrings.str_code_pin: "Código PIN",
          GbsSystemStrings.str_map: "Mapa",
          GbsSystemStrings.str_pointage_en_cours: "Registro em andamento ...",
          GbsSystemStrings.str_operation_en_cours: "Operação em andamento ...",
          GbsSystemStrings.str_details_vacation: "Detalhes da Licença",
          //time picker
          GbsSystemStrings.str_Select_Time: "Selecionar Hora",
          GbsSystemStrings.str_hour: "hora",
          GbsSystemStrings.str_minute: "minuto",
          GbsSystemStrings.str_timePickerInputHint: "Inserir Hora",
          //date picker
          GbsSystemStrings.str_selectDate: "Selecionar Data",
          GbsSystemStrings.str_cancel: "Cancelar",
          GbsSystemStrings.str_done: "Concluído",
          GbsSystemStrings.str_prevMonth: "Mês Anterior",
          GbsSystemStrings.str_nextMonth: "Próximo Mês",
          GbsSystemStrings.str_prevYear: "Ano Anterior",
          GbsSystemStrings.str_nextYear: "Próximo Ano",
          GbsSystemStrings.str_datePickerInputHint: "Inserir Data",
          GbsSystemStrings.str_datePickerHelpText: "Selecionar Data",
          //calendar
          GbsSystemStrings.str_monday: "Segunda-feira",
          GbsSystemStrings.str_tuesday: "Terça-feira",
          //
          GbsSystemStrings.str_droits_reserved_part_2:
              "Todos os direitos reservados",
          GbsSystemStrings.str_connexion: "Conexão",
          GbsSystemStrings.str_ignorer: "Ignorar",
          GbsSystemStrings.str_waiting_for_tag: "Aguardando Tag NFC",
          GbsSystemStrings.str_nfc_disabled:
              "A permissão da tag NFC está desativada, por favor habilite a permissão NFC e tente novamente",
          GbsSystemStrings.str_please_turn_on_nfc_service:
              "Por favor, ative o serviço NFC no seu dispositivo",
          GbsSystemStrings.str_your_device_dont_support_nfc:
              "Seu dispositivo não suporta NFC",
          GbsSystemStrings.str_hold_your_device_near_the_nfc_tag:
              "Mantenha seu dispositivo próximo à etiqueta NFC",
          GbsSystemStrings.str_ready_to_scan: "Pronto para digitalizar",
          GbsSystemStrings.str_deconnexion_question: "Deseja desconectar?",
          GbsSystemStrings.str_no_item: "Não há nenhum elemento",

          GbsSystemStrings.str_filtrer: "Filtrar",
          GbsSystemStrings.str_detail_contact: "Detalhe do Contrato",
          GbsSystemStrings.str_document_administratif:
              "Documento Administrativo",
          GbsSystemStrings.str_tous: "Todos",
          GbsSystemStrings.str_empty_pdf: "o PDF está vazio",
          GbsSystemStrings.str_nombre_des_telechargement: "Número de Downloads",
          GbsSystemStrings.str_creation: "Criação",
          GbsSystemStrings.str_entreprise: "Empresa",
          GbsSystemStrings.str_type_document: "Tipo de Documento",
          GbsSystemStrings.str_placement_cet: "Colocação de CET",
          GbsSystemStrings.str_rachat_cet: "Compra de CET",
          GbsSystemStrings.str_prise_de_jours_cet: "Dias de CET Tomados",
          GbsSystemStrings.solde_des_jours_de_cet: "Saldo de Dias de CET",
          GbsSystemStrings.str_nombre_des_jours: "Número de Dias",
          GbsSystemStrings.mise_au_cet_en_cours:
              "Colocação de CET em Andamento",
          GbsSystemStrings.mise_au_cet_annee_en_cours:
              "Colocação de CET no Ano em Andamento",
          GbsSystemStrings.rachat_cet_en_cours: "Compra de CET em Andamento",
          GbsSystemStrings.rachat_de_cet: "Compra de CET",
          GbsSystemStrings.prise_de_cet_en_cours:
              "Dias de CET Tomados em Andamento",
          GbsSystemStrings.prise_de_cet: "Dias de CET Tomados",
          GbsSystemStrings.solde_de_cet: "Saldo de CET",
          GbsSystemStrings.str_motif: "Motivo",
          GbsSystemStrings.str_type_jour: "Tipo de Dia",
          GbsSystemStrings.str_indisponibiliter_recurrentes:
              "Indisponibilidades Recorrentes",
          GbsSystemStrings.str_dispo_definitive: "Disponibilidade Definitiva",
          GbsSystemStrings.str_dispo_recurrente: "Disponibilidade Recorrente",
          GbsSystemStrings.str_exclusions_propositions_vacation:
              "Exclusão/Proposta de Férias",
          GbsSystemStrings.str_disponibiliter_propositions_de_vacation:
              "Disponibilidade/Proposta de Férias",
          GbsSystemStrings.str_date_pro: "Data Profissional",
          GbsSystemStrings.str_documents_officiel: "Documentos Oficiais",
          GbsSystemStrings.str_date_validiter: "Validade do",
          GbsSystemStrings.str_departement: "Departamento",
          GbsSystemStrings.str_numero_document: "N° Doc",
          GbsSystemStrings.str_diplome: "Diploma",
          GbsSystemStrings.str_agrement: "Aprovação",
          GbsSystemStrings.str_remplie_cases: "preencha os espaços",
          GbsSystemStrings.str_creer: "Criar",
          GbsSystemStrings.str_depasser: "Ultrapassado",
          GbsSystemStrings.kRefuser: "Recusar",
          GbsSystemStrings.kDemander: "Solicitar",
          GbsSystemStrings.kAccepter: "Aceitar",
          GbsSystemStrings.str_valider_le: "Validado em",
          GbsSystemStrings.str_date_obtention: "Data de Obtenção",
          GbsSystemStrings.str_documents_officiels: "Documentos Oficiais",
          GbsSystemStrings.str_diplomes: "Diplomas",
          GbsSystemStrings.str_agrements: "Aprovações",
          GbsSystemStrings.str_habilitations: "Habilitações",
          GbsSystemStrings.str_notes_de_frais: "Notas de Despesas",
          GbsSystemStrings.str_changment_mot_de_passe: "Alteração de Senha",
          GbsSystemStrings.str_carte_proffisionel: "Cartão Profissional",
          GbsSystemStrings.str_att_vos_devez_valider_docs:
              "Atenção: Deve validar seus documentos",
          GbsSystemStrings.str_definitif: "Definitivo",
          GbsSystemStrings.str_are_you_sure_want_delete:
              "Tem certeza de que deseja excluir este elemento?",
          GbsSystemStrings.str_deleted_with_success: "Excluído com sucesso",
          GbsSystemStrings.str_exclu_definitive: "Exclusão Definitiva",
          GbsSystemStrings.str_exclu_recurrente: "Exclusão Recorrente",
          GbsSystemStrings.str_list_preferences: "Lista de Preferências",
          GbsSystemStrings.str_accepter_proposition: "Aceitar Proposta",
          GbsSystemStrings.svp_select_type: "selecione um tipo por favor",
          GbsSystemStrings.svp_ecrire_un_message:
              "escreva uma mensagem por favor",
          GbsSystemStrings.str_prise_de_service: "Preço do Serviço",
          GbsSystemStrings.str_ecrire_votre_message_ici:
              "escreva sua mensagem aqui",
          GbsSystemStrings.str_terminer: "terminar",
          GbsSystemStrings.str_document: "documento",
          GbsSystemStrings.str_documents_de_lentreprise:
              "Documentos da Empresa",
          GbsSystemStrings.str_planning_non_consulter:
              "Planejamentos não consultados",
          GbsSystemStrings.str_valider_vos_documents: "validar seus documentos",
          GbsSystemStrings.str_proposer_le: "Proposto em",
          GbsSystemStrings.str_consulter: "Consultar",
          GbsSystemStrings.str_publier: "Publicado",
          GbsSystemStrings.str_geolocaliser: "Geolocalizar",
          GbsSystemStrings.str_demander: "Solicitado",
          GbsSystemStrings.str_publier_le: "Publicado em",
          GbsSystemStrings.str_distance: "Distância",
          GbsSystemStrings.str_du: "do",
          GbsSystemStrings.str_charger: "carregar",
          GbsSystemStrings.str_demande_vacation: "Pedido de Férias",
          GbsSystemStrings.str_app_bar_select_item: "selecionar um item",
          GbsSystemStrings.str_svp_add_date_debut_fin:
              "por favor, adicione a data de início e fim",
          GbsSystemStrings.str_cloturer: "Encerrado",
          GbsSystemStrings.str_propositions: "Propostas",
          GbsSystemStrings.str_description: "Descrição",
          GbsSystemStrings.str_list_des_indisponibiliter:
              "Lista de Indisponibilidades",
          GbsSystemStrings.str_commentaire_planificateur:
              "Comentário do Planeador",
          GbsSystemStrings.str_commentaire_salarie: "Comentário do Funcionário",
          GbsSystemStrings.str_en_attente: "Pendente",
          GbsSystemStrings.str_accepter: "Aceite",
          GbsSystemStrings.str_refuser: "Recusado",
          GbsSystemStrings.str_list_des_absences: "Lista de Ausências",
          GbsSystemStrings.str_solde_des_absences: "Saldo de Ausências",
          GbsSystemStrings.demander_solde_restant_a_prendre:
              "Saldo Restante a Tomar",
          GbsSystemStrings.demander_demande_en_cours: "Pedidos em Curso",
          GbsSystemStrings.demander_a_venir: "Próximo",
          GbsSystemStrings.demander_pris: "Levado",
          GbsSystemStrings.demander_acquis: "Adquirido",
          GbsSystemStrings.str_demande: "Pedido",
          GbsSystemStrings.str_piece_jointe: "Anexos",
          GbsSystemStrings.str_choisie_un_fichier: "Escolha um ficheiro PDF",
          GbsSystemStrings.str_aucune_fichier_choisie:
              "Nenhum ficheiro selecionado",
          GbsSystemStrings.str_calculer: "Calcular",
          GbsSystemStrings.str_comment: "Comentário",
          GbsSystemStrings.str_select_date: "Selecionar uma Data",
          GbsSystemStrings.str_disponibiliter: "Disponibilidade",
          GbsSystemStrings.str_indisponibiliter: "Indisponibilidades",
          GbsSystemStrings.str_demande_indisponibiliter:
              "Pedido de Indisponibilidade",
          GbsSystemStrings.str_demande_absence: "Pedido de Ausência",
          GbsSystemStrings.str_options: "Opções",
          GbsSystemStrings.str_messagerie: "Mensagens",
          GbsSystemStrings.str_tenue: "Vestuário",

          GbsSystemStrings.str_aucune_vacation_suiv:
              "não há nenhum turno seguinte",
          GbsSystemStrings.str_aucune_vacation_prec: "não há turno anterior",
          GbsSystemStrings.str_pointage_sortie_succes: "Saída bem sucedida",
          GbsSystemStrings.str_location_denied:
              "você deve aceitar a permissão de localização",
          GbsSystemStrings.str_mal_tourner: "algo correu mal",
          GbsSystemStrings.str_pointage_entrer_succes: "Entrada bem sucedida",
          GbsSystemStrings.str_debut: "começo",

          GbsSystemStrings.str_fin: "fim",

          GbsSystemStrings.str_aucune_vacation_trouver:
              "Nenhuma férias encontrada",
          GbsSystemStrings.str_afficher: "Exibir",
          GbsSystemStrings.str_telecharger: "Baixar",
          GbsSystemStrings.str_publication: "Publicação",
          GbsSystemStrings.str_telechargement: "Download",
          GbsSystemStrings.str_consultation: "Consulta",
          GbsSystemStrings.str_file_uploaded_with_success:
              "Arquivo baixado com sucesso",
          GbsSystemStrings.str_agenda: "Agenda",
          GbsSystemStrings.str_prise_de_vacation: "Tirar férias",
          GbsSystemStrings.str_qualification: "Qualificação",
          GbsSystemStrings.str_pause: "Pausa",
          GbsSystemStrings.str_duree: "Duração",
          GbsSystemStrings.str_plages_horaires: "Horários",
          GbsSystemStrings.str_aucune_vacation: "Nenhuma férias no servidor",
          GbsSystemStrings.str_documents: "Documentos",
          GbsSystemStrings.str_info_salarie: "Informações do funcionário",
          GbsSystemStrings.str_absence: "Ausência",
          GbsSystemStrings.str_dispo_ponctuelle: "Disponibilidade pontual",
          GbsSystemStrings.str_exclu_ponctuelle: "Exclusão pontual",
          GbsSystemStrings.str_etat: "Estado",
          GbsSystemStrings.str_date_debut: "Data de início",
          GbsSystemStrings.str_hour_debut: "Hora de início",
          GbsSystemStrings.str_date_fin: "Data de término",
          GbsSystemStrings.str_hour_fin: "Hora de término",
          GbsSystemStrings.str_lieu: "Local",
          GbsSystemStrings.str_date_demande: "Data da solicitação",
          GbsSystemStrings.str_preferences: "Preferências",
          GbsSystemStrings.str_list_des_vacations: "Lista de férias",
          GbsSystemStrings.str_prise_de_vacations: "Tirar férias",
          GbsSystemStrings.str_planning_du_mois: "Planejamento mensal",
          GbsSystemStrings.str_mois_de_selection: "Mês selecionado",
          GbsSystemStrings.str_empty_data: "Não há nenhum elemento",
          GbsSystemStrings.str_entrer: "Entrada",
          GbsSystemStrings.str_sortie: "Saída",
          GbsSystemStrings.str_clotures_le: "Encerrado em",
          GbsSystemStrings.str_refuser_le: "Recusado em",
          GbsSystemStrings.str_acceptation_le: "Aceito em",
          GbsSystemStrings.str_demande_absence_du: "Pedido de ausência de",
          GbsSystemStrings.str_au: "para",
          GbsSystemStrings.str_effectuee_le: "realizado em",
          GbsSystemStrings.str_vacation: "Férias",
          GbsSystemStrings.str_planning: "Planeamento",
          GbsSystemStrings.str_historique: "Histórico",

          GbsSystemStrings.str_field_required: "Campo obrigatório",
          GbsSystemStrings.str_code_email: "Código de e-mail",
          GbsSystemStrings.str_code_sms: "Código SMS",
          GbsSystemStrings.str_portable: "Portátil",
          GbsSystemStrings.str_precedent: "Anterior",
          GbsSystemStrings.str_ville: "cidade",
          GbsSystemStrings.str_longitude: "longitude",
          GbsSystemStrings.str_latitude: "latitude",
          GbsSystemStrings.str_valider: "Validar",
          GbsSystemStrings.str_photo: "Foto",
          GbsSystemStrings.str_adresse: "endereço",
          GbsSystemStrings.str_telephone: "Telefone",
          GbsSystemStrings.str_suivant: "Próximo",
          GbsSystemStrings.str_nom: "nome",
          GbsSystemStrings.str_prenom: "Primeiro Nome",
          GbsSystemStrings.str_my_info: "minhas informações",
          GbsSystemStrings.str_modifier: "Modificar",
          ////

          GbsSystemStrings.str_home: "Início",
          GbsSystemStrings.str_afficher_historique: "Mostrar histórico",
          GbsSystemStrings.str_bienvenue: "Bem-vindo",
          GbsSystemStrings.vacation_proposer: "Férias propostas",
          GbsSystemStrings.str_acceder_a_vos_informations:
              "Aceder às suas informações",
          GbsSystemStrings.demander_vacation: "Solicitar férias",
          GbsSystemStrings.str_fois_pour_activer_mode:
              "vezes para ativar o modo de salvar servidor",
          GbsSystemStrings.str_error_no_connection_title:
              "Oops, sem conexão à internet",
          GbsSystemStrings.str_error_connection_returned_title:
              "Conexão restabelecida!",
          GbsSystemStrings.str_error_server_title: "Oops, algo deu errado",
          GbsSystemStrings.str_quitter: "Sair",
          GbsSystemStrings.str_appyier: "Digitar",
          GbsSystemStrings.str_fois_pour_quiter: "vezes para sair",
          GbsSystemStrings.str_refresh: "Atualizar",
          GbsSystemStrings.str_password_changed: "Senha alterada com sucesso",
          GbsSystemStrings.str_mail_sended: "E-mail enviado com sucesso",
          GbsSystemStrings.boarding_1_subtitle:
              "Seu parceiro no processamento de informações em campo",
          GbsSystemStrings.boarding_2_subtitle:
              "Ao seu serviço para uma gestão mais confiável",
          GbsSystemStrings.boarding_3_title: "Tempo real",
          GbsSystemStrings.boarding_3_subtitle:
              "Informação disponível em tempo real para todos os seus colaboradores",
          GbsSystemStrings.boarding_4_subtitle:
              "Ajude-nos a melhorar para um melhor serviço",
          GbsSystemStrings.str_dialog_avertissement: "Aviso",
          GbsSystemStrings.str_annuler: "Cancelar",
          GbsSystemStrings.str_dialog_erreur: "Erro",
          GbsSystemStrings.str_dialog_succes: "Sucesso",
          GbsSystemStrings.str_dialog_info: "Informação",
          GbsSystemStrings.str_mode_identification: "identificação",
          GbsSystemStrings.str_mode_enregistrer_server: "salvar servidor",
          GbsSystemStrings.str_mode_enregistrer_server_active:
              "O modo de salvar no servidor foi ativado com sucesso",
          GbsSystemStrings.str_validat_svp_enter_site:
              "Por favor, insira o site",
          GbsSystemStrings.str_validat_svp_enter_mail:
              "Por favor, insira o e-mail",
          GbsSystemStrings.str_validat_svp_enter_site_valide:
              "Por favor, insira um site válido",
          GbsSystemStrings.str_site: "Site",
          GbsSystemStrings.str_validat_svp_enter_password:
              "Por favor, insira a senha",
          GbsSystemStrings.str_validat_password_length:
              "A senha deve conter pelo menos 8 caracteres",
          GbsSystemStrings.str_email_required: "O e-mail é obrigatório",
          GbsSystemStrings.str_enter_valid_email: "Entre com um email válido",
          GbsSystemStrings.str_mail: "E-mail",
          GbsSystemStrings.str_password: "Senha",
          GbsSystemStrings.str_password_required: "Senha requerida",
          GbsSystemStrings.str_password_contain_6_car:
              "A senha deve conter pelo menos 6 caracteres",
          GbsSystemStrings.str_mot_de_passe_oublier: "Esqueceu sua senha ?",
          GbsSystemStrings.str_change_password: "Alterar a senha",
          GbsSystemStrings.str_ok: "ok",
          GbsSystemStrings.str_droits_reserved:
              "© BM Soft 2022 todos os direitos reservados",
          GbsSystemStrings.str_changement_mot_passe: "Mudança de senha",
          GbsSystemStrings.str_old_password: "Senha Antiga",
          GbsSystemStrings.str_new_password: "Nova Senha",
          GbsSystemStrings.str_new_password_confirmation:
              "Nova confirmação de senha",
          GbsSystemStrings.str_reset_password: "Redefinir senha",
          GbsSystemStrings.str_validat_password_must_be_the_same:
              "A senha deve ser a mesma",
        },
        "ro": {
          GbsSystemStrings.str_session_experer_sso: "Sesiunea a expirat",

          GbsSystemStrings.str_fermer: "aproape",

          GbsSystemStrings.str_operation_effectuer: "Operațiune finalizată",
          GbsSystemStrings.str_operation_non_autoriser:
              "Operațiune neautorizată",
          GbsSystemStrings.str_partager: "Partajare",
          GbsSystemStrings.str_actions_offline:
              "Date în așteptare pentru sincronizare",
          GbsSystemStrings.str_question_actions_offline:
              "Doriți să sincronizați datele nesalvate cu serverul?",
          GbsSystemStrings.str_non: "nu",
          GbsSystemStrings.str_oui: "da",

          GbsSystemStrings.str_code_entreprise: "Cod companie",
          GbsSystemStrings.str_are_you_sure_want_change_entreprise:
              "Sunteți sigur că doriți să schimbați agenția?",
          GbsSystemStrings.str_validat_svp_code_entreprise_invalid:
              "Codul companiei este invalid",
          GbsSystemStrings.str_validat_svp_enter_code_client:
              "Vă rugăm să introduceți codul clientului",
          GbsSystemStrings.str_new_version_available:
              "Nouă versiune disponibilă!",
          GbsSystemStrings.str_new_version_desc:
              "O nouă versiune a aplicației este disponibilă. Pentru a beneficia de cele mai recente funcții, actualizați aplicația făcând clic pe 'Actualizare'.",
          GbsSystemStrings.str_try_later: "Încercați mai târziu",
          GbsSystemStrings.str_update_now: "Actualizați",

          GbsSystemStrings.str_device_dont_support_biometrics:
              "Dispozitivul dumneavoastră nu suportă biometria.",

          GbsSystemStrings.str_auth_please_authentificate:
              "Vă rugăm să vă autentificați",

          GbsSystemStrings.str_auth_please_authentificate_to_proceed:
              "Vă rugăm să vă autentificați pentru a continua",

          GbsSystemStrings.str_auth_auth_success: "Autentificare reușită",

          GbsSystemStrings.str_auth_auth_failed: "Autentificare eșuată",

          GbsSystemStrings.str_auth_biometric_auth: "Autentificare biometrică",

          GbsSystemStrings.str_auth_auth_with_biometrics:
              "Autentificați-vă cu biometrie",

          GbsSystemStrings.str_auth_biometrics_not_available:
              "Autentificarea biometrică nu este disponibilă.",

          GbsSystemStrings.str_auth_start_auth: "Începe autentificarea",

          GbsSystemStrings.str_proposition_s: "Propunere(e)",

          GbsSystemStrings.str_nfc: "NFC",
          GbsSystemStrings.str_taille: "Dimensiune",
          GbsSystemStrings.str_qte: "Cantitate",

          GbsSystemStrings.str_loading_map: "Încărcare hartă",

          GbsSystemStrings.str_rendre: "A returna",
          GbsSystemStrings.str_pas_rendre: "Nu este de returnat",

          GbsSystemStrings.str_demander_refuser: "Solicitare/Refuz",
          GbsSystemStrings.str_proposition: "Propunere",
          GbsSystemStrings.str_indisponibiliter_ponctuelle:
              "Indisponibilitate temporară",
          GbsSystemStrings.str_action_non_autoriser: "Acțiune neautorizată",
          GbsSystemStrings.str_code_pin_wrong: "Codul PIN este incorect",
          GbsSystemStrings.str_nouvelle_connexion: "Conexiune nouă",
          GbsSystemStrings.str_code_pin_oublier: "Ați uitat codul PIN?",
          GbsSystemStrings.str_enregistrer: "Salvează",
          GbsSystemStrings.str_enregistrement: "Salvare",
          GbsSystemStrings.str_enrigester_nv_code_pin:
              "Salvează un nou cod PIN pentru a continua",
          GbsSystemStrings.str_entrer_code_pin_deja_enrigester:
              "Introduceti codul PIN deja salvat pentru a continua",
          GbsSystemStrings.str_verification: "Verificare",
          GbsSystemStrings.str_code_pin: "Cod PIN",
          GbsSystemStrings.str_map: "Hartă",
          GbsSystemStrings.str_pointage_en_cours: "Înregistrare în curs ...",
          GbsSystemStrings.str_operation_en_cours: "Operațiune în curs ...",
          GbsSystemStrings.str_details_vacation: "Detalii Vacanță",
          //time picker
          GbsSystemStrings.str_Select_Time: "Selectați Ora",
          GbsSystemStrings.str_hour: "oră",
          GbsSystemStrings.str_minute: "minut",
          GbsSystemStrings.str_timePickerInputHint: "Introduceți Ora",
          //date picker
          GbsSystemStrings.str_selectDate: "Selectați Data",
          GbsSystemStrings.str_cancel: "Anulare",
          GbsSystemStrings.str_done: "Finalizat",
          GbsSystemStrings.str_prevMonth: "Luna Anterioară",
          GbsSystemStrings.str_nextMonth: "Luna Următoare",
          GbsSystemStrings.str_prevYear: "Anul Anterior",
          GbsSystemStrings.str_nextYear: "Anul Următor",
          GbsSystemStrings.str_datePickerInputHint: "Introduceți Data",
          GbsSystemStrings.str_datePickerHelpText: "Selectați Data",
          //calendar
          GbsSystemStrings.str_monday: "Luni",
          GbsSystemStrings.str_tuesday: "Marți",
          //
          GbsSystemStrings.str_droits_reserved_part_2:
              "Toate drepturile rezervate",
          GbsSystemStrings.str_connexion: "Conexiune",
          GbsSystemStrings.str_ignorer: "Ignorare",
          GbsSystemStrings.str_waiting_for_tag: "Așteptând Eticheta NFC",
          GbsSystemStrings.str_nfc_disabled:
              "Permisiunea de etichetă NFC este dezactivată, vă rugăm să activați permisiunea NFC și să încercați din nou",
          GbsSystemStrings.str_please_turn_on_nfc_service:
              "Vă rugăm să activați serviciul NFC pe dispozitivul dvs.",
          GbsSystemStrings.str_your_device_dont_support_nfc:
              "Dispozitivul dvs. nu suportă NFC",
          GbsSystemStrings.str_hold_your_device_near_the_nfc_tag:
              "Țineți dispozitivul aproape de eticheta NFC",
          GbsSystemStrings.str_ready_to_scan: "Gata de scanare",
          GbsSystemStrings.str_deconnexion_question:
              "Doriți să vă deconectați?",
          GbsSystemStrings.str_no_item: "Nu există niciun element",

          GbsSystemStrings.str_filtrer: "Filtrare",
          GbsSystemStrings.str_detail_contact: "Detaliu Contract",
          GbsSystemStrings.str_document_administratif: "Document Administrativ",
          GbsSystemStrings.str_tous: "Toate",
          GbsSystemStrings.str_empty_pdf: "PDF-ul este gol",
          GbsSystemStrings.str_nombre_des_telechargement:
              "Numărul de Descărcări",
          GbsSystemStrings.str_creation: "Creare",
          GbsSystemStrings.str_entreprise: "Companie",
          GbsSystemStrings.str_type_document: "Tip Document",
          GbsSystemStrings.str_placement_cet: "Plasare CET",
          GbsSystemStrings.str_rachat_cet: "Răscumpărare CET",
          GbsSystemStrings.str_prise_de_jours_cet: "Zilele CET luate",
          GbsSystemStrings.solde_des_jours_de_cet: "Soldul zilelor de CET",
          GbsSystemStrings.str_nombre_des_jours: "Numărul de Zile",
          GbsSystemStrings.mise_au_cet_en_cours: "Plasare CET în curs",
          GbsSystemStrings.mise_au_cet_annee_en_cours:
              "Plasare CET în curs de an",
          GbsSystemStrings.rachat_cet_en_cours: "Răscumpărare CET în curs",
          GbsSystemStrings.rachat_de_cet: "Răscumpărare CET",
          GbsSystemStrings.prise_de_cet_en_cours: "CET luat în curs",
          GbsSystemStrings.prise_de_cet: "CET luat",
          GbsSystemStrings.solde_de_cet: "Soldul CET",
          GbsSystemStrings.str_motif: "Motiv",
          GbsSystemStrings.str_type_jour: "Tip de Zi",
          GbsSystemStrings.str_indisponibiliter_recurrentes:
              "Indisponibilități recurente",
          GbsSystemStrings.str_dispo_definitive: "Disponibilitate definitivă",
          GbsSystemStrings.str_dispo_recurrente: "Disponibilitate recurentă",
          GbsSystemStrings.str_exclusions_propositions_vacation:
              "Excluziune/Propunere de Vacanță",
          GbsSystemStrings.str_disponibiliter_propositions_de_vacation:
              "Disponibilitate/Propunere de Vacanță",
          GbsSystemStrings.str_date_pro: "Data Profesională",
          GbsSystemStrings.str_documents_officiel: "Documente Oficiale",
          GbsSystemStrings.str_date_validiter: "Valabilitatea",
          GbsSystemStrings.str_departement: "Departament",
          GbsSystemStrings.str_numero_document: "Nr. Doc",
          GbsSystemStrings.str_diplome: "Diplomă",
          GbsSystemStrings.str_agrement: "Aprobare",
          GbsSystemStrings.str_remplie_cases: "completează casetele",
          GbsSystemStrings.str_creer: "Creare",
          GbsSystemStrings.str_depasser: "Depășit",
          GbsSystemStrings.kRefuser: "Refuzare",
          GbsSystemStrings.kDemander: "Cerere",
          GbsSystemStrings.kAccepter: "Acceptare",
          GbsSystemStrings.str_valider_le: "Validat la",
          GbsSystemStrings.str_date_obtention: "Data Obținerii",
          GbsSystemStrings.str_documents_officiels: "Documente Oficiale",
          GbsSystemStrings.str_diplomes: "Diplome",
          GbsSystemStrings.str_agrements: "Aprobări",
          GbsSystemStrings.str_habilitations: "Autorizații",
          GbsSystemStrings.str_notes_de_frais: "Note de Cheltuieli",
          GbsSystemStrings.str_changment_mot_de_passe: "Schimbare Parolă",
          GbsSystemStrings.str_carte_proffisionel: "Carte Profesională",
          GbsSystemStrings.str_att_vos_devez_valider_docs:
              "Atenție: Trebuie să validați documentele",
          GbsSystemStrings.str_definitif: "Definitiv",
          GbsSystemStrings.str_are_you_sure_want_delete:
              "Sunteți sigur că doriți să ștergeți acest element?",
          GbsSystemStrings.str_deleted_with_success: "Șters cu succes",
          GbsSystemStrings.str_exclu_definitive: "Excludere definitivă",
          GbsSystemStrings.str_exclu_recurrente: "Excludere recurentă",
          GbsSystemStrings.str_list_preferences: "Listă de Preferințe",
          GbsSystemStrings.str_accepter_proposition: "Acceptare Propunere",
          GbsSystemStrings.svp_select_type: "vă rugăm să selectați un tip",
          GbsSystemStrings.svp_ecrire_un_message:
              "vă rugăm să scrieți un mesaj",
          GbsSystemStrings.str_prise_de_service: "Preț Serviciu",
          GbsSystemStrings.str_ecrire_votre_message_ici:
              "scrieți mesajul dvs. aici",
          GbsSystemStrings.str_terminer: "termina",
          GbsSystemStrings.str_document: "document",
          GbsSystemStrings.str_documents_de_lentreprise:
              "Documente de Companie",
          GbsSystemStrings.str_planning_non_consulter: "Planificări necitite",
          GbsSystemStrings.str_valider_vos_documents:
              "validați documentele dvs.",
          GbsSystemStrings.str_proposer_le: "Propus la",
          GbsSystemStrings.str_consulter: "Consulta",
          GbsSystemStrings.str_publier: "Publicat",
          GbsSystemStrings.str_geolocaliser: "Geolocalizare",
          GbsSystemStrings.str_demander: "Cerut",
          GbsSystemStrings.str_publier_le: "Publicat la",
          GbsSystemStrings.str_distance: "Distanță",
          GbsSystemStrings.str_du: "de la",
          GbsSystemStrings.str_charger: "încărca",
          GbsSystemStrings.str_demande_vacation: "Cerere de Vacanță",
          GbsSystemStrings.str_app_bar_select_item: "selectați un element",
          GbsSystemStrings.str_svp_add_date_debut_fin:
              "vă rugăm să adăugați data de început și de sfârșit",
          GbsSystemStrings.str_cloturer: "Închis",
          GbsSystemStrings.str_propositions: "Propuneri",
          GbsSystemStrings.str_description: "Descriere",
          GbsSystemStrings.str_list_des_indisponibiliter:
              "Listă de Indisponibilități",
          GbsSystemStrings.str_commentaire_planificateur: "Comentariu Planner",
          GbsSystemStrings.str_commentaire_salarie: "Comentariu Angajat",
          GbsSystemStrings.str_en_attente: "În așteptare",
          GbsSystemStrings.str_accepter: "Acceptat",
          GbsSystemStrings.str_refuser: "Refuzat",
          GbsSystemStrings.str_list_des_absences: "Listă de absențe",
          GbsSystemStrings.str_solde_des_absences: "Sold al absențelor",
          GbsSystemStrings.demander_solde_restant_a_prendre:
              "Sold rămas de luat",
          GbsSystemStrings.demander_demande_en_cours: "Cereri în curs",
          GbsSystemStrings.demander_a_venir: "Viitor",
          GbsSystemStrings.demander_pris: "Luat",
          GbsSystemStrings.demander_acquis: "Achiziționat",
          GbsSystemStrings.str_demande: "Cerere",
          GbsSystemStrings.str_piece_jointe: "Piese atașate",
          GbsSystemStrings.str_choisie_un_fichier:
              "Va rugam sa alegeti un fisier PDF",
          GbsSystemStrings.str_aucune_fichier_choisie: "Niciun fișier selectat",
          GbsSystemStrings.str_calculer: "Calculați",
          GbsSystemStrings.str_comment: "Comentariu",
          GbsSystemStrings.str_select_date: "Selectați o dată",
          GbsSystemStrings.str_disponibiliter: "Disponibilitate",
          GbsSystemStrings.str_indisponibiliter: "Indisponibilități",
          GbsSystemStrings.str_demande_indisponibiliter:
              "Cerere de indisponibilitate",
          GbsSystemStrings.str_demande_absence: "Cerere de absență",
          GbsSystemStrings.str_options: "Opțiuni",
          GbsSystemStrings.str_messagerie: "Mesaje",
          GbsSystemStrings.str_tenue: "Ținută",

          GbsSystemStrings.str_aucune_vacation_suiv:
              "nu există nicio tura următoare",
          GbsSystemStrings.str_aucune_vacation_prec:
              "nu există nicio tură anterioară",
          GbsSystemStrings.str_pointage_sortie_succes: "Check-out reușit",
          GbsSystemStrings.str_location_denied:
              "trebuie să acceptați permisiunea de localizare",
          GbsSystemStrings.str_mal_tourner: "ceva nu a mers bine",
          GbsSystemStrings.str_pointage_entrer_succes: "Check-in reușit",
          GbsSystemStrings.str_debut: "început",
          GbsSystemStrings.str_fin: "sfârșit",

          GbsSystemStrings.str_aucune_vacation_trouver:
              "Nu s-a găsit nicio vacanță",
          GbsSystemStrings.str_afficher: "Afișare",
          GbsSystemStrings.str_telecharger: "Descărcare",
          GbsSystemStrings.str_publication: "Publicare",
          GbsSystemStrings.str_telechargement: "Descărcare",
          GbsSystemStrings.str_consultation: "Consultare",
          GbsSystemStrings.str_file_uploaded_with_success:
              "Fișier descărcat cu succes",
          GbsSystemStrings.str_agenda: "Agendă",
          GbsSystemStrings.str_prise_de_vacation: "Luarea concediului",
          GbsSystemStrings.str_qualification: "Calificare",
          GbsSystemStrings.str_pause: "Pauză",
          GbsSystemStrings.str_duree: "Durată",
          GbsSystemStrings.str_plages_horaires: "Intervale Orare",
          GbsSystemStrings.str_aucune_vacation: "Nicio vacanță pe server",
          GbsSystemStrings.str_documents: "Documente",
          GbsSystemStrings.str_info_salarie: "Informații angajat",
          GbsSystemStrings.str_absence: "Absență",
          GbsSystemStrings.str_dispo_ponctuelle: "Disponibilitate punctuală",
          GbsSystemStrings.str_exclu_ponctuelle: "Excludere punctuală",
          GbsSystemStrings.str_etat: "Stare",
          GbsSystemStrings.str_date_debut: "Dată început",
          GbsSystemStrings.str_hour_debut: "Oră început",
          GbsSystemStrings.str_date_fin: "Dată final",
          GbsSystemStrings.str_hour_fin: "Oră final",
          GbsSystemStrings.str_lieu: "Loc",
          GbsSystemStrings.str_date_demande: "Dată cerere",
          GbsSystemStrings.str_preferences: "Preferințe",
          GbsSystemStrings.str_list_des_vacations: "Listă concedii",
          GbsSystemStrings.str_prise_de_vacations: "Luarea concediului",
          GbsSystemStrings.str_planning_du_mois: "Planificare lunară",
          GbsSystemStrings.str_mois_de_selection: "Lună selectată",
          GbsSystemStrings.str_empty_data: "Nu există niciun element",
          GbsSystemStrings.str_entrer: "Intrare",
          GbsSystemStrings.str_sortie: "Ieșire",
          GbsSystemStrings.str_clotures_le: "Închis pe",
          GbsSystemStrings.str_refuser_le: "Refuzat pe",
          GbsSystemStrings.str_acceptation_le: "Acceptat pe",
          GbsSystemStrings.str_demande_absence_du: "Cerere de absență de la",
          GbsSystemStrings.str_au: "până la",
          GbsSystemStrings.str_effectuee_le: "efectuat pe",
          GbsSystemStrings.str_vacation: "Concediu",
          GbsSystemStrings.str_planning: "Planificare",
          GbsSystemStrings.str_historique: "Istoric",

          GbsSystemStrings.str_field_required: "Câmp obligatoriu",
          GbsSystemStrings.str_code_email: "Cod e-mail",
          GbsSystemStrings.str_code_sms: "Cod SMS",
          GbsSystemStrings.str_portable: "Portabil",
          GbsSystemStrings.str_precedent: "Previous",
          GbsSystemStrings.str_ville: "oraș",
          GbsSystemStrings.str_longitude: "longitudine",
          GbsSystemStrings.str_latitude: "latitudine",
          GbsSystemStrings.str_valider: "Validați",
          GbsSystemStrings.str_photo: "Foto",
          GbsSystemStrings.str_adresse: "adresă",
          GbsSystemStrings.str_telephone: "Telefon",
          GbsSystemStrings.str_suivant: "Următorul",
          GbsSystemStrings.str_nom: "Nume",
          GbsSystemStrings.str_prenom: "Prenume",
          GbsSystemStrings.str_my_info: "informațiile mele",
          GbsSystemStrings.str_modifier: "Modifica",
          ////

          GbsSystemStrings.str_home: "Acasă",
          GbsSystemStrings.str_afficher_historique: "Afișați istoricul",
          GbsSystemStrings.str_bienvenue: "Bine ati venit",
          GbsSystemStrings.vacation_proposer: "Vacanță(e) propusă(e)",
          GbsSystemStrings.str_acceder_a_vos_informations:
              "Accesați informațiile dvs.",
          GbsSystemStrings.demander_vacation: "Solicitați o vacanță",
          GbsSystemStrings.str_fois_pour_activer_mode:
              "ori pentru a activa modul de salvare a serverului",
          GbsSystemStrings.str_error_no_connection_title:
              "Oups, fără conexiune la internet",
          GbsSystemStrings.str_error_connection_returned_title:
              "Conexiune restabilită!",
          GbsSystemStrings.str_error_server_title: "Oups, ceva nu a mers bine",
          GbsSystemStrings.str_quitter: "Ieșire",
          GbsSystemStrings.str_appyier: "Tastați",
          GbsSystemStrings.str_fois_pour_quiter: "ori pentru a ieși",
          GbsSystemStrings.str_refresh: "Reîmprospăta",
          GbsSystemStrings.str_password_changed:
              "Parola a fost schimbată cu succes",
          GbsSystemStrings.str_mail_sended: "E-mail trimis cu succes",
          GbsSystemStrings.boarding_1_subtitle:
              "Partenerul dvs. în prelucrarea informațiilor pe teren",
          GbsSystemStrings.boarding_2_subtitle:
              "La dispoziția dvs. pentru o gestionare mai fiabilă",
          GbsSystemStrings.boarding_3_title: "Timp real",
          GbsSystemStrings.boarding_3_subtitle:
              "Informații disponibile în timp real pentru toți colaboratorii dvs.",
          GbsSystemStrings.boarding_4_subtitle:
              "Ajutați-ne să îmbunătățim pentru un serviciu mai bun",
          GbsSystemStrings.str_dialog_avertissement: "Avertisment",
          GbsSystemStrings.str_annuler: "Anulare",
          GbsSystemStrings.str_dialog_erreur: "Eroare",
          GbsSystemStrings.str_dialog_succes: "Succes",
          GbsSystemStrings.str_dialog_info: "Informații",
          GbsSystemStrings.str_mode_identification: "Identificare",
          GbsSystemStrings.str_mode_enregistrer_server: "salva serverul",
          GbsSystemStrings.str_mode_enregistrer_server_active:
              "Modul de salvare pe server a fost activat cu succes",
          GbsSystemStrings.str_validat_svp_enter_site:
              "Vă rugăm să introduceți site-ul",
          GbsSystemStrings.str_validat_svp_enter_mail:
              "Vă rugăm să introduceți adresa de email",
          GbsSystemStrings.str_validat_svp_enter_site_valide:
              "Vă rugăm să introduceți un site valid",
          GbsSystemStrings.str_site: "Site",
          GbsSystemStrings.str_validat_svp_enter_password:
              "Vă rugăm să introduceți parola",
          GbsSystemStrings.str_validat_password_length:
              "Parola trebuie să conțină cel puțin 8 caractere",
          GbsSystemStrings.str_email_required: "E-mailul este obligatoriu",
          GbsSystemStrings.str_enter_valid_email: "Introduceți un e-mail valid",
          GbsSystemStrings.str_mail: "E-mail",
          GbsSystemStrings.str_password: "Parola",
          GbsSystemStrings.str_password_required: "Parola este necesara",
          GbsSystemStrings.str_password_contain_6_car:
              "Parola trebuie să conțină cel puțin 6 caractere",
          GbsSystemStrings.str_mot_de_passe_oublier: "Aţi uitat parola ?",
          GbsSystemStrings.str_change_password: "Schimbaţi parola",
          GbsSystemStrings.str_ok: "Bine",
          GbsSystemStrings.str_droits_reserved:
              "© BM Soft 2022 toate drepturile rezervate",
          GbsSystemStrings.str_changement_mot_passe: "Schimbarea parolei",
          GbsSystemStrings.str_old_password: "Parola veche",
          GbsSystemStrings.str_new_password: "Parolă Nouă",
          GbsSystemStrings.str_new_password_confirmation:
              "Confirmarea parolei noi",
          GbsSystemStrings.str_reset_password: "Reseteaza parola",
          GbsSystemStrings.str_validat_password_must_be_the_same:
              "Parola trebuie să fie aceeași",
        },
        "tr": {
          GbsSystemStrings.str_session_experer_sso: "Oturum süresi doldu",

          GbsSystemStrings.str_fermer: "kapali",

          GbsSystemStrings.str_operation_effectuer: "Islem tamamlandi",
          GbsSystemStrings.str_operation_non_autoriser:
              "Islem yetkilendirilmedi",
          GbsSystemStrings.str_partager: "Paylas",
          GbsSystemStrings.str_actions_offline:
              "Senkronizasyon bekleyen veriler",
          GbsSystemStrings.str_question_actions_offline:
              "Kaydedilmemiş verilerinizi sunucuyla senkronize etmek istiyor musunuz?",
          GbsSystemStrings.str_non: "hayır",
          GbsSystemStrings.str_oui: "evet",

          GbsSystemStrings.str_code_entreprise: "Şirket Kodu",
          GbsSystemStrings.str_are_you_sure_want_change_entreprise:
              "Ajansı değiştirmek istediğinizden emin misiniz?",
          GbsSystemStrings.str_validat_svp_code_entreprise_invalid:
              "Şirket kodu geçersiz",
          GbsSystemStrings.str_validat_svp_enter_code_client:
              "Lütfen müşteri kodunu giriniz",
          GbsSystemStrings.str_new_version_available: "Yeni sürüm mevcut!",
          GbsSystemStrings.str_new_version_desc:
              "Uygulamanın yeni bir sürümü mevcut. En son özelliklerden yararlanmak için lütfen 'Güncelle'ye tıklayarak uygulamayı güncelleyin.",
          GbsSystemStrings.str_try_later: "Daha sonra tekrar deneyin",
          GbsSystemStrings.str_update_now: "Güncelle",

          GbsSystemStrings.str_device_dont_support_biometrics:
              "Cihazınız biyometrik verileri desteklemiyor.",

          GbsSystemStrings.str_auth_please_authentificate:
              "Lütfen kimlik doğrulaması yapın",

          GbsSystemStrings.str_auth_please_authentificate_to_proceed:
              "Devam etmek için lütfen kimlik doğrulaması yapın",

          GbsSystemStrings.str_auth_auth_success: "Kimlik doğrulama başarılı",

          GbsSystemStrings.str_auth_auth_failed: "Kimlik doğrulama başarısız",

          GbsSystemStrings.str_auth_biometric_auth:
              "Biyometrik Kimlik Doğrulama",

          GbsSystemStrings.str_auth_auth_with_biometrics:
              "Biyometrik verilerle kimlik doğrulaması yapın",

          GbsSystemStrings.str_auth_biometrics_not_available:
              "Biyometrik kimlik doğrulama mevcut değil.",

          GbsSystemStrings.str_auth_start_auth: "Kimlik doğrulamasına başla",

          GbsSystemStrings.str_proposition_s: "Teklif(ler)",

          GbsSystemStrings.str_nfc: "NFC",
          GbsSystemStrings.str_taille: "Boyut",
          GbsSystemStrings.str_qte: "Miktar",

          GbsSystemStrings.str_loading_map: "Harita yükleniyor",

          GbsSystemStrings.str_rendre: "İade",
          GbsSystemStrings.str_pas_rendre: "İade edilmez",

          GbsSystemStrings.str_demander_refuser: "Talep/Red",
          GbsSystemStrings.str_proposition: "Teklif",
          GbsSystemStrings.str_indisponibiliter_ponctuelle:
              "Geçici olarak mevcut değil",
          GbsSystemStrings.str_action_non_autoriser: "Yetkisiz işlem",
          GbsSystemStrings.str_code_pin_wrong: "PIN kodu yanlış",
          GbsSystemStrings.str_nouvelle_connexion: "Yeni bağlantı",
          GbsSystemStrings.str_code_pin_oublier: "PIN kodunu unuttunuz mu?",
          GbsSystemStrings.str_enregistrer: "Kaydet",
          GbsSystemStrings.str_enregistrement: "Kaydediliyor",
          GbsSystemStrings.str_enrigester_nv_code_pin:
              "Devam etmek için yeni bir PIN kodu kaydedin",
          GbsSystemStrings.str_entrer_code_pin_deja_enrigester:
              "Devam etmek için zaten kaydedilmiş PIN kodunu girin",
          GbsSystemStrings.str_verification: "Doğrulama",
          GbsSystemStrings.str_code_pin: "PIN kodu",
          GbsSystemStrings.str_map: "Harita",
          GbsSystemStrings.str_pointage_en_cours:
              "Zaman kaydı devam ediyor ...",
          GbsSystemStrings.str_operation_en_cours: "İşlem devam ediyor ...",
          GbsSystemStrings.str_details_vacation: "Tatil Detayları",
          //time picker
          GbsSystemStrings.str_Select_Time: "Zaman Seç",
          GbsSystemStrings.str_hour: "saat",
          GbsSystemStrings.str_minute: "dakika",
          GbsSystemStrings.str_timePickerInputHint: "Zaman Gir",
          //date picker
          GbsSystemStrings.str_selectDate: "Tarih Seç",
          GbsSystemStrings.str_cancel: "İptal",
          GbsSystemStrings.str_done: "Tamam",
          GbsSystemStrings.str_prevMonth: "Önceki Ay",
          GbsSystemStrings.str_nextMonth: "Sonraki Ay",
          GbsSystemStrings.str_prevYear: "Önceki Yıl",
          GbsSystemStrings.str_nextYear: "Sonraki Yıl",
          GbsSystemStrings.str_datePickerInputHint: "Tarih Gir",
          GbsSystemStrings.str_datePickerHelpText: "Tarih Seç",
          //calendar
          GbsSystemStrings.str_monday: "Pazartesi",
          GbsSystemStrings.str_tuesday: "Salı",
          //
          GbsSystemStrings.str_droits_reserved_part_2: "Tüm hakları saklıdır",
          GbsSystemStrings.str_connexion: "Bağlan",
          GbsSystemStrings.str_ignorer: "Yoksay",
          GbsSystemStrings.str_waiting_for_tag: "NFC Etiketi Bekleniyor",
          GbsSystemStrings.str_nfc_disabled:
              "NFC Etiketi İzni devre dışı bırakıldı, lütfen NFC iznini etkinleştirin ve tekrar deneyin",
          GbsSystemStrings.str_please_turn_on_nfc_service:
              "Lütfen cihazınızda NFC hizmetini açın",
          GbsSystemStrings.str_your_device_dont_support_nfc:
              "Cihazınız NFC'yi desteklemiyor",
          GbsSystemStrings.str_hold_your_device_near_the_nfc_tag:
              "Cihazınızı NFC Etiketine yakın tutun",
          GbsSystemStrings.str_ready_to_scan: "Taramaya hazır",
          GbsSystemStrings.str_deconnexion_question:
              "Oturumu kapatmak istiyor musunuz?",
          GbsSystemStrings.str_no_item: "Hiçbir öğe yok",

          GbsSystemStrings.str_filtrer: "Filtrele",
          GbsSystemStrings.str_detail_contact: "Sözleşme Detayı",
          GbsSystemStrings.str_document_administratif: "Yönetim Belgesi",
          GbsSystemStrings.str_tous: "Tümü",
          GbsSystemStrings.str_empty_pdf: "PDF boş",
          GbsSystemStrings.str_nombre_des_telechargement: "İndirme Sayısı",
          GbsSystemStrings.str_creation: "Oluşturma",
          GbsSystemStrings.str_entreprise: "Şirket",
          GbsSystemStrings.str_type_document: "Belge Türü",
          GbsSystemStrings.str_placement_cet: "CET Yerleştirme",
          GbsSystemStrings.str_rachat_cet: "CET Geri Alma",
          GbsSystemStrings.str_prise_de_jours_cet: "CET Günü Alma",
          GbsSystemStrings.solde_des_jours_de_cet: "CET Gün Bakiyesi",
          GbsSystemStrings.str_nombre_des_jours: "Gün Sayısı",
          GbsSystemStrings.mise_au_cet_en_cours:
              "CET'e Yerleştirme Devam Ediyor",
          GbsSystemStrings.mise_au_cet_annee_en_cours:
              "Yılda CET'e Yerleştirme Devam Ediyor",
          GbsSystemStrings.rachat_cet_en_cours: "CET Geri Alma Devam Ediyor",
          GbsSystemStrings.rachat_de_cet: "CET Geri Alma",
          GbsSystemStrings.prise_de_cet_en_cours: "CET Günü Alma Devam Ediyor",
          GbsSystemStrings.prise_de_cet: "CET Günü Alma",
          GbsSystemStrings.solde_de_cet: "CET Bakiyesi",
          GbsSystemStrings.str_motif: "Neden",
          GbsSystemStrings.str_type_jour: "Gün Türü",
          GbsSystemStrings.str_indisponibiliter_recurrentes:
              "Tekrarlayan Kullanım Dışı Zamanlar",
          GbsSystemStrings.str_dispo_definitive: "Kesin Kullanılabilirlik",
          GbsSystemStrings.str_dispo_recurrente:
              "Tekrarlayan Kullanılabilirlik",
          GbsSystemStrings.str_exclusions_propositions_vacation:
              "Tatil Dışı/Öneri",
          GbsSystemStrings.str_disponibiliter_propositions_de_vacation:
              "Tatil/Öneri",
          GbsSystemStrings.str_date_pro: "Profesyonel Tarih",
          GbsSystemStrings.str_documents_officiel: "Resmi Belgeler",
          GbsSystemStrings.str_date_validiter: "Geçerlilik",
          GbsSystemStrings.str_departement: "Departman",
          GbsSystemStrings.str_numero_document: "Belge No.",
          GbsSystemStrings.str_diplome: "Diploma",
          GbsSystemStrings.str_agrement: "Onay",
          GbsSystemStrings.str_remplie_cases: "boş alanları doldurun",
          GbsSystemStrings.str_creer: "Oluştur",
          GbsSystemStrings.str_depasser: "Süresi Dolmuş",
          GbsSystemStrings.kRefuser: "Reddet",
          GbsSystemStrings.kDemander: "Talep et",
          GbsSystemStrings.kAccepter: "Kabul et",
          GbsSystemStrings.str_valider_le: "Onaylanan Tarih",
          GbsSystemStrings.str_date_obtention: "Alınan Tarih",
          GbsSystemStrings.str_documents_officiels: "Resmi Belgeler",
          GbsSystemStrings.str_diplomes: "Diplomalar",
          GbsSystemStrings.str_agrements: "Onaylar",
          GbsSystemStrings.str_habilitations: "Yetkilendirme",
          GbsSystemStrings.str_notes_de_frais: "Gider Notları",
          GbsSystemStrings.str_changment_mot_de_passe: "Şifre Değişikliği",
          GbsSystemStrings.str_carte_proffisionel: "Meslek Kartı",
          GbsSystemStrings.str_att_vos_devez_valider_docs:
              "Dikkat: Belgelerinizi onaylamalısınız",
          GbsSystemStrings.str_definitif: "Kesin",
          GbsSystemStrings.str_are_you_sure_want_delete:
              "Bu öğeyi silmek istediğinizden emin misiniz?",
          GbsSystemStrings.str_deleted_with_success: "Başarıyla Silindi",
          GbsSystemStrings.str_exclu_definitive: "Kesin Hariç Tutma",
          GbsSystemStrings.str_exclu_recurrente: "Tekrarlayan Hariç Tutma",
          GbsSystemStrings.str_list_preferences: "Tercih Listesi",
          GbsSystemStrings.str_accepter_proposition: "Öneriyi Kabul Et",
          GbsSystemStrings.svp_select_type: "Lütfen bir tür seçin",
          GbsSystemStrings.svp_ecrire_un_message: "Lütfen bir mesaj yazın",
          GbsSystemStrings.str_prise_de_service: "Servis Ücreti",
          GbsSystemStrings.str_ecrire_votre_message_ici:
              "Mesajınızı buraya yazın",
          GbsSystemStrings.str_terminer: "bitir",
          GbsSystemStrings.str_document: "belge",
          GbsSystemStrings.str_documents_de_lentreprise: "Şirket Belgeleri",
          GbsSystemStrings.str_planning_non_consulter:
              "Görüntülenmemiş Planlar",
          GbsSystemStrings.str_valider_vos_documents: "belgelerinizi onaylayın",
          GbsSystemStrings.str_proposer_le: "Önerilen",
          GbsSystemStrings.str_consulter: "Danış",
          GbsSystemStrings.str_publier: "Yayımlandı",
          GbsSystemStrings.str_geolocaliser: "Yer Belirleme",
          GbsSystemStrings.str_demander: "Talep Edildi",
          GbsSystemStrings.str_publier_le: "Yayımlanma Tarihi",
          GbsSystemStrings.str_distance: "Mesafe",
          GbsSystemStrings.str_du: "ile",
          GbsSystemStrings.str_charger: "yüklemek",
          GbsSystemStrings.str_demande_vacation: "Tatil Talebi",
          GbsSystemStrings.str_app_bar_select_item: "bir öğe seçin",
          GbsSystemStrings.str_svp_add_date_debut_fin:
              "lütfen başlangıç ve bitiş tarihini ekleyin",
          GbsSystemStrings.str_cloturer: "Kapalı",
          GbsSystemStrings.str_propositions: "Öneriler",
          GbsSystemStrings.str_description: "Açıklama",
          GbsSystemStrings.str_list_des_indisponibiliter:
              "Kullanılabilirlik Listesi",
          GbsSystemStrings.str_commentaire_planificateur: "Planlayıcı Yorumu",
          GbsSystemStrings.str_commentaire_salarie: "Çalışan Yorumu",
          GbsSystemStrings.str_en_attente: "Beklemede",
          GbsSystemStrings.str_accepter: "Kabul edildi",
          GbsSystemStrings.str_refuser: "Reddedildi",
          GbsSystemStrings.str_list_des_absences: "Yoklama Listesi",
          GbsSystemStrings.str_solde_des_absences: "Devamsızlık Bakiyesi",
          GbsSystemStrings.demander_solde_restant_a_prendre:
              "Alınacak kalan bakiye",
          GbsSystemStrings.demander_demande_en_cours: "Devam eden talepler",
          GbsSystemStrings.demander_a_venir: "Yaklaşan",
          GbsSystemStrings.demander_pris: "Alınan",
          GbsSystemStrings.demander_acquis: "Kazanılmış",
          GbsSystemStrings.str_demande: "Talep",
          GbsSystemStrings.str_piece_jointe: "Ek dosyalar",
          GbsSystemStrings.str_choisie_un_fichier:
              "Lütfen bir PDF dosyasi seçin",
          GbsSystemStrings.str_aucune_fichier_choisie: "Seçilen dosya yok",
          GbsSystemStrings.str_calculer: "Hesaplamak",
          GbsSystemStrings.str_comment: "Yorum",
          GbsSystemStrings.str_select_date: "Bir tarih seçin",
          GbsSystemStrings.str_disponibiliter: "Uygunluk",
          GbsSystemStrings.str_indisponibiliter: "Uygun olmamalar",
          GbsSystemStrings.str_demande_indisponibiliter: "Uygun olmama isteği",
          GbsSystemStrings.str_demande_absence: "Devamsızlık talebi",
          GbsSystemStrings.str_options: "Seçenekler",
          GbsSystemStrings.str_messagerie: "Mesajlaşma",
          GbsSystemStrings.str_tenue: "Giyim",

          GbsSystemStrings.str_aucune_vacation_suiv: "sonraki vardiya yok",
          GbsSystemStrings.str_aucune_vacation_prec: "önceki vardiya yok",
          GbsSystemStrings.str_pointage_sortie_succes: "Çıkış başarılı",
          GbsSystemStrings.str_location_denied:
              "konum iznini kabul etmelisiniz",
          GbsSystemStrings.str_mal_tourner: "bir şeyler yanlış gitti",
          GbsSystemStrings.str_pointage_entrer_succes: "Giriş başarılı",
          GbsSystemStrings.str_debut: "başlangıç",
          GbsSystemStrings.str_fin: "son",

          GbsSystemStrings.str_aucune_vacation_trouver:
              "Hiçbir tatil bulunamadı",
          GbsSystemStrings.str_afficher: "Göster",
          GbsSystemStrings.str_telecharger: "İndir",
          GbsSystemStrings.str_publication: "Yayın",
          GbsSystemStrings.str_telechargement: "İndirme",
          GbsSystemStrings.str_consultation: "Danışma",
          GbsSystemStrings.str_file_uploaded_with_success:
              "Dosya başarıyla indirildi",
          GbsSystemStrings.str_agenda: "Ajanda",
          GbsSystemStrings.str_prise_de_vacation: "Tatil alma",
          GbsSystemStrings.str_qualification: "Niteliği",
          GbsSystemStrings.str_pause: "Mola",
          GbsSystemStrings.str_duree: "Süre",
          GbsSystemStrings.str_plages_horaires: "Saat dilimleri",
          GbsSystemStrings.str_aucune_vacation: "Sunucuda tatil yok",
          GbsSystemStrings.str_documents: "Belgeler",
          GbsSystemStrings.str_info_salarie: "Çalışan Bilgileri",
          GbsSystemStrings.str_absence: "Yokluk",
          GbsSystemStrings.str_dispo_ponctuelle: "Noktasal Uygunluk",
          GbsSystemStrings.str_exclu_ponctuelle: "Noktasal Hariç Tutma",
          GbsSystemStrings.str_etat: "Durum",
          GbsSystemStrings.str_date_debut: "Başlangıç tarihi",
          GbsSystemStrings.str_hour_debut: "Başlangıç saati",
          GbsSystemStrings.str_date_fin: "Bitiş tarihi",
          GbsSystemStrings.str_hour_fin: "Bitiş saati",
          GbsSystemStrings.str_lieu: "Yer",
          GbsSystemStrings.str_date_demande: "Talep tarihi",
          GbsSystemStrings.str_preferences: "Tercihler",
          GbsSystemStrings.str_list_des_vacations: "Tatil Listesi",
          GbsSystemStrings.str_prise_de_vacations: "Tatil almak",
          GbsSystemStrings.str_planning_du_mois: "Aylık Planlama",
          GbsSystemStrings.str_mois_de_selection: "Seçilen Ay",
          GbsSystemStrings.str_empty_data: "Hiçbir öğe yok",
          GbsSystemStrings.str_entrer: "Giriş",
          GbsSystemStrings.str_sortie: "Çıkış",
          GbsSystemStrings.str_clotures_le: "Kapanma tarihi",
          GbsSystemStrings.str_refuser_le: "Reddedilme tarihi",
          GbsSystemStrings.str_acceptation_le: "Kabul edilme tarihi",
          GbsSystemStrings.str_demande_absence_du: "Talep dönemi",
          GbsSystemStrings.str_au: "ila",
          GbsSystemStrings.str_effectuee_le: "gerçekleştirildi",
          GbsSystemStrings.str_vacation: "Tatil",
          GbsSystemStrings.str_planning: "Planlama",
          GbsSystemStrings.str_historique: "Tarih",

          GbsSystemStrings.str_field_required: "Zorunlu alan",
          GbsSystemStrings.str_code_email: "E-posta Kodu",
          GbsSystemStrings.str_code_sms: "SMS Kodu",
          GbsSystemStrings.str_portable: "Taşınabilir",
          GbsSystemStrings.str_precedent: "Önceki",
          GbsSystemStrings.str_ville: "şehir",
          GbsSystemStrings.str_longitude: "boylam",
          GbsSystemStrings.str_latitude: "enlem",
          GbsSystemStrings.str_valider: "Doğrula",
          GbsSystemStrings.str_photo: "Fotoğraf",
          GbsSystemStrings.str_adresse: "adres",
          GbsSystemStrings.str_telephone: "Telefon",
          GbsSystemStrings.str_suivant: "Takip etme",
          GbsSystemStrings.str_nom: "İsim",
          GbsSystemStrings.str_prenom: "İlk adı",
          GbsSystemStrings.str_my_info: "benim bilgim",
          GbsSystemStrings.str_modifier: "Değiştir",
          ////

          GbsSystemStrings.str_home: "Anasayfa",
          GbsSystemStrings.str_afficher_historique: "Geçmişi Göster",
          GbsSystemStrings.str_bienvenue: "Hoş geldiniz",
          GbsSystemStrings.vacation_proposer: "Önerilen Tatil(ler)",
          GbsSystemStrings.str_acceder_a_vos_informations:
              "Bilgilerinize Erişin",
          GbsSystemStrings.demander_vacation: "Tatil İsteği",
          GbsSystemStrings.str_fois_pour_activer_mode:
              "Sunucu kaydetme modunu etkinleştirmek için kez",
          GbsSystemStrings.str_error_no_connection_title:
              "Ops, internet bağlantısı yok",
          GbsSystemStrings.str_error_connection_returned_title:
              "Bağlantı yeniden sağlandı!",
          GbsSystemStrings.str_error_server_title: "Ops, bir şeyler ters gitti",
          GbsSystemStrings.str_quitter: "Çıkış",
          GbsSystemStrings.str_appyier: "Yazın",
          GbsSystemStrings.str_fois_pour_quiter: "kez çıkmak için",
          GbsSystemStrings.str_refresh: "Yenile",
          GbsSystemStrings.str_password_changed: "Şifre başarıyla değiştirildi",
          GbsSystemStrings.str_mail_sended: "Mail başarıyla gönderildi",
          GbsSystemStrings.boarding_1_subtitle:
              "Bilgi işleme alanında ortağınız",
          GbsSystemStrings.boarding_2_subtitle:
              "Daha güvenilir bir yönetim için hizmetinizde",
          GbsSystemStrings.boarding_3_title: "Gerçek zamanlı",
          GbsSystemStrings.boarding_3_subtitle:
              "Tüm işbirlikçileriniz için gerçek zamanlı bilgi mevcut",
          GbsSystemStrings.boarding_4_subtitle:
              "Daha iyi bir hizmet için bize yardım edin",
          GbsSystemStrings.str_dialog_avertissement: "Uyarı",
          GbsSystemStrings.str_annuler: "İptal",
          GbsSystemStrings.str_dialog_erreur: "Hata",
          GbsSystemStrings.str_dialog_succes: "Başarı",
          GbsSystemStrings.str_dialog_info: "Bilgi",
          GbsSystemStrings.str_mode_identification: "Tanılama",
          GbsSystemStrings.str_mode_enregistrer_server: "sunucuyu kaydet",
          GbsSystemStrings.str_mode_enregistrer_server_active:
              "Sunucu kayıt modu başarıyla etkinleştirildi",
          GbsSystemStrings.str_validat_svp_enter_site: "Lütfen siteyi girin",
          GbsSystemStrings.str_validat_svp_enter_mail: "Lütfen e-postayı girin",
          GbsSystemStrings.str_validat_svp_enter_site_valide:
              "Lütfen geçerli bir site girin",
          GbsSystemStrings.str_site: "Site",
          GbsSystemStrings.str_validat_svp_enter_password:
              "Lütfen şifreyi girin",
          GbsSystemStrings.str_validat_password_length:
              "Şifre en az 8 karakter içermelidir",
          GbsSystemStrings.str_email_required: "Email gereklidir",
          GbsSystemStrings.str_enter_valid_email: "Geçerli bir e-posta giriniz",
          GbsSystemStrings.str_mail: "E-posta",
          GbsSystemStrings.str_password: "Şifre",
          GbsSystemStrings.str_password_required: "ŞifreŞifre gerekli",
          GbsSystemStrings.str_password_contain_6_car:
              "Şifre en az 6 karakter içermelidir",
          GbsSystemStrings.str_mot_de_passe_oublier:
              "Parolanızı mı unuttunuz ?",
          GbsSystemStrings.str_change_password: "Şifre değiştir",
          GbsSystemStrings.str_ok: "Tamam",
          GbsSystemStrings.str_droits_reserved:
              "© BM Soft 2022 her hakkı saklıdır",
          GbsSystemStrings.str_changement_mot_passe: "Parola değişimi",
          GbsSystemStrings.str_old_password: "eski Şifre",
          GbsSystemStrings.str_new_password: "Yeni Şifre",
          GbsSystemStrings.str_new_password_confirmation: "Yeni parola onayı",
          GbsSystemStrings.str_reset_password: "Şifreyi yenile",
          GbsSystemStrings.str_validat_password_must_be_the_same:
              "Şifre aynı olmalıdır"
        },
      };
}
