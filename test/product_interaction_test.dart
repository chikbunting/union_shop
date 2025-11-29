import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/services/cart_service.dart';

void main() {
  testWidgets('Product page displays controls', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProductPage()));
    await tester.pumpAndSettle();

    expect(find.text('Students should add size options, colour options, quantity selector, add to cart button, and buy now button here.'), findsOneWidget);
    expect(find.text('Add to Cart'), findsOneWidget);
    expect(find.text('Buy Now'), findsOneWidget);
  });

  testWidgets('product page add to cart updates cart service', (tester) async {
    CartService.instance.clear();
    await tester.pumpWidget(const MaterialApp(home: ProductPage()));
    await tester.pumpAndSettle();

    // increase quantity once
    // ensure controls are visible before interacting (prevents off-screen tap failures)
    final addIcon = find.byIcon(Icons.add);
    await tester.ensureVisible(addIcon);
    await tester.tap(addIcon);
    await tester.pumpAndSettle();

    final addToCartBtn = find.text('Add to Cart');
    await tester.ensureVisible(addToCartBtn);
    await tester.tap(addToCartBtn);
    await tester.pumpAndSettle();

    expect(CartService.instance.totalItems, greaterThanOrEqualTo(1));
  });
}
