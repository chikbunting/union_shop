import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/product_service.dart';

void main() {
  test('ProductService returns collections and products', () {
    final collections = ProductService.getCollections();
    expect(collections.isNotEmpty, true);

    final first = collections.first;
    final products = ProductService.getProductsForCollection(first);
    expect(products, isNotEmpty);
  });
}
