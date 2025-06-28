// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';                    // Import pour ChangeNotifier et les widgets Flutter

// ===================================
// GESTIONNAIRE D'ÉTAT GLOBAL - CŒUR DE L'APPLICATION
// ===================================

/// Gestionnaire d'état global de l'application NoteCraft
/// Utilise le pattern Singleton pour avoir une instance unique dans toute l'app
/// Étend ChangeNotifier pour pouvoir notifier les widgets des changements d'état
/// 
/// PHILOSOPHIE DE LA GESTION D'ÉTAT :
/// Au lieu d'avoir des données éparpillées dans chaque page, cette classe centralise
/// TOUT l'état de l'application en un seul endroit. Cela permet :
/// 1. Cohérence : Toutes les pages voient les mêmes données
/// 2. Réactivité : Quand une donnée change, toute l'interface se met à jour
/// 3. Simplicité : Plus besoin de passer des données entre les pages
/// 4. Persistence : L'état survit aux changements de page
/// 
/// CHANGENOTIFIER : Classe Flutter qui permet d'écouter les changements
/// Quand on appelle notifyListeners(), tous les widgets qui écoutent cette classe
/// se reconstruisent automatiquement avec les nouvelles données
class EtatApplication extends ChangeNotifier {
  
  // ===================================
  // PATTERN SINGLETON - INSTANCE UNIQUE
  // ===================================
  
  /// Instance unique de la classe (pattern Singleton)
  /// STATIC FINAL : Variable partagée par toute l'application, initialisée une seule fois
  /// AVANTAGE : On peut accéder à cette instance depuis n'importe où avec EtatApplication.instance
  static final EtatApplication instance = EtatApplication._();
  
  /// Constructeur privé pour empêcher l'instanciation directe
  /// Le _ rend ce constructeur privé (inaccessible depuis l'extérieur)
  /// SÉCURITÉ : Garantit qu'il n'y aura qu'une seule instance de cette classe
  EtatApplication._();

  // ===================================
  // VARIABLES D'ÉTAT PRIVÉES - SOURCES DE VÉRITÉ
  // ===================================
  
  /// Indique si l'utilisateur est connecté ou non
  /// BOOL : État d'authentification central de l'application
  /// false = Utilisateur déconnecté (affiche PageConnexion)
  /// true = Utilisateur connecté (affiche VueAccueil)
  bool _estAuthentifie = false;
  
  /// Index de l'onglet sélectionné dans la navigation principale
  /// INT : Détermine quelle page afficher dans la navigation par onglets
  /// 0 = Transcription, 1 = Historique, 2 = Abonnement
  int _indexOngletSelectionne = 0;
  
  /// Email de l'utilisateur connecté
  /// STRING : Stocke l'identifiant de l'utilisateur pour personnalisation
  /// Utilisé pour affichage dans les paramètres, sauvegarde, etc.
  String _emailUtilisateur = "";
  
  /// Nom de l'utilisateur connecté
  /// STRING : Nom d'affichage pour personnaliser l'expérience utilisateur
  /// Affiché dans l'interface, les salutations, etc.
  String _nomUtilisateur = "";
  
  /// Indique si un enregistrement audio est en cours
  /// BOOL : État principal de l'enregistrement audio
  /// false = Pas d'enregistrement (bouton rond normal)
  /// true = Enregistrement actif (bouton rouge, animation)
  bool _estEnregistrement = false;
  
  /// Indique si l'enregistrement est en pause
  /// BOOL : État secondaire de l'enregistrement (seulement si _estEnregistrement = true)
  /// false = Enregistrement en cours
  /// true = Enregistrement en pause (peut reprendre)
  bool _estEnPause = false;
  
  /// Texte de la transcription actuelle
  /// STRING : Résultat de la transcription audio en texte
  /// Peut être édité par l'utilisateur après génération
  String _texteTranscription = "";
  
  /// Crédit de transcription restant en secondes (5 minutes par défaut)
  /// INT : Temps disponible pour la transcription (limitation du plan gratuit)
  /// 300 secondes = 5 minutes par défaut
  int _creditSecondes = 300;

  // ===================================
  // GETTERS PUBLICS - ACCÈS CONTRÔLÉ AUX DONNÉES
  // ===================================
  
  /// PRINCIPE DES GETTERS :
  /// Les variables privées (_variable) ne sont pas accessibles directement
  /// Les getters fournissent un accès en lecture seule aux données
  /// AVANTAGE : Empêche la modification accidentelle depuis l'extérieur
  
