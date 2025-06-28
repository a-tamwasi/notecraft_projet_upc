// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';                    // Import principal Flutter pour les widgets
import '../core/constantes/couleurs_application.dart';     // Couleurs standardisées de l'application

// ===================================
// WIDGET PERSONNALISÉ - CHAMP DE SAISIE
// ===================================

/// Widget personnalisé pour créer des champs de saisie avec un design moderne
/// Supporte les mots de passe, les icônes préfixes et la validation
/// 
/// PHILOSOPHIE : Ce widget encapsule la complexité des TextFormField pour :
/// 1. Assurer un design cohérent dans tous les formulaires
/// 2. Simplifier l'ajout de fonctionnalités (validation, icônes, types)
/// 3. Gérer automatiquement les états visuels (focus, erreur)
/// 
/// STATELESSWIDGET : Parfait car le contrôleur gère l'état du texte
/// Le widget parent contrôle la logique, ce widget gère seulement l'affichage
class ChampSaisie extends StatelessWidget {
  
  // ===================================
  // CONSTRUCTEUR AVEC PARAMÈTRES
  // ===================================
  
  /// Constructeur avec paramètres configurables pour différents types de champs
  /// REQUIRED : Paramètres essentiels (libellé et contrôleur)
  /// OPTIONAL : Fonctionnalités avancées (validation, icônes, types)
  const ChampSaisie({
    super.key,                          // Clé pour l'optimisation Flutter
    required this.libelle,              // OBLIGATOIRE : Texte d'aide pour l'utilisateur
    required this.controleur,           // OBLIGATOIRE : Gestionnaire du texte saisi
    this.estMotDePasse = false,         // OPTIONNEL : Masque le texte (défaut: false)
    this.iconePrefixe,                  // OPTIONNEL : Icône au début du champ
    this.validateur,                    // OPTIONNEL : Fonction de validation personnalisée
    this.typeClavier,                   // OPTIONNEL : Type de clavier (email, numérique, etc.)
  });

  // ===================================
  // PROPRIÉTÉS DU WIDGET
  // ===================================

  /// Libellé affiché dans le champ (placeholder)
  /// STRING : Texte d'aide qui guide l'utilisateur
  /// Exemple : "Adresse email", "Mot de passe", "Nom complet"
  final String libelle;
  
  /// Contrôleur pour gérer le texte saisi
  /// TEXTEDITINGCONTROLLER : Point central de gestion du texte
  /// Permet de : lire le texte, le modifier, vider le champ, écouter les changements
  final TextEditingController controleur;
  
  /// Indique si c'est un champ mot de passe (masque le texte)
  /// BOOL : Quand true, remplace les caractères par des points
  /// Sécurité : Évite que le texte soit visible à l'écran
  final bool estMotDePasse;
  
  /// Icône optionnelle à afficher au début du champ
  /// ICONDATA? : Icône Material Design (peut être null)
  /// Usage : Email (Icons.email), Mot de passe (Icons.lock), etc.
  final IconData? iconePrefixe;
  
  /// Fonction de validation personnalisée
  /// FUNCTION? : Prend le texte saisi et retourne un message d'erreur ou null
  /// null = validation réussie, String = message d'erreur à afficher
  /// Exemple : vérifier format email, longueur minimum, etc.
  final String? Function(String?)? validateur;
  
  /// Type de clavier à afficher (email, numérique, etc.)
  /// TEXTINPUTTYPE? : Optimise le clavier selon le type de données
  /// Exemples : TextInputType.emailAddress, TextInputType.number
  final TextInputType? typeClavier;

  // ===================================
  // MÉTHODE DE CONSTRUCTION DE L'INTERFACE
  // ===================================

