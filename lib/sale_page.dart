import 'package:flutter/material.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    final saleProducts = const [
      {'title': 'Sale Magnet', 'price': '£5.00', 'old': '£10.00'},
      {'title': 'Discounted Postcard', 'price': '£2.50', 'old': '£5.00'},
      {'title': 'Sale Sticker', 'price': '£1.00', 'old': '£2.00'},
    ];

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
                  final p = saleProducts[index];
                  return ListTile(
                    title: Text(p['title'] ?? ''),
                    subtitle: Text('Was ${p['old']}'),
                    trailing: Text(p['price'] ?? ''),
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
