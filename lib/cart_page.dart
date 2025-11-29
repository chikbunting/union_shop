import 'package:flutter/material.dart';
import 'package:union_shop/services/cart_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = CartService.items();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), backgroundColor: const Color(0xFF4d2963)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final it = items[index];
                  return ListTile(
                    title: Text(it.product.title),
                    subtitle: Text('Qty: ${it.quantity} ${it.size != null ? '\nSize: ${it.size}' : ''}'),
                    trailing: Text('£${(it.product.price * it.quantity).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text('Total: £${CartService.total().toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () { CartService.clear(); Navigator.pop(context); }, child: const Text('Place Order (demo)')),
          ],
        ),
      ),
    );
  }
}
