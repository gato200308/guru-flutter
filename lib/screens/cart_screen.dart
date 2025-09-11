import 'package:flutter/material.dart';
import 'package:guru_app/screens/historial_pedidos_page.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Redirige automáticamente al historial de pedidos
    Future.microtask(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HistorialPedidosPage(),
        ),
      );
    });

    // Pantalla vacía mientras se realiza la redirección
    return const Scaffold(
      body: SizedBox.shrink(),
    );
  }
}