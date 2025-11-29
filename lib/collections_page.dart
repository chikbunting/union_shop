import 'package:flutter/material.dart';
import 'package:union_shop/collection_page.dart';
import 'package:union_shop/services/product_service.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final collections = ProductService.getCollections();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: collections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final name = collections[index];
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            tileColor: Colors.white,
            title: Text(name, style: const TextStyle(fontSize: 18)),
            subtitle: const Text('Dummy collection description'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CollectionPage(collectionName: name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
