import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/services/auth_service.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _signInEmail = TextEditingController();
  final _signInPass = TextEditingController();
  final _signUpName = TextEditingController();
  final _signUpEmail = TextEditingController();
  final _signUpPass = TextEditingController();

  bool _loading = false;

  Future<void> _doSignIn() async {
    setState(() => _loading = true);
    final ok = await AuthService.instance.signIn(email: _signInEmail.text.trim(), password: _signInPass.text);
    setState(() => _loading = false);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signed in')));
      Navigator.pushNamedAndRemoveUntil(context, '/account', (r) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in failed')));
    }
  }

  Future<void> _doSignUp() async {
    setState(() => _loading = true);
    final ok = await AuthService.instance.signUp(name: _signUpName.text.trim(), email: _signUpEmail.text.trim(), password: _signUpPass.text);
    setState(() => _loading = false);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account created and signed in')));
      Navigator.pushNamedAndRemoveUntil(context, '/account', (r) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account already exists')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In / Sign Up'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            const Text('Sign in to your account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(controller: _signInEmail, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 8),
            TextField(controller: _signInPass, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loading ? null : _doSignIn, child: _loading ? const CircularProgressIndicator() : const Text('Sign In')),
            const SizedBox(height: 24),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _loading
                  ? null
                  : () async {
                      setState(() => _loading = true);
                      final ok = await AuthService.instance.signInWithGoogle();
                      setState(() => _loading = false);
                      if (ok) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signed in with Google')));
                        Navigator.pushNamedAndRemoveUntil(context, '/account', (r) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Google sign-in failed or was cancelled')));
                      }
                    },
              icon: const Icon(Icons.login),
              label: const Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4285F4)),
            ),
            const SizedBox(height: 12),
            const Text('New here? Create an account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(controller: _signUpName, decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 8),
            TextField(controller: _signUpEmail, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 8),
            TextField(controller: _signUpPass, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _loading ? null : _doSignUp, child: _loading ? const CircularProgressIndicator() : const Text('Sign Up')),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
