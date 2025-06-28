import 'package:flutter/material.dart'; // Import principal pour utiliser les widgets et thèmes Flutter
import '../core/constantes/couleurs_application.dart'; // Import des constantes de couleurs définies pour l'application
import '../core/etat/etat_application.dart'; // Import du gestionnaire d'état global de l'application
import '../widgets/bouton_moderne.dart'; // Import du widget personnalisé pour les boutons modernes
import '../widgets/champ_saisie.dart'; // Import du widget personnalisé pour les champs de saisie
import 'page_inscription.dart'; // Import de la page d'inscription pour la navigation


/// Page de connexion permettant aux utilisateurs de s'authentifier
/// Contient un formulaire avec email/mot de passe et validation
/// 
/// STATEFULWIDGET : Utilisé car cette page a un état qui change
/// (chargement, erreurs, visibilité du mot de passe, animations)
class PageConnexion extends StatefulWidget {
  const PageConnexion({super.key});

  @override
  State<PageConnexion> createState() => _PageConnexionState();
}

/// État de la page contenant toutes les variables et méthodes
/// 
/// SINGLETICKERPROVIDER : Nécessaire pour les animations
/// Fournit un "ticker" qui synchronise les animations avec l'écran
class _PageConnexionState extends State<PageConnexion> with SingleTickerProviderStateMixin {
  
  // ===================================
  // VARIABLES D'ÉTAT ET CONTRÔLEURS
  // ===================================
  
  // VALIDATION DU FORMULAIRE
  /// Clé du formulaire pour la validation globale
  /// Permet de valider tous les champs en une fois
  final _cleFormulaire = GlobalKey<FormState>();
  
  // CONTRÔLEURS DE TEXTE
  /// Contrôleur pour le champ email - récupère et contrôle le texte saisi
  final _controleurEmail = TextEditingController();
  
  /// Contrôleur pour le champ mot de passe - récupère et contrôle le texte saisi
  final _controleurMotDePasse = TextEditingController();
  
  // VARIABLES D'ÉTAT POUR L'INTERFACE
  /// Indique si le mot de passe est visible ou masqué (true = visible)
  bool _motDePasseVisible = false;
  
  /// Indique si la connexion est en cours (affiche un spinner de chargement)
  bool _estEnChargement = false;
  
  /// Message d'erreur à afficher si la connexion échoue (null = pas d'erreur)
  String? _messageErreur;
  
  // VARIABLES POUR L'ANIMATION
  /// Contrôleur d'animation pour gérer l'effet d'apparition de la page
  late AnimationController _controleurAnimation;
  
  /// Animation d'opacité pour créer un effet fade-in (apparition progressive)
  late Animation<double> _animationApparition;

// ===================================
// MÉTHODES DU CYCLE DE VIE DU WIDGET
// ===================================

  @override
  void initState() {
    super.initState();
    // INITIALISATION : Appelée une seule fois quand le widget est créé
    _initialiserAnimation();
  }

  @override
  void dispose() {
    // NETTOYAGE : Appelée quand le widget est détruit
    // TRÈS IMPORTANT : Évite les fuites mémoire en libérant les ressources
    _controleurAnimation.dispose();  // Libère l'animation
    _controleurEmail.dispose();      // Libère le contrôleur email
    _controleurMotDePasse.dispose(); // Libère le contrôleur mot de passe
    super.dispose();
  }

  /// MÉTHODE D'INITIALISATION : Configure l'animation d'apparition
  void _initialiserAnimation() {
    // CONTRÔLEUR D'ANIMATION : Gère la durée et la progression
    _controleurAnimation = AnimationController(
      duration: const Duration(milliseconds: 1500), // Animation de 1.5 secondes
      vsync: this, // Synchronise avec l'écran (60fps)
    );
    
    // ANIMATION TWEEN : Définit la transition de 0.0 (invisible) à 1.0 (visible)
    _animationApparition = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controleurAnimation, 
        curve: Curves.easeInOut, // Courbe d'animation douce (lent-rapide-lent)
      ),
    );
    
    // DÉMARRAGE : Lance l'animation immédiatement
    _controleurAnimation.forward();
  }

