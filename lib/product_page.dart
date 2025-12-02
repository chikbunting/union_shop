import 'package:flutter/material.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/header.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _selectedSize = 'One Size';
  String _selectedColour = 'Black';
  int _quantity = 1;

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // placeholder
  }

  void _addToCart() {
    final routeArg = ModalRoute.of(context)?.settings.arguments;
    final product = (routeArg is String)
        ? (ProductService.instance.getProductById(routeArg) ?? Product(
            id: 'p-demo',
            title: 'Placeholder Product Name',
            price: '£15.00',
            description: 'Demo product',
            collection: 'Demo',
            imageUrl: '',
          ))
        : Product(
            id: 'p-demo',
            title: 'Placeholder Product Name',
            price: '£15.00',
            description: 'Demo product',
            collection: 'Demo',
            imageUrl: '',
          );

    CartService.instance.add(product, quantity: _quantity, size: _selectedSize, colour: _selectedColour);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Use reusable header for consistency
            const Header(),

            // Product details
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image and details loaded from ProductService when a product id is provided via route arguments
                  Builder(builder: (context) {
                    final routeArg = ModalRoute.of(context)?.settings.arguments;
                    final product = (routeArg is String)
                        ? (ProductService.instance.getProductById(routeArg) ?? Product(
                            id: 'p-demo',
                            title: 'Placeholder Product Name',
                            price: '£15.00',
                            description: 'Demo product',
                            collection: 'Demo',
                            imageUrl: '',
                          ))
                        : Product(
                            id: 'p-demo',
                            title: 'Placeholder Product Name',
                            price: '£15.00',
                            description: 'Demo product',
                            collection: 'Demo',
                            imageUrl: '',
                          );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: product.imageUrl.isNotEmpty
                                ? Image.asset(
                                    product.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Product name
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Product price
                        Text(
                          product.price,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4d2963),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Product description
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                  const SizedBox(height: 16),
                  // Student instruction line (kept from earlier)
                  const Text(
                    'Students should add size options, colour options, quantity selector, add to cart button, and buy now button here.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  // Simple functional controls: size, colour, quantity, add to cart
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedSize,
                          items: const [
                            DropdownMenuItem(value: 'One Size', child: Text('One Size')),
                            DropdownMenuItem(value: 'Small', child: Text('Small')),
                            DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                            DropdownMenuItem(value: 'Large', child: Text('Large')),
                          ],
                          onChanged: (v) => setState(() => _selectedSize = v ?? 'One Size'),
                          decoration: const InputDecoration(labelText: 'Size'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedColour,
                          items: const [
                            DropdownMenuItem(value: 'Black', child: Text('Black')),
                            DropdownMenuItem(value: 'White', child: Text('White')),
                          ],
                          onChanged: (v) => setState(() => _selectedColour = v ?? 'Black'),
                          decoration: const InputDecoration(labelText: 'Colour'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('Quantity:'),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => setState(() { if (_quantity > 1) _quantity -= 1; }),
                            ),
                            Text('$_quantity'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => setState(() => _quantity += 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _addToCart,
                        child: const Text('Add to Cart'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: placeholderCallbackForButtons,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                        child: const Text('Buy Now'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Placeholder Footer',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Students should customise this footer section',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
