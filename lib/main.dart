import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guru App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.transparent, // ← fuerza sin fondo
          ),
        ),
      ),
      home: const HomeScreen(),
      routes: {'/login': (context) => const LoginScreen()},
    );
  }
}
