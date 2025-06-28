// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';                    // Import principal de Flutter (widgets, couleurs, etc.)
import '../core/constantes/couleurs_application.dart';     // Fichier contenant toutes les couleurs de l'app
import '../core/constantes/dimensions_application.dart';   // Fichier contenant les tailles (padding, margins, etc.)
import '../widgets/bouton_moderne.dart';                   // Widget personnalisé pour les boutons stylisés

// ===================================
// PAGE D'ABONNEMENT - WIDGET PRINCIPAL
// ===================================

/// Page des abonnements présentant les différents plans disponibles
/// Permet aux utilisateurs de choisir leur formule de transcription
/// 
/// Cette page utilise un StatelessWidget car elle n'a pas besoin de gérer
/// un état interne qui change au cours du temps
class PageAbonnement extends StatelessWidget {
  const PageAbonnement({super.key});

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD : Structure de base d'une page Flutter
    // Fournit la structure de base (AppBar, Body, FloatingActionButton, etc.)
    return Scaffold(
      // Couleur de fond de toute la page
      backgroundColor: CouleursApplication.fondPrincipal,
      
      // BODY : Contenu principal de la page
      body: SingleChildScrollView( // Permet le scroll si le contenu dépasse la taille d'écran
        padding: const EdgeInsets.all(DimensionsApplication.paddingM), // Espacement autour du contenu
        
        // COLUMN : Organise les enfants verticalement (les uns sous les autres)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu à gauche
          children: [
            // 1. EN-TÊTE : Titre et description de la page
            _construireEnteteAbonnement(),
            const SizedBox(height: 32), // Espace vertical de 32 pixels
            
            // 2. PLAN GRATUIT : Premier plan d'abonnement
            _construireCartePlan(
              titre: 'Gratuit',
              prix: '0€',
              periode: '/mois',
              fonctionnalites: [
                '5 minutes de transcription/jour',
                'Qualité standard',
                'Export TXT uniquement',
              ],
              estPopulaire: false, // Pas de badge "POPULAIRE"
              estPlanActuel: true, // C'est le plan actuellement utilisé
            ),
            
            const SizedBox(height: 16), // Espace entre les cartes
            
            // 3. PLAN PRO : Plan recommandé avec badge "POPULAIRE"
            _construireCartePlan(
              titre: 'Pro',
              prix: '9,99€',
              periode: '/mois',
              fonctionnalites: [
                '60 minutes de transcription/jour',
                'Qualité HD avec IA avancée',
                'Export PDF, DOCX, TXT',
                'Historique illimité',
                'Support prioritaire',
              ],
              estPopulaire: true, // Affiche le badge "POPULAIRE"
              estPlanActuel: false, // L'utilisateur n'a pas ce plan
            ),
            
            const SizedBox(height: 16),
            
            // 4. PLAN BUSINESS : Plan le plus complet
            _construireCartePlan(
              titre: 'Business',
              prix: '29,99€',
              periode: '/mois',
              fonctionnalites: [
                'Transcription illimitée',
                'IA ultra-avancée',
                'Tous les formats d\'export',
                'Collaboration équipe',
                'API dédiée',
                'Support 24/7',
              ],
              estPopulaire: false,
              estPlanActuel: false,
            ),
            
            // ESPACE FINAL : Pour éviter que le contenu soit coupé par la navigation
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

// ===================================
// MÉTHODES PRIVÉES - CONSTRUCTION DES WIDGETS
// ===================================

  /// MÉTHODE 1 : Construit l'en-tête de la page avec titre et description
  /// Le underscore (_) indique que cette méthode est privée (utilisable uniquement dans cette classe)
  Widget _construireEnteteAbonnement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligne le texte à gauche
      children: [
        // TITRE PRINCIPAL : Texte large et gras
        const Text(
          'Choisissez votre abonnement',
          style: TextStyle(
            fontSize: 28, // Taille de police large
            fontWeight: FontWeight.w700, // Texte très gras
            color: CouleursApplication.textePrincipal, // Couleur définie dans les constantes
          ),
        ),
        const SizedBox(height: 8), // Petit espace entre titre et description
        
        // DESCRIPTION : Texte plus petit et moins contrasté
        const Text(
          'Débloquez tout le potentiel de NoteCraft',
          style: TextStyle(
            fontSize: 16, // Taille normale
            color: CouleursApplication.texteSecondaire, // Couleur plus claire
          ),
        ),
      ],
    );
  }

  /// MÉTHODE 2 : Construit une carte de plan d'abonnement
  /// Cette méthode est réutilisable pour créer différents plans avec des paramètres différents
  Widget _construireCartePlan({
    required String titre,           // Nom du plan (ex: "Pro")
    required String prix,            // Prix (ex: "9,99€")
    required String periode,         // Période (ex: "/mois")
    required List<String> fonctionnalites, // Liste des fonctionnalités
    required bool estPopulaire,      // Détermine si on affiche le badge "POPULAIRE"
    required bool estPlanActuel,     // Détermine si c'est le plan actuel de l'utilisateur
  }) {
    // CONTAINER : Widget qui permet de styliser un contenu (bordures, ombres, etc.)
    return Container(
      width: double.infinity, // Prend toute la largeur disponible
      
      // DÉCORATION : Style visuel de la carte
      decoration: BoxDecoration(
        color: Colors.white, // Fond blanc
        borderRadius: BorderRadius.circular(DimensionsApplication.radiusL), // Coins arrondis
        
        // BORDURE CONDITIONNELLE : 
        // Si c'est populaire = bordure colorée, sinon = bordure grise
        border: estPopulaire 
            ? Border.all(color: CouleursApplication.primaire, width: 2)
            : Border.all(color: CouleursApplication.bordure),
            
        // OMBRE : Effet de profondeur sous la carte
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05), // Ombre légère et transparente
            blurRadius: 10, // Flou de l'ombre
            offset: const Offset(0, 4), // Décalage de l'ombre (x=0, y=4)
          ),
        ],
      ),
      
