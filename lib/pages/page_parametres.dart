import 'package:flutter/material.dart';
import '../core/constantes/couleurs_application.dart';
import '../core/constantes/dimensions_application.dart';
import '../core/etat/etat_application.dart';
import '../widgets/bouton_moderne.dart';

/// Page des paramètres permettant de gérer le profil utilisateur
/// et configurer les préférences de l'application
class PageParametres extends StatelessWidget {
  const PageParametres({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _construireAppBar(),
      body: Column(
        children: [
          _construireSectionProfil(),
          Expanded(
            child: _construireListeParametres(context),
          ),
        ],
      ),
    );
  }

  /// Construit l'AppBar personnalisée de la page
  PreferredSizeWidget _construireAppBar() {
    return AppBar(
      title: const Text(
        'Paramètres',
        style: TextStyle(
          color: CouleursApplication.textePrincipal,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: const Color(0xFFF0F4FF),
      elevation: 0,
      iconTheme: const IconThemeData(color: CouleursApplication.textePrincipal),
      centerTitle: true,
    );
  }

  /// Construit la section profil utilisateur avec gradient
  Widget _construireSectionProfil() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DimensionsApplication.paddingXL),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFFD0E1FF),
            Color(0xFFE1ECFF),
            Color(0xFFF0F4FF),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(DimensionsApplication.radiusL),
          bottomRight: Radius.circular(DimensionsApplication.radiusL),
        ),
      ),
      child: Column(
        children: [
          // Avatar utilisateur
          _construireAvatarUtilisateur(),
          const SizedBox(height: 16),
          
          // Nom utilisateur
          Text(
            EtatApplication.instance.nomUtilisateur.isNotEmpty 
                ? EtatApplication.instance.nomUtilisateur
                : 'Utilisateur',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 4),
          
          // Email utilisateur
          Text(
            EtatApplication.instance.emailUtilisateur,
            style: const TextStyle(
              fontSize: 14,
              color: CouleursApplication.texteSecondaire,
            ),
          ),
        ],
      ),
    );
  }

  /// Construit l'avatar circulaire de l'utilisateur
  Widget _construireAvatarUtilisateur() {
    // Première lettre du nom utilisateur pour l'avatar
    String initialeUtilisateur = EtatApplication.instance.nomUtilisateur.isNotEmpty 
        ? EtatApplication.instance.nomUtilisateur[0].toUpperCase()
        : 'U';

    return CircleAvatar(
      radius: 50,
      backgroundColor: CouleursApplication.primaire.shade200,
      child: Text(
        initialeUtilisateur,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Construit la liste des options de paramètres
  Widget _construireListeParametres(BuildContext context) {
    // Définition des options de paramètres
    final List<Map<String, dynamic>> optionsParametres = [
      {
        'icon': Icons.person_outline,
        'title': 'Informations personnelles',
        'subtitle': 'Gérer votre profil',
      },
      {
        'icon': Icons.credit_card_outlined,
        'title': 'Moyens de paiement',
        'subtitle': 'Cartes et abonnements',
      },
      {
        'icon': Icons.shield_outlined,
        'title': 'Confidentialité & Sécurité',
        'subtitle': 'Paramètres de sécurité',
      },
      {
        'icon': Icons.help_outline,
        'title': 'Support',
        'subtitle': 'Aide et contact',
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(DimensionsApplication.paddingL),
      children: [
        // Options de paramètres
        ...optionsParametres.map((option) => 
          _construireOptionParametre(
            context,
            icone: option['icon'] as IconData,
            titre: option['title'] as String,
            sousTitre: option['subtitle'] as String,
          )
        ).toList(),
        
        const SizedBox(height: 32),
        
        // Bouton de déconnexion
        _construireBoutonDeconnexion(context),
      ],
    );
  }

  /// Construit une option de paramètre individuelle
  Widget _construireOptionParametre(
    BuildContext context, {
    required IconData icone,
    required String titre,
    required String sousTitre,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        // Icône avec conteneur coloré
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CouleursApplication.primaire.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icone, color: CouleursApplication.primaire),
        ),
        
        // Titre de l'option
        title: Text(
          titre,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        
        // Sous-titre descriptif
        subtitle: Text(
          sousTitre,
          style: const TextStyle(
            color: CouleursApplication.texteSecondaire,
            fontSize: 12,
          ),
        ),
        
        // Flèche de navigation
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        
        // Action au tap
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Page "$titre" simulée')),
          );
        },
      ),
    );
  }

  /// Construit le bouton de déconnexion
  Widget _construireBoutonDeconnexion(BuildContext context) {
    return BoutonModerne(
      texte: 'Se déconnecter',
      onPressed: () => _gererDeconnexion(context),
      estSecondaire: true,
    );
  }

  /// Gère le processus de déconnexion avec confirmation
  void _gererDeconnexion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          // Bouton Annuler
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          
          // Bouton Confirmer
          TextButton(
            onPressed: () {
              // Ferme la boîte de dialogue
              Navigator.pop(context);
              // Ferme la page des paramètres
              Navigator.pop(context);
              // Déconnecte l'utilisateur
              EtatApplication.instance.deconnecterUtilisateur();
            },
            child: const Text('Se déconnecter'),
          ),
        ],
      ),
    );
  }
} 