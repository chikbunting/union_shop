import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/auth_page.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/search_page.dart';
import 'package:union_shop/personalisation_page.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/app_drawer.dart';
import 'package:union_shop/account_page.dart';
import 'package:union_shop/widgets/footer.dart';
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
        '/personalisation': (context) => const PersonalisationPage(),
        '/account': (context) => const AccountPage(),
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
      drawer: const AppDrawer(),
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
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width > 900 ? 40.0 : 16.0,
                    vertical: MediaQuery.of(context).size.width > 900 ? 32 : 20),
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
                    const SizedBox(height: 12),
                    Builder(builder: (context) {
                      final w = MediaQuery.of(context).size.width;
                      final cols = w > 1200 ? 4 : w > 900 ? 3 : w > 600 ? 2 : 1;
                      final childAspect = w > 900 ? 0.78 : w > 600 ? 0.9 : 1.05;
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: cols,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: childAspect,
                        // Featured products: first four products from ProductService
                        children: ProductService.instance
                            .getAllProducts()
                            .take(4)
                            .map((p) => ProductCard(
                                  productId: p.id,
                                  title: p.title,
                                  price: p.price,
                                  imageUrl: p.imageUrl,
                                ))
                            .toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

// ProductCard moved to `lib/widgets/product_card.dart`
