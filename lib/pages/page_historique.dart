// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';                    // Import principal Flutter (widgets, dialogs, etc.)
import '../core/constantes/couleurs_application.dart';     // Couleurs définies pour l'application
import '../core/constantes/dimensions_application.dart';   // Tailles et espacements standardisés

/// Page d'historique affichant la liste des transcriptions sauvegardées
/// Permet de consulter, modifier et supprimer les transcriptions passées
/// 
/// STATELESSWIDGET : Utilisé car les données sont simulées et statiques
/// Dans une vraie app, on utiliserait plutôt StatefulWidget avec gestion d'état
class PageHistorique extends StatelessWidget {
  const PageHistorique({super.key});

  @override
  Widget build(BuildContext context) {
    
    // ===================================
    // DONNÉES SIMULÉES
    // ===================================
    
    /// LISTE DES TRANSCRIPTIONS : Simule des données venant d'une base de données
    /// Dans une vraie app, ces données viendraient d'un serveur ou d'une BDD locale
    final List<Map<String, String>> historiqueSimule = [
      {
        'titre': 'Réunion équipe du 15/12',                                     // Nom de la transcription
        'date': '15 décembre 2024, 14:30',                                     // Date et heure
        'duree': '25 min',                                                      // Durée de l'enregistrement
        'preview': 'Aujourd\'hui nous avons discuté des nouvelles fonctionnalités...'  // Aperçu du contenu
      },
      {
        'titre': 'Conférence marketing',
        'date': '14 décembre 2024, 10:15',
        'duree': '45 min',
        'preview': 'Les stratégies de marketing digital pour 2025...'
      },
      {
        'titre': 'Brainstorming produit',
        'date': '13 décembre 2024, 16:00',
        'duree': '30 min',
        'preview': 'Idées pour améliorer l\'expérience utilisateur...'
      },
    ];

    // ===================================
    // CONSTRUCTION DE L'INTERFACE
    // ===================================

    // SCAFFOLD : Structure de base de la page
    return Scaffold(
      backgroundColor: CouleursApplication.fondPrincipal,  // Couleur de fond standard
      
      // LISTVIEW.BUILDER : Widget optimisé pour afficher des listes longues
      // Construit les éléments uniquement quand ils sont visibles (performance)
      body: ListView.builder(
        padding: const EdgeInsets.all(DimensionsApplication.paddingM),  // Marges autour de la liste
        itemCount: historiqueSimule.length + 1,  // +1 pour inclure l'en-tête dans la liste
        
        // ITEMBUILDER : Fonction appelée pour construire chaque élément de la liste
        itemBuilder: (context, index) {
          // PREMIER ÉLÉMENT (index 0) : En-tête de la page
          if (index == 0) {
            return _construireEnteteHistorique(historiqueSimule.length);
          }

          // ÉLÉMENTS SUIVANTS : Les transcriptions de l'historique
          // index - 1 car l'en-tête occupe l'index 0
          final elementHistorique = historiqueSimule[index - 1];
          return _construireElementHistorique(context, elementHistorique);
        },
      ),
    );
  }

// ===================================
// MÉTHODES PRIVÉES - CONSTRUCTION DES WIDGETS
// ===================================

