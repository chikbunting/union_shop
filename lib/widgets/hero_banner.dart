import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToCollections() => Navigator.pushNamed(context, '/collections');

    return SizedBox(
      height: 360,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/hero_banner.png',
              fit: BoxFit.cover,
              // Decorative background image — excluded from semantics
              excludeFromSemantics: true,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey[300]);
              },
            ),
          ),
          Positioned.fill(child: Container(color: Colors.black.withOpacity(0.6))),
          Positioned(
            left: 24,
            right: 24,
            top: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Semantics(
                  header: true,
                  child: Text(
                    'welcome to the union shop',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "where student life begins",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Semantics(
                  button: true,
                  label: 'Browse products',
                  child: ElevatedButton(
                    onPressed: navigateToCollections,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4d2963),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text('BROWSE PRODUCTS', style: TextStyle(fontSize: 14, letterSpacing: 1)),
                  ),
                ),
                const SizedBox(height: 8),
                Semantics(
                  button: true,
                  label: 'View all products',
                  child: TextButton(onPressed: navigateToCollections, child: const Text('VIEW ALL PRODUCTS')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
