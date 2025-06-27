import 'package:flutter/material.dart';
import '../core/constantes/couleurs_application.dart';
import '../core/etat/etat_application.dart';
import '../widgets/bouton_moderne.dart';
import '../widgets/champ_saisie.dart';
import 'page_inscription.dart';

/// Page de connexion permettant aux utilisateurs de s'authentifier
/// Contient un formulaire avec email/mot de passe et validation
class PageConnexion extends StatefulWidget {
  const PageConnexion({super.key});

  @override
  State<PageConnexion> createState() => _PageConnexionState();
}

class _PageConnexionState extends State<PageConnexion> with SingleTickerProviderStateMixin {
  
  // === CONTRÔLEURS ET VARIABLES D'ÉTAT ===
  /// Clé du formulaire pour la validation
  final _cleFormulaire = GlobalKey<FormState>();
  
  /// Contrôleur pour le champ email
  final _controleurEmail = TextEditingController();
  
  /// Contrôleur pour le champ mot de passe
  final _controleurMotDePasse = TextEditingController();
  
  /// Indique si le mot de passe est visible ou masqué
  bool _motDePasseVisible = false;
  
  /// Indique si la connexion est en cours (état de chargement)
  bool _estEnChargement = false;
  
  /// Message d'erreur à afficher si la connexion échoue
  String? _messageErreur;
  
  // === ANIMATION ===
  /// Contrôleur d'animation pour l'effet d'apparition
  late AnimationController _controleurAnimation;
  
  /// Animation d'opacité pour l'effet fade-in
  late Animation<double> _animationApparition;

  @override
  void initState() {
    super.initState();
    _initialiserAnimation();
  }

  @override
  void dispose() {
    _controleurAnimation.dispose();
    _controleurEmail.dispose();
    _controleurMotDePasse.dispose();
    super.dispose();
  }

  /// Initialise l'animation d'apparition de la page
  void _initialiserAnimation() {
    _controleurAnimation = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animationApparition = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controleurAnimation, curve: Curves.easeInOut),
    );
    _controleurAnimation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: FadeTransition(
              opacity: _animationApparition,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  _construireEntete(),
                  const SizedBox(height: 50),
                  _construireFormulaireConnexion(),
                  const SizedBox(height: 30),
                  if (_messageErreur != null) _construireMessageErreur(),
                  const SizedBox(height: 30),
                  _construireBoutonConnexion(),
                  const SizedBox(height: 20),
                  _construireBoutonInscription(),
                  const SizedBox(height: 40),
                ],
              ),
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
        // Logo avec gradient et ombre
        Container(
          width: 100,
          height: 100,
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
            boxShadow: [
              BoxShadow(
                color: CouleursApplication.primaire.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.note_alt_rounded,
            size: 50,
            color: Colors.white,
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Titre principal
        const Text(
          'Connexion',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Sous-titre descriptif
        const Text(
          'Accédez à vos transcriptions audio',
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

  /// Construit le formulaire de connexion avec les champs email et mot de passe
  Widget _construireFormulaireConnexion() {
    return Form(
      key: _cleFormulaire,
      child: Column(
        children: [
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
          
          // Champ mot de passe avec bouton pour afficher/masquer
          _construireChampMotDePasse(),
        ],
      ),
    );
  }

  /// Construit le champ mot de passe avec la possibilité de l'afficher/masquer
  Widget _construireChampMotDePasse() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: _controleurMotDePasse,
        obscureText: !_motDePasseVisible,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: 'Mot de passe',
          labelStyle: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
          // Icône préfixe
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CouleursApplication.primaire.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.lock_outline,
              color: CouleursApplication.primaire,
              size: 20,
            ),
          ),
          // Bouton pour afficher/masquer le mot de passe
          suffixIcon: IconButton(
            icon: Icon(
              _motDePasseVisible ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFF6B7280),
            ),
            onPressed: () {
              setState(() {
                _motDePasseVisible = !_motDePasseVisible;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
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
        validator: (valeur) {
          if (valeur == null || valeur.isEmpty) {
            return 'Veuillez entrer votre mot de passe';
          }
          if (valeur.length < 6) {
            return 'Le mot de passe doit contenir au moins 6 caractères';
          }
          return null;
        },
      ),
    );
  }

  /// Construit le message d'erreur si la connexion échoue
  Widget _construireMessageErreur() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade600,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _messageErreur!,
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Construit le bouton principal de connexion
  Widget _construireBoutonConnexion() {
    return BoutonModerne(
      texte: 'Se connecter',
      estEnChargement: _estEnChargement,
      onPressed: _gererConnexion,
    );
  }

  /// Construit le bouton secondaire pour aller à l'inscription
  Widget _construireBoutonInscription() {
    return BoutonModerne(
      texte: 'Créer un compte',
      estSecondaire: true,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PageInscription()),
        );
      },
    );
  }

  /// Gère le processus de connexion avec validation et simulation
  Future<void> _gererConnexion() async {
    // Valide le formulaire avant de continuer
    if (!_cleFormulaire.currentState!.validate()) return;

    setState(() {
      _estEnChargement = true;
      _messageErreur = null;
    });

    // Simulation d'un appel réseau pour la connexion
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Simulation d'une connexion réussie
      EtatApplication.instance.connecterUtilisateur(
        _controleurEmail.text.trim(),
        _controleurEmail.text.split('@')[0], // Utilise la partie avant @ comme nom
      );
      
      // Affiche un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connexion réussie !'),
          backgroundColor: CouleursApplication.succes,
        ),
      );
    }

    setState(() {
      _estEnChargement = false;
    });
  }
} 