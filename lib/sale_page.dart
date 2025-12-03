import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/models/product.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Show selected sale products (p1 and p5) with images, plus legacy static sale items
    final p1 = ProductService.instance.getProductById('p1');
    final p5 = ProductService.instance.getProductById('p5');

    final List<dynamic> saleEntries = [];
    if (p1 != null) saleEntries.add(p1);
    if (p5 != null) saleEntries.add(p5);
    saleEntries.addAll([
      {'title': 'Sale Magnet', 'price': '£5.00', 'old': '£10.00'},
      {'title': 'Discounted Postcard', 'price': '£2.50', 'old': '£5.00'},
      {'title': 'Sale Sticker', 'price': '£1.00', 'old': '£2.00'},
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sale Items',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: saleEntries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final entry = saleEntries[index];
                  if (entry is Product) {
                    return ListTile(
                      leading: Image.asset(
                        entry.imageUrl,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                      ),
                      title: Text(entry.title),
                      subtitle: Text(entry.description),
                      trailing: Text(entry.price),
                    );
                  } else {
                    final Map m = entry as Map;
                    return ListTile(
                      title: Text(m['title'] ?? ''),
                      subtitle: Text('Was ${m['old'] ?? ''}'),
                      trailing: Text(m['price'] ?? ''),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
