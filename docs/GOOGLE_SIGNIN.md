Google Sign-In integration (scaffold)

What I added
- `google_sign_in` dependency added to `pubspec.yaml`.
- `AuthService.signInWithGoogle({String? webClientId})` and `AuthService.signOutGoogle()` implemented in `lib/services/auth_service.dart`.

Notes
- This is scaffolding only: it uses the `google_sign_in` package to prompt the user and create a local `UserProfile` on success.
- Passwords for OAuth-created users are left empty (since auth is delegated to Google). The profile is still stored locally for the app's demo purposes.

Web setup
1. Create an OAuth 2.0 Client ID for Web in Google Cloud Console and add your authorized origins (e.g., `http://localhost:5000`) and authorized redirect URIs if necessary.
2. Pass the web client id to `AuthService.instance.signInWithGoogle(webClientId: '<YOUR_WEB_CLIENT_ID>')` when calling from web. Example (in a button handler):

```dart
final ok = await AuthService.instance.signInWithGoogle(webClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com');
```

Mobile (Android/iOS) setup
- For Android, add the generated `google-services.json` and configure your project if you later use Firebase. For `google_sign_in` alone, configure the Android OAuth client in Google Cloud Console and ensure package name / SHA-1 are set correctly.
- For iOS, configure the reversed client id in `Info.plist` if using Firebase. For `google_sign_in` you may need platform-specific setup per the package docs.

Security note
- This repo uses local storage and plaintext passwords for demo purposes. For production, don't store passwords in SharedPreferences and use a secure backend or `firebase_auth`.

References
- package: https://pub.dev/packages/google_sign_in
- Guide: https://developers.google.com/identity/sign-in/web/sign-in

If you want, I can:
- Add a 'Sign in with Google' button to `lib/auth_page.dart` that calls `signInWithGoogle()` and navigates to `/account` on success.
- Scaffold Firebase Auth instead (if you prefer using `firebase_auth` which centralizes auth across providers).
- Add unit/widget tests that mock `GoogleSignIn` responses.
