// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';                    // Import principal Flutter pour les widgets
import '../core/constantes/couleurs_application.dart';     // Couleurs standardisées de l'application

// ===================================
// WIDGET PERSONNALISÉ - BOUTON MODERNE
// ===================================

/// Widget personnalisé pour créer des boutons modernes avec un design cohérent
/// Supporte deux styles : primaire (avec gradient) et secondaire (contour)
/// Peut afficher un état de chargement avec un indicateur de progression
/// 
/// PHILOSOPHIE : Ce widget encapsule la logique de design des boutons pour :
/// 1. Assurer la cohérence visuelle dans toute l'application
/// 2. Simplifier l'utilisation (une seule ligne pour créer un bouton)
/// 3. Centraliser les modifications de style (un seul endroit à modifier)
/// 
/// STATELESSWIDGET : Parfait pour un composant qui ne gère pas d'état interne
/// Tout son comportement dépend des paramètres passés par le parent
class BoutonModerne extends StatelessWidget {
  
  // ===================================
  // CONSTRUCTEUR AVEC PARAMÈTRES
  // ===================================
  
  /// Constructeur du widget avec tous les paramètres configurables
  /// REQUIRED : Paramètres obligatoires pour utiliser le widget
  /// OPTIONAL : Paramètres facultatifs avec valeurs par défaut
  const BoutonModerne({
    super.key,                      // Clé pour l'optimisation Flutter
    required this.texte,            // OBLIGATOIRE : Texte du bouton
    required this.onPressed,        // OBLIGATOIRE : Action au clic
    this.estEnChargement = false,   // OPTIONNEL : État de chargement (défaut: false)
    this.estSecondaire = false,     // OPTIONNEL : Style secondaire (défaut: false = primaire)
    this.icone,                     // OPTIONNEL : Icône avant le texte (défaut: aucune)
  });

  // ===================================
  // PROPRIÉTÉS DU WIDGET
  // ===================================
  
  /// Texte affiché sur le bouton
  /// FINAL : Ne peut pas être modifié après la création du widget
  /// STRING : Type simple pour le texte
  final String texte;
  
  /// Fonction appelée quand le bouton est pressé
  /// VOIDCALLBACK? : Peut être null (bouton désactivé) ou une fonction sans paramètre
  /// Le ? indique que cette valeur peut être null
  final VoidCallback? onPressed;
  
  /// Indique si le bouton est en état de chargement (affiche un spinner)
  /// BOOL : Type booléen (true/false)
  /// Quand true : remplace le contenu par un indicateur de progression
  final bool estEnChargement;
  
  /// Indique si c'est un bouton secondaire (style contour au lieu du gradient)
  /// BOOL : Détermine le style visuel du bouton
  /// false = Bouton primaire (gradient coloré)
  /// true = Bouton secondaire (bordure + fond blanc)
  final bool estSecondaire;
  
  /// Icône optionnelle à afficher avant le texte
  /// ICONDATA? : Type d'icône Material Design (peut être null)
  /// Si fournie, sera affichée à gauche du texte
  final IconData? icone;

  // ===================================
  // MÉTHODE DE CONSTRUCTION DE L'INTERFACE
  // ===================================

