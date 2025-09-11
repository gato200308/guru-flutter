import 'environment.dart';

class ApiConfig {
  // URLs base según el entorno
  static const String _devBaseUrl = 'http://192.168.0.8/backendguru';
  static const String _stagingBaseUrl = 'http://192.168.0.8/backendguru';
  static const String _prodBaseUrl = 'http://192.168.0.8/backendguru';

  // URL base del backend según el entorno
  static String get baseUrl {
    switch (EnvironmentConfig.environment) {
      case Environment.development:
        return _devBaseUrl;
      case Environment.staging:
        return _stagingBaseUrl;
      case Environment.production:
        return _prodBaseUrl;
    }
  }

  // Endpoints
  static String get loginEndpoint => '${baseUrl}/auth/login.php';

  // Timeouts
  static const Duration requestTimeout = Duration(seconds: 10);

  // Headers por defecto
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Función para verificar si la URL es accesible
  static bool isLocalNetwork() {
    return baseUrl.contains('172.17.15.181');
  }

  // Función para obtener información de debug
  static String get debugInfo {
    return '''
    Entorno: ${EnvironmentConfig.environmentName}
    URL Base: $baseUrl
    Endpoint Login: $loginEndpoint
    Timeout: ${requestTimeout.inSeconds}s
    Red Local: ${isLocalNetwork()}
    ''';
  }
}