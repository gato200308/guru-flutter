import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import 'editar_producto_form.dart';

class EditarProductosScreen extends StatefulWidget {
  final int vendedorId;
  const EditarProductosScreen({super.key, required this.vendedorId});

  @override
  State<EditarProductosScreen> createState() => _EditarProductosScreenState();
}

class _EditarProductosScreenState extends State<EditarProductosScreen> {
  Future<List<dynamic>> cargarProductos() async {
    final url = '${ApiConfig.baseUrl}/products/list_by_vendedor.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'vendedor_id': widget.vendedorId}),
    );
    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      return data['productos'];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar productos')),
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: cargarProductos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final productos = snapshot.data!;
            if (productos.isEmpty) {
              return const Center(child: Text('No tienes productos subidos.'));
            }
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                final imagenUrl =
                    producto['imagen'] != null &&
                        producto['imagen'].toString().isNotEmpty
                    ? '${ApiConfig.baseUrl}/${producto['imagen']}'
                    : null;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: imagenUrl != null
                        ? Image.network(
                            imagenUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported, size: 80),
                    title: Text(producto['nombre']),
                    subtitle: Text('Precio: \$${producto['precio']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditarProductoForm(producto: producto),
                              ),
                            ).then((_) => setState(() {}));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            final url =
                                '${ApiConfig.baseUrl}/products/delete.php';
                            final response = await http.post(
                              Uri.parse(url),
                              headers: {'Content-Type': 'application/json'},
                              body: jsonEncode({'id': producto['id']}),
                            );
                            final data = jsonDecode(response.body);
                            if (data['success'] == true) {
                              setState(() {}); // Refresca la lista
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Producto eliminado'),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
