// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';                    // Import principal Flutter (widgets, dialogs, etc.)
import '../core/constantes/couleurs_application.dart';     // Couleurs standardisées de l'application
import '../core/constantes/dimensions_application.dart';   // Tailles et espacements constants
import '../core/etat/etat_application.dart';               // Gestionnaire d'état global (utilisateur connecté)
import '../widgets/bouton_moderne.dart';                   // Widget personnalisé pour les boutons

// ===================================
// PAGE DE PARAMÈTRES - WIDGET PRINCIPAL
// ===================================

/// Page des paramètres permettant de gérer le profil utilisateur
/// et configurer les préférences de l'application
/// 
/// STATELESSWIDGET : Utilisé car les données utilisateur viennent de l'état global
/// Les changements d'état se font via EtatApplication, pas via setState local
class PageParametres extends StatelessWidget {
  const PageParametres({super.key});

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD : Structure de base avec AppBar personnalisée
    return Scaffold(
      backgroundColor: Colors.white,  // Fond blanc pour contraste avec les cartes
      appBar: _construireAppBar(),    // AppBar personnalisée avec style cohérent
      
      // COLUMN : Organisation verticale en 2 sections principales
      body: Column(
        children: [
          // SECTION 1 : Profil utilisateur (en haut, taille fixe)
          _construireSectionProfil(),
          
          // SECTION 2 : Liste des paramètres (remplit l'espace restant)
          Expanded(  // Prend tout l'espace vertical restant
            child: _construireListeParametres(context),
          ),
        ],
      ),
    );
  }

