// ===================================
// IMPORTS NÉCESSAIRES
// ===================================

import 'package:flutter/material.dart';                    // Import principal Flutter (widgets, animations, etc.)
import '../core/constantes/couleurs_application.dart';     // Couleurs standardisées de l'application
import '../core/constantes/dimensions_application.dart';   // Tailles et espacements constants
import '../core/etat/etat_application.dart';               // Gestionnaire d'état global (enregistrement, transcription)
import '../widgets/bouton_moderne.dart';                   // Widget personnalisé pour les boutons

// ===================================
// PAGE DE TRANSCRIPTION - WIDGET PRINCIPAL
// ===================================

/// Page principale de transcription permettant d'enregistrer des audios
/// et d'afficher les transcriptions générées par l'IA
/// 
/// STATEFULWIDGET : Nécessaire car cette page écoute les changements d'état global
/// et met à jour son interface en temps réel (enregistrement, transcription, crédit)
class PageTranscription extends StatefulWidget {
  const PageTranscription({super.key});

  @override
  State<PageTranscription> createState() => _PageTranscriptionState();
}

// ===================================
// ÉTAT DE LA PAGE DE TRANSCRIPTION
// ===================================

/// Classe d'état gérant l'interface de transcription et l'écoute des changements globaux
class _PageTranscriptionState extends State<PageTranscription> {
  
  // ===================================
  // VARIABLES D'ÉTAT
  // ===================================
  
  /// Contrôleur pour le champ de texte de transcription éditable
  /// Permet de récupérer et modifier le texte transcrit par l'utilisateur
  final TextEditingController _controleurTranscription = TextEditingController();

// ===================================
// MÉTHODES DU CYCLE DE VIE AVEC LISTENERS
// ===================================

  @override
  void initState() {
    super.initState();
    // LISTENER D'ÉTAT GLOBAL : Écoute les changements dans EtatApplication
    // Très important pour une interface réactive qui se met à jour automatiquement
    EtatApplication.instance.addListener(_surChangementEtat);
  }

  @override
  void dispose() {
    // NETTOYAGE CRITIQUE : Retire le listener pour éviter les fuites mémoire
    // et les erreurs quand le widget n'existe plus
    EtatApplication.instance.removeListener(_surChangementEtat);
    _controleurTranscription.dispose();  // Libère le contrôleur de texte
    super.dispose();
  }

  /// CALLBACK DE CHANGEMENT D'ÉTAT : Appelée automatiquement quand l'état global change
  /// Met à jour le texte de transcription dans le champ éditable
  void _surChangementEtat() {
    // VÉRIFICATION DE SÉCURITÉ : S'assure que le widget existe encore
    if (mounted) {
      // SYNCHRONISATION : Met à jour le contrôleur avec le texte global
      _controleurTranscription.text = EtatApplication.instance.texteTranscription;
      
      // RECONSTRUCTION : Force la mise à jour de l'interface
      setState(() {});
    }
  }

// ===================================
// CONSTRUCTION DE L'INTERFACE
// ===================================

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD : Structure de base sans AppBar (interface immersive)
    return Scaffold(
      backgroundColor: CouleursApplication.fondPrincipal,  // Fond standard de l'app
      
      // SINGLECHILDSCROLLVIEW : Permet le scroll pour les transcriptions longues
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DimensionsApplication.paddingM),  // Marges uniformes
        