// ===================================
// CONSTRUCTION DE L'INTERFACE
// ===================================

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD : Structure de base d'une page Flutter
    return Scaffold(
      // BODY AVEC IMAGE D'ARRIÈRE-PLAN
      body: Stack(
        children: [
          // ARRIÈRE-PLAN : Image qui couvre tout l'écran
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'),
                fit: BoxFit.cover,  // Couvre tout l'écran
              ),
            ),
          ),
          
          // CONTENU AU-DESSUS DE L'ARRIÈRE-PLAN
          SafeArea(
            // SINGLECHILDSCROLLVIEW : Permet le scroll si le contenu dépasse l'écran
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0), // Marges gauche/droite
                
                // FADETRANSITION : Applique l'animation d'apparition à tout le contenu
                child: FadeTransition(
                  opacity: _animationApparition, // Utilise l'animation définie plus haut
              
              // COLUMN : Organise les éléments verticalement
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Étire les enfants sur toute la largeur
                children: [
                  const SizedBox(height: 10), // Espace en haut
                  
                  // 1. EN-TÊTE : Logo et titre
                  _construireEntete(),
                  const SizedBox(height: 30),
                  
                  // 2. FORMULAIRE : Champs email et mot de passe
                  _construireFormulaireConnexion(),
                  const SizedBox(height: 30),
                  
                  // 3. MESSAGE D'ERREUR : Affiché seulement s'il y a une erreur
                  if (_messageErreur != null) _construireMessageErreur(),
                  const SizedBox(height: 30),
                  
                  // 4. BOUTON CONNEXION : Bouton principal
                  _construireBoutonConnexion(),
                  const SizedBox(height: 20),
                  
                  // 5. BOUTON INSCRIPTION : Bouton secondaire
                  _construireBoutonInscription(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    ]));
  }

