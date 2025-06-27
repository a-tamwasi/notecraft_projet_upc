import 'package:flutter/material.dart';
import '../core/constantes/couleurs_application.dart';
import '../core/etat/etat_application.dart';
import '../widgets/bouton_moderne.dart';
import '../widgets/champ_saisie.dart';

/// Page d'inscription permettant aux nouveaux utilisateurs de créer un compte
/// Contient un formulaire complet avec validation des champs
class PageInscription extends StatefulWidget {
  const PageInscription({super.key});

  @override
  State<PageInscription> createState() => _PageInscriptionState();
}

class _PageInscriptionState extends State<PageInscription> {
  
  // === CONTRÔLEURS ET VARIABLES D'ÉTAT ===
  /// Clé du formulaire pour la validation
  final _cleFormulaire = GlobalKey<FormState>();
  
  /// Contrôleur pour le champ nom complet
  final _controleurNom = TextEditingController();
  
  /// Contrôleur pour le champ email
  final _controleurEmail = TextEditingController();
  
  /// Contrôleur pour le champ mot de passe
  final _controleurMotDePasse = TextEditingController();
  
  /// Contrôleur pour la confirmation du mot de passe
  final _controleurConfirmationMotDePasse = TextEditingController();
  
  /// Indique si le mot de passe est visible ou masqué
  bool _motDePasseVisible = false;
  
  /// Indique si la confirmation du mot de passe est visible ou masquée
  bool _confirmationMotDePasseVisible = false;
  
  /// Indique si l'inscription est en cours (état de chargement)
  bool _estEnChargement = false;

  @override
  void dispose() {
    _controleurNom.dispose();
    _controleurEmail.dispose();
    _controleurMotDePasse.dispose();
    _controleurConfirmationMotDePasse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _construireEntete(),
                const SizedBox(height: 40),
                _construireFormulaireInscription(),
                const SizedBox(height: 30),
                _construireBoutonInscription(),
                const SizedBox(height: 20),
                _construireLienConnexion(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Construit l'en-tête avec le logo et le titre de la page
  Widget _construireEntete() {
    return Column(
      children: [
        // Logo avec gradient
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                CouleursApplication.primaire,
                CouleursApplication.primaire.shade300,
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_add_rounded,
            size: 40,
            color: Colors.white,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Titre principal
        const Text(
          'Créer un compte',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Sous-titre descriptif
        const Text(
          'Rejoignez NoteCraft pour transcrire vos audios',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Construit le formulaire d'inscription avec tous les champs nécessaires
  Widget _construireFormulaireInscription() {
    return Form(
      key: _cleFormulaire,
      child: Column(
        children: [
          // Champ nom complet
          ChampSaisie(
            libelle: 'Nom complet',
            controleur: _controleurNom,
            iconePrefixe: Icons.person_outline,
            validateur: (valeur) {
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez entrer votre nom';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 20),
          
          // Champ email
          ChampSaisie(
            libelle: 'Adresse email',
            controleur: _controleurEmail,
            iconePrefixe: Icons.email_outlined,
            typeClavier: TextInputType.emailAddress,
            validateur: (valeur) {
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(valeur)) {
                return 'Veuillez entrer un email valide';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 20),
          
          // Champ mot de passe
          ChampSaisie(
            libelle: 'Mot de passe',
            controleur: _controleurMotDePasse,
            estMotDePasse: !_motDePasseVisible,
            iconePrefixe: Icons.lock_outline,
            validateur: (valeur) {
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              }
              if (valeur.length < 6) {
                return 'Le mot de passe doit contenir au moins 6 caractères';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 20),
          
          // Champ confirmation mot de passe
          ChampSaisie(
            libelle: 'Confirmer mot de passe',
            controleur: _controleurConfirmationMotDePasse,
            estMotDePasse: !_confirmationMotDePasseVisible,
            iconePrefixe: Icons.lock_outline,
            validateur: (valeur) {
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez confirmer votre mot de passe';
              }
              if (valeur != _controleurMotDePasse.text) {
                return 'Les mots de passe ne correspondent pas';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Construit le bouton principal d'inscription
  Widget _construireBoutonInscription() {
    return BoutonModerne(
      texte: 'Créer mon compte',
      estEnChargement: _estEnChargement,
      onPressed: _gererInscription,
    );
  }

  /// Construit le lien pour revenir à la page de connexion
  Widget _construireLienConnexion() {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: RichText(
        text: const TextSpan(
          text: 'Déjà un compte ? ',
          style: TextStyle(color: Color(0xFF6B7280)),
          children: [
            TextSpan(
              text: 'Se connecter',
              style: TextStyle(
                color: CouleursApplication.primaire,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Gère le processus d'inscription avec validation et simulation
  Future<void> _gererInscription() async {
    // Valide le formulaire avant de continuer
    if (!_cleFormulaire.currentState!.validate()) return;

    setState(() {
      _estEnChargement = true;
    });

    // Simulation d'un appel réseau pour l'inscription
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Simulation d'une inscription réussie - connecte automatiquement l'utilisateur
      EtatApplication.instance.connecterUtilisateur(
        _controleurEmail.text.trim(),
        _controleurNom.text.trim(),
      );
      
      // Retourne à la page précédente (sera automatiquement redirigé vers l'accueil)
      Navigator.pop(context);
      
      // Affiche un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Compte créé avec succès !'),
          backgroundColor: CouleursApplication.succes,
        ),
      );
    }

    setState(() {
      _estEnChargement = false;
    });
  }
} 