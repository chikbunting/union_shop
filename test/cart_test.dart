import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/services/product_service.dart';

void main() {
  test('CartService add and total', () {
    // use the singleton API
    final cart = CartService.instance;
    final products = ProductService.instance.getProductsForCollection(ProductService.instance.getCollections().first);
    final p = products.first;

    cart.clear();
    cart.add(p, quantity: 2);
    final items = cart.items;
    expect(items.length, 1);

    // price stored as string like '£10.00' so compare numeric totalPrice
    final rawPrice = p.price.replaceAll('£', '').replaceAll(',', '');
    final price = double.tryParse(rawPrice) ?? 0.0;
    expect(cart.totalPrice, closeTo(price * 2, 0.001));
    cart.clear();
  });
}
