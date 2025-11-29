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
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();

    expect(CartService.instance.totalItems, greaterThanOrEqualTo(1));
  });
}
