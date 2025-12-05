import 'package:flutter/material.dart';
import 'package:union_shop/services/auth_service.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToHome() => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    void navigateToCollections() => Navigator.pushNamed(context, '/collections');

    final w = MediaQuery.of(context).size.width;
    final horizontalPadding = w > 900 ? 32.0 : 16.0;
    final verticalPadding = w > 900 ? 20.0 : 12.0;

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
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: Row(
              children: [
                Semantics(
                  button: true,
                  label: 'Union Shop home',
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: navigateToHome,
                      child: Row(
                        children: [
                          Image.network(
                            'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                            height: 48,
                            width: 48,
                            fit: BoxFit.cover,
                            semanticLabel: 'Union Shop logo',
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                width: 48,
                                height: 48,
                                child: const Center(
                                  child: Icon(Icons.image_not_supported, color: Colors.grey),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 16),
                          const Text('Union Shop', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Center nav links
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width > 800 ? 500 : 0),
                  child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Tooltip(message: 'Shop', child: TextButton(onPressed: navigateToCollections, child: const Text('Shop', style: TextStyle(fontSize: 16)))),
                          Tooltip(message: 'Sale items', child: TextButton(onPressed: () => Navigator.pushNamed(context, '/sale'), child: const Text('Sale', style: TextStyle(fontSize: 16)))),
                          Tooltip(message: 'Personalisation', child: TextButton(onPressed: () => Navigator.pushNamed(context, '/personalisation'), child: const Text('Personalisation', style: TextStyle(fontSize: 16)))),
                          Tooltip(message: 'About', child: TextButton(onPressed: () => Navigator.pushNamed(context, '/about'), child: const Text('About', style: TextStyle(fontSize: 16)))),
                        ],
                  ),
                ),

                const Spacer(),

                // Right icons
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, size: 20, color: Colors.grey),
                      tooltip: 'Search',
                      onPressed: () => Navigator.pushNamed(context, '/search'),
                    ),
                    Builder(builder: (ctx) {
                      return IconButton(
                        icon: const Icon(Icons.person_outline, size: 20, color: Colors.grey),
                        tooltip: AuthService.instance.currentUser == null ? 'Sign in' : 'Account',
                        onPressed: () {
                          Navigator.pushNamed(context, AuthService.instance.currentUser == null ? '/auth' : '/account');
                        },
                      );
                    }),
                    IconButton(
                      icon: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.grey),
                      tooltip: 'Cart',
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