// ===================================
// MÉTHODES PRIVÉES - CONSTRUCTION DES WIDGETS
// ===================================

  /// MÉTHODE 1 : Construit l'en-tête avec le logo et le titre de la page
  Widget _construireEntete() {
    return Column(
      children: [
        // LOGO DANS UN SIZEBOX
        SizedBox(
          width: 200,  // Largeur du logo
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,    // Garde les proportions
          ),
        ),
        
        
        // TITRE PRINCIPAL : Gros texte "Connexion"
        const Text(
          'Connexion',
          style: TextStyle(
            fontSize: 32,                    // Très grande taille
            fontWeight: FontWeight.w700,     // Très gras
            color: Color(0xFF1A1A1A),       // Couleur sombre (presque noir)
          ),
        ),
        
        const SizedBox(height: 8), // Petit espace
        
        // SOUS-TITRE DESCRIPTIF : Texte explicatif plus petit
        const Text(
          'Accédez à vos transcriptions audio',
          style: TextStyle(
            fontSize: 16,                    // Taille normale
            fontWeight: FontWeight.w400,     // Poids normal
            color: Color.fromARGB(255, 255, 255, 255),       // Couleur grise
          ),
          textAlign: TextAlign.center,      // Centré horizontalement
        ),
      ],
    );
  }

  /// MÉTHODE 2 : Construit le formulaire de connexion avec les champs email et mot de passe
  Widget _construireFormulaireConnexion() {
    // FORM : Widget qui groupe les champs pour une validation commune
    return Form(
      key: _cleFormulaire, // Clé pour accéder au formulaire depuis l'extérieur
      child: Column(
        children: [
          // CHAMP EMAIL : Utilise notre widget personnalisé ChampSaisie
          ChampSaisie(
            libelle: 'Adresse email',                    // Texte affiché au-dessus du champ
            controleur: _controleurEmail,                // Contrôleur pour récupérer le texte
            iconePrefixe: Icons.email_outlined,          // Icône à gauche du champ
            typeClavier: TextInputType.emailAddress,     // Clavier optimisé pour email
            
            // VALIDATEUR : Fonction qui vérifie si la saisie est correcte
            validateur: (valeur) {
              // Vérification 1 : Le champ n'est pas vide
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              
              // Vérification 2 : Format email valide avec regex
              // Cette regex vérifie : nom@domaine.extension
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(valeur)) {
                return 'Veuillez entrer un email valide';
              }
              
              // Si tout est OK, retourne null (pas d'erreur)
              return null;
            },
          ),
          
          const SizedBox(height: 20), // Espace entre les champs
          
          // CHAMP MOT DE PASSE : Construction personnalisée pour le bouton "afficher/masquer"
          _construireChampMotDePasse(),
        ],
      ),
    );
  }

  /// MÉTHODE 3 : Construit le champ mot de passe avec la possibilité de l'afficher/masquer
  Widget _construireChampMotDePasse() {
    // CONTAINER : Pour la décoration (ombre, bordures)
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,                                    // Fond blanc
        borderRadius: BorderRadius.circular(16),                // Coins arrondis
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),             // Ombre légère
            blurRadius: 10,                                     // Flou de l'ombre
            offset: const Offset(0, 4),                        // Décalage vers le bas
          ),
        ],
      ),
      
      // TEXTFORMFIELD : Champ de texte avec validation intégrée
      child: TextFormField(
        controller: _controleurMotDePasse,         // Contrôleur pour récupérer le texte
        obscureText: !_motDePasseVisible,         // Masque le texte si _motDePasseVisible = false
        
        // STYLE DU TEXTE SAISI
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        
        // DÉCORATION DU CHAMP
        decoration: InputDecoration(
          labelText: 'Mot de passe',               // Texte du label
          labelStyle: const TextStyle(
            color: Color(0xFF6B7280),             // Couleur grise
            fontWeight: FontWeight.w500,
          ),
          
          // ICÔNE PRÉFIXE : Icône à gauche dans un container stylisé
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),      // Marge autour de l'icône
            padding: const EdgeInsets.all(8),      // Espacement intérieur
            decoration: BoxDecoration(
              // Fond coloré avec transparence
              color: CouleursApplication.primaire.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8), // Coins arrondis
            ),
            child: Icon(
              Icons.lock_outline,                   // Icône cadenas
              color: CouleursApplication.primaire,  // Couleur de l'icône
              size: 20,
            ),
          ),
          
          // BOUTON SUFFIXE : Bouton pour afficher/masquer le mot de passe
          suffixIcon: IconButton(
            icon: Icon(
              // ICÔNE CONDITIONNELLE : Change selon l'état de visibilité
              _motDePasseVisible ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFF6B7280),
            ),
            
            // ACTION AU CLIC : Inverse l'état de visibilité
            onPressed: () {
              setState(() { // Déclenche une reconstruction du widget
                _motDePasseVisible = !_motDePasseVisible;
              });
            },
          ),
          
          // BORDURES DU CHAMP
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,           // Pas de bordure par défaut
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: CouleursApplication.primaire, // Bordure colorée quand focus
              width: 2,
            ),
          ),
          
          // ESPACEMENT INTÉRIEUR
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          
          // FOND DU CHAMP
          filled: true,
          fillColor: Colors.white,
        ),
        
        // VALIDATEUR : Vérifie la validité du mot de passe
        validator: (valeur) {
          if (valeur == null || valeur.isEmpty) {
            return 'Veuillez entrer votre mot de passe';
          }
          if (valeur.length < 6) {
            return 'Le mot de passe doit contenir au moins 6 caractères';
          }
          return null; // Pas d'erreur
        },
      ),
    );
  }

  /// MÉTHODE 4 : Construit le message d'erreur si la connexion échoue
  Widget _construireMessageErreur() {
    return Container(
      padding: const EdgeInsets.all(16),        // Espacement intérieur
      decoration: BoxDecoration(
        color: Colors.red.shade50,              // Fond rouge très clair
        borderRadius: BorderRadius.circular(12), // Coins arrondis
        border: Border.all(color: Colors.red.shade200), // Bordure rouge claire
      ),
      
      // ROW : Icône + texte sur la même ligne
      child: Row(
        children: [
          // ICÔNE D'ERREUR
          Icon(
            Icons.error_outline,
            color: Colors.red.shade600,          // Rouge moyen
            size: 20,
          ),
          const SizedBox(width: 12),            // Espace entre icône et texte
          
          // TEXTE D'ERREUR
          Expanded(                             // Prend tout l'espace restant
            child: Text(
              _messageErreur!,                  // ! car on sait qu'il n'est pas null
              style: TextStyle(
                color: Colors.red.shade700,     // Rouge foncé
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// MÉTHODE 5 : Construit le bouton principal de connexion
  Widget _construireBoutonConnexion() {
    return BoutonModerne(
      texte: 'Se connecter',              // Texte affiché sur le bouton
      estEnChargement: _estEnChargement,  // Affiche un spinner si true
      onPressed: _gererConnexion,         // Fonction appelée au clic
    );
  }

  /// MÉTHODE 6 : Construit le bouton secondaire pour aller à l'inscription
  Widget _construireBoutonInscription() {
    return BoutonModerne(
      texte: 'Créer un compte',           // Texte du bouton
      estSecondaire: true,                // Style secondaire (moins proéminent)
      onPressed: () {
        // NAVIGATION : Pousse une nouvelle page sur la pile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PageInscription()),
        );
      },
    );
  }

// ===================================
// LOGIQUE MÉTIER
// ===================================

  /// MÉTHODE 7 : Gère le processus de connexion avec validation et simulation
  Future<void> _gererConnexion() async {
    // VALIDATION DU FORMULAIRE : Vérifie tous les champs d'un coup
    if (!_cleFormulaire.currentState!.validate()) return; // Arrête si invalide

    // MISE À JOUR DE L'ÉTAT : Active le mode chargement
    setState(() {
      _estEnChargement = true;           // Active le spinner
      _messageErreur = null;             // Efface les erreurs précédentes
    });

    // SIMULATION D'APPEL RÉSEAU : Simule une requête vers un serveur
    // Dans une vraie app, ici on ferait un appel HTTP
    await Future.delayed(const Duration(seconds: 2));

    // VÉRIFICATION : S'assure que le widget existe encore
    if (mounted) { // mounted = true si le widget n'a pas été détruit
      
      // CONNEXION RÉUSSIE : Met à jour l'état global de l'application
      EtatApplication.instance.connecterUtilisateur(
        _controleurEmail.text.trim(),                    // Email (sans espaces)
        _controleurEmail.text.split('@')[0],            // Nom = partie avant @
      );
      
      // MESSAGE DE SUCCÈS : Affiche une notification en bas de l'écran
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connexion réussie !'),
          backgroundColor: CouleursApplication.succes,  // Couleur verte
        ),
      );
    }

    // DÉSACTIVATION DU CHARGEMENT : Remet le bouton en état normal
    setState(() {
      _estEnChargement = false;
    });
  }
} 