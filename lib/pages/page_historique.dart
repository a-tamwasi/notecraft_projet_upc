import 'package:flutter/material.dart';
import '../core/constantes/couleurs_application.dart';
import '../core/constantes/dimensions_application.dart';

/// Page d'historique affichant la liste des transcriptions sauvegardées
/// Permet de consulter, modifier et supprimer les transcriptions passées
class PageHistorique extends StatelessWidget {
  const PageHistorique({super.key});

  @override
  Widget build(BuildContext context) {
    // Données simulées pour l'historique des transcriptions
    final List<Map<String, String>> _historiqueSimule = [
      {
        'titre': 'Réunion équipe du 15/12',
        'date': '15 décembre 2024, 14:30',
        'duree': '25 min',
        'preview': 'Aujourd\'hui nous avons discuté des nouvelles fonctionnalités...'
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

    return Scaffold(
      backgroundColor: CouleursApplication.fondPrincipal,
      body: ListView.builder(
        padding: const EdgeInsets.all(DimensionsApplication.paddingM),
        itemCount: _historiqueSimule.length + 1, // +1 pour l'en-tête
        itemBuilder: (context, index) {
          // Premier élément : en-tête de la page
          if (index == 0) {
            return _construireEnteteHistorique(_historiqueSimule.length);
          }

          // Éléments suivants : les transcriptions
          final elementHistorique = _historiqueSimule[index - 1];
          return _construireElementHistorique(context, elementHistorique);
        },
      ),
    );
  }

  /// Construit l'en-tête de la page avec titre et compteur
  Widget _construireEnteteHistorique(int nombreTranscriptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre principal
        const Text(
          'Historique des transcriptions',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: CouleursApplication.textePrincipal,
          ),
        ),
        const SizedBox(height: 8),
        
        // Compteur des transcriptions
        Text(
          '$nombreTranscriptions transcriptions sauvegardées',
          style: const TextStyle(
            fontSize: 16,
            color: CouleursApplication.texteSecondaire,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  /// Construit un élément de l'historique (carte de transcription)
  Widget _construireElementHistorique(BuildContext context, Map<String, String> element) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DimensionsApplication.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(DimensionsApplication.paddingL),
        
        // Icône de transcription avec style
        leading: _construireIconeTranscription(),
        
        // Contenu principal : titre, date et aperçu
        title: Text(
          element['titre']!,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: _construireContenuElement(element),
        
        // Menu d'actions (3 points)
        trailing: _construireMenuActions(context, element['titre']!),
        
        // Action au tap : simulation d'ouverture
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ouverture de "${element['titre']}" simulée')),
          );
        },
      ),
    );
  }

  /// Construit l'icône de transcription avec arrière-plan coloré
  Widget _construireIconeTranscription() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CouleursApplication.primaire.shade100, 
            CouleursApplication.primaire.shade200
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.audiotrack, color: CouleursApplication.primaire),
    );
  }

  /// Construit le contenu détaillé d'un élément (date, durée, aperçu)
  Widget _construireContenuElement(Map<String, String> element) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        
        // Date et durée
        Text(
          '${element['date']} • ${element['duree']}',
          style: const TextStyle(
            color: CouleursApplication.texteSecondaire,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        
        // Aperçu du contenu
        Text(
          element['preview']!,
          style: const TextStyle(
            color: CouleursApplication.texteSecondaire,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  /// Construit le menu d'actions (modifier, exporter, supprimer)
  Widget _construireMenuActions(BuildContext context, String titre) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        // Option Modifier
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, size: 18),
              SizedBox(width: 8),
              Text('Modifier'),
            ],
          ),
        ),
        
        // Option Exporter
        const PopupMenuItem(
          value: 'export',
          child: Row(
            children: [
              Icon(Icons.download, size: 18),
              SizedBox(width: 8),
              Text('Exporter'),
            ],
          ),
        ),
        
        // Option Supprimer (en rouge)
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, size: 18, color: CouleursApplication.erreur),
              SizedBox(width: 8),
              Text(
                'Supprimer', 
                style: TextStyle(color: CouleursApplication.erreur)
              ),
            ],
          ),
        ),
      ],
      onSelected: (valeur) => _gererActionMenu(context, valeur, titre),
    );
  }

  /// Gère les actions du menu contextuel
  void _gererActionMenu(BuildContext context, String action, String titre) {
    switch (action) {
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Édition de "$titre" simulée')),
        );
        break;
      case 'export':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export de "$titre" simulé')),
        );
        break;
      case 'delete':
        _afficherDialogueSuppression(context, titre);
        break;
    }
  }

  /// Affiche une boîte de dialogue de confirmation de suppression
  void _afficherDialogueSuppression(BuildContext context, String titre) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: Text('Êtes-vous sûr de vouloir supprimer "$titre" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"$titre" supprimé'),
                  backgroundColor: CouleursApplication.succes,
                ),
              );
            },
            child: const Text(
              'Supprimer',
              style: TextStyle(color: CouleursApplication.erreur),
            ),
          ),
        ],
      ),
    );
  }
} 