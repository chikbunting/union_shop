import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/about_page.dart';

void main() {
  testWidgets('About page displays content', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AboutPage()));
    await tester.pumpAndSettle();

    expect(find.text('About Us'), findsWidgets);
    expect(
      find.textContaining('This is a student implementation', findRichText: false),
      findsOneWidget,
    );
  });
}
