import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class CodeService extends BaseServices {
  Future<Response> indexCode() async {
    return await get(path: '/code/index');
  }
}
