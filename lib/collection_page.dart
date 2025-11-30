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

            // Non-functional dropdowns / filters (hardcoded data acceptable)
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'All',
                    items: const [
                      DropdownMenuItem(value: 'All', child: Text('All')),
                      DropdownMenuItem(value: 'New', child: Text('New')),
                      DropdownMenuItem(value: 'Popular', child: Text('Popular')),
                    ],
                    onChanged: (_) {},
                    decoration: const InputDecoration(labelText: 'Sort by'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'Any',
                    items: const [
                      DropdownMenuItem(value: 'Any', child: Text('Any')),
                      DropdownMenuItem(value: 'Red', child: Text('Red')),
                      DropdownMenuItem(value: 'Blue', child: Text('Blue')),
                    ],
                    onChanged: (_) {},
                    decoration: const InputDecoration(labelText: 'Colour'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: const [
                FilterChip(label: Text('Under £10'), selected: false, onSelected: null),
                FilterChip(label: Text('Sale'), selected: false, onSelected: null),
                FilterChip(label: Text('Eco'), selected: false, onSelected: null),
              ],
            ),
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
