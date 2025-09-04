import 'package:flutter/material.dart';
import '../widgets/cart_item.dart';
import '../services/cart_service.dart';
import '../services/history_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartSrv = CartService();
    final historySrv = HistoryService();

    return Scaffold(
      appBar: AppBar(title: const Text('Carrito de Compras')),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: cartSrv.itemCount,
              builder: (context, _, __) {
                final items = cartSrv.cart.items;
                if (items.isEmpty) {
                  return const Center(child: Text('Tu carrito está vacío'));
                }
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final p = items[i];
                    return CartItem(
                      product: p,
                      onRemove: () => cartSrv.remove(p),
                    );
                  },
                );
              },
            ),
          ),
          ValueListenableBuilder<double>(
            valueListenable: cartSrv.total,
            builder: (context, total, __) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Total: \$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (cartSrv.cart.items.isEmpty) return;
                          historySrv.add(Purchase(
                            date: DateTime.now(),
                            items: List.of(cartSrv.cart.items),
                            total: cartSrv.cart.total,
                          ));
                          cartSrv.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Compra registrada (falsa)')),
                          );
                        },
                        child: const Text('Finalizar compra (falso)'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
