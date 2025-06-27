import 'package:flutter/material.dart';
import '../core/constantes/couleurs_application.dart';
import '../core/constantes/dimensions_application.dart';
import '../widgets/bouton_moderne.dart';

/// Page des abonnements présentant les différents plans disponibles
/// Permet aux utilisateurs de choisir leur formule de transcription
class PageAbonnement extends StatelessWidget {
  const PageAbonnement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApplication.fondPrincipal,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DimensionsApplication.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _construireEnteteAbonnement(),
            const SizedBox(height: 32),
            
            // Plan Gratuit
            _construireCartePlan(
              titre: 'Gratuit',
              prix: '0€',
              periode: '/mois',
              fonctionnalites: [
                '5 minutes de transcription/jour',
                'Qualité standard',
                'Export TXT uniquement',
              ],
              estPopulaire: false,
              estPlanActuel: true,
            ),
            
            const SizedBox(height: 16),
            
            // Plan Pro (Populaire)
            _construireCartePlan(
              titre: 'Pro',
              prix: '9,99€',
              periode: '/mois',
              fonctionnalites: [
                '60 minutes de transcription/jour',
                'Qualité HD avec IA avancée',
                'Export PDF, DOCX, TXT',
                'Historique illimité',
                'Support prioritaire',
              ],
              estPopulaire: true,
              estPlanActuel: false,
            ),
            
            const SizedBox(height: 16),
            
            // Plan Business
            _construireCartePlan(
              titre: 'Business',
              prix: '29,99€',
              periode: '/mois',
              fonctionnalites: [
                'Transcription illimitée',
                'IA ultra-avancée',
                'Tous les formats d\'export',
                'Collaboration équipe',
                'API dédiée',
                'Support 24/7',
              ],
              estPopulaire: false,
              estPlanActuel: false,
            ),
            
            // Espace pour la navigation en bas
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  /// Construit l'en-tête de la page avec titre et description
  Widget _construireEnteteAbonnement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre principal
        const Text(
          'Choisissez votre abonnement',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: CouleursApplication.textePrincipal,
          ),
        ),
        const SizedBox(height: 8),
        
        // Description
        const Text(
          'Débloquez tout le potentiel de NoteCraft',
          style: TextStyle(
            fontSize: 16,
            color: CouleursApplication.texteSecondaire,
          ),
        ),
      ],
    );
  }

  /// Construit une carte de plan d'abonnement
  Widget _construireCartePlan({
    required String titre,
    required String prix,
    required String periode,
    required List<String> fonctionnalites,
    required bool estPopulaire,
    required bool estPlanActuel,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DimensionsApplication.radiusL),
        // Bordure spéciale pour le plan populaire
        border: estPopulaire 
            ? Border.all(color: CouleursApplication.primaire, width: 2)
            : Border.all(color: CouleursApplication.bordure),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Badge "POPULAIRE" pour le plan recommandé
          if (estPopulaire) _construireBadgePopulaire(),
          
          // Contenu principal de la carte
          Padding(
            padding: const EdgeInsets.all(DimensionsApplication.paddingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _construireEntetePlan(titre, prix, periode, estPopulaire),
                const SizedBox(height: 24),
                _construireListeFonctionnalites(fonctionnalites),
                const SizedBox(height: 24),
                _construireBoutonPlan(estPlanActuel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construit le badge "POPULAIRE" positionné en haut à droite
  Widget _construireBadgePopulaire() {
    return Positioned(
      top: 0,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: CouleursApplication.primaire,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: const Text(
          'POPULAIRE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Construit l'en-tête du plan (titre, prix, période)
  Widget _construireEntetePlan(String titre, String prix, String periode, bool estPopulaire) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre du plan
        Text(
          titre,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: CouleursApplication.textePrincipal,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Prix et période
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              prix,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: estPopulaire ? CouleursApplication.primaire : CouleursApplication.textePrincipal,
              ),
            ),
            Text(
              periode,
              style: const TextStyle(
                fontSize: 16,
                color: CouleursApplication.texteSecondaire,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Construit la liste des fonctionnalités du plan
  Widget _construireListeFonctionnalites(List<String> fonctionnalites) {
    return Column(
      children: fonctionnalites.map((fonctionnalite) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              // Icône de validation
              Icon(
                Icons.check_circle,
                size: 20,
                color: CouleursApplication.succes,
              ),
              const SizedBox(width: 12),
              
              // Texte de la fonctionnalité
              Expanded(
                child: Text(
                  fonctionnalite,
                  style: const TextStyle(
                    fontSize: 14,
                    color: CouleursApplication.textePrincipal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ).toList(),
    );
  }

  /// Construit le bouton d'action du plan
  Widget _construireBoutonPlan(bool estPlanActuel) {
    return SizedBox(
      width: double.infinity,
      child: BoutonModerne(
        texte: estPlanActuel ? 'Plan actuel' : 'Choisir ce plan',
        onPressed: estPlanActuel ? null : () {
          // Simulation du choix du plan
          // Dans une vraie app, ici on déclencherait le processus de paiement
        },
        estSecondaire: estPlanActuel,
      ),
    );
  }
} 