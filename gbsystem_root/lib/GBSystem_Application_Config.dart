class GBSystem_Application_Config {
  static const apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://www.bmplanning.com', // 🔹 valeur par défaut
  );
}