  /// Retourne true si l'utilisateur est authentifié
  /// USAGE : Utilisé par GestionnaireAuthentification pour décider quelle page afficher
  bool get estAuthentifie => _estAuthentifie;
  
  /// Retourne l'index de l'onglet actuellement sélectionné
  /// USAGE : Utilisé par VueAccueil pour savoir quelle page afficher dans IndexedStack
  int get indexOngletSelectionne => _indexOngletSelectionne;
  
  /// Retourne l'email de l'utilisateur connecté
  /// USAGE : Affiché dans PageParametres, utilisé pour sauvegardes
  String get emailUtilisateur => _emailUtilisateur;
  
  /// Retourne le nom de l'utilisateur connecté
  /// USAGE : Personnalisation de l'interface (salutations, profil)
  String get nomUtilisateur => _nomUtilisateur;
  
  /// Retourne true si un enregistrement est en cours
  /// USAGE : Change l'apparence du bouton d'enregistrement (couleur, animation)
  bool get estEnregistrement => _estEnregistrement;
  
  /// Retourne true si l'enregistrement est en pause
  /// USAGE : Affiche l'icône pause au lieu de l'icône microphone
  bool get estEnPause => _estEnPause;
  
  /// Retourne le texte de transcription actuel
  /// USAGE : Affiché et éditable dans PageTranscription
  String get texteTranscription => _texteTranscription;
  
  /// Retourne le crédit de transcription restant en secondes
  /// USAGE : Barre de progression et limitation des fonctionnalités
  int get creditSecondes => _creditSecondes;

  // ===================================
  // MÉTHODES PUBLIQUES - ACTIONS QUI MODIFIENT L'ÉTAT
  // ===================================
  
  /// PRINCIPE DES MÉTHODES PUBLIQUES :
  /// Ce sont les SEULES façons de modifier l'état depuis l'extérieur
  /// Chaque méthode termine par notifyListeners() pour informer l'interface
  /// AVANTAGE : Contrôle total sur quand et comment l'état change

  /// Connecte un utilisateur avec son email et nom
  /// [email] : adresse email de l'utilisateur
  /// [nom] : nom complet de l'utilisateur
  /// 
  /// APPELÉE DEPUIS : PageConnexion.dart et PageInscription.dart
  /// EFFET : Déclenche automatiquement l'affichage de VueAccueil
  void connecterUtilisateur(String email, String nom) {
    // MISE À JOUR DES DONNÉES
    _estAuthentifie = true;           // Active l'état connecté
    _emailUtilisateur = email;        // Stocke l'email pour usage futur
    _nomUtilisateur = nom;            // Stocke le nom pour personnalisation
    
    // NOTIFICATION : Informe tous les widgets qui écoutent cette classe
    // Résultat : GestionnaireAuthentification se reconstruit et affiche VueAccueil
    notifyListeners();
  }

  /// Déconnecte l'utilisateur et remet les variables à zéro
  /// 
  /// APPELÉE DEPUIS : PageParametres.dart (bouton de déconnexion)
  /// EFFET : Retour automatique à PageConnexion + nettoyage complet des données
  void deconnecterUtilisateur() {
    // REMISE À ZÉRO COMPLÈTE : Sécurité et vie privée
    _estAuthentifie = false;          // Désactive l'état connecté
    _emailUtilisateur = "";           // Efface l'email
    _nomUtilisateur = "";             // Efface le nom
    _indexOngletSelectionne = 0;      // Retour au premier onglet
    _estEnregistrement = false;       // Arrête tout enregistrement
    _estEnPause = false;              // Remet l'état de pause à zéro
    _texteTranscription = "";         // Efface la transcription
    
    // NOTIFICATION : Déclenche le retour à PageConnexion
    notifyListeners();
  }

  /// Change l'onglet sélectionné dans la navigation
  /// [index] : index du nouvel onglet à sélectionner
  /// 
  /// APPELÉE DEPUIS : VueAccueil.dart (navigation par onglets)
  /// EFFET : Change automatiquement la page affichée dans IndexedStack
  void changerOngletSelectionne(int index) {
    _indexOngletSelectionne = index;
    
    // NOTIFICATION : VueAccueil se reconstruit avec le nouvel onglet
    notifyListeners();
  }

