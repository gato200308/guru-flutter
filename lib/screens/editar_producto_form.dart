import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

class EditarProductoForm extends StatefulWidget {
  final Map<String, dynamic> producto;
  const EditarProductoForm({Key? key, required this.producto})
    : super(key: key);

  @override
  State<EditarProductoForm> createState() => _EditarProductoFormState();
}

class _EditarProductoFormState extends State<EditarProductoForm> {
  late TextEditingController nombreController;
  late TextEditingController descripcionController;
  late TextEditingController precioController;
  late TextEditingController stockController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(
      text: widget.producto['nombre'] ?? '',
    );
    descripcionController = TextEditingController(
      text: widget.producto['descripcion'] ?? '',
    );
    precioController = TextEditingController(
      text: widget.producto['precio']?.toString() ?? '',
    );
    stockController = TextEditingController(
      text: widget.producto['stock']?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    nombreController.dispose();
    descripcionController.dispose();
    precioController.dispose();
    stockController.dispose();
    super.dispose();
  }

  Future<void> actualizarProducto() async {
    final url = '${ApiConfig.baseUrl}/products/update.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': widget.producto['id'],
        'nombre': nombreController.text,
        'descripcion': descripcionController.text,
        'precio': double.tryParse(precioController.text) ?? 0,
        'stock': int.tryParse(stockController.text) ?? 0,
      }),
    );
    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Producto actualizado')));
      Navigator.pop(context, true); // Vuelve y refresca la lista
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al actualizar')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagenUrl =
        widget.producto.containsKey('imagen') &&
            widget.producto['imagen'] != null &&
            widget.producto['imagen'].toString().isNotEmpty
        ? '${ApiConfig.baseUrl}/${widget.producto['imagen']}'
        : null;

    return Scaffold(
      appBar: AppBar(title: Text('Editar producto')),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              imagenUrl != null
                  ? Image.network(
                      imagenUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.image_not_supported, size: 80),
                    )
                  : Icon(Icons.image_not_supported, size: 80),
              SizedBox(height: 16),
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: precioController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: actualizarProducto,
                child: Text('Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