// ===================================
// MÉTHODES PRIVÉES - CONSTRUCTION DES WIDGETS
// ===================================

  /// MÉTHODE 1 : Construit l'AppBar personnalisée de la page
  PreferredSizeWidget _construireAppBar() {
    return AppBar(
      // TITRE CENTRÉ
      title: const Text(
        'Paramètres',
        style: TextStyle(
          color: CouleursApplication.textePrincipal,  // Couleur cohérente avec l'app
          fontWeight: FontWeight.w600,                // Semi-gras pour l'importance
        ),
      ),
      
      // STYLE DE L'APPBAR
      backgroundColor: const Color(0xFFF0F4FF),  // Couleur qui s'harmonise avec le gradient
      elevation: 0,                              // Pas d'ombre pour un look moderne
      iconTheme: const IconThemeData(color: CouleursApplication.textePrincipal),  // Couleur des icônes
      centerTitle: true,                         // Centre le titre (style iOS)
    );
  }

  /// MÉTHODE 2 : Construit la section profil utilisateur avec gradient
  Widget _construireSectionProfil() {
    return Container(
      width: double.infinity,  // Prend toute la largeur disponible
      padding: const EdgeInsets.all(DimensionsApplication.paddingXL),  // Espacement généreux
      
      // DÉCORATION AVEC GRADIENT COMPLEXE
      decoration: const BoxDecoration(
        // GRADIENT VERTICAL : Dégradé de 3 couleurs pour un effet doux
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,    // Commence en bas
          end: Alignment.topCenter,         // Finit en haut
          colors: [
            Color(0xFFD0E1FF),              // Bleu foncé en bas
            Color(0xFFE1ECFF),              // Bleu moyen au centre
            Color(0xFFF0F4FF),              // Bleu clair en haut
          ],
          stops: [0.0, 0.5, 1.0],           // Répartition des couleurs (0%, 50%, 100%)
        ),
        
        // BORDURES ARRONDIES : Seulement en bas pour créer une section distincte
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(DimensionsApplication.radiusL),
          bottomRight: Radius.circular(DimensionsApplication.radiusL),
        ),
      ),
      
      // CONTENU DE LA SECTION PROFIL
      child: Column(
        children: [
          // AVATAR : Image de profil circulaire avec initiale
          _construireAvatarUtilisateur(),
          const SizedBox(height: 16),
          
          // NOM UTILISATEUR : Récupéré depuis l'état global
          Text(
            // CONDITION : Affiche le nom ou "Utilisateur" par défaut
            EtatApplication.instance.nomUtilisateur.isNotEmpty 
                ? EtatApplication.instance.nomUtilisateur
                : 'Utilisateur',
            style: const TextStyle(
              fontSize: 20,                        // Grande taille pour le nom principal
              fontWeight: FontWeight.w600,         // Semi-gras pour l'importance
              color: Color(0xFF333333),           // Couleur sombre pour la lisibilité
            ),
          ),
          const SizedBox(height: 4),  // Petit espace entre nom et email
          
          // EMAIL UTILISATEUR : Toujours affiché depuis l'état global
          Text(
            EtatApplication.instance.emailUtilisateur,  // Récupéré de l'état global
            style: const TextStyle(
              fontSize: 14,                              // Plus petit que le nom
              color: CouleursApplication.texteSecondaire,  // Couleur secondaire moins visible
            ),
          ),
        ],
      ),
    );
  }

  /// MÉTHODE 3 : Construit l'avatar circulaire de l'utilisateur
  Widget _construireAvatarUtilisateur() {
    // GÉNÉRATION D'INITIALE : Première lettre du nom pour l'avatar
    String initialeUtilisateur = EtatApplication.instance.nomUtilisateur.isNotEmpty 
        ? EtatApplication.instance.nomUtilisateur[0].toUpperCase()  // Première lettre en majuscule
        : 'U';  // 'U' par défaut si pas de nom

    // CIRCLEAVATAR : Widget spécialisé pour les avatars circulaires
    return CircleAvatar(
      radius: 50,  // Rayon de 50 pixels = diamètre de 100 pixels
      backgroundColor: CouleursApplication.primaire.shade200,  // Fond coloré clair
      
      // CONTENU : Texte avec l'initiale
      child: Text(
        initialeUtilisateur,
        style: const TextStyle(
          fontSize: 32,              // Grande taille pour la visibilité
          fontWeight: FontWeight.bold,  // Gras pour le contraste
          color: Colors.white,       // Blanc pour contraster avec le fond coloré
        ),
      ),
    );
  }

  /// MÉTHODE 4 : Construit la liste des options de paramètres
  Widget _construireListeParametres(BuildContext context) {
    
    // ===================================
    // DONNÉES DES OPTIONS DE PARAMÈTRES
    // ===================================
    
    /// LISTE DES OPTIONS : Structure de données pour chaque option de menu
    /// Chaque Map contient les informations nécessaires pour afficher une option
    final List<Map<String, dynamic>> optionsParametres = [
      {
        'icon': Icons.person_outline,           // Icône pour les infos personnelles
        'title': 'Informations personnelles',   // Titre affiché
        'subtitle': 'Gérer votre profil',      // Description sous le titre
      },
      {
        'icon': Icons.credit_card_outlined,     // Icône pour les paiements
        'title': 'Moyens de paiement',
        'subtitle': 'Cartes et abonnements',
      },
      {
        'icon': Icons.shield_outlined,          // Icône pour la sécurité
        'title': 'Confidentialité & Sécurité',
        'subtitle': 'Paramètres de sécurité',
      },
      {
        'icon': Icons.help_outline,             // Icône pour l'aide
        'title': 'Support',
        'subtitle': 'Aide et contact',
      },
    ];

    // LISTVIEW : Liste scrollable des options
    return ListView(
      padding: const EdgeInsets.all(DimensionsApplication.paddingL),  // Marges autour de la liste
      children: [
        
        // GÉNÉRATION DYNAMIQUE DES OPTIONS
        // MAP + SPREAD OPERATOR : Transforme chaque option en widget
        ...optionsParametres.map((option) => 
          _construireOptionParametre(
            context,
            icone: option['icon'] as IconData,      // Cast vers le bon type
            titre: option['title'] as String,
            sousTitre: option['subtitle'] as String,
          )
        ),  // Spread operator étale directement les éléments
        
        const SizedBox(height: 32),  // Espace avant le bouton de déconnexion
        
        // BOUTON DE DÉCONNEXION : En bas de la liste
        _construireBoutonDeconnexion(context),
      ],
    );
  }

  /// MÉTHODE 5 : Construit une option de paramètre individuelle
  Widget _construireOptionParametre(
    BuildContext context, {
    required IconData icone,     // Icône à afficher (paramètre obligatoire)
    required String titre,       // Titre de l'option (paramètre obligatoire)
    required String sousTitre,   // Sous-titre descriptif (paramètre obligatoire)
  }) {
    // CONTAINER : Carte individuelle pour chaque option
    return Container(
      margin: const EdgeInsets.only(bottom: 8),  // Espace entre les cartes
      
      // DÉCORATION : Style de carte avec ombre légère
      decoration: BoxDecoration(
        color: Colors.white,                    // Fond blanc
        borderRadius: BorderRadius.circular(12),  // Coins arrondis
        
        // OMBRE SUBTILE : Effet de profondeur
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),  // Ombre très légère
            blurRadius: 5,                          // Flou de l'ombre
            offset: const Offset(0, 2),            // Décalage vers le bas
          ),
        ],
      ),
      
      // LISTTILE : Widget spécialisé pour les éléments de liste interactifs
      child: ListTile(
        
        // LEADING : Icône dans un container stylisé à gauche
        leading: Container(
          padding: const EdgeInsets.all(8),  // Espacement autour de l'icône
          decoration: BoxDecoration(
            // FOND COLORÉ AVEC TRANSPARENCE
            color: CouleursApplication.primaire.withValues(alpha: 0.1),  // 10% d'opacité
            borderRadius: BorderRadius.circular(8),                // Coins arrondis
          ),
          child: Icon(icone, color: CouleursApplication.primaire),  // Icône colorée
        ),
        
        // TITLE : Titre principal de l'option
        title: Text(
          titre,
          style: const TextStyle(
            fontWeight: FontWeight.w600,  // Semi-gras pour l'importance
            fontSize: 16,                 // Taille lisible
          ),
        ),
        
        // SUBTITLE : Description sous le titre
        subtitle: Text(
          sousTitre,
          style: const TextStyle(
            color: CouleursApplication.texteSecondaire,  // Couleur moins visible
            fontSize: 12,                                // Plus petit que le titre
          ),
        ),
        
        // TRAILING : Flèche de navigation à droite
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),  // Petite flèche
        
        // ONTAP : Action exécutée au clic sur l'option
        onTap: () {
          // SIMULATION : Affiche une notification temporaire
          // Dans une vraie app, on naviguerait vers la page correspondante
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Page "$titre" simulée')),
          );
        },
      ),
    );
  }

  /// MÉTHODE 6 : Construit le bouton de déconnexion
  Widget _construireBoutonDeconnexion(BuildContext context) {
    return BoutonModerne(
      texte: 'Se déconnecter',                 // Texte explicite
      onPressed: () => _gererDeconnexion(context),  // Fonction de déconnexion
      estSecondaire: true,                     // Style secondaire (moins proéminent)
    );
  }

