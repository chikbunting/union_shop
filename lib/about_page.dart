import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'About Us',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'This is a student implementation of the Union Shop application.\n\n'
              'For the coursework you should reimplement features from the real site. '
              'Hardcoded data is acceptable for this assessment.\n\n'
              'Features implemented in this app include a static homepage, product page, and basic navigation. '
              'Follow the README for details on how to run and test the app.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
