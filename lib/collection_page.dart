import 'package:flutter/material.dart';
import 'package:union_shop/services/product_service.dart';

class CollectionPage extends StatelessWidget {
  final String collectionName;

  const CollectionPage({super.key, required this.collectionName});

  @override
  Widget build(BuildContext context) {
  final products = ProductService.instance.getProductsForCollection(collectionName);

    return Scaffold(
      appBar: AppBar(
        title: Text(collectionName),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Products in $collectionName', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final p = products[index];
                  return ListTile(
                title: Text(p.title),
                trailing: Text(p.price),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
