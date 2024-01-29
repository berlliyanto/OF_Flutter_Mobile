import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class ShiftService extends BaseServices {
  Future<Response> indexShift() async {
    return await get(path: '/shift/index');
  }
}
