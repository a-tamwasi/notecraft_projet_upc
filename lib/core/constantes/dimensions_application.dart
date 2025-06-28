// ===================================
// SYSTÈME DE DIMENSIONS - DESIGN SYSTEM SPATIAL
// ===================================

/// Classe contenant toutes les dimensions et espacements utilisés dans l'application
/// Cette centralisation assure une cohérence dans les espacements et facilite les ajustements
/// 
/// PHILOSOPHIE DU DESIGN SYSTEM SPATIAL :
/// Au lieu d'utiliser des valeurs d'espacement aléatoires (10px par ici, 15px par là),
/// cette classe définit un système cohérent et harmonieux. Avantages :
/// 1. COHÉRENCE VISUELLE : Tous les espacements suivent la même logique
/// 2. HARMONIE : Les proportions créent un rythme visuel agréable
/// 3. MAINTENANCE : Modifier un espacement dans toute l'app en un clic
/// 4. RAPIDITÉ : Les développeurs savent immédiatement quelle valeur utiliser
/// 5. PROFESSIONNALISME : L'app paraît plus soignée et réfléchie
/// 
/// SYSTÈME EN BASE 8 : Toutes les valeurs sont multiples de 4 ou 8
/// Cette approche est recommandée par Google Material Design et Apple HIG
/// 4, 8, 16, 24, 32... = Rythme visuel naturel et harmonieux
/// 
/// PATTERN UTILITY CLASS : Classe statique sans instanciation possible
class DimensionsApplication {
  
  // ===================================
  // PROTECTION CONTRE L'INSTANCIATION
  // ===================================
  
  /// Empêche l'instanciation de cette classe utilitaire
  /// CONSTRUCTEUR PRIVÉ : Cette classe sert uniquement de bibliothèque de constantes
  /// USAGE CORRECT : DimensionsApplication.paddingM ✅
  /// USAGE INCORRECT : DimensionsApplication() ❌ (impossible)
  DimensionsApplication._();

  // ===================================
  // PADDINGS (ESPACEMENT INTÉRIEUR) - RESPIRATION INTERNE
  // ===================================
  
  /// QU'EST-CE QUE LE PADDING ?
  /// Le padding est l'espace INTÉRIEUR d'un élément, entre sa bordure et son contenu
  /// Exemple : Dans un bouton, le padding sépare le texte des bords du bouton
  /// Plus le padding est grand, plus l'élément paraît "aéré" et confortable
  
  /// Padding extra-small : 4px - pour les petits espacements
  /// USAGE : Espacement minimal dans les listes denses, icônes collées
  /// EXEMPLE : Espace entre une icône et son badge, padding dans les chips
  static const double paddingXS = 4.0;
  
  /// Padding small : 8px - pour les espacements réduits
  /// USAGE : Éléments compacts, espacement dans les petits boutons
  /// EXEMPLE : Padding dans les boutons d'action secondaires, espacement dans les tags
  static const double paddingS = 8.0;
  
  /// Padding medium : 16px - espacement standard le plus utilisé
  /// USAGE : 80% des cas d'usage, espacement par défaut recommandé
  /// EXEMPLE : Padding des cartes, contenu des pages, boutons principaux
  /// RÈGLE D'OR : En cas de doute, utiliser cette valeur
  static const double paddingM = 16.0;
  
  /// Padding large : 24px - pour les grands espacements
  /// USAGE : Éléments importants qui ont besoin de respirer
  /// EXEMPLE : Padding des modals, containers de formulaires, sections importantes
  static const double paddingL = 24.0;
  
  /// Padding extra-large : 32px - pour les très grands espacements
  /// USAGE : Éléments exceptionnels, zones de contenu principal
  /// EXEMPLE : Padding des pages d'accueil, containers de hero sections
  static const double paddingXL = 32.0;

