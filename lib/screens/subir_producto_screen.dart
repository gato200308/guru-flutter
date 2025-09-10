import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class SubirProductoScreen extends StatefulWidget {
  final int vendedorId;
  const SubirProductoScreen({super.key, required this.vendedorId});

  @override
  State<SubirProductoScreen> createState() => _SubirProductoScreenState();
}

class _SubirProductoScreenState extends State<SubirProductoScreen> {
  final nombreController = TextEditingController();
  final descripcionController = TextEditingController();
  final precioController = TextEditingController();
  final stockController = TextEditingController();
  String? imagenPath;
  String? imagenBase64;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagenPath = pickedFile.path;
      });
      final bytes = await File(pickedFile.path).readAsBytes();
      imagenBase64 = base64Encode(bytes);
    }
  }

  Future<void> subirProducto() async {
    final url = '${ApiConfig.baseUrl}/products/add.php';
    final body = {
      'nombre': nombreController.text,
      'descripcion': descripcionController.text,
      'precio': precioController.text,
      'stock': stockController.text,
      'imagen_base64': imagenBase64 ?? '',
      'vendedor_id': widget.vendedorId.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: ApiConfig.defaultHeaders,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final resp = jsonDecode(response.body);
        if (resp['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Producto subido correctamente')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${resp['message']}')));
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error de red: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subir producto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: imagenPath != null && imagenPath!.isNotEmpty
                    ? FileImage(File(imagenPath!))
                    : null,
                child: (imagenPath == null || imagenPath!.isEmpty)
                    ? const Icon(Icons.camera_alt, size: 40)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: precioController,
              decoration: const InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: 'Inventario'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: subirProducto,
              child: const Text('Subir producto'),
            ),
          ],
        ),
      ),
    );
  }
}
