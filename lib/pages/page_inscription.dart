// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';            // Import principal Flutter (widgets, formulaires, etc.)
import '../core/constantes/couleurs_application.dart';  // Couleurs standardisées de l'application
import '../core/etat/etat_application.dart';            // Gestionnaire d'état global pour l'authentification
import '../widgets/bouton_moderne.dart';                // Widget personnalisé pour les boutons stylisés
import '../widgets/champ_saisie.dart';                  // Widget personnalisé pour les champs de formulaire

// ===================================
// PAGE D'INSCRIPTION - WIDGET PRINCIPAL
// ===================================

/// Page d'inscription permettant aux nouveaux utilisateurs de créer un compte
/// Contient un formulaire complet avec validation des champs
/// 
/// STATEFULWIDGET : Nécessaire car la page gère un état complexe
/// (multiple contrôleurs, validation, états de visibilité, chargement)
class PageInscription extends StatefulWidget {
  const PageInscription({super.key});

  @override
  State<PageInscription> createState() => _PageInscriptionState();
}

// ===================================
// ÉTAT DE LA PAGE D'INSCRIPTION
// ===================================

/// Classe d'état gérant toutes les variables et la logique de l'inscription
class _PageInscriptionState extends State<PageInscription> {
  
  // ===================================
  // VARIABLES D'ÉTAT ET CONTRÔLEURS
  // ===================================
  
  // VALIDATION DU FORMULAIRE
  /// Clé globale du formulaire pour valider tous les champs simultanément
  /// Permet d'accéder aux méthodes de validation depuis n'importe où
  final _cleFormulaire = GlobalKey<FormState>();
  
  // CONTRÔLEURS DE TEXTE MULTIPLES
  /// Contrôleur pour le champ nom - récupère et gère le nom complet saisi
  final _controleurNom = TextEditingController();
  
  /// Contrôleur pour le champ email - récupère et gère l'adresse email saisie
  final _controleurEmail = TextEditingController();
  
  /// Contrôleur pour le mot de passe principal
  final _controleurMotDePasse = TextEditingController();
  
  /// Contrôleur pour la confirmation du mot de passe (sécurité double vérification)
  final _controleurConfirmationMotDePasse = TextEditingController();
  
  // VARIABLES D'ÉTAT POUR L'INTERFACE
  /// Gère la visibilité du mot de passe principal (true = visible, false = masqué)
  final bool _motDePasseVisible = false;
  
  /// Gère la visibilité de la confirmation du mot de passe
  final bool _confirmationMotDePasseVisible = false;
  
  /// Indique si l'inscription est en cours (affiche un spinner de chargement)
  bool _estEnChargement = false;

// ===================================
// MÉTHODES DU CYCLE DE VIE
// ===================================

  @override
  void dispose() {
    // NETTOYAGE CRITIQUE : Libère tous les contrôleurs pour éviter les fuites mémoire
    // Plus de contrôleurs = plus important de bien nettoyer
    _controleurNom.dispose();                        // Libère le contrôleur nom
    _controleurEmail.dispose();                      // Libère le contrôleur email  
    _controleurMotDePasse.dispose();                 // Libère le contrôleur mot de passe
    _controleurConfirmationMotDePasse.dispose();     // Libère le contrôleur confirmation
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD : Structure de base avec AppBar personnalisée
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),  // Fond bleu très clair
      
      // APPBAR : Barre de navigation en haut avec bouton retour
      appBar: AppBar(
        backgroundColor: Colors.transparent,  // Transparente pour un look moderne
        elevation: 0,                        // Pas d'ombre sous l'AppBar
        
        // BOUTON RETOUR PERSONNALISÉ
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A1A1A)),  // Icône iOS style
          onPressed: () => Navigator.pop(context),  // Retourne à la page précédente
        ),
      ),
      
      // CORPS PRINCIPAL DE LA PAGE
      body: SafeArea(  // Évite les zones système (encoche, barre d'état)
        child: SingleChildScrollView(  // Permet le scroll si le contenu dépasse
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),  // Marges latérales
            
            // COLUMN : Organisation verticale de tous les éléments
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,  // Étire les enfants sur toute la largeur
              children: [
                const SizedBox(height: 20),  // Espace après l'AppBar
                
                // 1. EN-TÊTE : Logo et titre de l'inscription
                _construireEntete(),
                const SizedBox(height: 40),
                
                // 2. FORMULAIRE : Tous les champs de saisie
                _construireFormulaireInscription(),
                const SizedBox(height: 30),
                
                // 3. BOUTON PRINCIPAL : Créer le compte
                _construireBoutonInscription(),
                const SizedBox(height: 20),
                
                // 4. LIEN DE CONNEXION : Pour les utilisateurs existants
                _construireLienConnexion(),
              ],
            ),
          ),
        ),
      ),
    );
  }

