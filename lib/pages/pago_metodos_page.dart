import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'historial_pedidos_page.dart';

class PagoMetodosPage extends StatefulWidget {
  const PagoMetodosPage({super.key});

  @override
  State<PagoMetodosPage> createState() => _PagoMetodosPageState();
}

class _PagoMetodosPageState extends State<PagoMetodosPage> {
  final List<Map<String, dynamic>> productos = [
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

  double get subtotal => productos.fold(0.0, (total, item) => total + item['precio'] * item['cantidad']);

  Future<void> _simularPagoPSE(BuildContext context) async {
    final urlSimulado = 'https://www.google.com';
    if (await canLaunchUrl(Uri.parse(urlSimulado))) {
      await launchUrl(Uri.parse(urlSimulado));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace de pago')),
      );
    }
  }

  InputDecoration _estiloCampo(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      floatingLabelStyle: const TextStyle(
        color: Colors.black,
        backgroundColor: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      filled: true,
      fillColor: Colors.black,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _bannerSuperior() {
  return Container(
    height: 100,
    color: const Color(0xFF4E342E),
    child: Center(
      child: Container(
        width: 600,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/guru_logo.png',
              height: 48,
              fit: BoxFit.contain,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistorialPedidosPage()),
                );
              },
              icon: const Icon(Icons.shopping_bag),
              iconSize: 32,
              color: Color(0xFFFFD700),
              tooltip: 'Ver historial',
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _seccionTarjeta() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text('Información de la tarjeta', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      children: [
        const SizedBox(height: 12),
        TextField(style: const TextStyle(color: Colors.white), decoration: _estiloCampo('Número de tarjeta'), keyboardType: TextInputType.number),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: TextField(style: const TextStyle(color: Colors.white), decoration: _estiloCampo('MM/AA'), keyboardType: TextInputType.datetime)),
            const SizedBox(width: 12),
            Expanded(child: TextField(style: const TextStyle(color: Colors.white), decoration: _estiloCampo('CVV'), keyboardType: TextInputType.number)),
          ],
        ),
        const SizedBox(height: 12),
        TextField(style: const TextStyle(color: Colors.white), decoration: _estiloCampo('Nombre en la tarjeta')),
      ],
    );
  }

  Widget _seccionDireccion() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text('Dirección de envío', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      children: [
        const SizedBox(height: 12),
        TextField(style: const TextStyle(color: Colors.white), decoration: _estiloCampo('Dirección completa')),
        const SizedBox(height: 12),
        TextField(style: const TextStyle(color: Colors.white), decoration: _estiloCampo('Ciudad')),
        const SizedBox(height: 12),
        TextField(style: const TextStyle(color: Colors.white), decoration: _estiloCampo('Código postal'), keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _historialPedidos({required bool integrado}) {
    final contenido = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HISTORIAL DE PEDIDOS',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4E342E)),
        ),
        const SizedBox(height: 12),
        ...productos.map((p) => Text('- ${p['titulo']}')),
        Text('Subtotal: \$${subtotal.toStringAsFixed(2)}'),
      ],
    );

    return integrado
        ? ExpansionTile(
            initiallyExpanded: true,
            title: const Text('Historial de pedidos', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            children: [Padding(padding: const EdgeInsets.all(8), child: contenido)],
          )
        : Container(
            width: 250,
            margin: const EdgeInsets.only(left: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: contenido,
          );
  }

  Widget _botonesPago(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Pago confirmado'),
                content: const Text('Gracias por tu compra.'),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4B0082),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Pagar ahora', style: TextStyle(fontSize: 16, color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () => _simularPagoPSE(context),
          icon: const Icon(Icons.account_balance, color: Colors.white),
          label: const Text('Pagar con PayPal', style: TextStyle(fontSize: 16, color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF006400),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFFFF8DC), Color(0xFFF5DEB3)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 800;
              return Column(
                children: [
                  _bannerSuperior(),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 600,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  _seccionTarjeta(),
                                  _seccionDireccion(),
                                  if (!isWide) _historialPedidos(integrado: true),
                                  _botonesPago(context),
                                ],
                              ),
                            ),
                            if (isWide) _historialPedidos(integrado: false),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}