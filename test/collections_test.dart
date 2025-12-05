import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/services/product_service.dart';

void main() {
  testWidgets('Collections page shows collection list', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
    await tester.pumpAndSettle();

    // Assert that each collection provided by ProductService is shown
    final collections = ProductService.instance.getCollections();
    for (final c in collections) {
      expect(find.text(c), findsOneWidget);
    }
  });
}
