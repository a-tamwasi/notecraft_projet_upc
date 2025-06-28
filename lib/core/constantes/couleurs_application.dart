// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';                    // Import pour les types Color et MaterialColor

// ===================================
// SYSTÈME DE COULEURS - DESIGN SYSTEM
// ===================================

/// Classe contenant toutes les couleurs utilisées dans l'application NoteCraft
/// Cette centralisation permet une cohérence visuelle et facilite la maintenance
/// 
/// PHILOSOPHIE DU DESIGN SYSTEM :
/// Au lieu d'utiliser des couleurs aléatoires partout dans l'application,
/// cette classe centralise TOUTES les couleurs en un seul endroit. Avantages :
/// 1. COHÉRENCE : Toute l'app utilise exactement les mêmes couleurs
/// 2. MAINTENANCE : Pour changer une couleur, on modifie ici seulement
/// 3. BRANDING : Respect strict de l'identité visuelle de la marque
/// 4. ACCESSIBILITÉ : Couleurs choisies pour être lisibles par tous
/// 5. ORGANISATION : Développeurs savent exactement quelle couleur utiliser
/// 
/// PATTERN UTILITY CLASS : Classe qui contient seulement des constantes statiques
/// Aucune instance n'est créée, on accède directement via CouleursApplication.primaire
class CouleursApplication {
  
  // ===================================
  // PROTECTION CONTRE L'INSTANCIATION
  // ===================================
  
  /// Empêche l'instanciation de cette classe utilitaire
  /// CONSTRUCTEUR PRIVÉ : Le _ rend le constructeur inaccessible depuis l'extérieur
  /// OBJECTIF : Cette classe ne doit jamais être instanciée (comme une bibliothèque de constantes)
  /// USAGE CORRECT : CouleursApplication.primaire ✅
  /// USAGE INCORRECT : CouleursApplication() ❌ (impossible)
  CouleursApplication._();

  // ===================================
  // COULEURS PRINCIPALES - IDENTITÉ VISUELLE
  // ===================================

  /// Couleur principale de l'application (bleu)
  /// MATERIALCOLOR : Type spécial Flutter qui génère automatiquement des variantes
  /// (shade100, shade200, shade300, etc.) pour différents usages
  /// USAGE : Boutons principaux, AppBar, éléments importants, gradients
  /// PSYCHOLOGIE : Bleu = Confiance, professionnalisme, technologie
  static const MaterialColor primaire = Colors.blue;
  
  /// Couleur secondaire pour les accents et éléments complémentaires
  /// COLOR PERSONNALISÉE : Couleur définie par son code hexadécimal
  /// 0xFF : Opacité complète (FF) + code couleur (03DAC6 = cyan/turquoise)
  /// USAGE : Éléments secondaires, highlights, détails décoratifs
  /// COMPLÉMENTAIRE : S'harmonise avec le bleu principal
  static const Color secondaire = Color(0xFF03DAC6);
  
  /// Couleur d'accent pour attirer l'attention sur certains éléments
  /// ROUGE CORAIL : Couleur chaude qui contraste avec les bleus
  /// USAGE : Call-to-action importants, alertes positives, badges "populaire"
  /// ATTENTION : À utiliser avec parcimonie pour garder son impact
  static const Color accent = Color(0xFFFF6B6B);

  // ===================================
  // COULEURS DE FOND - HIÉRARCHIE VISUELLE
  // ===================================

  /// Couleur de fond principale de l'application (gris très clair)
  /// F5F5F5 : Gris très clair, presque blanc mais avec une légère teinte
  /// USAGE : Fond des pages principales, arrière-plan général
  /// AVANTAGE : Moins fatiguant que le blanc pur, crée de la profondeur
  static const Color fondPrincipal = Color(0xFFF5F5F5);
  
  /// Couleur de fond secondaire (blanc pur)
  /// BLANC PUR : Contraste maximum pour le texte noir
  /// USAGE : Cartes, modals, zones de contenu important
  /// HIÉRARCHIE : Se détache du fond principal gris
  static const Color fondSecondaire = Colors.white;

  // ===================================
  // COULEURS DE TEXTE - LISIBILITÉ OPTIMALE
  // ===================================

  /// Couleur du texte principal (noir foncé)
  /// 212121 : Noir très foncé mais pas complètement noir (plus doux pour les yeux)
  /// USAGE : Titres, texte important, contenu principal
  /// ACCESSIBILITÉ : Contraste maximal avec les fonds clairs
  static const Color textePrincipal = Color(0xFF212121);
  
