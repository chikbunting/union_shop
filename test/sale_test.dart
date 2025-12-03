import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/sale_page.dart';

void main() {
  testWidgets('Sale page shows sale products', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SalePage()));
    await tester.pumpAndSettle();

    expect(find.text('Sale Items'), findsWidgets);
    expect(find.text('Sale Magnet'), findsOneWidget);
    expect(find.text('£5.00'), findsOneWidget);
  });
}
