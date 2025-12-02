import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/auth_page.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/search_page.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/product_card.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/widgets/hero_banner.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product' or '/about', build and return the pages
      // In your browser, try these links: http://localhost:49856/#/product
      routes: {
        '/product': (context) => const ProductPage(),
        '/search': (context) => const SearchPage(),
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/sale': (context) => const SalePage(),
        '/auth': (context) => const AuthPage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header widget (extracted to widgets/header.dart)
            const Header(),

            // Hero section (extracted)
            const HeroBanner(),

            // Products Section (featured grid)
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Featured products',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: MediaQuery.of(context).size.width > 1200
                          ? 4
                          : MediaQuery.of(context).size.width > 900
                              ? 3
                              : MediaQuery.of(context).size.width > 600
                                  ? 2
                                  : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.75,
                      children: ProductService.instance.getAllProducts().take(4).map((p) {
                        return ProductCard(
                          productId: p.id,
                          title: p.title,
                          price: p.price,
                          imageUrl: p.imageUrl,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              color: const Color(0xFFF7F7F8),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 40,
                    runSpacing: 16,
                    children: const [
                      SizedBox(
                        width: 240,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Union Shop', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('Official student union store. Find merch, gifts and stationery.'),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Collections', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('Gifts'),
                            Text('Stationery'),
                            Text('Sale Items'),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Help', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('Contact'),
                            Text('Delivery'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('© ${2025} Union Shop', style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/search'),
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ProductCard moved to `lib/widgets/product_card.dart`
