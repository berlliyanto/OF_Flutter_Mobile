import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class AppVersionService extends BaseServices {
  Future<Response> appVersion() async {
    return await get(path: '/version/show');
  }
}
