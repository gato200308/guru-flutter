import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/account_screen.dart';
import 'services/session_service.dart';
import 'screens/home_screen.dart';
import 'screens/subir_producto_screen.dart';
import 'screens/editar_productos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guru App',
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/subir_producto': (context) => SubirProductoScreen(vendedorId: 1),
        '/editar_productos': (context) => EditarProductosScreen(vendedorId: 1),
        // ...otras rutas...
      },
    );
  }
}
