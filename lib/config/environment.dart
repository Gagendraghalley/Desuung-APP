class Environment {
  static String getEnvironment() {
    const String environment =
        'dev';
    return environment;
  }

  static bool isProduction() {
    return getEnvironment() == 'prod';
  }
  static String get base_url {
    
  
    if (getEnvironment() == 'dev') {
      return 'https://dev-api.example.com/v1/';
    }
    return 'https://prod-api.example.com/v1/';
  }
}