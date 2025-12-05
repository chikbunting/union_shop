import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToCollections() => Navigator.pushNamed(context, '/collections');

    final w = MediaQuery.of(context).size.width;
    final height = w > 900 ? 360.0 : w > 600 ? 300.0 : 220.0;
    final titleSize = w > 900 ? 28.0 : w > 600 ? 24.0 : 18.0;
    final subtitleSize = w > 900 ? 20.0 : w > 600 ? 18.0 : 14.0;

    return SizedBox(
      height: height,
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
          // Use a const Color.fromRGBO to avoid deprecated withOpacity
          Positioned.fill(child: Container(color: const Color.fromRGBO(0, 0, 0, 0.6))),
          Positioned(
            left: 24,
            right: 24,
            top: height * 0.18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Semantics(
                  header: true,
                  child: Text(
                    'welcome to the union shop',
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: titleSize > 20 ? 16 : 8),
                Text(
                  "where student life begins",
                  style: TextStyle(
                    fontSize: subtitleSize,
                    color: Colors.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: subtitleSize > 16 ? 28 : 12),
                Semantics(
                  button: true,
                  label: 'Browse products',
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: w > 600 ? 180 : 120),
                    child: ElevatedButton(
                      onPressed: navigateToCollections,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: w > 600 ? 20 : 12, vertical: w > 600 ? 14 : 10),
                      ),
                      child: const Text('BROWSE PRODUCTS', style: TextStyle(fontSize: 14, letterSpacing: 1)),
                    ),
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
