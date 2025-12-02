import 'package:union_shop/models/product.dart';

class ProductService {
  // Singleton
  ProductService._();
  static final ProductService instance = ProductService._();

  final List<Product> _products = const [
    Product(
      id: 'p1',
      title: 'Placeholder Product 1',
      price: '£10.00',
      description: 'A placeholder product in Gifts collection.',
      collection: 'Gifts',
    imageUrl: 'assets/images/p1.png',
    ),
    Product(
      id: 'p2',
      title: 'Placeholder Product 2',
      price: '£15.00',
      description: 'A placeholder product in Stationery collection.',
      collection: 'Stationery',
    imageUrl: 'assets/images/p2.png',
    ),
    Product(
      id: 'p3',
      title: 'Placeholder Product 3',
      price: '£20.00',
      description: 'A placeholder product in Sale Items.',
      collection: 'Sale Items',
    imageUrl: 'assets/images/p3.png',
    ),
    Product(
      id: 'p4',
      title: 'Placeholder Product 4',
      price: '£25.00',
      description: 'Another placeholder to fill the grid.',
      collection: 'Gifts',
    imageUrl: 'assets/images/p4.png',
    ),
  ];

  List<Product> getAllProducts() => _products;

  List<String> getCollections() {
    final set = _products.map((p) => p.collection).toSet();
    return set.toList();
  }

  List<Product> getProductsForCollection(String collectionName) {
    return _products.where((p) => p.collection == collectionName).toList();
  }

  Product? getProductById(String id) {
    return _products.firstWhere((p) => p.id == id, orElse: () => _products.first);
  }

  /// Simple search over title and description (case-insensitive)
  List<Product> search(String query) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return _products;
    return _products.where((p) {
      return p.title.toLowerCase().contains(q) || p.description.toLowerCase().contains(q) || p.collection.toLowerCase().contains(q);
    }).toList();
  }
}
