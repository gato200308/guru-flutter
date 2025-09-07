import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'account_screen.dart';
import '../services/session_service.dart';
import 'register.dart';
import '../config/api_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Agregar logging para debug
      print('Intentando login con correo: ${_emailController.text.trim()}');

      final response = await http
          .post(
            Uri.parse(ApiConfig.loginEndpoint),
            headers: ApiConfig.defaultHeaders,
            body: json.encode({
              'correo': _emailController.text.trim(),
              'contrasena': _passwordController.text,
            }),
          )
          .timeout(
            ApiConfig.requestTimeout,
            onTimeout: () {
              throw TimeoutException(
                'La petición tardó demasiado en responder',
                ApiConfig.requestTimeout,
              );
            },
          );

      // Log de la respuesta para debug
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data decodificada: $data');

        if (data['success'] == true) {
          // Login exitoso
          final user = data['user'];
          // Guardar datos en sesión
          await SessionService.saveUser({
            'nombre': user['nombre'] ?? '',
            'correo': user['correo'] ?? '',
            'direccion': user['direccion'] ?? '',
            'rol': user['rol'] ?? 'usuario',
            'fotoUrl': user['fotoUrl'] ?? null,
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('¡Bienvenido ${user['nombre'] ?? 'Usuario'}!'),
              backgroundColor: Colors.green,
            ),
          );
          // Navegar al HomeScreen después de login
          Navigator.pushReplacementNamed(context, '/');
        } else {
          // Login fallido - mostrar mensaje específico del servidor
          String errorMessage = data['message'] ?? 'Error en el login';
          print('Error del servidor: $errorMessage');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      } else {
        // Error de conexión - mostrar detalles del error HTTP
        print('Error HTTP: ${response.statusCode} - ${response.reasonPhrase}');
        print('Response headers: ${response.headers}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error del servidor: ${response.statusCode} - ${response.reasonPhrase ?? "Error desconocido"}',
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      // Error de red - mostrar detalles del error
      print('Error de red: $e');
      print('Tipo de error: ${e.runtimeType}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error de conexión: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5DC), // Color beige claro como tu header
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo y título
                        Column(
                          children: [
                            Image.asset(
                              'assets/logosinfondo.png',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Artesanías Guru',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C3E50),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Campo de correo
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color(0xFF8B4513),
                            ), // Marrón como tu tema
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF8B4513),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu correo';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Por favor ingresa un correo válido';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Campo de contraseña
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFF8B4513),
                            ), // Marrón como tu tema
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xFF8B4513),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF6A89CC),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu contraseña';
                            }
                            if (value.length < 6) {
                              return 'La contraseña debe tener al menos 6 caracteres';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 32),

                        // Botón de login
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF8B4513,
                              ), // Marrón como tu tema
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Iniciar Sesión',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Enlaces adicionales
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                '¿No tienes cuenta?',
                                style: TextStyle(color: Color(0xFF8B4513)),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Aquí puedes navegar a la pantalla de recuperar contraseña
                              },
                              child: const Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(color: Color(0xFF8B4513)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