  /// MÉTHODE 1 : Construit l'en-tête de la page avec titre et compteur
  Widget _construireEnteteHistorique(int nombreTranscriptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,  // Aligne le contenu à gauche
      children: [
        // TITRE PRINCIPAL : Nom de la page
        const Text(
          'Historique des transcriptions',
          style: TextStyle(
            fontSize: 24,                                  // Grande taille pour le titre
            fontWeight: FontWeight.w700,                   // Texte très gras
            color: CouleursApplication.textePrincipal,     // Couleur principale du texte
          ),
        ),
        const SizedBox(height: 8),  // Petit espace vertical
        
        // COMPTEUR : Affiche le nombre total de transcriptions
        Text(
          '$nombreTranscriptions transcriptions sauvegardées',  // Interpolation de la variable
          style: const TextStyle(
            fontSize: 16,                                  // Taille normale
            color: CouleursApplication.texteSecondaire,    // Couleur plus discrète
          ),
        ),
        const SizedBox(height: 24),  // Espace avant la liste
      ],
    );
  }

  /// MÉTHODE 2 : Construit un élément de l'historique (carte de transcription)
  Widget _construireElementHistorique(BuildContext context, Map<String, String> element) {
    // CONTAINER : Crée une carte avec décoration pour chaque transcription
    return Container(
      margin: const EdgeInsets.only(bottom: 16),  // Espace entre les cartes
      
      // DÉCORATION : Style visuel de la carte
      decoration: BoxDecoration(
        color: Colors.white,                                      // Fond blanc
        borderRadius: BorderRadius.circular(DimensionsApplication.radiusL),  // Coins arrondis
        
        // OMBRE : Effet de profondeur sous la carte
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),              // Ombre légère et transparente
            blurRadius: 10,                                      // Flou de l'ombre
            offset: const Offset(0, 2),                         // Décalage vertical de l'ombre
          ),
        ],
      ),
      
      // LISTTILE : Widget spécialisé pour afficher des éléments de liste
      // Fournit automatiquement la structure leading/title/subtitle/trailing
      child: ListTile(
        contentPadding: const EdgeInsets.all(DimensionsApplication.paddingL),  // Espacement interne
        
        // LEADING : Widget affiché à gauche (icône de transcription)
        leading: _construireIconeTranscription(),
        
        // TITLE : Titre principal de l'élément
        title: Text(
          element['titre']!,  // ! car on sait que la clé existe
          style: const TextStyle(
            fontWeight: FontWeight.w600,                        // Texte semi-gras
            fontSize: 16,                                        // Taille du titre
          ),
        ),
        
        // SUBTITLE : Contenu secondaire (date, durée, aperçu)
        subtitle: _construireContenuElement(element),
        
        // TRAILING : Widget affiché à droite (menu d'actions)
        trailing: _construireMenuActions(context, element['titre']!),
        
        // ONTAP : Action exécutée quand on tape sur l'élément
        onTap: () {
          // SNACKBAR : Notification temporaire en bas de l'écran
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ouverture de "${element['titre']}" simulée')),
          );
        },
      ),
    );
  }

  /// MÉTHODE 3 : Construit l'icône de transcription avec arrière-plan coloré
  Widget _construireIconeTranscription() {
    return Container(
      width: 48,
      height: 48,
      
      // DÉCORATION : Arrière-plan avec gradient
      decoration: BoxDecoration(
        // GRADIENT : Dégradé de couleurs pour un effet moderne
        gradient: LinearGradient(
          colors: [
            CouleursApplication.primaire.shade100,  // Couleur claire
            CouleursApplication.primaire.shade200   // Couleur un peu plus foncée
          ],
        ),
        borderRadius: BorderRadius.circular(12),    // Coins légèrement arrondis
      ),
      
      // ICÔNE : Symbole représentant l'audio/transcription
      child: Icon(
        Icons.audiotrack,                          // Icône de piste audio
        color: CouleursApplication.primaire        // Couleur de l'icône
      ),
    );
  }

  /// MÉTHODE 4 : Construit le contenu détaillé d'un élément (date, durée, aperçu)
  Widget _construireContenuElement(Map<String, String> element) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,  // Aligne le contenu à gauche
      children: [
        const SizedBox(height: 4),  // Petit espace après le titre
        
        // DATE ET DURÉE : Informations temporelles sur une ligne
        Text(
          '${element['date']} • ${element['duree']}',  // Concatène date et durée avec un séparateur
          style: const TextStyle(
            color: CouleursApplication.texteSecondaire,  // Couleur discrète
            fontSize: 12,                                // Petite taille pour les métadonnées
          ),
        ),
        const SizedBox(height: 8),  // Espace avant l'aperçu
        
        // APERÇU DU CONTENU : Extrait du texte transcrit
        Text(
          element['preview']!,  // Contenu de l'aperçu
          style: const TextStyle(
            color: CouleursApplication.texteSecondaire,  // Couleur secondaire
            fontSize: 14,                                // Taille lisible
          ),
          maxLines: 2,                    // Limite à 2 lignes maximum
          overflow: TextOverflow.ellipsis,  // Ajoute "..." si le texte est trop long
        ),
      ],
    );
  }

  /// MÉTHODE 5 : Construit le menu d'actions (modifier, exporter, supprimer)
  Widget _construireMenuActions(BuildContext context, String titre) {
    // POPUPMENUBUTTON : Widget qui affiche un menu contextuel au clic
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),  // Icône des 3 points verticaux
      
      // ITEMBUILDER : Fonction qui construit les éléments du menu
      itemBuilder: (context) => [
        
        // OPTION MODIFIER : Première option du menu
        const PopupMenuItem(
          value: 'edit',  // Valeur retournée quand cette option est sélectionnée
          child: Row(
            children: [
              Icon(Icons.edit, size: 18),         // Icône crayon
              SizedBox(width: 8),                 // Espace entre icône et texte
              Text('Modifier'),                   // Texte de l'option
            ],
          ),
        ),
        
        // OPTION EXPORTER : Deuxième option du menu
        const PopupMenuItem(
          value: 'export',
          child: Row(
            children: [
              Icon(Icons.download, size: 18),     // Icône téléchargement
              SizedBox(width: 8),
              Text('Exporter'),
            ],
          ),
        ),
        
        // OPTION SUPPRIMER : Troisième option (en rouge pour signaler la dangerosité)
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, size: 18, color: CouleursApplication.erreur),  // Icône poubelle rouge
              SizedBox(width: 8),
              Text(
                'Supprimer', 
                style: TextStyle(color: CouleursApplication.erreur)  // Texte rouge
              ),
            ],
          ),
        ),
      ],
      
      // ONSELECTED : Fonction appelée quand une option est sélectionnée
      onSelected: (valeur) => _gererActionMenu(context, valeur, titre),
    );
  }

