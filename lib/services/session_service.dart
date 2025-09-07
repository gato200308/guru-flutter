import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _userKey = 'user_data';

  // Guardar datos de usuario en sesión
  static Future<void> saveUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, userData.toString());
  }

  // Obtener datos de usuario de sesión
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString == null) return null;
    // Convertir el string a Map
    try {
      // El string se guarda como Map.toString(), así que lo parseamos manualmente
      final userMap = _parseUserString(userString);
      return userMap;
    } catch (e) {
      return null;
    }
  }

  // Eliminar datos de usuario (logout)
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Helper para convertir el string guardado a Map
  static Map<String, dynamic> _parseUserString(String userString) {
    // Ejemplo de string: {nombre: Juan, correo: juan@mail.com, direccion: Calle 1, rol: usuario}
    final map = <String, dynamic>{};
    final entries = userString.substring(1, userString.length - 1).split(', ');
    for (var entry in entries) {
      final kv = entry.split(': ');
      if (kv.length == 2) {
        map[kv[0]] = kv[1];
      }
    }
    return map;
  }
}
