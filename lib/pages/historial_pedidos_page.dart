import 'package:flutter/material.dart';
import 'pago_metodos_page.dart';

class HistorialPedidosPage extends StatelessWidget {
  const HistorialPedidosPage({super.key});

  final List<Map<String, dynamic>> productos = const [
    {
      'titulo': 'Summer Monument',
      'fecha': '09/09/2023',
      'cantidad': 1,
      'precio': 12.00,
    },
    {
      'titulo': 'Customer Element',
      'fecha': '09/09/2023',
      'cantidad': 1,
      'precio': 12.75,
    },
  ];

  double _calcularSubtotal() {
    return productos.fold(0.0, (total, item) => total + item['precio'] * item['cantidad']);
  }

  Widget _bannerSuperior(double anchoMaximo, bool isWide) {
    return Container(
      height: 100,
      color: const Color(0xFF4E342E),
      child: Center(
        child: Container(
          width: isWide ? anchoMaximo : double.infinity,
          alignment: isWide ? Alignment.centerLeft : Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Image.asset(
            'assets/images/guru_logo.png',
            height: 48,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = _calcularSubtotal();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 800;
        final anchoContenido = isWide ? 800.0 : constraints.maxWidth;

        return Scaffold(
          backgroundColor: const Color(0xFFFFF8DC),
          body: Column(
            children: [
              _bannerSuperior(anchoContenido, isWide),
              Expanded(
                child: Center(
                  child: Container(
                    width: anchoContenido,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          children: productos.map((producto) {
                            return SizedBox(
                              width: isWide ? 360 : double.infinity,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFF4E342E)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(producto['titulo'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    const SizedBox(height: 8),
                                    Text('Fecha de compra: ${producto['fecha']}'),
                                    Text('Cantidad: ${producto['cantidad']}'),
                                    Text('Precio: \$${producto['precio'].toStringAsFixed(2)}'),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Subtotal: \$${subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const PagoMetodosPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4B0082),
                              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Comprar ahora',
                              style: TextStyle(fontSize: 18, color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}