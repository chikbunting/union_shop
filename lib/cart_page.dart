import 'package:flutter/material.dart';
import 'package:union_shop/services/cart_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final items = CartService.instance.items;
    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), backgroundColor: const Color(0xFF4d2963)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: items.isEmpty
                  ? const Center(child: Text('Your cart is empty'))
                  : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final it = items[index];
                        return ListTile(
                          title: Text(it.product.title),
                          subtitle: Text('${it.size ?? ''} ${it.colour ?? ''}'),
                          trailing: Text('x${it.quantity}'),
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total items: ${CartService.instance.totalItems}'),
                Text('Total: £${CartService.instance.totalPrice.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () { CartService.instance.clear(); _refresh(); }, child: const Text('Clear Cart')),
          ],
        ),
      ),
    );
  }
}
 
