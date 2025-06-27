import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/constantes/couleurs_application.dart';
import '../core/etat/etat_application.dart';
import 'page_transcription.dart';
import 'page_historique.dart';
import 'page_abonnement.dart';
import 'page_parametres.dart';

/// Vue d'accueil principale de l'application authentifiée
/// Gère la navigation par onglets et l'AppBar commune
class VueAccueil extends StatefulWidget {
  const VueAccueil({super.key});

  @override
  State<VueAccueil> createState() => _VueAccueilState();
}

class _VueAccueilState extends State<VueAccueil> {
  
  /// Liste des pages disponibles dans la navigation
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialise la liste des pages de l'application
    _pages = const [
      PageTranscription(),
      PageHistorique(),
      PageAbonnement(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: EtatApplication.instance,
      builder: (context, child) {
        return Scaffold(
          extendBody: true,
          appBar: _construireAppBar(context),
          body: Stack(
            children: [
              // Pages de contenu avec IndexedStack pour maintenir l'état
              IndexedStack(
                index: EtatApplication.instance.indexOngletSelectionne,
                children: _pages,
              ),
              // Navigation en bas avec effet glassmorphism
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _construireNavigationInferieure(),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Construit l'AppBar avec le logo NoteCraft et le bouton paramètres
  PreferredSizeWidget _construireAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      scrolledUnderElevation: 0,
      title: _construireLogo(),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => _ouvrirParametres(context),
          tooltip: 'Ouvrir les paramètres',
        ),
      ],
    );
  }

  /// Construit le logo NoteCraft avec gradient
  Widget _construireLogo() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CouleursApplication.primaire, 
            CouleursApplication.primaire.shade300
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.note_alt_rounded, color: Colors.white, size: 20),
          SizedBox(width: 8),
          Text(
            'NoteCraft',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// Construit la navigation inférieure avec effet glassmorphism
  Widget _construireNavigationInferieure() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.2), width: 1.0),
            ),
          ),
          child: SafeArea(
            top: false,
            child: BottomNavigationBar(
              items: _construireElementsNavigation(),
              currentIndex: EtatApplication.instance.indexOngletSelectionne,
              onTap: _changerOnglet,
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: CouleursApplication.primaire,
              unselectedItemColor: Colors.black54,
              showUnselectedLabels: true,
            ),
          ),
        ),
      ),
    );
  }

  /// Construit la liste des éléments de navigation
  List<BottomNavigationBarItem> _construireElementsNavigation() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.mic),
        label: 'Transcription'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'Historique'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'Abonnement'
      ),
    ];
  }

  /// Gère le changement d'onglet dans la navigation
  void _changerOnglet(int index) {
    EtatApplication.instance.changerOngletSelectionne(index);
  }

  /// Ouvre la page des paramètres
  void _ouvrirParametres(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PageParametres()),
    );
  }
} 