// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';                    // Import principal Flutter (widgets, navigation, etc.)
import 'dart:ui';                                          // Import pour les effets visuels avancés (BackdropFilter)
import '../core/constantes/couleurs_application.dart';     // Couleurs standardisées de l'application
import '../core/etat/etat_application.dart';               // Gestionnaire d'état global (navigation, utilisateur)

// IMPORTS DES PAGES : Toutes les pages accessibles depuis la navigation
import 'page_transcription.dart';                          // Page principale de transcription audio
import 'page_historique.dart';                             // Page d'historique des transcriptions
import 'page_abonnement.dart';                             // Page de gestion des abonnements
import 'page_parametres.dart';                             // Page des paramètres utilisateur

// ===================================
// VUE D'ACCUEIL - WIDGET PRINCIPAL
// ===================================

/// Vue d'accueil principale de l'application authentifiée
/// Gère la navigation par onglets et l'AppBar commune
/// 
/// RÔLE CENTRAL : Cette vue est le "conteneur" principal de l'application
/// Elle orchestre la navigation entre les différentes fonctionnalités
/// 
/// STATEFULWIDGET : Nécessaire pour gérer la liste des pages et écouter l'état global
class VueAccueil extends StatefulWidget {
  const VueAccueil({super.key});

  @override
  State<VueAccueil> createState() => _VueAccueilState();
}

// ===================================
// ÉTAT DE LA VUE D'ACCUEIL
// ===================================

/// Classe d'état gérant la navigation par onglets et l'interface principale
class _VueAccueilState extends State<VueAccueil> {
  
  // ===================================
  // VARIABLES D'ÉTAT
  // ===================================
  
  /// Liste des pages disponibles dans la navigation par onglets
  /// LATE : Initialisée dans initState() car dépend du contexte du widget
  /// FINAL : Ne change jamais une fois initialisée
  late final List<Widget> _pages;

// ===================================
// MÉTHODES DU CYCLE DE VIE
// ===================================

  @override
  void initState() {
    super.initState();
    
    // INITIALISATION DES PAGES : Crée les instances des pages une seule fois
    // CONST : Optimisation - les pages sont constantes et réutilisables
    _pages = const [
      PageTranscription(),  // Index 0 : Page de transcription (onglet 1)
      PageHistorique(),     // Index 1 : Page d'historique (onglet 2)
      PageAbonnement(),     // Index 2 : Page d'abonnement (onglet 3)
    ];
    // Note : PageParametres n'est pas dans cette liste car accessible via l'AppBar
  }

// ===================================
// CONSTRUCTION DE L'INTERFACE PRINCIPALE
// ===================================

  @override
  Widget build(BuildContext context) {
    
    // LISTENABLEBUILDER : Écoute les changements dans EtatApplication
    // Reconstruit automatiquement l'interface quand l'état change
    // Essentiel pour la navigation réactive (changement d'onglet)
    return ListenableBuilder(
      listenable: EtatApplication.instance,  // Source des changements à écouter
      
      builder: (context, child) {
        // SCAFFOLD : Structure de base de l'application
        return Scaffold(
          extendBody: true,  // IMPORTANT : Étend le body sous la navigation (pour l'effet glassmorphism)
          
          // APPBAR : Barre supérieure commune à toutes les pages
          appBar: _construireAppBar(context),
          
          // BODY : Contenu principal avec superposition pour la navigation
          body: Stack(  // STACK : Permet de superposer les éléments
            children: [
              
              // SECTION 1 : CONTENU DES PAGES
              // IndexedStack maintient l'état de toutes les pages même quand elles ne sont pas visibles
              IndexedStack(
                // INDEX DYNAMIQUE : Change selon l'onglet sélectionné dans l'état global
                index: EtatApplication.instance.indexOngletSelectionne,
                children: _pages,  // Liste des pages initialisée dans initState
              ),
              
              // SECTION 2 : NAVIGATION FLOTTANTE
              // Positionnée au-dessus du contenu pour l'effet glassmorphism
              Positioned(
                left: 0,    // Collée au bord gauche
                right: 0,   // Collée au bord droit
                bottom: 0,  // Collée au bas de l'écran
                child: _construireNavigationInferieure(),
              ),
            ],
          ),
        );
      },
    );
  }

// ===================================
// MÉTHODES PRIVÉES - CONSTRUCTION DES WIDGETS
// ===================================

