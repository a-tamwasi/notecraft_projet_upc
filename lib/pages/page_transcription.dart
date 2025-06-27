import 'package:flutter/material.dart';
import '../core/constantes/couleurs_application.dart';
import '../core/constantes/dimensions_application.dart';
import '../core/etat/etat_application.dart';
import '../widgets/bouton_moderne.dart';

/// Page principale de transcription permettant d'enregistrer des audios
/// et d'afficher les transcriptions générées par l'IA
class PageTranscription extends StatefulWidget {
  const PageTranscription({super.key});

  @override
  State<PageTranscription> createState() => _PageTranscriptionState();
}

class _PageTranscriptionState extends State<PageTranscription> {
  
  /// Contrôleur pour le champ de texte de transcription
  final TextEditingController _controleurTranscription = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Écoute les changements d'état pour mettre à jour l'interface
    EtatApplication.instance.addListener(_surChangementEtat);
  }

  @override
  void dispose() {
    EtatApplication.instance.removeListener(_surChangementEtat);
    _controleurTranscription.dispose();
    super.dispose();
  }

  /// Appelée quand l'état de l'application change
  /// Met à jour le texte de transcription dans le champ
  void _surChangementEtat() {
    if (mounted) {
      _controleurTranscription.text = EtatApplication.instance.texteTranscription;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApplication.fondPrincipal,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DimensionsApplication.paddingM),
        child: Column(
          children: [
            _construireSectionCredit(),
            const SizedBox(height: DimensionsApplication.margeSection),
            _construireSectionEnregistrement(),
            const SizedBox(height: DimensionsApplication.margeSection),
            // Affiche la section transcription seulement si il y a du texte
            if (EtatApplication.instance.texteTranscription.isNotEmpty)
              _construireSectionTranscription(),
            // Espace pour la navigation en bas
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  /// Construit la section affichant le crédit de transcription restant
  Widget _construireSectionCredit() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DimensionsApplication.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CouleursApplication.primaire.shade50, 
            CouleursApplication.primaire.shade100
          ],
        ),
        borderRadius: BorderRadius.circular(DimensionsApplication.radiusL),
        border: Border.all(color: CouleursApplication.primaire.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          // En-tête avec icône et titre
          Row(
            children: [
              Icon(Icons.access_time, color: CouleursApplication.primaire),
              const SizedBox(width: 8),
              const Text(
                'Crédit de transcription',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Barre de progression du crédit
          LinearProgressIndicator(
            value: EtatApplication.instance.creditSecondes / 600, // Sur 10 minutes max
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation(CouleursApplication.primaire),
          ),
          const SizedBox(height: 8),
          
          // Texte du temps restant
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

  /// Construit la section principale d'enregistrement audio
  Widget _construireSectionEnregistrement() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DimensionsApplication.paddingXL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DimensionsApplication.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Titre de la section
          const Text(
            'Enregistrement Audio',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: CouleursApplication.textePrincipal,
            ),
          ),
          const SizedBox(height: 24),
          
          // Bouton d'enregistrement principal (rond)
          _construireBoutonEnregistrement(),
          
          const SizedBox(height: 24),
          
          // Texte d'état de l'enregistrement
          _construireTexteEtatEnregistrement(),
          
          // Bouton d'arrêt si enregistrement en cours
          if (EtatApplication.instance.estEnregistrement) ...[
            const SizedBox(height: 16),
            BoutonModerne(
              texte: 'Arrêter et transcrire',
              onPressed: () => EtatApplication.instance.arreterEnregistrement(),
              estSecondaire: true,
            ),
          ],
          
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          
          // Bouton d'import de fichier
          BoutonModerne(
            texte: 'Importer un fichier audio',
            icone: Icons.upload_file,
            estSecondaire: true,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fonctionnalité d\'import simulée')),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Construit le bouton principal d'enregistrement (rond avec gradient)
  Widget _construireBoutonEnregistrement() {
    return GestureDetector(
      onTap: () => EtatApplication.instance.basculerEnregistrement(),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          // Gradient rouge quand en enregistrement, bleu sinon
          gradient: LinearGradient(
            colors: EtatApplication.instance.estEnregistrement
                ? [Colors.red.shade400, Colors.red.shade600]
                : [CouleursApplication.primaire, CouleursApplication.primaire.shade600],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (EtatApplication.instance.estEnregistrement 
                      ? Colors.red 
                      : CouleursApplication.primaire)
                  .withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(
          _obtenirIconeEnregistrement(),
          size: 48,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Retourne l'icône appropriée selon l'état d'enregistrement
  IconData _obtenirIconeEnregistrement() {
    if (EtatApplication.instance.estEnregistrement) {
      return EtatApplication.instance.estEnPause ? Icons.play_arrow : Icons.pause;
    }
    return Icons.mic;
  }

  /// Construit le texte d'état sous le bouton d'enregistrement
  Widget _construireTexteEtatEnregistrement() {
    String texte;
    if (EtatApplication.instance.estEnregistrement) {
      texte = EtatApplication.instance.estEnPause ? 'En pause' : 'Enregistrement...';
    } else {
      texte = 'Appuyez pour enregistrer';
    }

    return Text(
      texte,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: CouleursApplication.texteSecondaire,
      ),
    );
  }

  /// Construit la section de transcription avec le texte éditable
  Widget _construireSectionTranscription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DimensionsApplication.paddingL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DimensionsApplication.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre de la section
          const Text(
            'Transcription',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: CouleursApplication.textePrincipal,
            ),
          ),
          const SizedBox(height: 16),
          
          // Champ de texte multi-lignes pour éditer la transcription
          TextFormField(
            controller: _controleurTranscription,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Votre transcription apparaîtra ici...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: CouleursApplication.bordure),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: CouleursApplication.primaire, width: 2),
              ),
            ),
            onChanged: (valeur) => EtatApplication.instance.mettreAJourTranscription(valeur),
          ),
          
          const SizedBox(height: 16),
          
          // Boutons d'action (Export PDF + Sauvegarde)
          Row(
            children: [
              // Bouton Export PDF
              Expanded(
                child: BoutonModerne(
                  texte: 'Exporter PDF',
                  icone: Icons.picture_as_pdf,
                  estSecondaire: true,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Export PDF simulé')),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Bouton Sauvegarde
              Expanded(
                child: BoutonModerne(
                  texte: 'Sauvegarder',
                  icone: Icons.save,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Transcription sauvegardée !'),
                        backgroundColor: CouleursApplication.succes,
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