import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/account_screen.dart';
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
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color(0xFFFF6B35),
          onPrimary: Colors.white,
          secondary: const Color(0xFF2D3142),
          onSecondary: Colors.white,
          error: Colors.red.shade400,
          onError: Colors.white,
          background: const Color(0xFFF9F9F9),
          onBackground: Colors.black87,
          surface: Colors.white,
          onSurface: Colors.black87,
        ),
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF6B35),
          elevation: 2,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
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
      const FavoriteScreen()
      
      ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Artesanías Guru'),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6B35),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.storefront, color: Colors.white, size: 50),
                      SizedBox(height: 8),
                      Text(
                        'Menú Principal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
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
                _drawerItem(
                  icon: Icons.person_outline,
                  text: 'Cuenta',
                  selected: _selectedIndex == 3,
                  onTap: () => _onItemTapped(3),
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
      Navigator.pop(context); // Cierra el Drawer
    });
  }

  Widget _drawerItem({
    required IconData icon,
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon,
          color: selected ? const Color(0xFFFF6B35) : Colors.black87),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? const Color(0xFFFF6B35) : Colors.black87,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}
