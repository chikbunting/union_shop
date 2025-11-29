import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collections_page.dart';

void main() {
  testWidgets('Collections page shows collection list', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
    await tester.pumpAndSettle();

    expect(find.text('Gifts'), findsOneWidget);
    expect(find.text('Stationery'), findsOneWidget);
    expect(find.text('Sale Items'), findsOneWidget);
    expect(find.text('Collections Example'), findsOneWidget);
  });
}