// ===================================
// MÉTHODES PRIVÉES - CONSTRUCTION DES WIDGETS
// ===================================

  /// MÉTHODE 1 : Construit l'en-tête avec le logo et le titre de la page
  Widget _construireEntete() {
    return Column(
      children: [
        // LOGO AVEC GRADIENT : Icône d'ajout de personne dans un cercle coloré
        Container(
          width: 80,   // Plus petit que sur la page de connexion
          height: 80,
          decoration: BoxDecoration(
            // GRADIENT : Dégradé de couleurs pour un effet moderne
            gradient: LinearGradient(
              begin: Alignment.topLeft,      // Début du gradient
              end: Alignment.bottomRight,    // Fin du gradient
              colors: [
                CouleursApplication.primaire,         // Couleur principale
                CouleursApplication.primaire.shade300, // Version plus claire
              ],
            ),
            shape: BoxShape.circle,  // Forme parfaitement circulaire
          ),
          
          // ICÔNE SPÉCIFIQUE À L'INSCRIPTION
          child: const Icon(
            Icons.person_add_rounded,  // Icône "ajouter une personne"
            size: 40,                  // Taille proportionnelle au container
            color: Colors.white,       // Blanc pour contraster avec le fond coloré
          ),
        ),
        
        const SizedBox(height: 24),  // Espace entre logo et titre
        
        // TITRE PRINCIPAL : Texte principal de la page
        const Text(
          'Créer un compte',
          style: TextStyle(
            fontSize: 28,                    // Grande taille pour attirer l'attention
            fontWeight: FontWeight.w700,     // Très gras pour l'importance
            color: Color(0xFF1A1A1A),       // Couleur sombre (presque noir)
          ),
        ),
        
        const SizedBox(height: 8),  // Petit espace
        
        // SOUS-TITRE DESCRIPTIF : Explique l'action et les bénéfices
        const Text(
          'Rejoignez NoteCraft pour transcrire vos audios',
          style: TextStyle(
            fontSize: 16,                    // Taille normale
            fontWeight: FontWeight.w400,     // Poids normal
            color: Color(0xFF6B7280),       // Couleur grise pour moins d'importance
          ),
          textAlign: TextAlign.center,      // Centré horizontalement
        ),
      ],
    );
  }

  /// MÉTHODE 2 : Construit le formulaire d'inscription avec tous les champs nécessaires
  Widget _construireFormulaireInscription() {
    // FORM : Container pour grouper tous les champs avec validation commune
    return Form(
      key: _cleFormulaire,  // Clé pour accéder au formulaire depuis l'extérieur
      child: Column(
        children: [
          
          // CHAMP 1 : NOM COMPLET
          ChampSaisie(
            libelle: 'Nom complet',                     // Label affiché
            controleur: _controleurNom,                 // Contrôleur pour récupérer la valeur
            iconePrefixe: Icons.person_outline,         // Icône personne à gauche
            
            // VALIDATEUR SIMPLE : Vérifie seulement que le champ n'est pas vide
            validateur: (valeur) {
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez entrer votre nom';     // Message d'erreur
              }
              return null;  // Pas d'erreur si le champ est rempli
            },
          ),
          
          const SizedBox(height: 20),  // Espace entre les champs
          
          // CHAMP 2 : EMAIL (avec validation format)
          ChampSaisie(
            libelle: 'Adresse email',                   // Label
            controleur: _controleurEmail,               // Contrôleur email
            iconePrefixe: Icons.email_outlined,         // Icône email
            typeClavier: TextInputType.emailAddress,    // Clavier optimisé pour email
            
            // VALIDATEUR COMPLEXE : Vérifie le format email avec regex
            validateur: (valeur) {
              // Vérification 1 : Champ non vide
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              
              // Vérification 2 : Format email valide
              // Regex expliquée : [\w-\.]+ = caractères/tirets/points, @ obligatoire, 
              // ([\w-]+\.)+ = domaine avec points, [\w-]{2,4} = extension 2-4 caractères
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(valeur)) {
                return 'Veuillez entrer un email valide';
              }
              
              return null;  // Email valide
            },
          ),
          
          const SizedBox(height: 20),
          
          // CHAMP 3 : MOT DE PASSE PRINCIPAL
          ChampSaisie(
            libelle: 'Mot de passe',                    // Label
            controleur: _controleurMotDePasse,          // Contrôleur mot de passe
            estMotDePasse: !_motDePasseVisible,         // Masque si _motDePasseVisible = false
            iconePrefixe: Icons.lock_outline,           // Icône cadenas
            
            // VALIDATEUR MOT DE PASSE : Vérifie la longueur minimale
            validateur: (valeur) {
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              }
              
              // SÉCURITÉ : Impose un minimum de 6 caractères
              if (valeur.length < 6) {
                return 'Le mot de passe doit contenir au moins 6 caractères';
              }
              
              return null;
            },
          ),
          
          const SizedBox(height: 20),
          
          // CHAMP 4 : CONFIRMATION MOT DE PASSE (sécurité double)
          ChampSaisie(
            libelle: 'Confirmer mot de passe',                  // Label explicite
            controleur: _controleurConfirmationMotDePasse,      // Contrôleur séparé
            estMotDePasse: !_confirmationMotDePasseVisible,     // Masque aussi
            iconePrefixe: Icons.lock_outline,                   // Même icône que mot de passe
            
            // VALIDATEUR SPÉCIAL : Compare avec le mot de passe principal
            validateur: (valeur) {
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez confirmer votre mot de passe';
              }
              
              // VÉRIFICATION CRITIQUE : Les deux mots de passe doivent être identiques
              if (valeur != _controleurMotDePasse.text) {
                return 'Les mots de passe ne correspondent pas';
              }
              
              return null;  // Confirmation valide
            },
          ),
        ],
      ),
    );
  }

  /// MÉTHODE 3 : Construit le bouton principal d'inscription
  Widget _construireBoutonInscription() {
    return BoutonModerne(
      texte: 'Créer mon compte',           // Texte engageant et personnel
      estEnChargement: _estEnChargement,   // Affiche un spinner pendant le traitement
      onPressed: _gererInscription,        // Fonction appelée au clic
    );
  }

  /// MÉTHODE 4 : Construit le lien pour revenir à la page de connexion
  Widget _construireLienConnexion() {
    return TextButton(
      onPressed: () => Navigator.pop(context),  // Retourne à la page de connexion
      
      // RICHTEXT : Permet de styliser différemment des parties d'un même texte
      child: RichText(
        text: const TextSpan(
          text: 'Déjà un compte ? ',                    // Première partie en gris
          style: TextStyle(color: Color(0xFF6B7280)),  // Style par défaut
          
          // CHILDREN : Parties de texte avec des styles différents
          children: [
            TextSpan(
              text: 'Se connecter',                     // Partie cliquable
              style: TextStyle(
                color: CouleursApplication.primaire,    // Couleur principale
                fontWeight: FontWeight.w600,            // Plus gras pour signaler l'action
              ),
            ),
          ],
        ),
      ),
    );
  }

