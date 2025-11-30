import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imageUrl;
  final String? semanticLabel;
  final BoxFit fit;

  const ProductImage({super.key, this.imageUrl, this.semanticLabel, this.fit = BoxFit.cover});

  bool get _isAsset => imageUrl != null && imageUrl!.startsWith('assets/');
  bool get _isEmpty => imageUrl == null || imageUrl!.trim().isEmpty;

  @override
  Widget build(BuildContext context) {
    if (_isEmpty) {
      return Container(
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.image_not_supported, color: Colors.grey, size: 36),
        ),
      );
    }

    if (_isAsset) {
      return Image.asset(
        imageUrl!,
        fit: fit,
        semanticLabel: semanticLabel,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, color: Colors.grey),
            ),
          );
        },
      );
    }

    // network image
    return Image.network(
      imageUrl!,
      fit: fit,
      semanticLabel: semanticLabel,
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
            child: Icon(Icons.broken_image, color: Colors.grey),
          ),
        );
      },
    );
  }
}
