import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('browse -> add to cart -> verify cart', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Ensure home loaded and featured product is visible
    final productFinder = find.text('Signature Hoodie');
    expect(productFinder, findsOneWidget);

    // Tap the product to open product page
    await tester.tap(productFinder);
    await tester.pumpAndSettle();

    // Verify product page shows the product title
    expect(find.text('Signature Hoodie'), findsWidgets);

    // Tap Add to Cart
    final addButton = find.text('Add to Cart');
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Open cart via header icon (tooltip 'Cart')
    final cartButton = find.byTooltip('Cart');
    expect(cartButton, findsOneWidget);
    await tester.tap(cartButton);
    await tester.pumpAndSettle();

    // Verify the cart contains the product that was added
    expect(find.text('Signature Hoodie'), findsOneWidget);
  });
}
