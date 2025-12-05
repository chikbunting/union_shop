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
      description: 'Placeholder product used in tests.',
      collection: 'Gifts',
      imageUrl: 'assets/images/p1.png',
    ),
    Product(
      id: 'p2',
      title: 'Placeholder Product 2',
      price: '£15.00',
      description: 'Placeholder product used in tests.',
      collection: 'Gifts',
      imageUrl: 'assets/images/p2.png',
    ),
    Product(
      id: 'p3',
      title: 'Placeholder Product 3',
      price: '£20.00',
      description: 'Placeholder product used in tests.',
      collection: 'Gifts',
      imageUrl: 'assets/images/p3.png',
    ),
    Product(
      id: 'p4',
      title: 'Placeholder Product 4',
      price: '£25.00',
      description: 'Placeholder product used in tests.',
      collection: 'Gifts',
      imageUrl: 'assets/images/p4.png',
    ),
    Product(
      id: 'p5',
      title: 'Varsity Hoodie',
      price: '£25.00',
      description: 'Additional placeholder product.',
      collection: 'Gifts',
      imageUrl: 'assets/images/p5.png',
    ),
    Product(
      id: 'p6',
      title: 'varsity Hoodie',
      price: '£25.00',
      description: 'Additional placeholder product.',
      collection: 'Gifts',
      imageUrl: 'assets/images/p6.png',
    ),
    Product(
      id: 'notebook_a5_blue',
      title: 'A5 Notebook — Blue',
      price: '£6.50',
      description: 'A durable A5 notebook with blue cover. 80 pages.',
      collection: 'Stationery',
      imageUrl: 'assets/images/notebook_a5_blue_800.png',
    ),
    Product(
      id: 'pen_metal_black',
      title: 'Metal Pen — Black',
      price: '£3.00',
      description: 'Smooth-writing metal pen with black ink.',
      collection: 'Stationery',
      imageUrl: 'assets/images/pen_metal_black_800.png',
    ),
    Product(
      id: 'pencil_set_6',
      title: 'Pencil Set (6)',
      price: '£4.00',
      description: 'Pack of 6 HB pencils in a neat box.',
      collection: 'Stationery',
      imageUrl: 'assets/images/pencil_set_6_800.png',
    ),
    Product(
      id: 'stationery_pack_small',
      title: 'Stationery Pack — Small',
      price: '£12.00',
      description: 'Starter stationery pack including notebook, pen and pencil set.',
      collection: 'Stationery',
      imageUrl: 'assets/images/stationery_pack_small_800.png',
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