  /// Gère l'état de l'enregistrement audio (démarrer/pause/reprendre)
  /// - Si pas d'enregistrement : démarre l'enregistrement
  /// - Si en pause : reprend l'enregistrement  
  /// - Si en cours : met en pause
  /// 
  /// APPELÉE DEPUIS : PageTranscription.dart (bouton rond d'enregistrement)
  /// LOGIQUE COMPLEXE : Un seul bouton gère 3 états différents
  void basculerEnregistrement() {
    
    // CAS 1 : DÉMARRAGE D'UN NOUVEL ENREGISTREMENT
    if (!_estEnregistrement) {
      _estEnregistrement = true;      // Active l'enregistrement
      _estEnPause = false;            // S'assure qu'on n'est pas en pause
    } 
    // CAS 2 : REPRISE D'UN ENREGISTREMENT EN PAUSE
    else if (_estEnPause) {
      _estEnPause = false;            // Désactive la pause (continue l'enregistrement)
    } 
    // CAS 3 : MISE EN PAUSE D'UN ENREGISTREMENT ACTIF
    else {
      _estEnPause = true;             // Active la pause (sans arrêter l'enregistrement)
    }
    
    // NOTIFICATION : Met à jour l'interface du bouton d'enregistrement
    notifyListeners();
  }

  /// Arrête complètement l'enregistrement et génère une transcription simulée
  /// 
  /// APPELÉE DEPUIS : PageTranscription.dart (bouton stop ou fin automatique)
  /// EFFET : Termine l'enregistrement + génère le texte de transcription
  void arreterEnregistrement() {
    // ARRÊT COMPLET DE L'ENREGISTREMENT
    _estEnregistrement = false;       // Désactive l'enregistrement
    _estEnPause = false;              // Remet la pause à zéro
    
    // SIMULATION D'UNE TRANSCRIPTION GÉNÉRÉE PAR IA
    // Dans une vraie application, ici on appellerait une API de transcription
    _texteTranscription = "Voici un exemple de transcription audio générée automatiquement. "
        "Le texte apparaît ici après l'enregistrement et la transcription via l'intelligence artificielle.";
    
    // NOTIFICATION : Met à jour l'interface avec le nouveau texte
    notifyListeners();
  }

  /// Met à jour le texte de transcription
  /// [texte] : nouveau texte de transcription
  /// 
  /// APPELÉE DEPUIS : PageTranscription.dart (quand l'utilisateur édite le texte)
  /// USAGE : Synchronisation bidirectionnelle entre l'état et l'interface
  void mettreAJourTranscription(String texte) {
    _texteTranscription = texte;
    
    // NOTIFICATION : Synchronise avec d'autres widgets qui affichent ce texte
    notifyListeners();
  }

  /// Met à jour le crédit de transcription restant
  /// [secondes] : nouveau crédit en secondes
  /// 
  /// APPELÉE DEPUIS : Système de décompte ou PageAbonnement.dart
  /// USAGE : Gestion des limitations du plan gratuit
  void mettreAJourCredit(int secondes) {
    _creditSecondes = secondes;
    
    // NOTIFICATION : Met à jour la barre de progression du crédit
    notifyListeners();
  }
}

// ===================================
// ARCHITECTURE RÉACTIVE - COMMENT ÇA FONCTIONNE
// ===================================

/*
FLUX DE DONNÉES DANS L'APPLICATION :

1. ACTION UTILISATEUR :
   L'utilisateur clique sur un bouton dans l'interface

2. APPEL DE MÉTHODE :
   Le widget appelle une méthode de EtatApplication.instance

3. MODIFICATION D'ÉTAT :
   La méthode modifie les variables privées

4. NOTIFICATION :
   notifyListeners() est appelé à la fin de la méthode

5. RECONSTRUCTION AUTOMATIQUE :
   Tous les widgets qui écoutent cette classe se reconstruisent

6. INTERFACE MISE À JOUR :
   L'utilisateur voit immédiatement les changements

EXEMPLE CONCRET - CHANGEMENT D'ONGLET :
1. Utilisateur clique sur l'onglet "Historique"
2. VueAccueil appelle EtatApplication.instance.changerOngletSelectionne(1)
3. _indexOngletSelectionne passe de 0 à 1
4. notifyListeners() est appelé
5. VueAccueil se reconstruit automatiquement
6. IndexedStack affiche PageHistorique au lieu de PageTranscription

AVANTAGES DE CETTE ARCHITECTURE :
✅ Centralisation : Toutes les données importantes en un seul endroit
✅ Réactivité : Interface qui s'adapte automatiquement aux changements
✅ Cohérence : Impossible d'avoir des données différentes entre les pages
✅ Simplicité : Pas besoin de passer des données entre les widgets
✅ Performance : Seuls les widgets concernés se reconstruisent
✅ Débogage : Facile de tracer l'origine des changements d'état
*/ 