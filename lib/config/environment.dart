enum Environment { development, staging, production }

class EnvironmentConfig {
  static Environment _environment = Environment.development;
  
  static void setEnvironment(Environment env) {
    _environment = env;
  }
  
  static Environment get environment => _environment;
  
  static bool get isDevelopment => _environment == Environment.development;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.production;
  
  static String get environmentName {
    switch (_environment) {
      case Environment.development:
        return 'Desarrollo';
      case Environment.staging:
        return 'Staging';
      case Environment.production:
        return 'Producción';
    }
  }
  
  static bool get enableDebugFeatures => isDevelopment;
  static bool get enableLogging => isDevelopment || isStaging;
  static bool get enableAnalytics => isProduction;
}
