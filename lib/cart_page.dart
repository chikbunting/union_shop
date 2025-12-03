import 'package:flutter/material.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/widgets/footer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final itemsMap = CartService.instance.itemsMap;
    final entries = itemsMap.entries.toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), backgroundColor: const Color(0xFF4d2963)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: entries.isEmpty
                  ? const Center(child: Text('Your cart is empty'))
                  : ListView.separated(
                      itemCount: entries.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final entry = entries[index];
                        final key = entry.key;
                        final it = entry.value;
                        return ListTile(
                          title: Text(it.product.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if ((it.size ?? '').isNotEmpty || (it.colour ?? '').isNotEmpty)
                                Text('${it.size ?? ''} ${it.colour ?? ''}'),
                              if ((it.personalisedText ?? '').isNotEmpty)
                                Text('Personalised: "${it.personalisedText}" (size ${it.personalisedFontSize?.toInt() ?? ''})', style: const TextStyle(fontStyle: FontStyle.italic)),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  final newQty = it.quantity - 1;
                                  CartService.instance.updateQuantity(key, newQty);
                                  setState(() {});
                                },
                              ),
                              Text('${it.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  final newQty = it.quantity + 1;
                                  CartService.instance.updateQuantity(key, newQty);
                                  setState(() {});
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  CartService.instance.remove(key);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
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
      bottomNavigationBar: const Footer(),
    );
  }
}
 
