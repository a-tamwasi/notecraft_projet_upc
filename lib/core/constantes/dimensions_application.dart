/// Classe contenant toutes les dimensions et espacements utilisés dans l'application
/// Cette centralisation assure une cohérence dans les espacements et facilite les ajustements
class DimensionsApplication {
  // Empêche l'instanciation de cette classe utilitaire
  DimensionsApplication._();

  // === PADDINGS (ESPACEMENT INTÉRIEUR) ===
  /// Padding extra-small : 4px - pour les petits espacements
  static const double paddingXS = 4.0;
  
  /// Padding small : 8px - pour les espacements réduits
  static const double paddingS = 8.0;
  
  /// Padding medium : 16px - espacement standard le plus utilisé
  static const double paddingM = 16.0;
  
  /// Padding large : 24px - pour les grands espacements
  static const double paddingL = 24.0;
  
  /// Padding extra-large : 32px - pour les très grands espacements
  static const double paddingXL = 32.0;

  // === MARGES (ESPACEMENT EXTÉRIEUR) ===
  /// Marge standard : 16px - marge de base entre les éléments
  static const double margeStandard = 16.0;
  
  /// Marge moyenne : 24px - pour séparer des groupes d'éléments
  static const double margeMoyenne = 24.0;
  
  /// Marge grande : 32px - pour de grandes séparations
  static const double margeGrande = 32.0;
  
  /// Marge de section : 32px - pour séparer les grandes sections
  static const double margeSection = 32.0;

  // === RAYONS DE BORDURE ===
  /// Rayon small : 4px - pour les petits éléments arrondis
  static const double radiusS = 4.0;
  
  /// Rayon medium : 8px - rayon standard pour la plupart des éléments
  static const double radiusM = 8.0;
  
  /// Rayon large : 16px - pour les cartes et conteneurs principaux
  static const double radiusL = 16.0;
  
  /// Rayon extra-large : 30px - pour les éléments très arrondis
  static const double radiusXL = 30.0;
  
  /// Rayon circulaire : 999px - pour créer des cercles parfaits
  static const double radiusCirculaire = 999.0;

  // === HAUTEURS FIXES ===
  /// Hauteur standard des boutons : 48px
  static const double hauteurBouton = 48.0;
  
  /// Hauteur de l'AppBar : 56px (standard Material Design)
  static const double hauteurAppBar = 56.0;
  
  /// Hauteur des champs de texte : 56px
  static const double hauteurChampTexte = 56.0;
} 