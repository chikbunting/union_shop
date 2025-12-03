import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProfile {
  String name;
  String email;
  String password; // NOTE: stored in plaintext for demo only — not secure for production

  UserProfile({required this.name, required this.email, required this.password});

  Map<String, dynamic> toJson() => {'name': name, 'email': email, 'password': password};

  static UserProfile fromJson(Map<String, dynamic> j) => UserProfile(
        name: j['name'] as String? ?? '',
        email: j['email'] as String? ?? '',
        password: j['password'] as String? ?? '',
      );
}

class AuthService {
  AuthService._() {
    _loadFromPrefs();
  }

  static final AuthService instance = AuthService._();

  final Map<String, UserProfile> _users = {};
  UserProfile? _currentUser;

  UserProfile? get currentUser => _currentUser;

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('auth_users');
      if (raw != null) {
        final decoded = json.decode(raw) as Map<String, dynamic>;
        _users.clear();
        decoded.forEach((k, v) {
          _users[k] = UserProfile.fromJson(Map<String, dynamic>.from(v as Map));
        });
      }
      final cur = prefs.getString('auth_current');
      if (cur != null && _users.containsKey(cur)) _currentUser = _users[cur];
    } catch (_) {}
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final map = <String, dynamic>{};
      _users.forEach((k, v) => map[k] = v.toJson());
      await prefs.setString('auth_users', json.encode(map));
      if (_currentUser != null) {
        await prefs.setString('auth_current', _currentUser!.email);
      } else {
        await prefs.remove('auth_current');
      }
    } catch (_) {}
  }

  /// Sign up a new user. Returns true on success, false if user already exists.
  Future<bool> signUp({required String name, required String email, required String password}) async {
    final key = email.toLowerCase();
    if (_users.containsKey(key)) return false;
    final user = UserProfile(name: name, email: email, password: password);
    _users[key] = user;
    _currentUser = user;
    await _saveToPrefs();
    return true;
  }

  /// Sign in existing user. Returns true on success.
  Future<bool> signIn({required String email, required String password}) async {
    final key = email.toLowerCase();
    final user = _users[key];
    if (user == null) return false;
    if (user.password != password) return false;
    _currentUser = user;
    await _saveToPrefs();
    return true;
  }

  Future<void> signOut() async {
    _currentUser = null;
    await _saveToPrefs();
  }

  /// Update profile (name/email). Returns false on conflict (email taken)
  Future<bool> updateProfile({required String name, required String email}) async {
    if (_currentUser == null) return false;
    final oldKey = _currentUser!.email.toLowerCase();
    final newKey = email.toLowerCase();
    if (newKey != oldKey && _users.containsKey(newKey)) return false;
    final updated = UserProfile(name: name, email: email, password: _currentUser!.password);
    _users.remove(oldKey);
    _users[newKey] = updated;
    _currentUser = updated;
    await _saveToPrefs();
    return true;
  }

  Future<bool> changePassword({required String oldPassword, required String newPassword}) async {
    if (_currentUser == null) return false;
    if (_currentUser!.password != oldPassword) return false;
    _currentUser!.password = newPassword;
    _users[_currentUser!.email.toLowerCase()] = _currentUser!;
    await _saveToPrefs();
    return true;
  }

  /// Sign in using Google (OAuth) and create a local profile if needed.
  /// Returns true when signed in successfully.
  Future<bool> signInWithGoogle({String? webClientId}) async {
    try {
      final googleSignIn = GoogleSignIn(
        // webClientId is optional; on web you may need to pass your OAuth client id
        clientId: webClientId,
        scopes: ['email', 'profile'],
      );
      final account = await googleSignIn.signIn();
      if (account == null) return false; // user aborted
      final email = account.email;
      final name = account.displayName ?? email.split('@').first;
      final key = email.toLowerCase();
      if (!_users.containsKey(key)) {
        // create a lightweight profile (password empty)
        _users[key] = UserProfile(name: name, email: email, password: '');
      }
      _currentUser = _users[key];
      await _saveToPrefs();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Sign out from google (if previously signed in) and clear local session.
  Future<void> signOutGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    } catch (_) {}
    await signOut();
  }
}
