import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/services/product_service.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Show selected sale products (p1 and p5) with images
    final saleProducts = [
      ProductService.instance.getProductById('p1'),
      ProductService.instance.getProductById('p5'),
    ].where((p) => p != null).toList();

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
                itemCount: saleProducts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final p = saleProducts[index]!;
                  return ListTile(
                    leading: Image.asset(
                      p.imageUrl ?? '',
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                    ),
                    title: Text(p.title),
                    subtitle: Text(p.description ?? ''),
                    trailing: Text(p.price),
                  );
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
