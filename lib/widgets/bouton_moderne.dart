import 'package:flutter/material.dart';
import '../core/constantes/couleurs_application.dart';

/// Widget personnalisé pour créer des boutons modernes avec un design cohérent
/// Supporte deux styles : primaire (avec gradient) et secondaire (contour)
/// Peut afficher un état de chargement avec un indicateur de progression
class BoutonModerne extends StatelessWidget {
  const BoutonModerne({
    super.key,
    required this.texte,
    required this.onPressed,
    this.estEnChargement = false,
    this.estSecondaire = false,
    this.icone,
  });

  /// Texte affiché sur le bouton
  final String texte;
  
  /// Fonction appelée quand le bouton est pressé
  final VoidCallback? onPressed;
  
  /// Indique si le bouton est en état de chargement (affiche un spinner)
  final bool estEnChargement;
  
  /// Indique si c'est un bouton secondaire (style contour au lieu du gradient)
  final bool estSecondaire;
  
  /// Icône optionnelle à afficher avant le texte
  final IconData? icone;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        // Gradient uniquement pour les boutons primaires
        gradient: estSecondaire 
            ? null 
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CouleursApplication.primaire,
                  CouleursApplication.primaire.shade600,
                ],
              ),
        // Couleur de fond pour les boutons secondaires
        color: estSecondaire ? Colors.white : null,
        borderRadius: BorderRadius.circular(16),
        // Bordure pour les boutons secondaires
        border: estSecondaire
            ? Border.all(
                color: CouleursApplication.primaire.withOpacity(0.3),
                width: 1.5,
              )
            : null,
        // Ombre adaptée au type de bouton
        boxShadow: [
          BoxShadow(
            color: estSecondaire 
                ? Colors.black.withOpacity(0.05)
                : CouleursApplication.primaire.withOpacity(0.3),
            blurRadius: estSecondaire ? 10 : 15,
            offset: Offset(0, estSecondaire ? 4 : 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: estEnChargement ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: _construireContenuBouton(),
      ),
    );
  }

  /// Construit le contenu du bouton (texte, icône ou indicateur de chargement)
  Widget _construireContenuBouton() {
    if (estEnChargement) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            estSecondaire ? CouleursApplication.primaire : Colors.white,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Affiche l'icône si elle est fournie
        if (icone != null) ...[
          Icon(
            icone,
            color: estSecondaire ? CouleursApplication.primaire : Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
        ],
        // Texte du bouton
        Text(
          texte,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: estSecondaire ? CouleursApplication.primaire : Colors.white,
          ),
        ),
      ],
    );
  }
} 