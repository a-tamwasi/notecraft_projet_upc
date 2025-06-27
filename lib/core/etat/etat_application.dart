import 'package:flutter/material.dart';

/// Gestionnaire d'état global de l'application NoteCraft
/// Utilise le pattern Singleton pour avoir une instance unique dans toute l'app
/// Étend ChangeNotifier pour pouvoir notifier les widgets des changements d'état
class EtatApplication extends ChangeNotifier {
  
  // === SINGLETON PATTERN ===
  /// Instance unique de la classe (pattern Singleton)
  static final EtatApplication instance = EtatApplication._();
  
  /// Constructeur privé pour empêcher l'instanciation directe
  EtatApplication._();

  // === VARIABLES D'ÉTAT PRIVÉES ===
  /// Indique si l'utilisateur est connecté ou non
  bool _estAuthentifie = false;
  
  /// Index de l'onglet sélectionné dans la navigation principale
  int _indexOngletSelectionne = 0;
  
  /// Email de l'utilisateur connecté
  String _emailUtilisateur = "";
  
  /// Nom de l'utilisateur connecté
  String _nomUtilisateur = "";
  
  /// Indique si un enregistrement audio est en cours
  bool _estEnregistrement = false;
  
  /// Indique si l'enregistrement est en pause
  bool _estEnPause = false;
  
  /// Texte de la transcription actuelle
  String _texteTranscription = "";
  
  /// Crédit de transcription restant en secondes (5 minutes par défaut)
  int _creditSecondes = 300;

  // === GETTERS PUBLICS ===
  /// Retourne true si l'utilisateur est authentifié
  bool get estAuthentifie => _estAuthentifie;
  
  /// Retourne l'index de l'onglet actuellement sélectionné
  int get indexOngletSelectionne => _indexOngletSelectionne;
  
  /// Retourne l'email de l'utilisateur connecté
  String get emailUtilisateur => _emailUtilisateur;
  
  /// Retourne le nom de l'utilisateur connecté
  String get nomUtilisateur => _nomUtilisateur;
  
  /// Retourne true si un enregistrement est en cours
  bool get estEnregistrement => _estEnregistrement;
  
  /// Retourne true si l'enregistrement est en pause
  bool get estEnPause => _estEnPause;
  
  /// Retourne le texte de transcription actuel
  String get texteTranscription => _texteTranscription;
  
  /// Retourne le crédit de transcription restant en secondes
  int get creditSecondes => _creditSecondes;

  // === MÉTHODES PUBLIQUES ===
  
  /// Connecte un utilisateur avec son email et nom
  /// [email] : adresse email de l'utilisateur
  /// [nom] : nom complet de l'utilisateur
  void connecterUtilisateur(String email, String nom) {
    _estAuthentifie = true;
    _emailUtilisateur = email;
    _nomUtilisateur = nom;
    // Notifie tous les widgets qui écoutent ce ChangeNotifier
    notifyListeners();
  }

  /// Déconnecte l'utilisateur et remet les variables à zéro
  void deconnecterUtilisateur() {
    _estAuthentifie = false;
    _emailUtilisateur = "";
    _nomUtilisateur = "";
    _indexOngletSelectionne = 0;
    _estEnregistrement = false;
    _estEnPause = false;
    _texteTranscription = "";
    notifyListeners();
  }

  /// Change l'onglet sélectionné dans la navigation
  /// [index] : index du nouvel onglet à sélectionner
  void changerOngletSelectionne(int index) {
    _indexOngletSelectionne = index;
    notifyListeners();
  }

  /// Gère l'état de l'enregistrement audio (démarrer/pause/reprendre)
  /// - Si pas d'enregistrement : démarre l'enregistrement
  /// - Si en pause : reprend l'enregistrement  
  /// - Si en cours : met en pause
  void basculerEnregistrement() {
    if (!_estEnregistrement) {
      // Démarrer l'enregistrement
      _estEnregistrement = true;
      _estEnPause = false;
    } else if (_estEnPause) {
      // Reprendre l'enregistrement
      _estEnPause = false;
    } else {
      // Mettre en pause
      _estEnPause = true;
    }
    notifyListeners();
  }

  /// Arrête complètement l'enregistrement et génère une transcription simulée
  void arreterEnregistrement() {
    _estEnregistrement = false;
    _estEnPause = false;
    // Simulation d'une transcription générée par IA
    _texteTranscription = "Voici un exemple de transcription audio générée automatiquement. "
        "Le texte apparaît ici après l'enregistrement et la transcription via l'intelligence artificielle.";
    notifyListeners();
  }

  /// Met à jour le texte de transcription
  /// [texte] : nouveau texte de transcription
  void mettreAJourTranscription(String texte) {
    _texteTranscription = texte;
    notifyListeners();
  }

  /// Met à jour le crédit de transcription restant
  /// [secondes] : nouveau crédit en secondes
  void mettreAJourCredit(int secondes) {
    _creditSecondes = secondes;
    notifyListeners();
  }
} 