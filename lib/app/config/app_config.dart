class AppConfig {
  //Apk Url
  final Uri urlApk = Uri.parse(
      "https://drive.google.com/drive/folders/1JSbasRwG2LSJbNtGzVSfTV3CyVPVaB4k?usp=sharing");

  // Use this in development
  // final String url = "http://192.168.100.171:8080/api";
  // final String url = "http://192.168.163.130:8080/api";

  // Use this in production
  final String url = "https://aplikasipms.com/operator-forklift/api";

  final String version = "1.0.1";
  final int buildNumber = 1; // => update every new build

  String get getBaseUrl => url;
  int get getBuildNumber => buildNumber;
  Uri get getDownloadUrl => urlApk;
}
