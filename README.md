
🌐 Flutter Translator App

A simple Flutter app that allows users to translate text between multiple languages using LibreTranslate, supports voice input (speech-to-text), shows translation history, and includes Firebase authentication with logout functionality.

## 📱 Features

- 🔄 Translate text using [LibreTranslate API](https://libretranslate.com/)
- 🧠 View translation history
- 🔐 Firebase Authentication (logout supported)
- 🌍 Supports multiple languages
- 📦 Lottie animation for visual feedback


## 🚀 Getting Started

### 🔧 Prerequisites

- Flutter SDK
- Android Studio / VS Code
- Firebase project (with authentication enabled)




### 📦 Install Packages

```bash
flutter pub get
```

### 🔌 Configure Firebase

1. Go to [Firebase Console](https://console.firebase.google.com/)

2. Create a project

3. Add Android/iOS apps

4. Download `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS)

5. Place it inside:

   * `android/app/` → `google-services.json`
   * `ios/Runner/` → `GoogleService-Info.plist`

6. Add this to `android/build.gradle`:

```gradle
classpath 'com.google.gms:google-services:4.3.15'
```

7. And in `android/app/build.gradle.kts`:

```kotlin
apply(plugin = "com.google.gms.google-services")
```

---

### 🏃 Run the App

```bash
flutter run
```

---

## 🧪 Testing Translation

* Type  your input
* Select language to translate **From** and **To**
* Tap **Translate**
* View the translated result and check History

---

## 📂 Project Structure

```
lib/
├── main.dart
├── translator_screen.dart
├── history_page.dart
└── widgets/
    └── (optional: custom UI widgets)
```

---

## 📜 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  translator: ^0.1.7
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  lottie: ^3.0.0
```

---

## 🙌 Credits

* [LibreTranslate](https://libretranslate.com/)
* [Google Firebase](https://firebase.google.com/)
* [Lottie](https://lottiefiles.com/)

---

## 🛡 License

This project is licensed under the MIT License.

---

