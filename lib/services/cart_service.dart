import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_shop/models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String? size;
  final String? colour;

  CartItem({required this.product, this.quantity = 1, this.size, this.colour});

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
        'size': size,
        'colour': colour,
      };

  static CartItem fromJson(Map<String, dynamic> json) => CartItem(
        product: Product.fromJson(Map<String, dynamic>.from(json['product'] as Map)),
        quantity: json['quantity'] as int? ?? 1,
        size: json['size'] as String?,
        colour: json['colour'] as String?,
      );
}

class CartService {
  // Simple singleton cart for demo purposes

  final Map<String, CartItem> _items = {};

  // Load persisted cart if available
  CartService._() {
    _loadFromPrefs();
  }

  static final CartService instance = CartService._();

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('cart_items');
      if (raw == null) return;
      final decoded = json.decode(raw) as Map<String, dynamic>;
      _items.clear();
      decoded.forEach((key, value) {
        _items[key] = CartItem.fromJson(Map<String, dynamic>.from(value as Map));
      });
    } catch (_) {
      // ignore errors in environments where shared_preferences isn't available (tests, etc.)
    }
  }

  void clear() => _items.clear();

  void add(Product product, {int quantity = 1, String? size, String? colour}) {
    final key = '${product.id}_${size ?? ''}_${colour ?? ''}';
    if (_items.containsKey(key)) {
      _items[key]!.quantity += quantity;
    } else {
      _items[key] = CartItem(product: product, quantity: quantity, size: size, colour: colour);
    }
    _saveToPrefs();
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

  void remove(String key) {
    _items.remove(key);
    _saveToPrefs();
  }

  void updateQuantity(String key, int quantity) {
    if (_items.containsKey(key)) {
      _items[key]!.quantity = quantity;
      if (_items[key]!.quantity <= 0) _items.remove(key);
      _saveToPrefs();
    }
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final map = <String, dynamic>{};
      _items.forEach((k, v) => map[k] = v.toJson());
      await prefs.setString('cart_items', json.encode(map));
    } catch (_) {
      // ignore errors (tests or missing platform channels)
    }
  }
}