  @override
  Widget build(BuildContext context) {
    
    // CONTAINER : Wrapper externe pour la décoration et l'ombre
    // Sépare la décoration du Container de celle du TextFormField pour plus de contrôle
    return Container(
      // DÉCORATION DU CONTAINER : Ombre et apparence générale
      decoration: BoxDecoration(
        color: Colors.white,                      // FOND BLANC : Contraste avec la page
        borderRadius: BorderRadius.circular(16),  // COINS ARRONDIS : Design moderne
        
        // OMBRE SUBTILE : Donne de la profondeur au champ
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),  // Ombre très légère
            blurRadius: 10,                         // Flou doux
            offset: const Offset(0, 4),             // Décalage vers le bas
          ),
        ],
      ),
      
      // TEXTFORMFIELD : Widget principal de saisie de texte
      // Version avancée de TextField avec support de validation intégré
      child: TextFormField(
        controller: controleur,          // CONTRÔLEUR : Gestion du texte
        obscureText: estMotDePasse,      // MASQUAGE : Pour les mots de passe
        keyboardType: typeClavier,       // TYPE CLAVIER : Optimisation selon le contenu
        
        // STYLE DU TEXTE SAISI : Apparence du texte tapé par l'utilisateur
        style: const TextStyle(
          fontSize: 16,                  // TAILLE : Lisible sur mobile
          fontWeight: FontWeight.w400,   // GRAISSE : Normale pour le texte saisi
        ),
        
        // DECORATION : Apparence du champ (bordures, libellé, icônes)
        decoration: InputDecoration(
          
          // LIBELLÉ : Texte d'aide qui flotte au-dessus du champ
          labelText: libelle,
          labelStyle: const TextStyle(
            color: CouleursApplication.texteSecondaire,  // Couleur discrète
            fontWeight: FontWeight.w500,                 // Légèrement gras
          ),
          
          // ICÔNE PRÉFIXE : Construction conditionnelle
          // Si une icône est fournie, utilise la méthode privée pour la construire
          prefixIcon: iconePrefixe != null ? _construireIconePrefixe() : null,
          
          // BORDURE PAR DÉFAUT : État normal (non focalisé)
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),  // Coins arrondis identiques au Container
            borderSide: BorderSide.none,              // Pas de bordure visible (transparente)
          ),
          
          // BORDURE DE FOCUS : État quand l'utilisateur tape
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: CouleursApplication.primaire,     // Couleur de la marque
              width: 2,                                // Largeur plus importante pour la visibilité
            ),
          ),
          
          // PADDING INTERNE : Espace entre le texte et les bords
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,  // Espace gauche/droite
            vertical: 16,    // Espace haut/bas
          ),
          
          // FOND DU CHAMP : Configuration du remplissage
          filled: true,              // Active le remplissage de couleur
          fillColor: Colors.white,   // Couleur de remplissage (identique au Container)
        ),
        
        // VALIDATEUR : Fonction de validation pour les formulaires
        // Appelée automatiquement lors de la validation du formulaire
        validator: validateur,
      ),
    );
  }

  // ===================================
  // MÉTHODES PRIVÉES - CONSTRUCTION D'ÉLÉMENTS
  // ===================================

  /// MÉTHODE PRIVÉE : Construit l'icône préfixe avec un style cohérent
  /// RETOURNE : Widget icône encapsulée dans un container stylé
  Widget _construireIconePrefixe() {
    // CONTAINER STYLÉ : Encapsule l'icône dans un fond coloré
    return Container(
      // MARGES : Espace entre l'icône et les bords du champ
      margin: const EdgeInsets.all(12),
      
      // PADDING : Espace interne autour de l'icône
      padding: const EdgeInsets.all(8),
      
      // DÉCORATION : Fond coloré et coins arrondis pour l'icône
      decoration: BoxDecoration(
        // COULEUR DE FOND : Version très transparente de la couleur primaire
                    color: CouleursApplication.primaire.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),  // Coins arrondis plus petits que le champ
      ),
      
      // ICÔNE : Widget icône avec style personnalisé
      child: Icon(
        iconePrefixe,                       // Icône fournie par l'utilisateur
        color: CouleursApplication.primaire, // Couleur coordonnée avec le thème
        size: 20,                           // Taille optimale pour la lisibilité
      ),
    );
  }
} 