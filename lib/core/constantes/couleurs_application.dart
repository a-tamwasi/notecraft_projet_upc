import 'package:flutter/material.dart';

/// Classe contenant toutes les couleurs utilisées dans l'application NoteCraft
/// Cette centralisation permet une cohérence visuelle et facilite la maintenance
class CouleursApplication {
  // Empêche l'instanciation de cette classe utilitaire
  CouleursApplication._();

  /// Couleur principale de l'application (bleu)
  static const MaterialColor primaire = Colors.blue;
  
  /// Couleur secondaire pour les accents et éléments complémentaires
  static const Color secondaire = Color(0xFF03DAC6);
  
  /// Couleur d'accent pour attirer l'attention sur certains éléments
  static const Color accent = Color(0xFFFF6B6B);
  
  /// Couleur de fond principale de l'application (gris très clair)
  static const Color fondPrincipal = Color(0xFFF5F5F5);
  
  /// Couleur de fond secondaire (blanc pur)
  static const Color fondSecondaire = Colors.white;
  
  /// Couleur du texte principal (noir foncé)
  static const Color textePrincipal = Color(0xFF212121);
  
  /// Couleur du texte secondaire (gris moyen)
  static const Color texteSecondaire = Color(0xFF757575);
  
  /// Couleur pour les messages d'erreur
  static const Color erreur = Color(0xFFB00020);
  
  /// Couleur pour les messages de succès
  static const Color succes = Color(0xFF4CAF50);
  
  /// Couleur pour les avertissements
  static const Color avertissement = Color(0xFFFFC107);
  
  /// Couleur pour les informations
  static const Color info = Color(0xFF2196F3);
  
  /// Couleur d'ombre pour les effets visuels
  static const Color ombre = Color(0x1F000000);
  
  /// Couleur des bordures
  static const Color bordure = Color(0xFFE0E0E0);
} 