  @override
  Widget build(BuildContext context) {
    
    // CONTAINER : Widget principal qui gère la décoration visuelle
    // Alternative à decoration directement sur ElevatedButton pour plus de contrôle
    return Container(
      height: 56,  // HAUTEUR FIXE : Tous les boutons ont la même taille (cohérence UI)
      
      // DECORATION : Gère l'apparence visuelle du bouton
      decoration: BoxDecoration(
        
        // GRADIENT CONDITIONNEL : Seulement pour les boutons primaires
        gradient: estSecondaire 
            ? null  // Pas de gradient pour les boutons secondaires
            : LinearGradient(  // Gradient diagonal pour les boutons primaires
                begin: Alignment.topLeft,      // Début du gradient (coin supérieur gauche)
                end: Alignment.bottomRight,    // Fin du gradient (coin inférieur droit)
                colors: [
                  CouleursApplication.primaire,         // Couleur de départ
                  CouleursApplication.primaire.shade600, // Couleur plus foncée pour l'effet
                ],
              ),
              
        // COULEUR DE FOND : Pour les boutons secondaires uniquement
        color: estSecondaire ? Colors.white : null,
        
        // COINS ARRONDIS : Design moderne avec radius de 16px
        borderRadius: BorderRadius.circular(16),
        
        // BORDURE CONDITIONNELLE : Seulement pour les boutons secondaires
        border: estSecondaire
            ? Border.all(
                color: CouleursApplication.primaire.withValues(alpha: 0.3),  // Bordure semi-transparente
                width: 1.5,  // Épaisseur de la bordure
              )
            : null,  // Pas de bordure pour les boutons primaires
            
        // OMBRE ADAPTÉE : Différente selon le type de bouton
        boxShadow: [
          BoxShadow(
            // COULEUR DE L'OMBRE : Dépend du type de bouton
            color: estSecondaire 
                ? Colors.black.withValues(alpha: 0.05)  // Ombre légère pour boutons secondaires
                : CouleursApplication.primaire.withValues(alpha: 0.3),  // Ombre colorée pour boutons primaires
            blurRadius: estSecondaire ? 10 : 15,   // FLOU : Plus prononcé pour les boutons primaires
            offset: Offset(0, estSecondaire ? 4 : 8),  // DÉCALAGE : Plus bas pour les boutons primaires
          ),
        ],
      ),
      
      // ELEVATEDBUTTON : Widget bouton de base de Flutter
      // Encapsulé dans Container pour plus de contrôle sur le design
      child: ElevatedButton(
        // ACTIVATION CONDITIONNELLE : Désactivé pendant le chargement
        onPressed: estEnChargement ? null : onPressed,
        
        // STYLE DU BOUTON : Annule le style par défaut pour utiliser notre Container
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,  // Transparent pour laisser voir le gradient
          shadowColor: Colors.transparent,      // Pas d'ombre (gérée par Container)
          shape: RoundedRectangleBorder(         // Forme identique au Container
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        
        // CONTENU DU BOUTON : Délégué à une méthode privée pour la lisibilité
        child: _construireContenuBouton(),
      ),
    );
  }

  // ===================================
  // MÉTHODES PRIVÉES - LOGIQUE D'AFFICHAGE
  // ===================================

  /// MÉTHODE PRIVÉE : Construit le contenu du bouton (texte, icône ou indicateur de chargement)
  /// RETOURNE : Widget différent selon l'état du bouton
  Widget _construireContenuBouton() {
    
    // CAS 1 : ÉTAT DE CHARGEMENT
    // Remplace tout le contenu par un spinner de progression
    if (estEnChargement) {
      return SizedBox(
        width: 24,   // TAILLE FIXE : Spinner de taille standard
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,  // ÉPAISSEUR : Ligne fine pour l'élégance
          
          // COULEUR DU SPINNER : Adaptée au type de bouton
          valueColor: AlwaysStoppedAnimation<Color>(
            estSecondaire 
                ? CouleursApplication.primaire  // Coloré sur fond blanc
                : Colors.white,                 // Blanc sur fond coloré
          ),
        ),
      );
    }

    // CAS 2 : CONTENU NORMAL (TEXTE + ICÔNE OPTIONNELLE)
    // Utilise Row pour aligner horizontalement les éléments
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,  // CENTRAGE : Contenu au centre du bouton
      children: [
        
        // SECTION ICÔNE (CONDITIONNELLE)
        // Affiche l'icône si elle est fournie, sinon rien
        if (icone != null) ...[  // SPREAD OPERATOR : Ajoute les éléments seulement si condition vraie
          Icon(
            icone,  // Icône fournie par l'utilisateur
            // COULEUR ADAPTÉE : Suit le style du bouton
            color: estSecondaire ? CouleursApplication.primaire : Colors.white,
            size: 20,  // TAILLE STANDARD : Cohérente avec le texte
          ),
          const SizedBox(width: 8),  // ESPACEMENT : Entre icône et texte
        ],
        
        // SECTION TEXTE (OBLIGATOIRE)
        Text(
          texte,  // Texte fourni par l'utilisateur
          style: TextStyle(
            fontSize: 16,                    // TAILLE : Lisible et proportionnée
            fontWeight: FontWeight.w600,     // GRAISSE : Semi-bold pour l'impact
            // COULEUR ADAPTÉE : Suit le style du bouton
            color: estSecondaire ? CouleursApplication.primaire : Colors.white,
          ),
        ),
      ],
    );
  }
} 