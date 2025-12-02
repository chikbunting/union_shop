class Product {
  final String id;
  final String title;
  final String price;
  final String description;
  final String collection;
  final String imageUrl;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.collection,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'collection': collection,
        'imageUrl': imageUrl,
      };

  static Product fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        price: json['price'] as String? ?? '£0.00',
        description: json['description'] as String? ?? '',
        collection: json['collection'] as String? ?? '',
        imageUrl: json['imageUrl'] as String? ?? '',
      );
}
