import 'package:flutter/material.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/widgets/product_card.dart';
import 'package:union_shop/widgets/footer.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
  // Featured sale product ids
  const saleProductIds = ['p1', 'p5'];

    // legacy simple sale list (kept for tests / simple display)
    const saleProducts = [
      {'title': 'Sale Magnet', 'price': '£5.00', 'old': '£10.00'},
      {'title': 'Discounted Postcard', 'price': '£2.50', 'old': '£5.00'},
      {'title': 'Sale Sticker', 'price': '£1.00', 'old': '£2.00'},
    ];
    // additionalSaleProducts intentionally removed (legacy placeholders)

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
            // Sale product cards + legacy sale list below
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: MediaQuery.of(context).size.width > 800 ? 2 : 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                      children: () {
                        final products = saleProductIds
                            .map((id) => ProductService.instance.getProductById(id))
                            .where((p) => p != null)
                            .map((p) => p!)
                            .toList();
                        return products
                            .map((p) => ProductCard(
                                  productId: p.id,
                                  title: p.title,
                                  price: p.price,
                                  imageUrl: p.imageUrl,
                                ))
                            .toList();
                      }(),
                    ),
                    const SizedBox(height: 16),
                    // legacy sale list for smaller items
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: saleProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final p = saleProducts[index];
                        return ListTile(
                          title: Text(p['title'] ?? ''),
                          subtitle: Text('Was ${p['old']}'),
                          trailing: Text(p['price'] ?? ''),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
