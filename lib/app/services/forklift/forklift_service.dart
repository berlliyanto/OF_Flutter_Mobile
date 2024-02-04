import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class ForkliftService extends BaseServices {
  Future<Response> indexForklift({String query = ""}) async {
    return await get(path: '/forklift/index', query: query);
  }

  Future<Response> storeForklift(FormData data) async {
    return await postFormData(path: '/forklift/store', data: data);
  }

  Future<Response> showForklift(int id) async {
    return await get(path: '/forklift/show', query: "id=$id");
  }

  Future<Response> updateForklift(int id, FormData data) async {
    return await postFormData(
        path: '/forklift/update', data: data, query: "id=$id");
  }

  Future<Response> destroyForklift(int id) async {
    return await delete(path: '/forklift/destroy', query: "id=$id");
  }
}
