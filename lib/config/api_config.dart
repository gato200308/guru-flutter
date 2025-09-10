import 'environment.dart';

class ApiConfig {
  // URLs base según el entorno
  static const String _devBaseUrl = 'http://172.20.10.8/backendguru';
  static const String _stagingBaseUrl = 'http://172.20.10.8/backendguru';
  static const String _prodBaseUrl = 'http://172.20.10.8/backendguru';

  // URL base del backend según el entorno
  static String get baseUrl => _devBaseUrl;

  // Endpoints
  static String get loginEndpoint => '$baseUrl/auth/login.php';
  static String get registerEndpoint => '$baseUrl/auth/register.php';
  static String get editProfileEndpoint => '$baseUrl/auth/edit_profile.php';
  static String get changePasswordEndpoint =>
      '$baseUrl/auth/change_password.php';

  // Ejemplo para productos
  static String get addProductEndpoint => '$baseUrl/products/add.php';
  static String get updateProductEndpoint => '$baseUrl/products/update.php';

  // Timeouts
  static const Duration requestTimeout = Duration(seconds: 10);

  // Headers por defecto
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };
}