// ===================================
// LOGIQUE MÉTIER - GESTION DES ACTIONS
// ===================================

  /// MÉTHODE 6 : Gère les actions du menu contextuel
  void _gererActionMenu(BuildContext context, String action, String titre) {
    // SWITCH : Structure de contrôle pour gérer différents cas
    switch (action) {
      case 'edit':
        // ACTION MODIFIER : Simule l'ouverture d'un éditeur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Édition de "$titre" simulée')),
        );
        break;
        
      case 'export':
        // ACTION EXPORTER : Simule l'export vers un fichier
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export de "$titre" simulé')),
        );
        break;
        
      case 'delete':
        // ACTION SUPPRIMER : Demande confirmation avant suppression
        _afficherDialogueSuppression(context, titre);
        break;
    }
  }

  /// MÉTHODE 7 : Affiche une boîte de dialogue de confirmation de suppression
  void _afficherDialogueSuppression(BuildContext context, String titre) {
    // SHOWDIALOG : Affiche une boîte de dialogue modale
    showDialog(
      context: context,
      
      // BUILDER : Fonction qui construit le contenu de la dialogue
      builder: (context) => AlertDialog(
        // TITRE DE LA DIALOGUE
        title: const Text('Confirmer la suppression'),
        
        // CONTENU : Message de confirmation personnalisé
        content: Text('Êtes-vous sûr de vouloir supprimer "$titre" ?'),
        
        // ACTIONS : Boutons en bas de la dialogue
        actions: [
          // BOUTON ANNULER : Ferme la dialogue sans action
          TextButton(
            onPressed: () => Navigator.pop(context),  // Ferme la dialogue
            child: const Text('Annuler'),
          ),
          
          // BOUTON SUPPRIMER : Confirme l'action de suppression
          TextButton(
            onPressed: () {
              Navigator.pop(context);  // Ferme d'abord la dialogue
              
              // MESSAGE DE CONFIRMATION : Informe que la suppression a réussi
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"$titre" supprimé'),
                  backgroundColor: CouleursApplication.succes,  // Fond vert pour le succès
                ),
              );
            },
            child: const Text(
              'Supprimer',
              style: TextStyle(color: CouleursApplication.erreur),  // Texte rouge pour signaler le danger
            ),
          ),
        ],
      ),
    );
  }
} 