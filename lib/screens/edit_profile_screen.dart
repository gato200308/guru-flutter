import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../config/api_config.dart';

// Paleta de colores
const kBeige = Color(0xFFF5F5DC);
const kMarron = Color(0xFF8B4513);
const kAzul = Color(0xFF6A89CC);
const kDorado = Color(0xFFFFD700);
const kTexto = Color(0xFF2C3E50);

class EditProfileScreen extends StatefulWidget {
  final String nombre;
  final String correo;
  final String direccion;
  final String rol;
  final String? fotoUrl;

  const EditProfileScreen({
    super.key,
    required this.nombre,
    required this.correo,
    required this.direccion,
    required this.rol,
    this.fotoUrl,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nombreController;
  late TextEditingController correoController;
  late TextEditingController direccionController;
  String? fotoPath;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.nombre);
    correoController = TextEditingController(text: widget.correo);
    direccionController = TextEditingController(text: widget.direccion);
    fotoPath = widget.fotoUrl;
  }

  @override
  void dispose() {
    nombreController.dispose();
    correoController.dispose();
    direccionController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        fotoPath = pickedFile.path;
      });
    }
  }

  Future<void> guardarCambios() async {
    final url = '${ApiConfig.baseUrl}/usuarios_update.php';
    String fotoBase64 = '';
    if (fotoPath != null) {
      final bytes = await File(fotoPath!).readAsBytes();
      fotoBase64 = base64Encode(bytes);
    }

    final body = {
      'id': 'ID_DEL_USUARIO', // Reemplaza por el ID real del usuario
      'nombre': nombreController.text,
      'correo': correoController.text,
      'direccion': direccionController.text,
      'foto': fotoBase64,
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
      backgroundColor: kBeige,
      appBar: AppBar(
        title: const Text('Editar Perfil', style: TextStyle(color: kBeige)),
        backgroundColor: kMarron,
        foregroundColor: kBeige,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: kMarron,
                      backgroundImage:
                          (fotoPath != null && !fotoPath!.startsWith('http'))
                          ? Image.asset(fotoPath!).image
                          : (fotoPath != null ? NetworkImage(fotoPath!) : null),
                      child: (fotoPath == null)
                          ? const Icon(Icons.person, size: 48, color: kBeige)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: kDorado,
                          size: 28,
                        ),
                        onPressed: pickImage,
                        tooltip: 'Cambiar foto',
                      ),
                    ),
                  ],
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
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    guardarCambios();
                  },
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
      ),
    );
  }
}
