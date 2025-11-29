import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';

void main() {
  testWidgets('Product page displays controls', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProductPage()));
    await tester.pumpAndSettle();

    expect(find.text('Students should add size options, colour options, quantity selector, add to cart button, and buy now button here.'), findsOneWidget);
    expect(find.text('Add to Cart'), findsOneWidget);
    expect(find.text('Buy Now'), findsOneWidget);
  });
}