// ===================================
// LOGIQUE MÉTIER - GESTION DE L'INSCRIPTION
// ===================================

  /// MÉTHODE 5 : Gère le processus d'inscription avec validation et simulation
  Future<void> _gererInscription() async {
    
    // VALIDATION GLOBALE : Vérifie tous les champs du formulaire d'un coup
    // Cette ligne exécute tous les validateurs définis plus haut
    if (!_cleFormulaire.currentState!.validate()) return;  // Arrête si un champ est invalide

    // ACTIVATION DU MODE CHARGEMENT : Met à jour l'interface
    setState(() {
      _estEnChargement = true;  // Active le spinner sur le bouton
    });

    // SIMULATION D'APPEL RÉSEAU : Simule une requête d'inscription vers un serveur
    // Dans une vraie app, ici on ferait un appel HTTP POST vers une API
    await Future.delayed(const Duration(seconds: 2));

    // VÉRIFICATION DE SÉCURITÉ : S'assure que le widget existe encore
    if (mounted) {  // mounted = true si le widget n'a pas été détruit pendant l'attente
      
      // INSCRIPTION RÉUSSIE : Met à jour l'état global de l'application
      // Connecte automatiquement l'utilisateur après l'inscription
      EtatApplication.instance.connecterUtilisateur(
        _controleurEmail.text.trim(),     // Email sans espaces en début/fin
        _controleurNom.text.trim(),       // Nom sans espaces en début/fin
      );
      
      // NAVIGATION : Retourne à la page précédente
      // Comme l'utilisateur est maintenant connecté, il sera automatiquement 
      // redirigé vers l'accueil grâce au GestionnaireAuthentification
      Navigator.pop(context);
      
      // MESSAGE DE SUCCÈS : Informe l'utilisateur que l'inscription a réussi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Compte créé avec succès !'),
          backgroundColor: CouleursApplication.succes,  // Couleur verte pour le succès
        ),
      );
    }

    // DÉSACTIVATION DU CHARGEMENT : Remet le bouton en état normal
    setState(() {
      _estEnChargement = false;
    });
  }
} 