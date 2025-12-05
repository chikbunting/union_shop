import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/cart_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Ensure shared_preferences uses in-memory store for tests
    SharedPreferences.setMockInitialValues({});
    // Clear in-memory cart
    CartService.instance.clear();
  });

  test('adding products updates totalItems and totalPrice', () async {
    const p = Product(
      id: 'p-test-1',
      title: 'Test Product',
      price: '£10.00',
      description: 'desc',
      collection: 'test',
      imageUrl: '',
    );

    CartService.instance.add(p, quantity: 2);

    expect(CartService.instance.totalItems, 2);
    expect(CartService.instance.items.length, 1);
    expect(CartService.instance.totalPrice, 20.0);

    // Also verify persistence key was written to prefs
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('cart_items');
    expect(raw, isNotNull);
  });

  test('updateQuantity removes item when set to zero', () async {
    const p = Product(
      id: 'p-test-2',
      title: 'Another Product',
      price: '£5.00',
      description: 'desc',
      collection: 'test',
      imageUrl: '',
    );

    CartService.instance.add(p, quantity: 1);
    final keys = CartService.instance.itemsMap.keys.toList();
    expect(keys, isNotEmpty);
    final key = keys.first;

    CartService.instance.updateQuantity(key, 0);

    expect(CartService.instance.items.isEmpty, isTrue);
    // Persistence should reflect removal
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('cart_items');
    // raw may be an empty map encoded or null depending on implementation; check it doesn't contain the product id
    if (raw != null) {
      expect(raw.contains(p.id), isFalse);
    }
  });
}
