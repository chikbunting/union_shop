import 'package:flutter/material.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/widgets/footer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _oldPassCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final u = AuthService.instance.currentUser;
    if (u != null) {
      _nameCtrl.text = u.name;
      _emailCtrl.text = u.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Account'), backgroundColor: const Color(0xFF4d2963)),
      body: user == null
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Text('Not signed in'), ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/auth'), child: const Text('Sign in'))]))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
                  const SizedBox(height: 8),
                  TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final ok = await AuthService.instance.updateProfile(name: _nameCtrl.text.trim(), email: _emailCtrl.text.trim());
                      if (ok) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
                        setState(() {});
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email already in use')));
                      }
                    },
                    child: const Text('Update profile'),
                  ),
                  const SizedBox(height: 20),
                  const Text('Change password', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(controller: _oldPassCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Current password')),
                  const SizedBox(height: 8),
                  TextField(controller: _newPassCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'New password')),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final ok = await AuthService.instance.changePassword(oldPassword: _oldPassCtrl.text, newPassword: _newPassCtrl.text);
                      if (ok) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password changed')));
                        _oldPassCtrl.clear();
                        _newPassCtrl.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password change failed')));
                      }
                    },
                    child: const Text('Change password'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        await AuthService.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
                      },
                      child: const Text('Sign out')),
                ],
              ),
            ),
      bottomNavigationBar: const Footer(),
    );
  }
}
