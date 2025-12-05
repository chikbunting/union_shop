import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF4d2963)),
              child: Row(
                children: const [
                  FlutterLogo(size: 40),
                  SizedBox(width: 12),
                  Text('Union Shop', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.storefront_outlined),
              title: const Text('Shop'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/collections');
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_offer_outlined),
              title: const Text('Sale'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/sale');
              },
            ),
            ListTile(
              leading: const Icon(Icons.format_paint_outlined),
              title: const Text('Personalisation'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/personalisation');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.login_outlined),
              title: const Text('Account / Sign in'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/auth');
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart');
              },
            ),
          ],
        ),
      ),
    );
  }
}
