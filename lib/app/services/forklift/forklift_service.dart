import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class ForkliftService extends BaseServices {
  Future<Response> indexForklift({String query = ""}) async {
    return await get(path: '/forklift/index?$query');
  }

  Future<Response> storeForklift(FormData data) async {
    return await postFormData(path: '/forklift/store', data: data);
  }
}
