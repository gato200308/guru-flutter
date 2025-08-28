import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class NetworkUtils {
  /// Prueba si hay conexión a internet
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Prueba si el servidor backend está accesible
  static Future<bool> isServerAccessible() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/'),
        headers: ApiConfig.defaultHeaders,
      ).timeout(const Duration(seconds: 5));
      
      return response.statusCode < 500;
    } catch (e) {
      print('Error al verificar servidor: $e');
      return false;
    }
  }

  /// Prueba la conectividad completa
  static Future<Map<String, bool>> testFullConnectivity() async {
    bool hasInternet = await hasInternetConnection();
    bool serverAccessible = false;
    
    if (hasInternet) {
      serverAccessible = await isServerAccessible();
    }
    
    return {
      'internet': hasInternet,
      'server': serverAccessible,
    };
  }

  /// Obtiene información detallada del error de red
  static String getNetworkErrorMessage(dynamic error) {
    if (error is SocketException) {
      if (error.message.contains('Connection refused')) {
        return 'El servidor rechazó la conexión. Verifica que el backend esté ejecutándose.';
      } else if (error.message.contains('Network is unreachable')) {
        return 'La red no es accesible. Verifica tu conexión WiFi.';
      } else {
        return 'Error de conexión: ${error.message}';
      }
    } else if (error is TimeoutException) {
      return 'Tiempo de espera agotado. El servidor no responde.';
    } else {
      return 'Error de red: $error';
    }
  }
}
