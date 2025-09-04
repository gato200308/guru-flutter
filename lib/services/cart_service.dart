import 'package:flutter/foundation.dart';
import '../models/cart.dart';
import '../models/product.dart';

class CartService {
  CartService._();
  static final CartService _instance = CartService._();
  factory CartService() => _instance;

  final Cart cart = Cart();

  // Notificadores simples para reconstruir la UI
  final ValueNotifier<int> itemCount = ValueNotifier<int>(0);
  final ValueNotifier<double> total = ValueNotifier<double>(0);

  void add(Product p) {
    cart.addProduct(p);
    _notify();
  }

  void remove(Product p) {
    cart.removeProduct(p);
    _notify();
  }

  void clear() {
    cart.items.clear();
    _notify();
  }

  void _notify() {
    itemCount.value = cart.items.length;
    total.value = cart.total;
  }
}
