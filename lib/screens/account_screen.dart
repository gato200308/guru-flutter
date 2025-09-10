import 'package:flutter/material.dart';
import '../services/session_service.dart';
import 'edit_profile_screen.dart';

const kBeige = Color(0xFFF5F5DC);
const kMarron = Color(0xFF8B4513);
const kAzul = Color(0xFF6A89CC);
const kDorado = Color(0xFFFFD700);
const kTexto = Color(0xFF2C3E50);

class AccountScreen extends StatelessWidget {
  final String nombre;
  final String correo;
  final String direccion;
  final String rol;
  final String? fotoUrl;

  const AccountScreen({
    super.key,
    required this.nombre,
    required this.correo,
    required this.direccion,
    required this.rol,
    this.fotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBeige,
      appBar: AppBar(
        title: const Text('Artesanías Guru', style: TextStyle(color: kBeige)),
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
                  rol == 'vendedor'
                      ? 'Cuenta de vendedor'
                      : 'Cuenta de usuario',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kMarron,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (fotoUrl != null && fotoUrl!.isNotEmpty)
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(fotoUrl!),
                  )
                else
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: kAzul,
                    child: Icon(Icons.person, color: Colors.white, size: 48),
                  ),
                const SizedBox(height: 18),
                Text(
                  nombre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: kTexto,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  correo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: kTexto),
                ),
                const SizedBox(height: 8),
                Text(
                  direccion,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: kTexto),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          nombre: nombre,
                          correo: correo,
                          direccion: direccion,
                          rol: rol,
                          fotoUrl: fotoUrl,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAzul,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Modificar datos'),
                ),
                const SizedBox(height: 12),
                if (rol == 'vendedor') ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/subir_producto');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDorado,
                      foregroundColor: kMarron,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Subir productos'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/editar_productos');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDorado,
                      foregroundColor: kMarron,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Editar productos'),
                  ),
                  const SizedBox(height: 12),
                ],
                ElevatedButton(
                  onPressed: () async {
                    await SessionService.clearUser();
                    if (context.mounted) {
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil('/', (route) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cerrar sesión'),
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