  // ===================================
  // MARGES (ESPACEMENT EXTÉRIEUR) - SÉPARATION ENTRE ÉLÉMENTS
  // ===================================
  
  /// QU'EST-CE QUE LA MARGE ?
  /// La marge est l'espace EXTÉRIEUR d'un élément, qui le sépare des autres éléments
  /// Exemple : Marge entre deux boutons, espace entre des sections de page
  /// Plus la marge est grande, plus les éléments paraissent séparés et organisés
  
  /// Marge standard : 16px - marge de base entre les éléments
  /// USAGE : Espacement par défaut entre widgets, séparation standard
  /// EXEMPLE : Espace entre deux boutons, marge entre les items d'une liste
  /// COHÉRENCE : Même valeur que paddingM pour l'harmonie visuelle
  static const double margeStandard = 16.0;
  
  /// Marge moyenne : 24px - pour séparer des groupes d'éléments
  /// USAGE : Séparation entre groupes logiques d'éléments
  /// EXEMPLE : Espace entre le header et le contenu, entre différentes sections d'un formulaire
  static const double margeMoyenne = 24.0;
  
  /// Marge grande : 32px - pour de grandes séparations
  /// USAGE : Séparation importante, éléments qui doivent être bien distincts
  /// EXEMPLE : Marge autour d'un call-to-action principal, séparation de zones importantes
  static const double margeGrande = 32.0;
  
  /// Marge de section : 32px - pour séparer les grandes sections
  /// USAGE : Délimitation claire entre les sections principales d'une page
  /// EXEMPLE : Espace entre le header et le body, entre différents modules de l'interface
  /// COHÉRENCE : Même valeur que margeGrande pour simplifier les choix
  static const double margeSection = 32.0;

  // ===================================
  // RAYONS DE BORDURE - DOUCEUR ET MODERNITÉ
  // ===================================
  
  /// QU'EST-CE QUE LE RAYON DE BORDURE ?
  /// Le rayon détermine à quel point les coins sont arrondis
  /// 0 = Coins carrés (style classique/corporatif)
  /// Valeur moyenne = Coins arrondis (style moderne/friendly)
  /// Valeur élevée = Très arrondi ou circulaire (style fun/app mobile)
  
  /// Rayon small : 4px - pour les petits éléments arrondis
  /// USAGE : Éléments fins et délicats, bordures subtiles
  /// EXEMPLE : Badges, petits boutons, bordures de champs de texte
  static const double radiusS = 4.0;
  
  /// Rayon medium : 8px - rayon standard pour la plupart des éléments
  /// USAGE : Rayon par défaut, équilibre entre moderne et sobre
  /// EXEMPLE : Boutons standards, cartes secondaires, containers moyens
  static const double radiusM = 8.0;
  
  /// Rayon large : 16px - pour les cartes et conteneurs principaux
  /// USAGE : Éléments importants, interface moderne et accueillante
  /// EXEMPLE : Cartes principales, modals, boutons d'action principaux
  /// STYLE : Donne un aspect très moderne et mobile-first
  static const double radiusL = 16.0;
  
  /// Rayon extra-large : 30px - pour les éléments très arrondis
  /// USAGE : Éléments spéciaux qui doivent attirer l'attention
  /// EXEMPLE : Boutons call-to-action exceptionnels, éléments décoratifs
  /// ATTENTION : À utiliser avec parcimonie pour garder l'impact
  static const double radiusXL = 30.0;
  
  /// Rayon circulaire : 999px - pour créer des cercles parfaits
  /// USAGE : Éléments qui doivent être parfaitement ronds
  /// EXEMPLE : Avatars, boutons flottants (FAB), badges ronds, boutons d'enregistrement
  /// ASTUCE : 999px garantit un cercle même si l'élément grandit
  static const double radiusCirculaire = 999.0;

  // ===================================
  // HAUTEURS FIXES - STANDARDS D'INTERFACE
  // ===================================
  
