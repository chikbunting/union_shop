import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/personalisation_page.dart';
import 'package:union_shop/services/cart_service.dart';

void main() {
  testWidgets('Personalisation preview updates when typing', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PersonalisationPage()));
    await tester.pumpAndSettle();

    final input = find.byType(TextField).first;
    await tester.enterText(input, 'Test Preview');
    await tester.pumpAndSettle();

    // Preview should show the typed text
    expect(find.text('Test Preview'), findsWidgets);
  });

  testWidgets('Add to cart stores personalised metadata', (tester) async {
    CartService.instance.clear();
    await tester.pumpWidget(const MaterialApp(home: PersonalisationPage()));
    await tester.pumpAndSettle();

    final input = find.byType(TextField).first;
    await tester.enterText(input, 'Cart Item');
    await tester.pumpAndSettle();

    final addBtn = find.text('Add to cart (demo)');
    await tester.ensureVisible(addBtn);
    await tester.tap(addBtn);
    await tester.pumpAndSettle();

    final items = CartService.instance.items;
    expect(items.any((it) => it.personalisedText == 'Cart Item'), isTrue);
    // Default font size in the page is 20.0
    final found = items.firstWhere((it) => it.personalisedText == 'Cart Item');
    expect(found.personalisedFontSize, equals(20));
  });
}