        // COLUMN : Organisation verticale des sections
        child: Column(
          children: [
            // SECTION 1 : Crédit de transcription restant (toujours visible)
            _construireSectionCredit(),
            const SizedBox(height: DimensionsApplication.margeSection),
            
            // SECTION 2 : Interface d'enregistrement (toujours visible)
            _construireSectionEnregistrement(),
            const SizedBox(height: DimensionsApplication.margeSection),
            
            // SECTION 3 : Transcription (CONDITIONNELLE - seulement si il y a du texte)
            // Affichage conditionnel basé sur l'état global
            if (EtatApplication.instance.texteTranscription.isNotEmpty)
              _construireSectionTranscription(),
              
            // ESPACE FINAL : Pour éviter que le contenu soit masqué par la navigation
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

// ===================================
// MÉTHODES PRIVÉES - CONSTRUCTION DES WIDGETS
// ===================================

  /// MÉTHODE 1 : Construit la section affichant le crédit de transcription restant
  Widget _construireSectionCredit() {
    return Container(
      width: double.infinity,  // Prend toute la largeur
      padding: const EdgeInsets.all(DimensionsApplication.paddingL),
      
      // DÉCORATION AVEC GRADIENT ET BORDURE
      decoration: BoxDecoration(
        // GRADIENT SUBTLE : Effet visuel doux avec les couleurs de l'app
        gradient: LinearGradient(
          colors: [
            CouleursApplication.primaire.shade50,   // Couleur très claire
            CouleursApplication.primaire.shade100   // Couleur un peu plus foncée
          ],
        ),
        borderRadius: BorderRadius.circular(DimensionsApplication.radiusL),
        
        // BORDURE TRANSPARENTE : Délimite la section sans être agressive
        border: Border.all(color: CouleursApplication.primaire.withValues(alpha: 0.2)),
      ),
      
      child: Column(
        children: [
          // EN-TÊTE : Icône + Titre de la section
          Row(
            children: [
              Icon(Icons.access_time, color: CouleursApplication.primaire),  // Icône horloge
              const SizedBox(width: 8),
              const Text(
                'Crédit de transcription',
                style: TextStyle(fontWeight: FontWeight.w600),  // Titre semi-gras
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // BARRE DE PROGRESSION : Visualisation du crédit restant
          LinearProgressIndicator(
            // CALCUL DE PROGRESSION : creditSecondes / 600 (10 minutes max)
            value: EtatApplication.instance.creditSecondes / 600,
            backgroundColor: Colors.white.withValues(alpha: 0.3),      // Fond clair
            valueColor: AlwaysStoppedAnimation(CouleursApplication.primaire),  // Couleur de progression
          ),
          const SizedBox(height: 8),
          
          // TEXTE INFORMATIF : Temps restant en minutes avec décimale
          Text(
            '${(EtatApplication.instance.creditSecondes / 60).toStringAsFixed(1)} min restantes',
            style: const TextStyle(
              fontSize: 14, 
              color: CouleursApplication.texteSecondaire
            ),
          ),
        ],
      ),
    );
  }

  /// MÉTHODE 2 : Construit la section principale d'enregistrement audio
  Widget _construireSectionEnregistrement() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DimensionsApplication.paddingXL),  // Espacement généreux
      
      // DÉCORATION : Carte blanche avec ombre pour mise en valeur
      decoration: BoxDecoration(
        color: Colors.white,                                    // Fond blanc pur
        borderRadius: BorderRadius.circular(DimensionsApplication.radiusL),
        
        // OMBRE MARQUÉE : Met en valeur cette section importante
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),              // Ombre plus visible que d'habitude
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      
      child: Column(
        children: [
          // TITRE DE LA SECTION
          const Text(
            'Enregistrement Audio',
            style: TextStyle(
              fontSize: 20,                                      // Grande taille pour l'importance
              fontWeight: FontWeight.w600,                       // Semi-gras
              color: CouleursApplication.textePrincipal,
            ),
          ),
          const SizedBox(height: 24),
          
          // BOUTON PRINCIPAL : Gros bouton rond d'enregistrement
          _construireBoutonEnregistrement(),
          
          const SizedBox(height: 24),
          
          // TEXTE D'ÉTAT : Indication de l'état actuel de l'enregistrement
          _construireTexteEtatEnregistrement(),
          
          // BOUTON CONDITIONNEL : Arrêt d'enregistrement (seulement si en cours)
          // Utilise un spread operator conditionnel pour l'insertion
          if (EtatApplication.instance.estEnregistrement) ...[
            const SizedBox(height: 16),
            BoutonModerne(
              texte: 'Arrêter et transcrire',                    // Action claire
              onPressed: () => EtatApplication.instance.arreterEnregistrement(),
              estSecondaire: true,                               // Style moins proéminent
            ),
          ],
          
          const SizedBox(height: 32),
          const Divider(),  // SÉPARATEUR VISUEL
          const SizedBox(height: 16),
          
          // BOUTON D'IMPORT : Alternative à l'enregistrement direct
          BoutonModerne(
            texte: 'Importer un fichier audio',
            icone: Icons.upload_file,                            // Icône explicite
            estSecondaire: true,                                 // Style secondaire
            onPressed: () {
              // SIMULATION : Affiche une notification temporaire
              // Dans une vraie app, ici on ouvrirait un sélecteur de fichiers
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fonctionnalité d\'import simulée')),
              );
            },
          ),
        ],
      ),
    );
  }

  /// MÉTHODE 3 : Construit le bouton principal d'enregistrement (rond avec gradient)
  Widget _construireBoutonEnregistrement() {
    // GESTUREDETECTOR : Détecte les taps sur le bouton personnalisé
    return GestureDetector(
      onTap: () => EtatApplication.instance.basculerEnregistrement(),  // Action au tap
      
      child: Container(
        width: 120,   // Taille imposante pour un bouton principal
        height: 120,
        
        // DÉCORATION CONDITIONNELLE : Change selon l'état d'enregistrement
        decoration: BoxDecoration(
          // GRADIENT DYNAMIQUE : Rouge pendant l'enregistrement, bleu sinon
          gradient: LinearGradient(
            colors: EtatApplication.instance.estEnregistrement
                ? [Colors.red.shade400, Colors.red.shade600]      // Rouge = enregistrement actif
                : [CouleursApplication.primaire, CouleursApplication.primaire.shade600],  // Bleu = prêt
          ),
          shape: BoxShape.circle,  // Forme parfaitement circulaire
          
          // OMBRE COLORÉE DYNAMIQUE : Assortie au gradient
          boxShadow: [
            BoxShadow(
              // COULEUR D'OMBRE CONDITIONNELLE
              color: (EtatApplication.instance.estEnregistrement 
                      ? Colors.red 
                      : CouleursApplication.primaire)
                  .withValues(alpha: 0.4),
              blurRadius: 20,              // Ombre diffuse
              offset: const Offset(0, 10), // Décalage vers le bas
            ),
          ],
        ),
        
        // ICÔNE CENTRALE : Change selon l'état
        child: Icon(
          _obtenirIconeEnregistrement(),  // Méthode qui détermine l'icône
          size: 48,                       // Grande taille pour la visibilité
          color: Colors.white,            // Blanc pour contraster
        ),
      ),
    );
  }

  /// MÉTHODE 4 : Retourne l'icône appropriée selon l'état d'enregistrement
  IconData _obtenirIconeEnregistrement() {
    // LOGIQUE CONDITIONNELLE COMPLEXE : 3 états possibles
    if (EtatApplication.instance.estEnregistrement) {
      // Si en enregistrement : pause ou play selon si en pause
      return EtatApplication.instance.estEnPause ? Icons.play_arrow : Icons.pause;
    }
    // Sinon : microphone (prêt à enregistrer)
    return Icons.mic;
  }

  /// MÉTHODE 5 : Construit le texte d'état sous le bouton d'enregistrement
  Widget _construireTexteEtatEnregistrement() {
    // GÉNÉRATION DE TEXTE CONDITIONNEL : Selon l'état actuel
    String texte;
    if (EtatApplication.instance.estEnregistrement) {
      // Si en enregistrement : "En pause" ou "Enregistrement..."
      texte = EtatApplication.instance.estEnPause ? 'En pause' : 'Enregistrement...';
    } else {
      // Sinon : instruction pour démarrer
      texte = 'Appuyez pour enregistrer';
    }

    return Text(
      texte,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,                            // Légèrement gras
        color: CouleursApplication.texteSecondaire,              // Couleur secondaire
      ),
    );
  }

  /// MÉTHODE 6 : Construit la section de transcription avec le texte éditable
  Widget _construireSectionTranscription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DimensionsApplication.paddingL),
      
      // MÊME STYLE QUE LA SECTION ENREGISTREMENT pour cohérence
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DimensionsApplication.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // Aligne le contenu à gauche
        children: [
          // TITRE DE LA SECTION
          const Text(
            'Transcription',
            style: TextStyle(
              fontSize: 18,                                      // Légèrement plus petit que "Enregistrement"
              fontWeight: FontWeight.w600,
              color: CouleursApplication.textePrincipal,
            ),
          ),
          const SizedBox(height: 16),
          
          // CHAMP DE TEXTE MULTI-LIGNES : Pour éditer la transcription
          TextFormField(
            controller: _controleurTranscription,               // Contrôleur pour récupérer/modifier le texte
            maxLines: 10,                                       // Hauteur fixe de 10 lignes
            
            // DÉCORATION DU CHAMP
            decoration: InputDecoration(
              hintText: 'Votre transcription apparaîtra ici...',  // Texte d'aide
              
              // BORDURES STANDARDS
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: CouleursApplication.bordure),
              ),
              
              // BORDURE QUAND FOCUS : Met en valeur le champ actif
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: CouleursApplication.primaire, width: 2),
              ),
            ),
            
            // CALLBACK DE CHANGEMENT : Met à jour l'état global à chaque modification
            onChanged: (valeur) => EtatApplication.instance.mettreAJourTranscription(valeur),
          ),
          
          const SizedBox(height: 16),
          
          // BOUTONS D'ACTION : Export PDF + Sauvegarde côte à côte
          Row(
            children: [
              // BOUTON EXPORT PDF (gauche)
              Expanded(  // Prend la moitié de l'espace disponible
                child: BoutonModerne(
                  texte: 'Exporter PDF',
                  icone: Icons.picture_as_pdf,                   // Icône PDF explicite
                  estSecondaire: true,                          // Style secondaire
                  onPressed: () {
                    // SIMULATION : Dans une vraie app, ici on générerait un PDF
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Export PDF simulé')),
                    );
                  },
                ),
              ),
              
              const SizedBox(width: 12),  // Espace entre les boutons
              
              // BOUTON SAUVEGARDE (droite)
              Expanded(  // Prend l'autre moitié de l'espace
                child: BoutonModerne(
                  texte: 'Sauvegarder',
                  icone: Icons.save,                             // Icône sauvegarde
                  onPressed: () {
                    // SIMULATION : Dans une vraie app, ici on sauvegarderait en BDD
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Transcription sauvegardée !'),
                        backgroundColor: CouleursApplication.succes,  // Couleur verte pour succès
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 