import 'package:flutter/material.dart';
import 'package:union_shop/services/auth_service.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToHome() => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    void navigateToCollections() => Navigator.pushNamed(context, '/collections');

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Top banner accent
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            color: const Color(0xFF4d2963),
            child: const Text(
              'Union Shop — Official Student Union Store',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          // Main header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: navigateToHome,
                  child: Row(
                    children: [
                      Image.network(
                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                        height: 42,
                        width: 42,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            width: 42,
                            height: 42,
                            child: const Center(
                              child: Icon(Icons.image_not_supported, color: Colors.grey),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      const Text('Union Shop', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                const Spacer(),

                // Center nav links
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width > 800 ? 500 : 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: navigateToCollections, child: const Text('Shop')),
                      TextButton(onPressed: () => Navigator.pushNamed(context, '/sale'), child: const Text('Sale')),
                      TextButton(onPressed: () => Navigator.pushNamed(context, '/personalisation'), child: const Text('Personalisation')),
                      TextButton(onPressed: () => Navigator.pushNamed(context, '/about'), child: const Text('About')),
                    ],
                  ),
                ),

                const Spacer(),

                // Right icons
                Row(
                  children: [
                        IconButton(
                              icon: const Icon(Icons.search, size: 20, color: Colors.grey),
                              onPressed: () => Navigator.pushNamed(context, '/search'),
                            ),
                        Builder(builder: (ctx) {
                          return IconButton(
                            icon: const Icon(Icons.person_outline, size: 20, color: Colors.grey),
                            onPressed: () {
                              Navigator.pushNamed(context, AuthService.instance.currentUser == null ? '/auth' : '/account');
                            },
                          );
                        }),
                    IconButton(
                      icon: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.grey),
                      onPressed: () => Navigator.pushNamed(context, '/cart'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
