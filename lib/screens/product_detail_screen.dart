import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  Widget _buildImage(String path) {
    // Si es URL, usamos Image.network
    if (path.startsWith('http')) {
      return Image.network(
        path,
        height: 250,
        width: double.infinity,
        fit: BoxFit.contain, // 👈 mantiene proporciones
        errorBuilder: (context, error, stackTrace) => Container(
          height: 250,
          width: double.infinity,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
        ),
      );
    } else {
      // Si es asset local
      return Image.asset(
        path,
        height: 250,
        width: double.infinity,
        fit: BoxFit.contain, // 👈 no recorta ni deforma
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.white, // 👈 evita fondo con cuadros grises
                child: _buildImage(product.imageUrl.isNotEmpty
                    ? product.imageUrl
                    : 'assets/placeholder.png'), // 👈 fallback local opcional
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              product.description.isNotEmpty
                  ? product.description
                  : 'Este producto no tiene descripción aún.',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