// ===================================
// LOGIQUE MÉTIER - GESTION DE LA DÉCONNEXION
// ===================================

  /// MÉTHODE 7 : Gère le processus de déconnexion avec confirmation
  void _gererDeconnexion(BuildContext context) {
    // SHOWDIALOG : Affiche une boîte de dialogue de confirmation
    // Important pour éviter les déconnexions accidentelles
    showDialog(
      context: context,
      
      // BUILDER : Construit le contenu de la dialogue
      builder: (context) => AlertDialog(
        // TITRE DE LA DIALOGUE
        title: const Text('Déconnexion'),
        
        // CONTENU : Question de confirmation
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        
        // ACTIONS : Boutons de choix
        actions: [
          
          // BOUTON ANNULER : Ferme la dialogue sans action
          TextButton(
            onPressed: () => Navigator.pop(context),  // Ferme juste la dialogue
            child: const Text('Annuler'),
          ),
          
          // BOUTON CONFIRMER : Effectue la déconnexion
          TextButton(
            onPressed: () {
              // SÉQUENCE DE DÉCONNEXION : 3 étapes importantes
              
              // 1. Ferme la boîte de dialogue
              Navigator.pop(context);
              
              // 2. Ferme la page des paramètres (retour à l'accueil)
              Navigator.pop(context);
              
              // 3. Déconnecte l'utilisateur (met à jour l'état global)
              // Ceci déclenchera automatiquement la redirection vers la page de connexion
              // grâce au GestionnaireAuthentification dans main.dart
              EtatApplication.instance.deconnecterUtilisateur();
            },
            child: const Text('Se déconnecter'),
          ),
        ],
      ),
    );
  }
} 