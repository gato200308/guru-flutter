import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductItem({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: onAddToCart,
        ),
      ),
    );
  }
}
