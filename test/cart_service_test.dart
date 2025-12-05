import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/product.dart';

void main() {
  test('cart service add and totals', () {
    final cart = CartService.instance;
    cart.clear();

    const p = Product(
      id: 't1',
      title: 'Test Product',
      price: '£2.50',
      description: 'desc',
      collection: 'Test',
      imageUrl: '',
    );

    cart.add(p, quantity: 2);
    expect(cart.totalItems, 2);
    expect(cart.totalPrice, closeTo(5.0, 0.001));
  });
}
