import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/favorite_screen.dart';
import 'services/session_service.dart';

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
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,

          // 🎨 Paleta principal
          primary: Color(0xFF8B4513), // Marrón — botones, íconos, énfasis
          onPrimary: Colors.white, // Texto sobre fondo marrón

          secondary: Color(0xFF6A89CC), // Azul grisáceo suave — acento de foco
          onSecondary: Color(0xFF2C3E50),

          error: Color(0xFFF44336), // Rojo — SnackBar error
          onError: Colors.white,

          background: Color(0xFFF5F5DC), // Beige claro — fondo principal
          onBackground: Color(0xFF2C3E50), // Azul oscuro — textos principales

          surface: Color(0xFFFFFFFF), // Blanco — tarjetas y contenedores
          onSurface: Color(0xFF2C3E50),
        ),

        scaffoldBackgroundColor: const Color(0xFFF5F5DC),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B4513), // Marrón
          elevation: 2,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),

        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFFF5F5DC), // Beige claro
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B4513), // Marrón
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFF4CAF50), // Verde para mensajes de éxito
          contentTextStyle: TextStyle(color: Colors.white),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final session = SessionService();

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const CartScreen(),
      const FavoriteScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Artesanías GURU'),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF8B4513), // Marrón
                        Color(0xFF6A89CC), // Azul grisáceo suave
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'GURU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                _drawerItem(
                  icon: Icons.home,
                  text: 'Inicio',
                  selected: _selectedIndex == 0,
                  onTap: () => _onItemTapped(0),
                ),
                _drawerItem(
                  icon: Icons.shopping_cart_outlined,
                  text: 'Carrito',
                  selected: _selectedIndex == 1,
                  onTap: () => _onItemTapped(1),
                ),
                _drawerItem(
                  icon: Icons.favorite_border,
                  text: 'Favoritos',
                  selected: _selectedIndex == 2,
                  onTap: () => _onItemTapped(2),
                ),
              ],
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screens[_selectedIndex],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context);
    });
  }

  Widget _drawerItem({
    required IconData icon,
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? const Color(0xFF8B4513) : const Color(0xFF2C3E50),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? const Color(0xFF8B4513) : const Color(0xFF2C3E50),
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}
