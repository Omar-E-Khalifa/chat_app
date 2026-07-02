# Scholar Chat

A real-time chat app built with Flutter, Firebase Authentication, and Cloud Firestore. Users sign up, log in, and exchange messages in a shared chat room that updates live for everyone.

## Features

- **Email/password authentication** — register and log in via Firebase Auth
- **Real-time messaging** — messages sync instantly across devices using Firestore snapshots
- **Loading states** — async actions (login, register, send) show a modal progress overlay instead of a frozen UI
- **Input validation & feedback** — form validation on auth screens, snackbar messages for errors
- **Auto-scroll to latest message** on send

## Tech Stack

- **Flutter** — cross-platform UI toolkit
- **firebase_auth** — user authentication
- **cloud_firestore** — real-time message storage and sync
- **firebase_core** — Firebase initialization

## Project Structure

```
lib/
├── models/          # MessageModel
├── views/            # LoginView, RegisterView, ChatView
├── widgets/           # ChatBubble, CustomButton, CustomChatField, CustomTextFormField
├── helpers/            # Snackbar helper
├── constants.dart
├── firebase_options.dart
└── main.dart
```

## Getting Started

1. **Clone the repo**
   ```bash
   git clone https://github.com/Omar-E-Khalifa/chat_app.git
   cd chat_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Connect your own Firebase project**
   This repo ships with a Firebase config tied to a personal project. To run it against your own backend, install the FlutterFire CLI and run:
   ```bash
   flutterfire configure
   ```
   Then enable Email/Password auth and Firestore in the Firebase console.

4. **Run the app**
   ```bash
   flutter run
   ```

## Author

Built by [Omar Essam](https://github.com/Omar-E-Khalifa) as part of a self-directed Flutter learning journey.