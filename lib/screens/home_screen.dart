import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artesanías Guru'),
        backgroundColor: const Color(0xFFF5F5DC),
        foregroundColor: const Color(0xFF8B4513),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Aquí irá la funcionalidad de búsqueda
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Aquí irá la funcionalidad del perfil
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5DC),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 100,
                color: Color(0xFF8B4513),
              ),
              SizedBox(height: 20),
              Text(
                '¡Hola Mundo!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Login exitoso - Sesión iniciada',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF8B4513),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              Text(
                'Tu amigo puede reemplazar esta pantalla\ncon la funcionalidad de productos',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7F8C8D),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
