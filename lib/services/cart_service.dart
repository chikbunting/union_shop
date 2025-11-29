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
