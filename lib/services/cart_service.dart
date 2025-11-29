import 'package:union_shop/models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String? size;
  final String? colour;

  CartItem({required this.product, this.quantity = 1, this.size, this.colour});
}

class CartService {
  // Simple singleton cart for demo purposes
  CartService._();
  static final CartService instance = CartService._();

  final Map<String, CartItem> _items = {};

  void clear() => _items.clear();

  void add(Product product, {int quantity = 1, String? size, String? colour}) {
    final key = '${product.id}_${size ?? ''}_${colour ?? ''}';
    if (_items.containsKey(key)) {
      _items[key]!.quantity += quantity;
    } else {
      _items[key] = CartItem(product: product, quantity: quantity, size: size, colour: colour);
    }
  }

  List<CartItem> get items => _items.values.toList();

  int get totalItems => _items.values.fold(0, (v, e) => v + e.quantity);

  double get totalPrice {
    double sum = 0.0;
    for (final item in _items.values) {
      final p = item.product.price.replaceAll('£', '').replaceAll(',', '');
      final price = double.tryParse(p) ?? 0.0;
      sum += price * item.quantity;
    }
    return sum;
  }

  void remove(String key) => _items.remove(key);
}
import '../models/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final String? size;
  final String? colour;

  CartItem({required this.product, this.quantity = 1, this.size, this.colour});
}

class CartService {
  static final List<CartItem> _items = [];

  static void add(Product product, {int quantity = 1, String? size, String? colour}) {
    // naive add: append as a separate line item
    _items.add(CartItem(product: product, quantity: quantity, size: size, colour: colour));
  }

  static List<CartItem> items() => List.unmodifiable(_items);

  static double total() {
    return _items.fold(0.0, (sum, it) => sum + it.product.price * it.quantity);
  }

  static void clear() => _items.clear();
}
