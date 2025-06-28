// ===================================
// NOTECRAFT - APPLICATION PRINCIPALE
// ===================================
// Point d'entrée de l'application NoteCraft
// Gère uniquement l'initialisation et la navigation d'authentification
//
// RÔLE DE CE FICHIER :
// 1. Démarre l'application Flutter (fonction main)
// 2. Configure le thème et les paramètres globaux
// 3. Gère la navigation d'authentification (connecté vs non connecté)
// 4. Sert de pont entre l'état global et l'interface utilisateur

// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';                    // Import principal Flutter (widgets, thèmes, navigation)
import 'core/constantes/couleurs_application.dart';        // Palette de couleurs standardisée de l'application
import 'core/etat/etat_application.dart';                  // Gestionnaire d'état global (authentification, navigation)
import 'pages/page_connexion.dart';                        // Page de connexion pour utilisateurs non authentifiés
import 'pages/vue_accueil.dart';                           // Vue principale pour utilisateurs authentifiés

// ===================================
// POINT D'ENTRÉE DE L'APPLICATION
// ===================================

/// FONCTION MAIN : Point de démarrage obligatoire de toute application Dart/Flutter
/// Cette fonction est appelée automatiquement par le système quand l'app se lance
/// 
/// RUNAPP() : Fonction Flutter qui :
/// 1. Initialise le framework Flutter
/// 2. Prend le widget racine et l'affiche à l'écran
/// 3. Démarre la boucle de rendu et d'événements
void main() {
  // LANCEMENT DE L'APPLICATION : Démarre NoteCraft avec le widget racine
  runApp(const ApplicationNoteCraft());
}

// ===================================
// APPLICATION PRINCIPALE - WIDGET RACINE
// ===================================

/// Widget racine de l'application NoteCraft
/// Configure le thème global et initialise le routage
/// 
/// STATELESSWIDGET : Ce widget ne change jamais (pas d'état interne)
/// Il sert uniquement de configuration pour toute l'application
/// 
/// RÔLE : Configuration globale de l'application (thème, titre, navigation)
class ApplicationNoteCraft extends StatelessWidget {
  const ApplicationNoteCraft({super.key});

  @override
  Widget build(BuildContext context) {
    
    // MATERIALAPP : Widget racine pour les applications Material Design
    // C'est le "conteneur" principal qui englobe toute l'application
    return MaterialApp(
      
      // CONFIGURATION DE L'APPLICATION
      title: 'NoteCraft',                    // NOM : Utilisé par l'OS (multitâche, accessibilité)
      debugShowCheckedModeBanner: false,     // SUPPRIME : Bannière "DEBUG" en haut à droite
      
      // THÈME GLOBAL : Configuration visuelle pour toute l'application
      theme: ThemeData(
        primarySwatch: CouleursApplication.primaire,  // COULEUR PRINCIPALE : Utilisée partout dans l'app
        useMaterial3: true,                           // MATERIAL YOU : Design moderne de Google
      ),
      
      // PAGE D'ACCUEIL : Premier widget affiché au lancement
      // Ne pointe pas directement sur une page, mais sur le gestionnaire d'authentification
      home: const GestionnaireAuthentification(),
    );
  }
}

// ===================================
// GESTIONNAIRE D'AUTHENTIFICATION - NAVIGATION CONDITIONNELLE
// ===================================

/// Widget qui gère la navigation entre les pages d'authentification et l'application
/// Écoute l'état d'authentification et affiche la vue appropriée
/// 
/// PHILOSOPHIE : Point central de décision de navigation
/// Au lieu d'avoir de la logique d'authentification éparpillée,
/// tout est centralisé ici pour une maintenance plus facile
/// 
/// STATELESSWIDGET : Pas d'état local car il écoute l'état global
class GestionnaireAuthentification extends StatelessWidget {
  const GestionnaireAuthentification({super.key});

  @override
  Widget build(BuildContext context) {
    
    // LISTENABLEBUILDER : Widget réactif qui écoute les changements d'état
    // PRINCIPE : Quand EtatApplication change, ce widget se reconstruit automatiquement
    // C'est la magie de Flutter : interface réactive aux changements de données
    return ListenableBuilder(
      
      // SOURCE D'ÉCOUTE : L'état global de l'application
      listenable: EtatApplication.instance,
      
      // FONCTION DE CONSTRUCTION : Appelée à chaque changement d'état
      builder: (context, child) {
        
        // LOGIQUE DE NAVIGATION CONDITIONNELLE
        // Décide quelle interface afficher selon l'état d'authentification
        
        // CAS 1 : UTILISATEUR CONNECTÉ
        // Affiche l'interface principale avec toutes les fonctionnalités
        if (EtatApplication.instance.estAuthentifie) {
          return const VueAccueil();  // Interface complète (onglets, transcription, etc.)
        } 
        // CAS 2 : UTILISATEUR NON CONNECTÉ
        // Affiche l'interface d'authentification
        else {
          return const PageConnexion();  // Formulaire de connexion/inscription
        }
        
        // IMPORTANT : Cette logique est évaluée à chaque fois que :
        // - L'utilisateur se connecte (estAuthentifie passe de false à true)
        // - L'utilisateur se déconnecte (estAuthentifie passe de true à false)
        // - L'application redémarre (vérification du token stocké)
      },
    );
  }
}

// ===================================
// ARCHITECTURE DE L'APPLICATION - EXPLICATION
// ===================================

/*
FLUX DE NAVIGATION SIMPLIFIÉ :

1. DÉMARRAGE :
   main() → ApplicationNoteCraft → GestionnaireAuthentification

2. UTILISATEUR NON CONNECTÉ :
   GestionnaireAuthentification → PageConnexion
   L'utilisateur peut se connecter ou s'inscrire

3. CONNEXION RÉUSSIE :
   EtatApplication.instance.connecterUtilisateur() est appelé
   → estAuthentifie devient true
   → ListenableBuilder détecte le changement
   → Affiche VueAccueil automatiquement

4. NAVIGATION DANS L'APPLICATION :
   VueAccueil gère la navigation par onglets
   (Transcription, Historique, Abonnement, Paramètres)

5. DÉCONNEXION :
   EtatApplication.instance.deconnecterUtilisateur() est appelé
   → estAuthentifie devient false
   → Retour automatique à PageConnexion

AVANTAGES DE CETTE ARCHITECTURE :
✅ Centralisation : Toute la logique d'authentification en un endroit
✅ Réactivité : Interface qui se met à jour automatiquement
✅ Simplicité : Pas de navigation manuelle complexe
✅ Maintenance : Facile à modifier ou déboguer
✅ Sécurité : Impossible d'accéder à l'app sans être authentifié
*/ 