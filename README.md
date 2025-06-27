# 📝 NoteCraft - Application de Transcription Audio

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

Une application Flutter moderne pour la transcription audio en temps réel, développée dans le cadre du projet de première année de licence en informatique.

## 🚀 Fonctionnalités

### 🎯 Fonctionnalités Principales
- **Transcription Audio** : Conversion automatique de l'audio en texte
- **Historique des Transcriptions** : Sauvegarde et consultation des transcriptions précédentes
- **Système d'Authentification** : Connexion et inscription sécurisées
- **Gestion d'Abonnements** : Options d'abonnement premium
- **Interface Moderne** : Design épuré et intuitif

### 📱 Plateformes Supportées
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🏗️ Architecture du Projet

```
lib/
├── core/
│   ├── constantes/          # Constantes de l'application
│   │   ├── couleurs_application.dart
│   │   └── dimensions_application.dart
│   └── etat/               # Gestion d'état
│       └── etat_application.dart
├── pages/                  # Pages de l'application
│   ├── vue_accueil.dart
│   ├── page_connexion.dart
│   ├── page_inscription.dart
│   ├── page_transcription.dart
│   ├── page_historique.dart
│   ├── page_abonnement.dart
│   └── page_parametres.dart
└── widgets/               # Composants réutilisables
    ├── bouton_moderne.dart
    └── champ_saisie.dart
```

## 🛠️ Installation

### Prérequis
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (≥ 3.0.0)
- [Dart SDK](https://dart.dev/get-dart) (≥ 2.17.0)
- Un éditeur (VS Code, Android Studio, IntelliJ)

### Étapes d'installation

1. **Cloner le dépôt**
```bash
git clone https://github.com/a-tamwasi/notecraft_projet_upc.git
cd notecraft_projet_upc
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Vérifier l'installation Flutter**
```bash
flutter doctor
```

4. **Lancer l'application**
```bash
# Sur un émulateur/appareil connecté
flutter run

# Pour le web
flutter run -d chrome

# Pour Windows
flutter run -d windows
```

## 🎨 Captures d'écran

<!-- TODO: Ajouter des captures d'écran de l'application -->

## 🧪 Tests

```bash
# Exécuter tous les tests
flutter test

# Tests avec couverture
flutter test --coverage
```

## 📦 Build

### Android
```bash
flutter build apk --release
# ou
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Windows
```bash
flutter build windows --release
```

## 🔧 Configuration

### Variables d'environnement
Créez un fichier `.env` à la racine du projet :
```env
API_URL=https://votre-api.com
API_KEY=votre_clé_api
```

### Configuration Firebase (si applicable)
1. Suivez la [documentation Firebase](https://firebase.flutter.dev/docs/overview)
2. Ajoutez vos fichiers de configuration :
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

## 🤝 Contribution

1. Forkez le dépôt officiel
2. Créez une nouvelle branche pour votre fonctionnalité (`git checkout -b feature/NouvelleFonctionnalite`)
3. Enregistrez vos modifications avec un commit (`git commit -m 'Ajout de NouvelleFonctionnalite'`)
4. Poussez vos modifications vers votre branche (`git push origin feature/NouvelleFonctionnalite`)
5. Soumettez une Pull Request vers le dépôt officiel

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 👥 Équipe

- **Développeur Principal** : [a-tamwasi](https://github.com/a-tamwasi)
- **Université** : UPC (Université Protestante au Congo)

## 📞 Support

Pour toute question ou problème :
- 📧 Email : tamwasiandre@gmail.com
- 🐛 Issues : [GitHub Issues](https://github.com/a-tamwasi/notecraft_projet_upc/issues)


- Flutter Team (https://flutter.dev) pour le framework fantastique
- UPC (https://upc.ac.cd/) pour le support du projet
- La communauté open source pour les packages utilisés

---

<p align="center">
  Fait avec ❤️ par Tamwasi Andre andy
</p>
