///TODO: need change app package name later

enum FlavorManager {
  dev,
  staging,
  production,
}

class ConfigManager {
  final String apiBaseUrl;
  final FlavorManager appFlavor;

  ConfigManager({
    required this.apiBaseUrl,
    required this.appFlavor,
  });

  static ConfigManager? _instance;

  static ConfigManager devConfig = ConfigManager(
    apiBaseUrl: 'http://18.136.73.120:8080/ibs',
    appFlavor: FlavorManager.dev,
  );

  static ConfigManager stagingConfig = ConfigManager(
    apiBaseUrl: 'https://cbp.dev.com/api/v1',
    appFlavor: FlavorManager.staging,
  );

  static ConfigManager productionConfig = ConfigManager(
    apiBaseUrl: 'https://cbp.dev.com/api/v1',
    appFlavor: FlavorManager.production,
  );

  static ConfigManager getInstance({String? flavorName}) {
    if (_instance == null) {
      switch (flavorName) {
        case 'staging':
          _instance = stagingConfig;
          break;
        case 'production':
          _instance = productionConfig;
          break;
        default:
          _instance = devConfig;
          break;
      }

      return _instance!;
    }

    return _instance!;
  }

  String get packageName {
    switch (_instance?.appFlavor) {
      case FlavorManager.staging:
        return 'com.cbp.stg';
      case FlavorManager.production:
        return 'com.cbp.prod';
      default:
        return 'com.cbp.dev';
    }
  }
}
