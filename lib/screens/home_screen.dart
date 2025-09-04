import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';
import '../widgets/fake_button.dart';
import '../services/cart_service.dart';
import 'cart_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Productos falsos para previsualización
  List<Product> get _products => [
        Product(id: '1', name: 'Pulsera artesanal', price: 19.99),
        Product(id: '2', name: 'Sombrero Wayuu', price: 39.50),
        Product(id: '3', name: 'Mochila tejida', price: 59.00),
      ];

  @override
  Widget build(BuildContext context) {
    final cartSrv = CartService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guru Store'),
        actions: [
          // Icono de carrito con contador
          ValueListenableBuilder<int>(
            valueListenable: cartSrv.itemCount,
            builder: (context, count, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                  if (count > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FakeButton(
                text: 'Ir al Carrito',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
              ),
              FakeButton(
                text: 'Ver Historial',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._products.map(
            (p) => ProductItem(
              product: p,
              onAddToCart: () => cartSrv.add(p),
            ),
          ),
        ],
      ),
    );
  }
}
