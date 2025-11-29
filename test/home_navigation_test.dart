import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  testWidgets('tapping VIEW ALL PRODUCTS opens Collections', (tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    final viewAllFinder = find.text('VIEW ALL PRODUCTS');
    expect(viewAllFinder, findsOneWidget);

    await tester.tap(viewAllFinder);
    await tester.pumpAndSettle();

    // Collections page has an AppBar title 'Collections'
    expect(find.text('Collections'), findsOneWidget);
  });

  testWidgets('tapping product card opens ProductPage', (tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Tap first product title
    final productFinder = find.text('Placeholder Product 1');
    expect(productFinder, findsOneWidget);
  // scroll by dragging the SingleChildScrollView until the product is visible
  await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -600));
  await tester.pumpAndSettle();

  await tester.tap(productFinder);
    await tester.pumpAndSettle();

    // Product page should show placeholder product name
    expect(find.text('Placeholder Product Name'), findsOneWidget);
  });
}
