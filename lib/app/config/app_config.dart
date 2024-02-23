class AppConfig {
  //Apk Url
  final Uri urlApk = Uri.parse(
      "https://drive.google.com/drive/folders/1xAxf-0fe3jjXkWZFs4g-8xFE_EKMrwja?usp=sharing");

  // Use this in development
  // final String url = "http://192.168.100.171:8080/api";
  // final String url = "http://192.168.1.10:8080/api";

  // Use this in production
  final String url = "https://system-soekiman.com/forklift/api";

  final String version = "1.0.5";
  final int buildNumber = 5; // => update every new build

  String get getBaseUrl => url;
  int get getBuildNumber => buildNumber;
  Uri get getDownloadUrl => urlApk;
}
