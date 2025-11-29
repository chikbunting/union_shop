import '../models/product.dart';

class ProductService {
  // In-memory demo data
  static const _products = [
    Product(
      id: 'p1',
      title: 'Demo Magnet',
      price: 10.0,
      imageUrl: '',
      collection: 'Gifts',
    ),
    Product(
      id: 'p2',
      title: 'Demo Postcard',
      price: 3.5,
      imageUrl: '',
      collection: 'Stationery',
    ),
    Product(
      id: 'p3',
      title: 'Sale Magnet',
      price: 5.0,
      imageUrl: '',
      collection: 'Sale Items',
    ),
    Product(
      id: 'p4',
      title: 'Collection Product 1',
      price: 9.99,
      imageUrl: '',
      collection: 'Collections Example',
    ),
  ];

  static List<String> getCollections() {
    final set = <String>{};
    for (final p in _products) set.add(p.collection);
    return set.toList();
  }

  static List<Product> getProductsForCollection(String collection) {
    return _products.where((p) => p.collection == collection).toList();
  }

  static Product? getProductById(String id) {
    return _products.firstWhere((p) => p.id == id, orElse: () => _products.first);
  }
}
