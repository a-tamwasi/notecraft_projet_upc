// ===================================
// NOTECRAFT - APPLICATION PRINCIPALE
// ===================================
// Point d'entrée de l'application NoteCraft
// Gère uniquement l'initialisation et la navigation d'authentification

import 'package:flutter/material.dart';
import 'core/constantes/couleurs_application.dart';
import 'core/etat/etat_application.dart';
import 'pages/page_connexion.dart';
import 'pages/vue_accueil.dart';

/// Point d'entrée de l'application
void main() {
  runApp(const ApplicationNoteCraft());
}

// ===================================
// APPLICATION PRINCIPALE
// ===================================

/// Widget racine de l'application NoteCraft
/// Configure le thème global et initialise le routage
class ApplicationNoteCraft extends StatelessWidget {
  const ApplicationNoteCraft({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteCraft',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CouleursApplication.primaire,
        useMaterial3: true,
      ),
      home: const GestionnaireAuthentification(),
    );
  }
}

// ===================================
// GESTIONNAIRE D'AUTHENTIFICATION
// ===================================

/// Widget qui gère la navigation entre les pages d'authentification et l'application
/// Écoute l'état d'authentification et affiche la vue appropriée
class GestionnaireAuthentification extends StatelessWidget {
  const GestionnaireAuthentification({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: EtatApplication.instance,
      builder: (context, child) {
        // Si l'utilisateur est authentifié, affiche l'accueil
        if (EtatApplication.instance.estAuthentifie) {
          return const VueAccueil();
        } else {
          // Sinon, affiche la page de connexion
          return const PageConnexion();
        }
      },
    );
  }
} 