  /// MÉTHODE 1 : Construit l'AppBar avec le logo NoteCraft et le bouton paramètres
  PreferredSizeWidget _construireAppBar(BuildContext context) {
    return AppBar(
      // STYLE DE L'APPBAR
      backgroundColor: Colors.white,          // Fond blanc pur
      surfaceTintColor: Colors.white,         // Évite les changements de couleur au scroll
      scrolledUnderElevation: 0,              // Pas d'ombre au scroll (design moderne)
      
      // CONTENU CENTRAL : Logo de l'application
      title: _construireLogo(),
      centerTitle: true,                      // Centre le logo (style iOS)
      
      // ACTIONS À DROITE : Bouton des paramètres
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),             // Icône engrenage
          onPressed: () => _ouvrirParametres(context),  // Action au clic
          tooltip: 'Ouvrir les paramètres',             // Aide pour l'accessibilité
        ),
      ],
    );
  }

  /// MÉTHODE 2 : Construit le logo NoteCraft avec gradient
  // MÉTHODE : Construit le logo de l'application
  Widget _construireLogo() {
    // ROW : Conteneur horizontal pour centrer le logo
    return Row(
        mainAxisSize: MainAxisSize.min,  // Prend seulement l'espace nécessaire pour le logo
        children: [
          // LOGO : Image du logo de l'application
          SizedBox(
            width: 120,  // Largeur de l'icône
            height: 120, // Hauteur de l'icône
            child: Image.asset(
              'assets/logo.png',  // Chemin vers l'image du logo
              fit: BoxFit.contain,  // Ajuste l'image pour qu'elle soit entièrement visible
            ),
          ),
        ],
      );
  }

  /// MÉTHODE 3 : Construit la navigation inférieure avec effet glassmorphism
  Widget _construireNavigationInferieure() {
    // CLIPRRECT : Découpe les angles pour l'effet glassmorphism
    return ClipRRect(
      // BACKDROPFILTER : EFFET GLASSMORPHISM (flou d'arrière-plan)
      // Crée un effet de verre dépoli très moderne
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),  // Intensité du flou
        
        child: Container(
          // DÉCORATION SEMI-TRANSPARENTE : Simule le verre
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),  // Fond blanc très transparent
            
            // BORDURE SUPÉRIEURE : Délimite la zone de navigation
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.2), width: 1.0),
            ),
          ),
          
          // SAFEAREA : Évite les zones système (barre d'accueil, encoche)
          child: SafeArea(
            top: false,  // Pas de marge en haut (on veut juste la marge du bas)
            
            // BOTTOMNAVIGATIONBAR : Widget spécialisé pour la navigation par onglets
            child: BottomNavigationBar(
              items: _construireElementsNavigation(),              // Liste des onglets
              currentIndex: EtatApplication.instance.indexOngletSelectionne,  // Onglet actuel
              onTap: _changerOnglet,                               // Fonction de changement d'onglet
              
              // STYLE DE LA NAVIGATION
              backgroundColor: Colors.transparent,                 // Transparent pour l'effet glassmorphism
              elevation: 0,                                        // Pas d'ombre
              type: BottomNavigationBarType.fixed,                 // Tous les onglets visibles
              selectedItemColor: CouleursApplication.primaire,     // Couleur de l'onglet actif
              unselectedItemColor: Colors.black54,                 // Couleur des onglets inactifs
              showUnselectedLabels: true,                          // Affiche les labels même pour les onglets inactifs
            ),
          ),
        ),
      ),
    );
  }

  /// MÉTHODE 4 : Construit la liste des éléments de navigation
  List<BottomNavigationBarItem> _construireElementsNavigation() {
    // LISTE STATIQUE : Les onglets ne changent jamais
    return const [
      
      // ONGLET 1 : TRANSCRIPTION (page principale)
      BottomNavigationBarItem(
        icon: Icon(Icons.mic),        // Icône microphone
        label: 'Transcription'       // Texte sous l'icône
      ),
      
      // ONGLET 2 : HISTORIQUE
      BottomNavigationBarItem(
        icon: Icon(Icons.history),    // Icône horloge
        label: 'Historique'
      ),
      
      // ONGLET 3 : ABONNEMENT
      BottomNavigationBarItem(
        icon: Icon(Icons.star),       // Icône étoile
        label: 'Abonnement'
      ),
    ];
  }

// ===================================
// LOGIQUE MÉTIER - NAVIGATION ET ACTIONS
// ===================================

  /// MÉTHODE 5 : Gère le changement d'onglet dans la navigation
  void _changerOnglet(int index) {
    // MISE À JOUR DE L'ÉTAT GLOBAL : Change l'onglet sélectionné
    // Ceci déclenchera automatiquement la reconstruction de l'interface
    // grâce au ListenableBuilder qui écoute EtatApplication
    EtatApplication.instance.changerOngletSelectionne(index);
  }

  /// MÉTHODE 6 : Ouvre la page des paramètres
  void _ouvrirParametres(BuildContext context) {
    // NAVIGATION PUSH : Ouvre une nouvelle page par-dessus la vue actuelle
    // La page des paramètres n'est pas dans la navigation par onglets
    // car c'est une page "modale" qu'on consulte ponctuellement
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PageParametres()),
    );
  }
} 