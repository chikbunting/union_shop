import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductCard extends StatefulWidget {
  final String productId;
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovered = false;

  void _onEnter(bool hovered) {
    setState(() => _hovered = hovered);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: FocusableActionDetector(
        onShowFocusHighlight: (focused) => setState(() => _hovered = focused),
        onFocusChange: (focused) => setState(() => _hovered = focused),
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (intent) {
            Navigator.pushNamed(context, '/product', arguments: widget.productId);
            return null;
          }),
        },
        child: AnimatedScale(
          duration: const Duration(milliseconds: 160),
          scale: _hovered ? 1.01 : 1.0,
          child: Card(
            elevation: _hovered ? 8 : 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: _hovered ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2) : BorderSide.none,
            ),
            clipBehavior: Clip.hardEdge,
            child: Semantics(
              // Expose the product card as a tappable button with a clear label for screen readers
              button: true,
              label: '${widget.title}, ${widget.price}',
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/product', arguments: widget.productId),
                child: LayoutBuilder(builder: (context, constraints) {
                final cw = constraints.maxWidth;
                final titleSize = cw > 240 ? 15.0 : 13.0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  // image area with overlay title and price
                  AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: widget.imageUrl.startsWith('assets/')
                              ? Image.asset(
                                  widget.imageUrl,
                                  fit: BoxFit.cover,
                                  // Mark the product image as decorative because we provide a clear semantic label on the card
                                  excludeFromSemantics: true,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: Icon(Icons.image_not_supported, color: Colors.grey),
                                      ),
                                    );
                                  },
                                )
                              : Image.network(
                                  widget.imageUrl,
                                  fit: BoxFit.cover,
                                  excludeFromSemantics: true,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey[200],
                                      child: const Center(child: CircularProgressIndicator()),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: Icon(Icons.image_not_supported, color: Colors.grey),
                                      ),
                                    );
                                  },
                                ),
                        ),
                        // title overlay
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black54],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Text(
                              widget.title,
                              style: TextStyle(color: Colors.white, fontSize: titleSize, fontWeight: FontWeight.w600),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        // price badge
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            color: Colors.black54,
                            child: Text(widget.price, style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // small padding area to keep card balanced
                  const SizedBox(height: 12),
                ],
              );
            }), // end LayoutBuilder
                ), // end InkWell
              ), // end Semantics
            ), // end Card
          ), // end AnimatedScale
        ), // end FocusableActionDetector
      ); // end MouseRegion
  }
}
