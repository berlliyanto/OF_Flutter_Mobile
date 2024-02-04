import 'package:of_flutter_mobile/app/config/app_config.dart';

String urlImageBuilder(
    {required String transaction,
    required String type,
    required String image}) {
  return AppConfig().getBaseUrl + "/image/$transaction?type=$type&image=$image";
}
