import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

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
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nombreController;
  late TextEditingController direccionController;
  late TextEditingController telefonoController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.nombre);
    direccionController = TextEditingController(text: widget.direccion);
    telefonoController = TextEditingController(text: widget.telefono);
  }

  @override
  void dispose() {
    nombreController.dispose();
    direccionController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  Future<void> guardarCambios() async {
    if (!_formKey.currentState!.validate()) return;

    final url = '${ApiConfig.baseUrl}/usuarios_update.php';
    final body = {
      'id': widget.id,
      'nombre': nombreController.text,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de red: $e')),
      );
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Ingrese su nombre' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: direccionController,
                  decoration: const InputDecoration(labelText: 'Dirección'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Ingrese su dirección' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: telefonoController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Ingrese su teléfono' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: widget.correo,
                  decoration: const InputDecoration(labelText: 'Correo electrónico'),
                  enabled: false,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: guardarCambios,
                  child: const Text('Guardar cambios'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}