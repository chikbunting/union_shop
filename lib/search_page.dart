import 'package:flutter/material.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/widgets/product_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List _results = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is String && arg.isNotEmpty) {
      _controller.text = arg;
      _runSearch(arg);
    } else {
      // show all by default
      _results = ProductService.instance.getAllProducts();
    }
  }

  void _runSearch(String q) {
    setState(() {
      _results = ProductService.instance.search(q);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search'), backgroundColor: const Color(0xFF4d2963)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'Search products...'),
                    onSubmitted: (v) => _runSearch(v),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _runSearch(_controller.text),
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _results.isEmpty
                  ? const Center(child: Text('No results found'))
                  : GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 900
              ? 3
              : MediaQuery.of(context).size.width > 600
                ? 2
                : 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                      children: _results.map<Widget>((p) {
                        return ProductCard(
                          productId: p.id,
                          title: p.title,
                          price: p.price,
                          imageUrl: p.imageUrl,
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
