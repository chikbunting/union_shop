import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF7F7F8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 600;
            return Flex(
              direction: isNarrow ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: isNarrow ? double.infinity : 260,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Union Shop', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Official student union store. Find merch, gifts and stationery.'),
                    ],
                  ),
                ),

                const SizedBox(height: 12, width: 24),

                SizedBox(
                  width: isNarrow ? double.infinity : 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Collections', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/collections'),
                        child: const Align(alignment: Alignment.centerLeft, child: Text('Shop')),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/personalisation'),
                        child: const Align(alignment: Alignment.centerLeft, child: Text('Personalisation')),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/sale'),
                        child: const Align(alignment: Alignment.centerLeft, child: Text('Sale Items')),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/search'),
                        child: const Align(alignment: Alignment.centerLeft, child: Text('Search')),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12, width: 24),

                SizedBox(
                  width: isNarrow ? double.infinity : 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Help', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextButton(onPressed: () => Navigator.pushNamed(context, '/about'), child: const Align(alignment: Alignment.centerLeft, child: Text('About'))),
                      TextButton(onPressed: () {}, child: const Align(alignment: Alignment.centerLeft, child: Text('Contact'))),
                    ],
                  ),
                ),
              ],
            );
          }),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('© 2025 Union Shop', style: TextStyle(color: Colors.grey)),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.facebook, color: Colors.grey)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.grey)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