  /// Couleur du texte secondaire (gris moyen)
  /// 757575 : Gris moyen pour hiérarchiser l'information
  /// USAGE : Sous-titres, descriptions, texte moins important
  /// HIÉRARCHIE VISUELLE : Plus discret que le texte principal
  static const Color texteSecondaire = Color(0xFF757575);

  // ===================================
  // COULEURS SÉMANTIQUES - COMMUNICATION VISUELLE
  // ===================================

  /// Couleur pour les messages d'erreur
  /// ROUGE FONCÉ : Universellement reconnu pour les erreurs
  /// USAGE : Messages d'erreur, validation échouée, actions dangereuses
  /// PSYCHOLOGIE : Rouge = Danger, attention, erreur
  static const Color erreur = Color(0xFFB00020);
  
  /// Couleur pour les messages de succès
  /// VERT MATERIAL : Couleur positive et rassurante
  /// USAGE : Validation réussie, confirmation d'actions, états positifs
  /// PSYCHOLOGIE : Vert = Succès, validation, sécurité
  static const Color succes = Color(0xFF4CAF50);
  
  /// Couleur pour les avertissements
  /// JAUNE/ORANGE : Attire l'attention sans alarmer
  /// USAGE : Alertes importantes, limites atteintes, actions à confirmer
  /// PSYCHOLOGIE : Jaune = Attention, prudence, information importante
  static const Color avertissement = Color(0xFFFFC107);
  
  /// Couleur pour les informations
  /// BLEU INFORMATION : Neutre et informatif
  /// USAGE : Messages informatifs, conseils, indications neutres
  /// PSYCHOLOGIE : Bleu clair = Information, aide, neutralité
  static const Color info = Color(0xFF2196F3);

  // ===================================
  // COULEURS UTILITAIRES - ÉLÉMENTS D'INTERFACE
  // ===================================

  /// Couleur d'ombre pour les effets visuels
  /// 1F000000 : Noir avec opacité faible (1F = ~12% d'opacité)
  /// USAGE : BoxShadow, ombres des cartes, profondeur visuelle
  /// SUBTILITÉ : Assez discrète pour ne pas surcharger l'interface
  static const Color ombre = Color(0x1F000000);
  
  /// Couleur des bordures
  /// E0E0E0 : Gris très clair pour délimiter sans agresser
  /// USAGE : Bordures des champs, séparations, contours
  /// DISCRÉTION : Visible mais non intrusive
  static const Color bordure = Color(0xFFE0E0E0);
}

// ===================================
// GUIDE D'UTILISATION DES COULEURS
// ===================================

/*
HIÉRARCHIE D'IMPORTANCE DES COULEURS :

1. COULEUR PRIMAIRE (primaire) :
   ✅ Boutons principaux, navigation active
   ✅ Éléments les plus importants
   ❌ Ne pas utiliser partout (perte d'impact)

2. COULEUR SECONDAIRE (secondaire) :
   ✅ Éléments complémentaires, accents subtils
   ✅ Icônes, détails décoratifs
   
3. COULEUR D'ACCENT (accent) :
   ✅ Call-to-action critiques, badges spéciaux
   ❌ Utilisation très modérée

RÈGLES DE CONTRASTE ET ACCESSIBILITÉ :

• textePrincipal sur fondSecondaire : Contraste maximum
• texteSecondaire sur fondPrincipal : Lecture confortable
• Couleurs sémantiques : Respectent les standards d'accessibilité
• Ombres : Ajoutent de la profondeur sans gêner la lecture

EXEMPLES D'USAGE DANS L'APPLICATION :

• AppBar : primaire (couleur de marque)
• Boutons principaux : primaire avec gradient
• Boutons secondaires : bordure primaire sur fondSecondaire
• Champs de saisie : fondSecondaire avec bordure
• Texte principal : textePrincipal
• Descriptions : texteSecondaire
• Messages d'erreur : erreur + fondSecondaire
• Cartes : fondSecondaire avec ombre

MAINTENANCE ET ÉVOLUTIVITÉ :

Pour changer le thème de l'application :
1. Modifier les couleurs principales ici
2. Toute l'application s'adapte automatiquement
3. Tester le contraste et l'accessibilité
4. Valider avec l'équipe design

Cette approche garantit une application visuellement cohérente
et facilement maintenable ! 🎨✨
*/ 