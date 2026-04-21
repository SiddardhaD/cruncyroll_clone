enum Environment { development, staging, production }

class AppConfig {
  final Environment environment;
  final String baseUrl;
  final String apiKey;
  final bool enableLogging;
  final bool enableCrashReporting;
  final int timeout;

  const AppConfig({
    required this.environment,
    required this.baseUrl,
    required this.apiKey,
    required this.enableLogging,
    required this.enableCrashReporting,
    required this.timeout,
  });

  static late AppConfig instance;

  static void init({required Environment environment}) {
    switch (environment) {
      case Environment.development:
        instance = _developmentConfig;
        break;
      case Environment.staging:
        instance = _stagingConfig;
        break;
      case Environment.production:
        instance = _productionConfig;
        break;
    }
  }

  static const AppConfig _developmentConfig = AppConfig(
    environment: Environment.development,
    baseUrl: 'https://dev-api.example.com',
    apiKey: 'dev_api_key',
    enableLogging: true,
    enableCrashReporting: false,
    timeout: 30,
  );

  static const AppConfig _stagingConfig = AppConfig(
    environment: Environment.staging,
    baseUrl: 'https://staging-api.example.com',
    apiKey: 'staging_api_key',
    enableLogging: true,
    enableCrashReporting: true,
    timeout: 30,
  );

  static const AppConfig _productionConfig = AppConfig(
    environment: Environment.production,
    baseUrl: 'https://api.example.com',
    apiKey: 'prod_api_key',
    enableLogging: false,
    enableCrashReporting: true,
    timeout: 30,
  );

  bool get isDevelopment => environment == Environment.development;
  bool get isStaging => environment == Environment.staging;
  bool get isProduction => environment == Environment.production;

  @override
  String toString() {
    return 'AppConfig(environment: $environment, baseUrl: $baseUrl)';
  }
}
