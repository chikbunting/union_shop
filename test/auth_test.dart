import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/auth_page.dart';

void main() {
  testWidgets('Auth page shows sign in and sign up', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AuthPage()));
    await tester.pumpAndSettle();

    expect(find.text('Sign in to your account'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}
