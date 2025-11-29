import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/services/product_service.dart';

void main() {
  test('CartService add and total', () {
    CartService.clear();
    final p = ProductService.getProductsForCollection(ProductService.getCollections().first).first;
    CartService.add(p, quantity: 2);
    final items = CartService.items();
    expect(items.length, 1);
    expect(CartService.total(), p.price * 2);
    CartService.clear();
  });
}
