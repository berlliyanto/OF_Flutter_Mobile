import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class LocationService extends BaseServices {
  Future<Response> indexLocation() async {
    return await get(path: '/location/index');
  }
}
