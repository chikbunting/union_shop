import 'package:flutter/material.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  String _text = 'Your text here';
  double _fontSize = 20;
  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personalisation'), backgroundColor: const Color(0xFF4d2963)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Print Shack — Personalisation', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(labelText: 'Enter text to personalise'),
                        onChanged: (v) => setState(() => _text = v),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text('Font size:'),
                          Expanded(
                            child: Slider(
                              min: 12,
                              max: 48,
                              value: _fontSize,
                              onChanged: (v) => setState(() => _fontSize = v),
                            ),
                          ),
                          Text(_fontSize.toInt().toString()),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text('Colour:'),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => setState(() => _color = Colors.black),
                            child: Container(width: 28, height: 28, color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => setState(() => _color = Colors.red),
                            child: Container(width: 28, height: 28, color: Colors.red),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => setState(() => _color = Colors.blue),
                            child: Container(width: 28, height: 28, color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(onPressed: () {}, child: const Text('Add to cart (demo)')),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 320,
                  height: 320,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), color: Colors.white),
                  child: Center(
                    child: Text(
                      _text.isEmpty ? 'Preview' : _text,
                      style: TextStyle(fontSize: _fontSize, color: _color),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('About Print Shack', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('A small demo page to personalise text for prints and gifts. Live preview updates as you type.'),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
