import 'package:flutter/material.dart';
import '../core/constantes/couleurs_application.dart';

/// Widget personnalisé pour créer des champs de saisie avec un design moderne
/// Supporte les mots de passe, les icônes préfixes et la validation
class ChampSaisie extends StatelessWidget {
  const ChampSaisie({
    super.key,
    required this.libelle,
    required this.controleur,
    this.estMotDePasse = false,
    this.iconePrefixe,
    this.validateur,
    this.typeClavier,
  });

  /// Libellé affiché dans le champ (placeholder)
  final String libelle;
  
  /// Contrôleur pour gérer le texte saisi
  final TextEditingController controleur;
  
  /// Indique si c'est un champ mot de passe (masque le texte)
  final bool estMotDePasse;
  
  /// Icône optionnelle à afficher au début du champ
  final IconData? iconePrefixe;
  
  /// Fonction de validation personnalisée
  final String? Function(String?)? validateur;
  
  /// Type de clavier à afficher (email, numérique, etc.)
  final TextInputType? typeClavier;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // Ombre subtile pour donner de la profondeur
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controleur,
        obscureText: estMotDePasse,
        keyboardType: typeClavier,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: libelle,
          labelStyle: const TextStyle(
            color: CouleursApplication.texteSecondaire,
            fontWeight: FontWeight.w500,
          ),
          // Construction de l'icône préfixe si fournie
          prefixIcon: iconePrefixe != null ? _construireIconePrefixe() : null,
          // Bordure par défaut (transparente)
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          // Bordure quand le champ est sélectionné
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: CouleursApplication.primaire,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: validateur,
      ),
    );
  }

  /// Construit l'icône préfixe avec un style cohérent
  Widget _construireIconePrefixe() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CouleursApplication.primaire.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconePrefixe,
        color: CouleursApplication.primaire,
        size: 20,
      ),
    );
  }
} 