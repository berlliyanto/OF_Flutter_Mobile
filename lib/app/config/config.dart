class AppConfig {
  // Use this in development
  final String url = "http://192.168.100.171:8080/api";

  // Use this in production
  // final String url = "https://aplikasipms.com/api";

  final String buildNumber = "1";

  get getBaseUrl => url;

  get getBuildNumber => buildNumber;
}