  /// POURQUOI DES HAUTEURS FIXES ?
  /// Certains éléments UI ont des hauteurs standardisées pour :
  /// 1. COHÉRENCE : Tous les boutons font la même taille
  /// 2. ERGONOMIE : Hauteurs optimisées pour le touch mobile
  /// 3. ALIGNEMENT : Éléments qui s'alignent parfaitement
  /// 4. ACCESSIBILITÉ : Tailles respectant les standards d'accessibilité
  
  /// Hauteur standard des boutons : 48px
  /// STANDARD MOBILE : Taille minimale recommandée pour les éléments tactiles
  /// ACCESSIBILITÉ : Respecte les guidelines d'accessibilité (44pt minimum sur iOS, 48dp sur Android)
  /// USAGE : Tous les boutons de l'application (primaires, secondaires)
  static const double hauteurBouton = 48.0;
  
  /// Hauteur de l'AppBar : 56px (standard Material Design)
  /// MATERIAL DESIGN : Hauteur officielle recommandée par Google
  /// COHÉRENCE : Respecte les standards que les utilisateurs connaissent
  /// USAGE : AppBar de toutes les pages, headers de navigation
  static const double hauteurAppBar = 56.0;
  
  /// Hauteur des champs de texte : 56px
  /// COHÉRENCE : Même hauteur que l'AppBar pour l'harmonie visuelle
  /// ERGONOMIE : Assez haute pour être facilement touchable et lisible
  /// USAGE : TextFormField, champs de saisie, zones d'input
  static const double hauteurChampTexte = 56.0;
}

// ===================================
// GUIDE D'UTILISATION DES DIMENSIONS
// ===================================

/*
RÈGLES DE CHOIX D'ESPACEMENT :

1. PADDING (espacement intérieur) :
   • paddingXS (4px) : Espaces très réduits, éléments denses
   • paddingS (8px) : Boutons compacts, éléments secondaires
   • paddingM (16px) : DÉFAUT - utilisez ceci dans 80% des cas
   • paddingL (24px) : Zones importantes, formulaires
   • paddingXL (32px) : Sections principales, hero areas

2. MARGE (espacement extérieur) :
   • margeStandard (16px) : Entre widgets individuels
   • margeMoyenne (24px) : Entre groupes d'éléments
   • margeGrande (32px) : Entre sections importantes
   • margeSection (32px) : Entre modules principaux

3. RAYON DE BORDURE (arrondis) :
   • radiusS (4px) : Éléments fins, bordures subtiles
   • radiusM (8px) : DÉFAUT - style moderne équilibré
   • radiusL (16px) : Cartes principales, boutons importants
   • radiusXL (30px) : Éléments exceptionnels
   • radiusCirculaire (999px) : Cercles parfaits

EXEMPLES CONCRETS DANS L'APPLICATION :

• Page principale : paddingM (16px) sur les côtés
• Boutons : hauteurBouton (48px) + radiusL (16px)
• Cartes : paddingM à l'intérieur + radiusL pour les coins
• Champs de saisie : hauteurChampTexte (56px) + radiusL (16px)
• AppBar : hauteurAppBar (56px) standard Material Design
• Entre deux sections : margeSection (32px)
• Entre deux boutons : margeStandard (16px)

CONSEILS POUR DÉBUTANTS :

1. EN CAS DE DOUTE : Utilisez paddingM et margeStandard
2. COHÉRENCE : Utilisez toujours les mêmes valeurs pour les mêmes usages
3. MOINS C'EST PLUS : Mieux vaut 3-4 valeurs bien utilisées que 10 valeurs différentes
4. TESTEZ SUR MOBILE : Vérifiez que les espacements sont agréables sur petit écran
5. HIÉRARCHIE : Plus un élément est important, plus il peut avoir d'espace autour

Cette approche systématique garantit une interface harmonieuse,
professionnelle et agréable à utiliser ! 📏✨
*/ 