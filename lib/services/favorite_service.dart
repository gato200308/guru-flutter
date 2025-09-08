import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoriteService {
  // Lista reactiva de favoritos
  static final ValueNotifier<List<Product>> favorites = ValueNotifier([]);

  static void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      // Si ya está, lo quitamos
      favorites.value = [...favorites.value]..remove(product);
    } else {
      // Si no está, lo agregamos
      favorites.value = [...favorites.value, product];
    }
  }

  static bool isFavorite(Product product) {
    return favorites.value.contains(product);
  }
}
