import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/services/product_service.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

  // Check that basic UI elements are present
  expect(find.text('Union Shop — Official Student Union Store'), findsOneWidget);
  // HeroBanner text (updated copy)
  expect(find.text('welcome to the union shop'), findsOneWidget);
      expect(find.text('Featured products'), findsOneWidget);
      expect(find.text('BROWSE PRODUCTS'), findsOneWidget);
      expect(find.text('VIEW ALL PRODUCTS'), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Get the first four products from the service so tests don't hard-code copy
      final products = ProductService.instance.getAllProducts().take(4).toList();
      for (final p in products) {
        expect(find.text(p.title), findsOneWidget);
        // multiple products may share a price (e.g. £25.00), so assert at least one match
        expect(find.text(p.price), findsWidgets);
      }
    });

    testWidgets('should display header icons', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

  // Check that header icons are present
  expect(find.byIcon(Icons.search), findsOneWidget);
  expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
  expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

  // Check that footer descriptive text is present
  expect(find.text('Official student union store. Find merch, gifts and stationery.'), findsOneWidget);
    });
  });
}
