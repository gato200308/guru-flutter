import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../config/api_config.dart';

// Paleta de colores
const kBeige = Color(0xFFF5F5DC);
const kMarron = Color(0xFF8B4513);
const kAzul = Color(0xFF6A89CC);
const kDorado = Color(0xFFFFD700);
const kTexto = Color(0xFF2C3E50);

class EditProfileScreen extends StatefulWidget {
  final String id;
  final String nombre;
  final String correo;
  final String direccion;
  final String telefono;
  final String rol;

  const EditProfileScreen({
    super.key,
    required this.id,
    required this.nombre,
    required this.correo,
    required this.direccion,
    required this.telefono,
    required this.rol,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nombreController;
  late TextEditingController correoController;
  late TextEditingController direccionController;
  late TextEditingController telefonoController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.nombre);
    correoController = TextEditingController(text: widget.correo);
    direccionController = TextEditingController(text: widget.direccion);
    telefonoController = TextEditingController(text: widget.telefono);
  }

  @override
  void dispose() {
    nombreController.dispose();
    correoController.dispose();
    direccionController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  Future<void> guardarCambios() async {
  final url = '${ApiConfig.baseUrl}/get_user.php';

    final body = {
      'id': widget.id,
      'nombre': nombreController.text,
      'correo': correoController.text,
      'direccion': direccionController.text,
      'telefono': telefonoController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: ApiConfig.defaultHeaders,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil actualizado correctamente')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar: ${response.body}')),
        );
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
      appBar: AppBar(title: const Text('Editar perfil')),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                'Editar Perfil',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kMarron,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: const TextStyle(color: kMarron),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: kMarron, width: 2),
                  ),
                  prefixIcon: const Icon(Icons.person, color: kMarron),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: correoController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: const TextStyle(color: kMarron),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: kMarron, width: 2),
                  ),
                  prefixIcon: const Icon(Icons.email, color: kMarron),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: direccionController,
                decoration: InputDecoration(
                  labelText: 'Dirección',
                  labelStyle: const TextStyle(color: kMarron),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: kMarron, width: 2),
                  ),
                  prefixIcon: const Icon(Icons.location_on, color: kMarron),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: telefonoController,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  labelStyle: const TextStyle(color: kMarron),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: kMarron, width: 2),
                  ),
                  prefixIcon: const Icon(Icons.phone, color: kMarron),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: guardarCambios,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAzul,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Guardar cambios'),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