      // STACK : Permet de superposer des widgets les uns sur les autres
      child: Stack(
        children: [
          // BADGE "POPULAIRE" : Affiché seulement si estPopulaire = true
          if (estPopulaire) _construireBadgePopulaire(),
          
          // CONTENU PRINCIPAL : Le contenu réel de la carte
          Padding(
            padding: const EdgeInsets.all(DimensionsApplication.paddingXL), // Espacement intérieur
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // En-tête du plan (titre, prix)
                _construireEntetePlan(titre, prix, periode, estPopulaire),
                const SizedBox(height: 24),
                
                // Liste des fonctionnalités
                _construireListeFonctionnalites(fonctionnalites),
                const SizedBox(height: 24),
                
                // Bouton d'action
                _construireBoutonPlan(estPlanActuel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// MÉTHODE 3 : Construit le badge "POPULAIRE" positionné en haut à droite
  Widget _construireBadgePopulaire() {
    // POSITIONED : Positionne un widget à un endroit précis dans un Stack
    return Positioned(
      top: 0,    // En haut
      right: 20, // À 20 pixels du bord droit
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), // Espacement interne
        
        // DÉCORATION DU BADGE : Forme et couleur
        decoration: BoxDecoration(
          color: CouleursApplication.primaire, // Couleur de fond
          // BORDURES ARRONDIES : Seulement en bas pour créer un effet "étiquette"
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        
        // TEXTE DU BADGE
        child: const Text(
          'POPULAIRE',
          style: TextStyle(
            color: Colors.white,        // Texte blanc
            fontSize: 10,              // Petite taille
            fontWeight: FontWeight.bold, // Texte gras
          ),
        ),
      ),
    );
  }

  /// MÉTHODE 4 : Construit l'en-tête du plan (titre, prix, période)
  Widget _construireEntetePlan(String titre, String prix, String periode, bool estPopulaire) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITRE DU PLAN : Nom du plan en gros
        Text(
          titre,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: CouleursApplication.textePrincipal,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // PRIX ET PÉRIODE : Affichés côte à côte
        Row( // ROW organise les enfants horizontalement
          crossAxisAlignment: CrossAxisAlignment.end, // Aligne en bas
          children: [
            // PRIX : Gros chiffre
            Text(
              prix,
              style: TextStyle(
                fontSize: 32, // Très gros
                fontWeight: FontWeight.w800, // Très gras
                // COULEUR CONDITIONNELLE : Coloré si populaire, sinon couleur normale
                color: estPopulaire ? CouleursApplication.primaire : CouleursApplication.textePrincipal,
              ),
            ),
            // PÉRIODE : Plus petit, à côté du prix
            Text(
              periode,
              style: const TextStyle(
                fontSize: 16,
                color: CouleursApplication.texteSecondaire, // Couleur plus claire
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// MÉTHODE 5 : Construit la liste des fonctionnalités du plan
  Widget _construireListeFonctionnalites(List<String> fonctionnalites) {
    return Column(
      // MAP : Transforme chaque fonctionnalité (String) en Widget
      children: fonctionnalites.map((fonctionnalite) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 12), // Espace entre chaque ligne
          child: Row( // Icône + texte sur la même ligne
            children: [
              // ICÔNE DE VALIDATION : Coche verte
              Icon(
                Icons.check_circle, // Icône coche circulaire
                size: 20,
                color: CouleursApplication.succes, // Couleur verte définie dans les constantes
              ),
              const SizedBox(width: 12), // Espace entre icône et texte
              
              // TEXTE DE LA FONCTIONNALITÉ
              Expanded( // Prend tout l'espace restant de la ligne
                child: Text(
                  fonctionnalite,
                  style: const TextStyle(
                    fontSize: 14,
                    color: CouleursApplication.textePrincipal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ).toList(), // Convertit le résultat du map en List<Widget>
    );
  }

  /// MÉTHODE 6 : Construit le bouton d'action du plan
  Widget _construireBoutonPlan(bool estPlanActuel) {
    return SizedBox(
      width: double.infinity, // Bouton prend toute la largeur
      child: BoutonModerne( // Widget personnalisé défini dans widgets/bouton_moderne.dart
        // TEXTE CONDITIONNEL : Change selon si c'est le plan actuel ou non
        texte: estPlanActuel ? 'Plan actuel' : 'Choisir ce plan',
        
        // FONCTION CONDITIONNELLE : 
        // Si c'est le plan actuel = null (bouton désactivé)
        // Sinon = fonction qui sera exécutée au clic
        onPressed: estPlanActuel ? null : () {
          debugPrint('Choix du plan : navigation vers le paiement');
        },
        
        // STYLE CONDITIONNEL : Bouton secondaire si c'est le plan actuel
        estSecondaire: estPlanActuel,
      ),
    );
  }
} 