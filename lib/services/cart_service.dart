import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class CartService {
  final String baseUrl;
  CartService(this.baseUrl);

  /// Verifica si hay conectividad de red local (Wi‑Fi / móvil).
  Future<bool> hasNetwork() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// Valida un endpoint de salud general del API (por convención /health).
  Future<bool> validateApi({Duration timeout = const Duration(seconds: 5)}) async {
    if (!await hasNetwork()) return false;
    try {
      final uri = Uri.parse('$baseUrl/health');
      final resp = await http.get(uri).timeout(timeout);
      return resp.statusCode >= 200 && resp.statusCode < 300;
    } catch (_) {
      return false;
    }
  }

  /// Comprueba directamente el endpoint del carrito (por ejemplo /cart/ping).
  Future<bool> validateCartConnection({Duration timeout = const Duration(seconds: 5)}) async {
    if (!await hasNetwork()) return false;
    try {
      final uri = Uri.parse('$baseUrl/cart/ping');
      final resp = await http.get(uri).timeout(timeout);
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}