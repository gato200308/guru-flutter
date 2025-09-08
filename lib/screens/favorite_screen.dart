import 'package:flutter/material.dart';
import '../services/favorite_service.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';
import '../services/cart_service.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartSrv = CartService();

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos ❤️')),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: FavoriteService.favorites,
        builder: (context, favorites, _) {
          if (favorites.isEmpty) {
            return const Center(child: Text('No tienes favoritos aún.'));
          }
          return ListView(
            children: favorites.map(
              (p) => ProductItem(
                product: p,
                onAddToCart: () => cartSrv.add(p),
              ),
            ).toList(),
          );
        },
      ),
    );
  }
}
