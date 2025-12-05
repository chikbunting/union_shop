import 'package:flutter/material.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/widgets/product_card.dart';
import 'package:union_shop/widgets/footer.dart';

class CollectionPage extends StatefulWidget {
  final String collectionName;

  const CollectionPage({super.key, required this.collectionName});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String _sortBy = 'All';
  String _colour = 'Any';
  bool _under10 = false;
  bool _sale = false;
  bool _eco = false;

  double _parsePrice(String price) {
    return double.tryParse(price.replaceAll('£', '').replaceAll(',', '')) ?? 0.0;
  }

  List filteredProducts() {
    final products = ProductService.instance.getProductsForCollection(widget.collectionName);
    var list = products.where((p) => true).toList();

    if (_under10) {
      list = list.where((p) => _parsePrice(p.price) < 10.0).toList();
    }
    if (_sale) {
      list = list.where((p) => p.collection.toLowerCase().contains('sale')).toList();
    }

    // Colour filter is a no-op unless product metadata contains colour; kept for UI completeness
    if (_colour != 'Any') {
      // no-op (placeholder for future colour metadata)
    }

    // Sorting
    if (_sortBy == 'Price: Low to High') {
      list.sort((a, b) => _parsePrice(a.price).compareTo(_parsePrice(b.price)));
    } else if (_sortBy == 'Price: High to Low') {
      list.sort((a, b) => _parsePrice(b.price).compareTo(_parsePrice(a.price)));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final products = filteredProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collectionName),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Products in ${widget.collectionName}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),

            // Functional dropdowns / filters
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _sortBy,
                    items: const [
                      DropdownMenuItem(value: 'All', child: Text('All')),
                      DropdownMenuItem(value: 'Price: Low to High', child: Text('Price: Low to High')),
                      DropdownMenuItem(value: 'Price: High to Low', child: Text('Price: High to Low')),
                    ],
                    onChanged: (v) => setState(() => _sortBy = v ?? 'All'),
                    decoration: const InputDecoration(labelText: 'Sort by'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _colour,
                    items: const [
                      DropdownMenuItem(value: 'Any', child: Text('Any')),
                      DropdownMenuItem(value: 'Red', child: Text('Red')),
                      DropdownMenuItem(value: 'Blue', child: Text('Blue')),
                    ],
                    onChanged: (v) => setState(() => _colour = v ?? 'Any'),
                    decoration: const InputDecoration(labelText: 'Colour'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Tooltip(message: 'Show products under £10', child: FilterChip(label: const Text('Under £10'), selected: _under10, onSelected: (v) => setState(() => _under10 = v))),
                Tooltip(message: 'Show sale items', child: FilterChip(label: const Text('Sale'), selected: _sale, onSelected: (v) => setState(() => _sale = v))),
                Tooltip(message: 'Show eco-friendly items', child: FilterChip(label: const Text('Eco'), selected: _eco, onSelected: (v) => setState(() => _eco = v))),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: GridView.count(
                  shrinkWrap: false,
                  crossAxisCount: MediaQuery.of(context).size.width > 1200
                      ? 4
                      : MediaQuery.of(context).size.width > 900
                          ? 3
                          : MediaQuery.of(context).size.width > 600
                              ? 2
                              : 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                  padding: const EdgeInsets.all(4),
                  children: products
                      .map((p) => ProductCard(
                            productId: p.id,
                            title: p.title,
                            price: p.price,
                            imageUrl: p.imageUrl,
                          ))
                      .toList(),
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
